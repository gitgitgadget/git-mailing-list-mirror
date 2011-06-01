From: Jeff King <peff@peff.net>
Subject: Re: git annotate with date option not working?
Date: Wed, 1 Jun 2011 12:49:04 -0400
Message-ID: <20110601164904.GD7132@sigill.intra.peff.net>
References: <4DE5F655.9020400@gmail.com>
 <20110601161638.GB7132@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chengwei Ding <waterding@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:49:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRobZ-0003xp-UC
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758439Ab1FAQtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 12:49:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60068
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637Ab1FAQtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 12:49:07 -0400
Received: (qmail 14253 invoked by uid 107); 1 Jun 2011 16:49:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 12:49:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 12:49:04 -0400
Content-Disposition: inline
In-Reply-To: <20110601161638.GB7132@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174880>

On Wed, Jun 01, 2011 at 12:16:38PM -0400, Jeff King wrote:

> On Wed, Jun 01, 2011 at 10:20:37AM +0200, Chengwei Ding wrote:
> 
> > can anyone confirm that this "--date" option is working for git
> > annotate cmd.
> 
> This is by design:
> 
>   $ git show 31653c1abc1ac80206db9efca56ff1969150d8fe
>   Author: Eugene Letuchy <eugene@facebook.com>
>   Date:   Fri Feb 20 14:51:11 2009 -0800
>   [...]
>       git annotate ignores the date format specifiers and continues to
>       uses the ISO format, as before.
>   [...]
>   +       if (cmd_is_annotate) {
>                   output_option |= OUTPUT_ANNOTATE_COMPAT;
>   +               blame_date_mode = DATE_ISO8601;
>   +       } else {
>   +               blame_date_mode = revs.date_mode;
>   +       }
> 
> The annotate command is a historical artifact, and will remain frozen in
> time in terms of output format and features. If you want to use newer
> features, use "git blame". If you really need the annotate output format
> with newer blame features, use "git blame -c".

Having said that, this would be really easy to support, and I don't
think would have any negative compatibility consequences, as long as we
don't support blame.date. But I don't think we're breaking anybody
relying on "git annotate --date=whatever" being silently ignored, as
that option has never done anything useful.

The patch would look like this:

diff --git a/builtin/blame.c b/builtin/blame.c
index 26a5d42..274a98d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2333,7 +2333,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
-	revs.date_mode = blame_date_mode;
+	if (cmd_is_annotate)
+		revs.date_mode = DATE_ISO8601;
+	else
+		revs.date_mode = blame_date_mode;
 	DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);
 
 	save_commit_buffer = 0;
@@ -2368,13 +2371,10 @@ parse_done:
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
 
-	if (cmd_is_annotate) {
+	if (cmd_is_annotate)
 		output_option |= OUTPUT_ANNOTATE_COMPAT;
-		blame_date_mode = DATE_ISO8601;
-	} else {
-		blame_date_mode = revs.date_mode;
-	}
 
+	blame_date_mode = revs.date_mode;
 	/* The maximum width used to show the dates */
 	switch (blame_date_mode) {
 	case DATE_RFC2822:
