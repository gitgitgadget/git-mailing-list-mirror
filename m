From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Fix some printf format warnings
Date: Thu, 01 Oct 2009 13:29:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910011329060.4997@xanadu.home>
References: <4AC3A834.6070208@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 01 19:30:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtPTk-0002TC-19
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 19:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbZJAR36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 13:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755609AbZJAR36
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 13:29:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32367 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233AbZJAR35 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 13:29:57 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQU00410J9ARVO0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Oct 2009 13:29:34 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4AC3A834.6070208@ramsay1.demon.co.uk>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129404>

On Wed, 30 Sep 2009, Ramsay Jones wrote:

> 
> commit 51ea551 ("make sure byte swapping is optimal for git"
> 2009-08-18) introduced a "sane definition for ntohl()/htonl()"
> for use on some GNU C platforms. Unfortunately, for some of
> these platforms, this results in the introduction of a problem
> which is essentially the reverse of a problem that commit 6e1c234
> ("Fix some warnings (on cygwin) to allow -Werror" 2008-07-3) was
> intended to fix.
> 
> In particular, on platforms where the uint32_t type is defined
> to be unsigned long, the return type of the new ntohl()/htonl()
> is causing gcc to issue printf format warnings, such as:
> 
>     warning: long unsigned int format, unsigned int arg (arg 3)
> 
> (nine such warnings, covering six different files). The earlier
> commit (6e1c234) needed to suppress these same warnings, except
> that the types were in the opposite direction; namely the format
> specifier ("%u") was 'unsigned int' and the argument type (ie the
> return type of ntohl()) was 'long unsigned int' (aka uint32_t).
> 
> In order to suppress these warnings, the earlier commit used the
> (C99) PRIu32 format specifier, since the definition of this macro
> is suitable for use with the uint32_t type on that platform.
> This worked because the return type of the (original) platform
> ntohl()/htonl() functions was uint32_t.
> 
> In order to suppress these warnings, we change the return type of
> the new byte swapping functions in the compat/bswap.h header file
> from 'unsigned int' to uint32_t.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  compat/bswap.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/compat/bswap.h b/compat/bswap.h
> index 7246a12..5cc4acb 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -9,7 +9,7 @@
>   * Default version that the compiler ought to optimize properly with
>   * constant values.
>   */
> -static inline unsigned int default_swab32(unsigned int val)
> +static inline uint32_t default_swab32(uint32_t val)
>  {
>  	return (((val & 0xff000000) >> 24) |
>  		((val & 0x00ff0000) >>  8) |
> @@ -20,7 +20,7 @@ static inline unsigned int default_swab32(unsigned int val)
>  #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
>  
>  #define bswap32(x) ({ \
> -	unsigned int __res; \
> +	uint32_t __res; \
>  	if (__builtin_constant_p(x)) { \
>  		__res = default_swab32(x); \
>  	} else { \
> -- 
> 1.6.4
> 
> 
