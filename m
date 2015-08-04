From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 25/45] builtin-am: implement -k/--keep, --keep-non-patch
Date: Tue,  4 Aug 2015 21:51:46 +0800
Message-ID: <1438696326-19590-26-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:59:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMck8-00051N-Hv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934294AbbHDN6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:58:54 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35418 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964892AbbHDNyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:04 -0400
Received: by pdrg1 with SMTP id g1so4869097pdr.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7c1LQZA6c2k9abiLNv1zf9o9cFQpYHXxSHDogVPeYZ8=;
        b=ZUVt6DlpW6TbB8lwcuJCjOwqmmihHTtHsDaVz+44G0lrJvbfMi5/PDJBKghVGOj9KP
         aKHD2dLCSYw6U0MCRj3bDQXFgBxVKe+FBZvh61CRELXXwUcN141wkmHEba5Zk/tixr/T
         vW490/msDRZVniocXCsCoiHYVxx4xoZLqX5c5b1pvD1BY4Gak3vY+qRv3vpvDsRGpjgO
         KTS2ryY60xyeJYNmxnYTRR05gDwqOQH0Z4Xwc6A2GM2jzJBFq8C7paqHrlkjN13pOpQF
         GCu/msUtaUi+lmo0GYIJ1Ni1tLSdCeCroJzxSUpm0XBSNU74GmAXzKP1pYPx7C+DT0Y/
         mvlQ==
X-Received: by 10.70.38.69 with SMTP id e5mr8039285pdk.27.1438696444287;
        Tue, 04 Aug 2015 06:54:04 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275315>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh supported the -k/--keep option to pass the -k option to
git-mailsplit.

Since f7e5ea1 (am: learn passing -b to mailinfo, 2012-01-16), git-am.sh
supported the --keep-non-patch option to pass the -b option to
git-mailsplit.

Re-implement these two options in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 528b2c9..68dca2e 100644
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
@@ -91,6 +97,7 @@ struct am_state {
 	int quiet;
 	int signoff;
 	int utf8;
+	int keep; /* enum keep_type */
 	const char *resolvemsg;
 	int rebasing;
 };
@@ -373,6 +380,14 @@ static void am_load(struct am_state *state)
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
@@ -536,6 +551,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 			const char **paths)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
+	const char *str;
 
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
@@ -564,6 +580,22 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
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
@@ -731,6 +763,20 @@ static int parse_mail(struct am_state *state, const char *mail)
 
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
 
@@ -1471,6 +1517,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.280.gd88bd6e
