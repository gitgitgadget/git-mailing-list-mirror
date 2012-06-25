From: Leila Muhtasib <muhtasib@gmail.com>
Subject: [PATCH v2] log: Handle new repository case.
Date: Mon, 25 Jun 2012 18:53:33 -0400
Message-ID: <1340664813-96891-1-git-send-email-muhtasib@gmail.com>
Cc: Leila Muhtasib <muhtasib@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 00:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjIA9-00051E-G8
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 00:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab2FYWxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 18:53:37 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61304 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab2FYWxg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 18:53:36 -0400
Received: by qadb17 with SMTP id b17so1622728qad.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 15:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=E064bnGF/9qKb4yseyXQ0iGq1n7brFgRYUoHqgi5vdA=;
        b=pZ1eEhuoekL6O0vSPFeCCE8DBNeMMiK3j/B3PZCu3ScJPLpFTo5gL+RgnUdHYbvOqx
         4h2L/IfF2JeBEtpLjjT/6dbFYJiTSLrt/B0IsIfcAxx1nk4DQMBLvpd/FD3MELMmoFXt
         1wr05Vn9fVD4GQpzKrQ5e2TJftR70lXGAE3o4bsp6GhoLvP+An31rSIESowbOKdbqqvP
         mxatm5bqA631W83VDfh43wcK1SKDF4WjYMwX1ec0ZwIfRBIqI35L6R0G+acXu5FrwiCV
         yimUoIdXErpwDpLaO3f3RLvwhLYNGXOySTP8yrRAGhodV+AoNnloIKBenupJ1YlTOal7
         q32w==
Received: by 10.224.111.139 with SMTP id s11mr22712618qap.78.1340664816103;
        Mon, 25 Jun 2012 15:53:36 -0700 (PDT)
Received: from localhost ([38.117.156.148])
        by mx.google.com with ESMTPS id bk12sm15126762qab.6.2012.06.25.15.53.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 15:53:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.5 (Apple Git-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200603>

Currently, we display an error message if 'git log' is run on a new repo with no commits.
This is a corner case and shouldn't return an error.
Also, updated other functions to use new 'default_to_head_if_exists()' function introduced.

Signed-off-by: Leila Muhtasib <muhtasib@gmail.com>
---
 builtin/log.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4f1b42a..1685946 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -355,6 +355,15 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	return git_diff_ui_config(var, value, cb);
 }
 
+static const char *default_to_head_if_exists(void)
+{
+	unsigned char sha1[20];
+	if (resolve_ref_unsafe("HEAD", sha1, 1, NULL))
+		return "HEAD";
+	else
+		return NULL;
+}
+
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
@@ -366,7 +375,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.simplify_history = 0;
 	memset(&opt, 0, sizeof(opt));
-	opt.def = "HEAD";
+	opt.def = default_to_head_if_exists();
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
@@ -459,7 +468,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.diffopt.stat_width = -1; 	/* Scale to real terminal size */
 
 	memset(&opt, 0, sizeof(opt));
-	opt.def = "HEAD";
+	opt.def = default_to_head_if_exists();
 	opt.tweak = show_rev_tweak_rev;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
@@ -532,7 +541,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	init_reflog_walk(&rev.reflog_info);
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
-	opt.def = "HEAD";
+	opt.def = default_to_head_if_exists();
 	cmd_log_init_defaults(&rev);
 	rev.abbrev_commit = 1;
 	rev.commit_format = CMIT_FMT_ONELINE;
@@ -553,8 +562,13 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
-	opt.def = "HEAD";
+	opt.def = default_to_head_if_exists();
+
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
+
+	if (!opt.def && !rev.cmdline.nr)
+		return 0;
+
 	return cmd_log_walk(&rev);
 }
 
@@ -1128,7 +1142,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
-	s_r_opt.def = "HEAD";
+	s_r_opt.def = default_to_head_if_exists();
 
 	if (default_attach) {
 		rev.mime_boundary = default_attach;
-- 
1.7.7.5 (Apple Git-26)
