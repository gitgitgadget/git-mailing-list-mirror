From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7] safecrlf: Add mechanism to warn about irreversible
 crlf conversions
Date: Sun, 3 Feb 2008 22:29:54 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802032222380.7372@racer.site>
References: <4C024D67-9FA5-451D-BB91-CE9464C6F50D@zib.de> <1202053379677-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:31:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLnMf-0004Kw-IX
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbYBCWab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 17:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYBCWab
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:30:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:52274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752566AbYBCWaa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:30:30 -0500
Received: (qmail invoked by alias); 03 Feb 2008 22:30:28 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp046) with SMTP; 03 Feb 2008 23:30:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kj5U4M7Vk5zkaI0sCWc2ZbjuIQA2rucpBrFg8Mm
	DmaKqSoGDIDs+J
X-X-Sender: gene099@racer.site
In-Reply-To: <1202053379677-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72413>

Hi,

On Sun, 3 Feb 2008, Steffen Prohaska wrote:

> diff --git a/convert.c b/convert.c
> index 80f114b..d580a62 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -95,9 +95,6 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
>  		return 0;
>  
>  	gather_stats(src, len, &stats);
> -	/* No CR? Nothing to convert, regardless. */
> -	if (!stats.cr)
> -		return 0;

Yes, you add it later, but would this not be "more correct" if you 
prepended a "!checksafe &&" and kept the if here?  Of course, you'd _also_ 
need it later, but then _inside_ the "if (checksafe)" clause.

> @@ -115,6 +112,30 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
>  			return 0;
>  	}
>  
> +	if (checksafe) {
> +		if (action == CRLF_INPUT || auto_crlf <= 0) {
> +			/* CRLFs would not be restored by checkout: check if we'd remove CRLFs */

There are lines in your patch that are substantially longer than 80 
characters / line.  Please fix.

> diff --git a/environment.c b/environment.c
> index 18a1c4e..e351e99 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -35,6 +35,7 @@ int pager_use_color = 1;
>  char *editor_program;
>  char *excludes_file;
>  int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
> +enum safe_crlf safe_crlf = SAFE_CRLF_WARN;

I think this choice needs some defending.  At first I thought: "no way 
that this will be the default; it affects too many users it should _not_ 
affect".  The thing is, Unix users should not need to suffer, only because 
other users are cursed by insane choices of their OS developers.

However, safe_crlf != SAFE_CRLF_FALSE does not affect people who did not 
set core.crlf = input or core.crlf = true.  And for those who set 
core.crlf, the default makes sense, absolutely.

So I think this patch should go in, with shortened lines (and possibly the 
changes to the "if (!stats.cr)" if you agree with me).

Ciao,
Dscho
