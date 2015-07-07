From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 24/44] builtin-am: implement -k/--keep, --keep-non-patch
Date: Tue,  7 Jul 2015 22:20:42 +0800
Message-ID: <1436278862-2638-25-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTlw-0004qP-HR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757739AbbGGOWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:49 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33660 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757689AbbGGOWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:24 -0400
Received: by pacws9 with SMTP id ws9so115530968pac.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tRhQGLTJXzk62Collj2TzA9kVyiPlC64IGA2Sed1b/4=;
        b=NfF847gKXFwnXHdqAw1KMSAljk8JQhuULeXhj9VVoyU7jZvcT8VYUJKEknMTjvd6sV
         jLXjJG7g+ZTwqWOKADl5GHUY833Pa//fwPsVBtRgtbG1FqQx6LlcqYW0kqTRxeduKzju
         4JQdKGIJGNbobASQL57+iI5/w5amoMszT7Vl1C8H0cwuChOE8c5E5rBwT9d2ZLp0b2PY
         xPaQ56ONJ8pTpFN8S9aKP7pjQOUFRKBWofgM5P/ISjuYkQimmqS567pgXoBlmltmZXWG
         jRZWHNjKok2VYMtriuP3HXiv7PKUmiU7+bwxQm4Zx2jQ9WvXYaQUztFdue2Iw/c13vR7
         YuzQ==
X-Received: by 10.69.10.196 with SMTP id ec4mr9508575pbd.69.1436278944182;
        Tue, 07 Jul 2015 07:22:24 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:23 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273539>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh supported the -k/--keep option to pass the -k option to
git-mailsplit.

Since f7e5ea1 (am: learn passing -b to mailinfo, 2012-01-16), git-am.sh
supported the --keep-non-patch option to pass the -b option to
git-mailsplit.

Re-implement these two options in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 0b441fb..4e1ee7f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -68,6 +68,12 @@ enum patch_format {
 	PATCH_FORMAT_MBOX
 };
 
+enum keep_type {
+	KEEP_FALSE = 0,
+	KEEP_TRUE,      /* pass -k flag to git-mailinfo */
+	KEEP_NON_PATCH  /* pass -b flag to git-mailinfo */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -94,6 +100,9 @@ struct am_state {
 
 	int utf8;
 
+	/* one of the enum keep_type values */
+	int keep;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -397,6 +406,14 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "utf8", 1);
 	state->utf8 = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "keep", 1);
+	if (!strcmp(sb.buf, "t"))
+		state->keep = KEEP_TRUE;
+	else if (!strcmp(sb.buf, "b"))
+		state->keep = KEEP_NON_PATCH;
+	else
+		state->keep = KEEP_FALSE;
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -560,6 +577,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 			const char **paths)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
+	const char *str;
 
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
@@ -588,6 +606,22 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "utf8"), 1, state->utf8 ? "t" : "f");
 
+	switch (state->keep) {
+	case KEEP_FALSE:
+		str = "f";
+		break;
+	case KEEP_TRUE:
+		str = "t";
+		break;
+	case KEEP_NON_PATCH:
+		str = "b";
+		break;
+	default:
+		die("BUG: invalid value for state->keep");
+	}
+
+	write_file(am_path(state, "keep"), 1, "%s", str);
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -760,6 +794,20 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	argv_array_push(&cp.args, "mailinfo");
 	argv_array_push(&cp.args, state->utf8 ? "-u" : "-n");
+
+	switch (state->keep) {
+	case KEEP_FALSE:
+		break;
+	case KEEP_TRUE:
+		argv_array_push(&cp.args, "-k");
+		break;
+	case KEEP_NON_PATCH:
+		argv_array_push(&cp.args, "-b");
+		break;
+	default:
+		die("BUG: invalid value for state->keep");
+	}
+
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1476,6 +1524,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("add a Signed-off-by line to the commit message")),
 		OPT_BOOL('u', "utf8", &state.utf8,
 			N_("recode into utf8 (default)")),
+		OPT_SET_INT('k', "keep", &state.keep,
+			N_("pass -k flag to git-mailinfo"), KEEP_TRUE),
+		OPT_SET_INT(0, "keep-non-patch", &state.keep,
+			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc1.76.gf60a929
