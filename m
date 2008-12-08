From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] reorder ALLOW_TEXTCONV option setting
Date: Sun, 7 Dec 2008 21:54:17 -0500
Message-ID: <20081208025417.GA22072@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 03:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9WHb-00031i-26
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 03:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbYLHCyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 21:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754542AbYLHCyU
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 21:54:20 -0500
Received: from peff.net ([208.65.91.99]:4037 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470AbYLHCyU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 21:54:20 -0500
Received: (qmail 21396 invoked by uid 111); 8 Dec 2008 02:54:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Dec 2008 21:54:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Dec 2008 21:54:17 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102520>

Right now for the diff porcelain and the log family, we
call:

  init_revisions();
  setup_revisions();
  DIFF_OPT_SET(ALLOW_TEXTCONV);

However, that means textconv will _always_ be on, instead of
being a default that can be manipulated with
setup_revisions. Instead, we want:

  init_revisions();
  DIFF_OPT_SET(ALLOW_TEXTCONV);
  setup_revisions();

which is what this patch does.

We'll go ahead and move the callsite in wt-status, also;
even though the user can't pass any options here, it is a
cleanup that will help avoid any surprise later if the
setup_revisions line is changed.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a "bug fix" in the sense that the code does not match the
original intent (which was to set a default for these porcelains). But
you can't _trigger_ the bug since setup_revisions never munges the value
(but it will in 2/3).

 builtin-diff.c |    4 ++--
 builtin-log.c  |    2 +-
 wt-status.c    |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index dddcf69..d75d69b 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -290,8 +290,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
 
-	/* Default to let external be used */
+	/* Default to let external and textconv be used */
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
+	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
 
 	if (nongit)
 		die("Not a git repository");
@@ -303,7 +304,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	}
 
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
-	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
 
 	/*
 	 * If the user asked for our exit code then don't start a
diff --git a/builtin-log.c b/builtin-log.c
index b164717..840daf9 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -37,6 +37,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
+	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
 	if (default_date_mode)
 		rev->date_mode = parse_date_format(default_date_mode);
@@ -60,7 +61,6 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		} else
 			die("unrecognized argument: %s", arg);
 	}
-	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 }
 
 /*
diff --git a/wt-status.c b/wt-status.c
index 3edae43..96ff2f8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -279,11 +279,11 @@ static void wt_status_print_verbose(struct wt_status *s)
 	struct rev_info rev;
 
 	init_revisions(&rev, NULL);
+	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
 	setup_revisions(0, NULL, &rev,
 		s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
-	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
 	rev.diffopt.file = s->fp;
 	rev.diffopt.close_file = 0;
 	/*
-- 
1.6.1.rc2.285.gc1cf2
