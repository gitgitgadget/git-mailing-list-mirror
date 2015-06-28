From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 24/44] builtin-am: implement -k/--keep, --keep-non-patch
Date: Sun, 28 Jun 2015 22:05:46 +0800
Message-ID: <1435500366-31700-25-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DG1-0002X7-Ir
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbbF1OIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:24 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33453 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbbF1OIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:04 -0400
Received: by padev16 with SMTP id ev16so91889732pad.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OxoFJDQPORpz75Nf5NqhNl+Y0Tvn+Fb2In0y1HG+tTQ=;
        b=ybcGYkbVqHQWcT1rdPrAcEI4Cw5p03W920a1seRxXshQlYsonz1VLyUnEzkGiTWdgo
         dhFV9ry0MirjJfW3R3H71hCKHteC6Kt9rgRg+mFZF6qquTGU0t5pT2eMleb+cevHPQpJ
         xFssSPA8FclGgyFIo69Hl/37uHZvKVBNsSqhQT4UJVlynGFIVwGxOXIL5aeU3U/MR9Qm
         MHMk7Z35BipnvYlshjlv9MMVUoUmaje4PkS/3/Wu7ZQg7pY/Ulli/ZE3F1rv2i+xaB2Z
         Z4VyVpzvmDHulmh4kYn+NpXUTmhX8H5Nj0HjrQHvbdzDJ5NkaYoZr5NSOfKUlyi2wab+
         43NA==
X-Received: by 10.70.42.233 with SMTP id r9mr22241266pdl.140.1435500483668;
        Sun, 28 Jun 2015 07:08:03 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272898>

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
index bc44225..3410601 100644
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
 
@@ -403,6 +412,14 @@ static void am_load(struct am_state *state)
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
@@ -566,6 +583,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 			const char **paths)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
+	const char *str;
 
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
@@ -594,6 +612,22 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
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
@@ -766,6 +800,20 @@ static int parse_mail(struct am_state *state, const char *mail)
 
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
 
@@ -1482,6 +1530,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc0.76.gb2c6e93
