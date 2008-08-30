From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/12] xdiff-merge: optionally show conflicts in "diff3
 -m" style
Date: Sat, 30 Aug 2008 11:29:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808301115530.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com> <1220056963-2352-2-git-send-email-gitster@pobox.com> <1220056963-2352-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:24:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZMhU-0004Zy-2q
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 11:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbYH3JXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 05:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbYH3JXv
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 05:23:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:50594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750878AbYH3JXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 05:23:50 -0400
Received: (qmail invoked by alias); 30 Aug 2008 09:23:48 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 30 Aug 2008 11:23:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mo0gw0xDmlzqx40Vrsj+CcmihINKqBEZAdz8+s+
	uzNpjaPJI5X1yV
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1220056963-2352-3-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94365>

Hi,

On Fri, 29 Aug 2008, Junio C Hamano wrote:

> diff --git a/builtin-merge-file.c b/builtin-merge-file.c
> index 3605960..5b4f020 100644
> --- a/builtin-merge-file.c
> +++ b/builtin-merge-file.c
> @@ -25,6 +27,10 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>  		else if (!strcmp(argv[1], "-q") ||
>  				!strcmp(argv[1], "--quiet"))
>  			freopen("/dev/null", "w", stderr);
> +		else if (!strcmp(argv[1], "--diff3")) {
> +			merge_style = XDL_MERGE_DIFF3;
> +			merge_level = XDL_MERGE_EAGER;
> +		}

FWIW I do not follow your reasoning why --diff3 does not make sense for 
anything more eager than MERGE_EAGER.  All that ZEALOUS and ZEALOUS_ALNUM 
(the latter of which is useless at the moment, since it is not enabled for 
git-merge) do is change the way the conflicting regions are displayed, but 
they do not leave out conflicting regions.

So I actually suspect that ZEALOUS_ALNUM will be _especially_ useful with 
--diff3, since it is designed to skip the single curly brackets that would 
disrupt the reading pleasure otherwise.

> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 413082e..deebe02 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -50,10 +50,16 @@ extern "C" {
>  #define XDL_BDOP_CPY 2
>  #define XDL_BDOP_INSB 3
>  
> +/* merge simplification levels */
>  #define XDL_MERGE_MINIMAL 0
>  #define XDL_MERGE_EAGER 1
>  #define XDL_MERGE_ZEALOUS 2
>  #define XDL_MERGE_ZEALOUS_ALNUM 3
> +#define XDL_MERGE_LEVEL_MASK 0x0f
> +
> +/* merge output styles */
> +#define XDL_MERGE_DIFF3 0x8000
> +#define XDL_MERGE_STYLE_MASK 0x8000

Hmm.  This is not the Linux kernel, I think we could safely pass around 
two integers instead of one.

> @@ -91,11 +108,13 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
>  	return 0;
>  }
>  
> -static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
> +static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int add_nl, char *dest)

You rewrapped many function headers already; I wonder why this one was 
left out.

The rest looks pretty much obviously correct to me; I was too lazy/ran out 
of time to apply the patch and look through the resulting code, though, 
but I guess that you searched for "i1" and "chg1" and added the code for 
i0 and chg0 where necessary.

So: ACK.

Ciao,
Dscho
