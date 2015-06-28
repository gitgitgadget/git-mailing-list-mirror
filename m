From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 25/44] builtin-am: implement --[no-]message-id, am.messageid
Date: Sun, 28 Jun 2015 22:05:47 +0800
Message-ID: <1435500366-31700-26-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DFx-0002UW-MA
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbbF1OIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:21 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33540 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbbF1OIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:06 -0400
Received: by pdjn11 with SMTP id n11so101605701pdj.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oM5aNbTL7EJgACkiILDmPJXMko+mZXQv3nz1iAERrIE=;
        b=nqCaqaWMRe/Zn0z2uVeMBWCWODntGuNDEjstP74f0fcFdQifaqMVxancTXQ1aJFaVS
         8qBD0QVYlEiz3vifR6MXjT81KNyIPUwztyJ7/+RLb3KwOUrd7tUdlFOy6Nve7216w/fK
         Bpuk/Nja+YrzF/WMLPo0LPlJxKYiO8JIfV3PNxDp+hhh7MWLIHtZbLfLnHnqZBxDl3LK
         V8T+AyCX0thtX3ERXbfWM+piq+BlFhGGnPMym9r/tKhWnf0xXk92W+VmthncsNAfnzKj
         bd2cDPDRROO2UZZUlg8Mh73YG5JD9JZ+YQI7NiuCRuaiCfTOYzZ1WqQwTINyQPvq1wlX
         FWLA==
X-Received: by 10.70.128.104 with SMTP id nn8mr22623274pdb.28.1435500485735;
        Sun, 28 Jun 2015 07:08:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272897>

Since a078f73 (git-am: add --message-id/--no-message-id, 2014-11-25),
git-am.sh supported the --[no-]message-id options, and the
"am.messageid" setting which specifies the default option.

--[no-]message-id tells git-am whether or not the -m option should be
passed to git-mailinfo.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    No test for am.messageid

 builtin/am.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 3410601..52e5b5a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -103,6 +103,9 @@ struct am_state {
 	/* one of the enum keep_type values */
 	int keep;
 
+	/* pass -m flag to git-mailinfo */
+	int message_id;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -131,6 +134,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 		state->quiet = 1;
 
 	state->utf8 = 1;
+
+	git_config_get_bool("am.messageid", &state->message_id);
 }
 
 /**
@@ -420,6 +425,9 @@ static void am_load(struct am_state *state)
 	else
 		state->keep = KEEP_FALSE;
 
+	read_state_file(&sb, state, "messageid", 1);
+	state->message_id = !strcmp(sb.buf, "t");
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -628,6 +636,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "keep"), 1, "%s", str);
 
+	write_file(am_path(state, "messageid"), 1, state->message_id ? "t" : "f");
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -814,6 +824,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die("BUG: invalid value for state->keep");
 	}
 
+	if (state->message_id)
+		argv_array_push(&cp.args, "-m");
+
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1534,6 +1547,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("pass -k flag to git-mailinfo"), KEEP_TRUE),
 		OPT_SET_INT(0, "keep-non-patch", &state.keep,
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
+		OPT_BOOL('m', "message-id", &state.message_id,
+			N_("pass -m flag to git-mailinfo")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc0.76.gb2c6e93
