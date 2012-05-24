From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] progress: don't print if !isatty(2).
Date: Thu, 24 May 2012 01:45:06 -0400
Message-ID: <20120524054506.GA3440@sigill.intra.peff.net>
References: <1337836732-26778-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 07:45:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXQra-0001Lc-9f
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 07:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab2EXFpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 01:45:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53405
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab2EXFpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 01:45:11 -0400
Received: (qmail 24344 invoked by uid 107); 24 May 2012 05:45:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 01:45:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 01:45:06 -0400
Content-Disposition: inline
In-Reply-To: <1337836732-26778-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198354>

On Thu, May 24, 2012 at 01:18:52AM -0400, Avery Pennarun wrote:

> If stderr isn't a tty, we shouldn't be printing incremental progress
> messages.  In particular, this affected 'git checkout -f . >&logfile' unless
> you provided -q.  And git-new-workdir has no way to provide -q.

Makes sense to fix checkout, but...

> diff --git a/progress.c b/progress.c
> index 3971f49..4d9f416 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -211,9 +211,11 @@ int display_progress(struct progress *progress, unsigned n)
>  struct progress *start_progress_delay(const char *title, unsigned total,
>  				       unsigned percent_treshold, unsigned delay)
>  {
> -	struct progress *progress = malloc(sizeof(*progress));
> +	struct progress *progress = NULL;
> +	if (isatty(2))
> +		progress = malloc(sizeof(*progress));

This is the wrong place to put the fix. The user might have asked git to
override the isatty(2) check and show progress anyway (e.g., "git push
--progress"), and this would break that case.

The fix has to go in builtin/checkout.c, and probably looks like this:

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3ddda34..e8c1b1f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -343,7 +343,7 @@ static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet;
+	opts.verbose_update = !o->quiet && isatty(2);
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -420,7 +420,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
-		topts.verbose_update = !opts->quiet;
+		topts.verbose_update = !opts->quiet && isatty(2);
 		topts.fn = twoway_merge;
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));

but I did not test it.

-Peff
