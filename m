From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Sat, 03 May 2008 18:34:31 +0100
Message-ID: <481CA227.1000801@ramsay1.demon.co.uk>
References: <20080430172136.GA22601@sigill.intra.peff.net> <20080430172553.GC23747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 03 19:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsLrt-00061Z-9p
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 19:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbYECRsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 13:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755439AbYECRsv
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 13:48:51 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:2204 "EHLO
	anchor-post-32.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755960AbYECRsu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2008 13:48:50 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 May 2008 13:48:50 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.67)
	id 1JsLhV-000NvG-6q; Sat, 03 May 2008 17:39:09 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20080430172553.GC23747@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81106>

Jeff King wrote:
> In many cases, the warning ends up as clutter, because the
> diff is being done "behind the scenes" from the user (e.g.,
> when generating a commit diffstat), and whether we show
> renames or not is not particularly interesting to the user.
> 

[snip]

> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 1369a5e..1b2ebb4 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -492,7 +492,8 @@ void diffcore_rename(struct diff_options *options)
>  		rename_limit = 32767;
>  	if ((num_create > rename_limit && num_src > rename_limit) ||
>  	    (num_create * num_src > rename_limit * rename_limit)) {
> -		warning("too many files, skipping inexact rename detection");
> +		if (options->warn_on_too_large_rename)
> +			warning("too many files, skipping inexact rename detection");
>  		goto cleanup;
>  	}
>  

This will also fix the problem I had with gitk on cygwin; namely "gitk --all &" on my
"git" repo pops up an error dialog (see below), after which the diff display disappears.

The error dialog shows:
--- >8 ---
warning: too many files, skipping inexact rename detection
warning: too many files, skipping inexact rename detection
    while executing
"close $bdf"
    (procedure "getblobdiffline" line 89)
    invoked from within
"getblobdiffline file102daa00 1d6aeb410dc19893adbc0209bcf859f35ff1c7d6"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 9)
    invoked from within
"dorunq"
    ("after" script)
--- 8< ---

The git command issued by gitk appears to be:
   git diff-tree -r -p -C --no-commit-id -U3 1d6aeb410dc19893adbc0209bcf859f35ff1c7d6

However, if I type the above into bash (and include --no-pager), then the error
message does not appear! Ho hum. Also, the same repo on Linux does not exhibit this
problem at all.

In any event, if the above warning() call is commented out, then gitk is quite happy
on cygwin as well.

All the best,

Ramsay Jones
