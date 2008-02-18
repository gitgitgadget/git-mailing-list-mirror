From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Mon, 18 Feb 2008 18:47:51 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181839400.30505@racer.site>
References: alpine.LSU.1.00.0802181328380.30505@racer.site <1203342817-19653-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRB2i-0008HL-NP
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 19:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYBRSsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 13:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbYBRSsH
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 13:48:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:39636 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751610AbYBRSsG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 13:48:06 -0500
Received: (qmail invoked by alias); 18 Feb 2008 18:48:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 18 Feb 2008 19:48:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ezLtSqTmezN/jf4cl12Gk9hZvvvr0nBzs5tqRVL
	KF11JG2RO+ORBX
X-X-Sender: gene099@racer.site
In-Reply-To: <1203342817-19653-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74328>

Hi,

On Mon, 18 Feb 2008, Jay Soffian wrote:

> diff --git a/branch.c b/branch.c
> index 1fc8788..64f0a4a 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -49,8 +49,12 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
>  	if (for_each_remote(find_tracked_branch, &tracking) ||
> -			!tracking.matches)
> -		return 1;
> +			!tracking.matches) {
> +		if (!always)
> +			return 1;
> +		tracking.matches = 1;
> +		tracking.src = xstrdup(orig_ref);
> +	}

I think you need to split this into

	if (for_each_remote(...))
		return 1;
	if (!tracking.matches && !always)
			return 1;

because an error in for_each_remote() is a proper error, and should not be 
ignored (speaking of which, the return value is unchecked...).  And then, 
later,

        if (tracking.matches == 1) {
                sprintf(key, "branch.%s.remote", new_ref);
                git_config_set(key, tracking.remote ?  tracking.remote : ".");
                sprintf(key, "branch.%s.merge", new_ref);
-               git_config_set(key, tracking.src);
+               git_config_set(key, tracking.src ? tracking.src : orig_ref);
                free(tracking.src);

> @@ -130,7 +135,7 @@ void create_branch(const char *head,
>  	   automatically merges from there.  So far, this is only done for
>  	   remotes registered via .git/config.  */
>  	if (real_ref && track)
> -		setup_tracking(name, real_ref);
> +		setup_tracking(name, real_ref, (track == BRANCH_TRACK_ALWAYS));

It is a matter of taste, I guess, but I would remove the parens around the 
boolean expression.

FWIW a very good argument in favour of your patch is IMHO that now, 
"--track" works as a user would expect, even for local branch-offs.

And of course that you were very responsive, and really put in a lot of 
effort.

Thanks,
Dscho
