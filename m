From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 15 Jun 2010 11:11:35 -0500
Message-ID: <gJV0lM_e77LzoiHR7moWdAApSZ7yI38lZ-w8kZwc97unWqtBc94nfg@cipher.nrlssc.navy.mil>
References: <4C0E5103.7030501@viscovery.net> <AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com> <4C0E6810.3070301@viscovery.net> <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com> <4C0E932B.3010702@viscovery.net> <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com> <4C0EB741.9020905@op5.se> <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com> <20100610082916.GA5559@coredump.intra.peff.net> <AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com> <20100610085952.GA8269@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tor Arntsen <tor@spacetec.no>, Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>, gary@thewrittenword.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:18:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOYps-0008Oe-Bz
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab0FOQRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:17:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45680 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab0FOQRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:17:54 -0400
Received: by mail.nrlssc.navy.mil id o5FGBZnv026511; Tue, 15 Jun 2010 11:11:36 -0500
In-Reply-To: <20100610085952.GA8269@coredump.intra.peff.net>
X-OriginalArrivalTime: 15 Jun 2010 16:11:34.0851 (UTC) FILETIME=[6D071930:01CB0CA5]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149198>

On 06/10/2010 03:59 AM, Jeff King wrote:
> On Thu, Jun 10, 2010 at 10:48:31AM +0200, Tor Arntsen wrote:
> 
>> That looks good to me.
> 
> OK, here it is with a commit message. Other systems might want the same,
> I guess (Solaris, IRIX?). I'm cc'ing Brandon, who might have some input.

Yes, I currently set DEFAULT_PAGER to 'more' in my config.mak file
on both of these platforms.  The 'more' on IRIX is decent (it can go
backwards), but the 'more' on Solaris sucks.  I've seen 'less' on some
newer versions of Solaris.  Is it a standard component yet?

So, I think it's appropriate to set DEFAULT_PAGER on IRIX.  There can't
be many users anyway.  It's probably appropriate to set it on Solaris
too, if 'less' is not a commonly installed component on modern systems.
I wonder how surprised existing git users will be, for those on Solaris
platforms that have 'less' installed, when Solaris's crappy 'more'
becomes their pager.

Actually, there is a 'more' in /usr/xpg4/bin that is much better, but
it is not being used when DEFAULT_PAGER is set to 'more'.  Junio
created the SANE_TOOL_PATH hack to add this additional path to the
search path, but it is only implemented in git-sh-setup, so it only
has effect for git scripts.  Maybe it should be added to setup_path().

But, I also think it would be nice if git fell back to the 'cat'
behavior when it fails to spawn the pager, because the following error
is not very informative:

   casey@<a_solaris_box> # git log
   sh: less: not found
   Broken Pipe

-brandon


> Note that this is completely untested by me, as all of my AIX boxen have
> gone away in the past few months (yay!).
> 
> -- >8 --
> Subject: [PATCH] Makefile: default pager on AIX to "more"
> 
> AIX doesn't ship with "less" by default, and their "more" is
> more featureful than average, so the latter is a more
> sensible choice.  People who really want less can set the
> compile-time option themselves, or users can set $PAGER.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 34b7dd5..6ad0aca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -930,6 +930,7 @@ ifeq ($(uname_S),NetBSD)
>  	HAVE_PATHS_H = YesPlease
>  endif
>  ifeq ($(uname_S),AIX)
> +	DEFAULT_PAGER = more
>  	NO_STRCASESTR=YesPlease
>  	NO_MEMMEM = YesPlease
>  	NO_MKDTEMP = YesPlease
