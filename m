From: Jonh Wendell <jonh.wendell@gmail.com>
Subject: [PATCH 1/2] describe: support the syntax "--abbrev=+"
Date: Sat, 23 Aug 2014 14:13:21 -0300
Message-ID: <1408814002-6553-2-git-send-email-jonh.wendell@gmail.com>
References: <1408814002-6553-1-git-send-email-jonh.wendell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 19:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLEsl-0006M9-E9
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 19:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbaHWRN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 13:13:29 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:37253 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbaHWRN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 13:13:28 -0400
Received: by mail-yh0-f44.google.com with SMTP id f73so9887470yha.31
        for <git@vger.kernel.org>; Sat, 23 Aug 2014 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=fwnbkDSvr7P+jfD434bUTPr+w14wtYIdi+mg3IYERdY=;
        b=ePoEdJ6+q2e/W6XCKc5fm8T8IK8nrAC5dkZaTbx9cgnR4q1xpbPfmBZliLxdPXeknM
         oBmczJ1sOSFPD4qEGZ81QBpUH/mXPrXkHktTFcTXBp64qYiy2mxLN67lYaikQxFxJr1R
         YfGLT5prD9dpUUs87er6UqupVacY7xhQmcxM+vCMVsf57Fuxwj3MqRS6NdH5C0e3zPc4
         X+53w46hTsZywz2B2E1pNpSkBlhKq3vchVGdSWf3CCpa1X6BT4IWba9MHTAA4TBwSj5u
         pLxS+JlruyZMCxM3UcY3iAeHgOD6z57PmZghAzC/c8JR2hY/sVTydf0MELuFpNXPBCN8
         aLHA==
X-Received: by 10.236.125.78 with SMTP id y54mr3410441yhh.117.1408814007920;
        Sat, 23 Aug 2014 10:13:27 -0700 (PDT)
Received: from jwendell-mobl1.amr.corp.intel.com ([187.37.207.144])
        by mx.google.com with ESMTPSA id s9sm1485471yhp.39.2014.08.23.10.13.27
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Aug 2014 10:13:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1408814002-6553-1-git-send-email-jonh.wendell@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255759>

It will print just a "+" sign appended to the found tag, if there
are commits between the tag and the supplied commit.

It's useful when you just need a simple output to know if the
supplied commit is an exact match or not.
---
 builtin/describe.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index ee6a3b9..3a5c052 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -30,6 +30,7 @@ static int have_util;
 static const char *pattern;
 static int always;
 static const char *dirty;
+static int simple_abbrev = 0;
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
@@ -378,8 +379,12 @@ static void describe(const char *arg, int last_one)
 	}
 
 	display_name(all_matches[0].name);
-	if (abbrev)
-		show_suffix(all_matches[0].depth, cmit->object.sha1);
+	if (abbrev) {
+		if (simple_abbrev)
+			printf("+");
+		else
+			show_suffix(all_matches[0].depth, cmit->object.sha1);
+	}
 	if (dirty)
 		printf("%s", dirty);
 	printf("\n");
@@ -388,6 +393,16 @@ static void describe(const char *arg, int last_one)
 		clear_commit_marks(cmit, -1);
 }
 
+static int parse_opt_abbrev_for_describe_cb(const struct option *opt, const char *arg, int unset)
+{
+	if (arg && !strncmp(arg, "+", 1)) {
+		simple_abbrev = 1;
+		return 0;
+	}
+
+	return parse_opt_abbrev_cb(opt, arg, unset);
+}
+
 int cmd_describe(int argc, const char **argv, const char *prefix)
 {
 	int contains = 0;
@@ -398,7 +413,6 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "tags",       &tags, N_("use any tag, even unannotated")),
 		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
 		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent")),
-		OPT__ABBREV(&abbrev),
 		OPT_SET_INT(0, "exact-match", &max_candidates,
 			    N_("only output exact matches"), 0),
 		OPT_INTEGER(0, "candidates", &max_candidates,
@@ -410,6 +424,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
 			N_("append <mark> on dirty working tree (default: \"-dirty\")"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
+		{OPTION_CALLBACK, 0, "abbrev", &abbrev, N_("n"), N_("use <n> digits to display SHA-1s"),
+			PARSE_OPT_OPTARG, &parse_opt_abbrev_for_describe_cb, 0},
 		OPT_END(),
 	};
 
@@ -425,8 +441,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 
-	if (longformat && abbrev == 0)
-		die(_("--long is incompatible with --abbrev=0"));
+	if (longformat && (abbrev == 0 || simple_abbrev))
+		die(_("--long is incompatible with --abbrev=+ or --abbrev=0"));
 
 	if (contains) {
 		struct argv_array args;
-- 
1.9.3
