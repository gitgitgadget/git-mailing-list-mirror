From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Fri, 15 Jun 2012 14:40:30 -0400
Message-ID: <20120615184030.GC14843@sigill.intra.peff.net>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:40:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfbRm-0000Px-41
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 20:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab2FOSke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 14:40:34 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57672
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab2FOSkd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 14:40:33 -0400
Received: (qmail 2318 invoked by uid 107); 15 Jun 2012 18:40:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 14:40:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 14:40:30 -0400
Content-Disposition: inline
In-Reply-To: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200078>

On Fri, Jun 15, 2012 at 01:31:03PM -0400, Tim Henigan wrote:

> When running 'git diff --quiet <file1> <file2>', if file1 or file2
> is outside the repository, it will exit(0) even if the files differ.
> It should exit(1) when they differ.

>From your description, I would expect the fix to be in builtin/diff.c,
or in diff-no-index.c, since that is where the code paths diverge.

> This was the least invasive fix that I found.  I considered adding
> the following when the '--quiet' option is parsed instead:
> 
> +   DIFF_OPT_SET(options, EXIT_WITH_STATUS)
> +   DIFF_OPT_SET(options, DIFF_FROM_CONTENTS)

We already set EXIT_WITH_STATUS when we see --quiet (we just do it a
little later, during diff_setup_done). We would not want to set
DIFF_FROM_CONTENTS all the time with --quiet. The point of that flag is
"we cannot know just from seeing the path sha1s whether they are
different or not, because we are doing content-level munging" (for
example, things like ignoring whitespace changes).

So we would not want to always set it whenever --quiet is given, because
it means we must do a lot of extra work comparing file content.

> diff --git a/diff.c b/diff.c
> index 77edd50..b1d74fe 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4432,9 +4432,10 @@ void diff_flush(struct diff_options *options)
>  		separator++;
>  	}
>  
> -	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
> +	if ((output_format & DIFF_FORMAT_NO_OUTPUT &&
>  	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
> -	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
> +	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) ||
> +		DIFF_OPT_TST(options, QUICK)) {
>  		/*
>  		 * run diff_flush_patch for the exit status. setting
>  		 * options->file to /dev/null should be safe, becaue we

And this is equally bad, because it means that --quiet gets much slower
for _all_ cases, not just the no-index case.

I suspect what you actually want is to set DIFF_FROM_CONTENTS in the
no-index case, since we by definition do not have a pair of sha1s to
compare. But it may also be that diff.c could detect this case
automatically. I'd have to look closer.

-Peff
