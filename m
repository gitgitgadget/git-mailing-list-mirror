From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 26/45] builtin-am: implement --[no-]message-id, am.messageid
Date: Mon, 20 Jul 2015 00:10:18 +0800
Message-ID: <1437322237-29863-27-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:13:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrDI-00074k-LL
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015AbbGSQLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:55 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36796 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbbGSQLx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:53 -0400
Received: by pdjr16 with SMTP id r16so91402052pdj.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=duQ0VpCBwU1vCd7U3OFa96n00MQnknncC+TYXx4oAHI=;
        b=TD4iOoHIucE2mm90V2m4vDBsM3QnYRdJxTSRdACJok6PGeCuRDoThUH3Nq0kJ3dTHc
         kjYE8U5E6SkS3GrklLM0Rjg0nne/MOwM7k0P/XLBv1yLeRZvfoQVknlIujm6qwPeZ7av
         9cdbsZLF+TApRsn/NOpl+D/dYAVL/dPK8hOknthYKizTdBj1WLu3pPFsNtElCBtePV0i
         IHIfZda7LYNrQowi75qSTVetSzLfqjZN8tB9F3seTxX3wuW1gPO9zYZ15pG9RIJP/lS8
         mQ0kt4UUafKp47GuqVE9XSgjY43fbWZV/jZkrmTL+oVYHAx4F3kV+KqBqG+Jl41FRZS3
         NT6w==
X-Received: by 10.70.45.134 with SMTP id n6mr16295721pdm.124.1437322313201;
        Sun, 19 Jul 2015 09:11:53 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274269>

Since a078f73 (git-am: add --message-id/--no-message-id, 2014-11-25),
git-am.sh supported the --[no-]message-id options, and the
"am.messageid" setting which specifies the default option.

--[no-]message-id tells git-am whether or not the -m option should be
passed to git-mailinfo.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index af08a22..e41a104 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -98,6 +98,7 @@ struct am_state {
 	int append_signoff;
 	int utf8;
 	int keep; /* enum keep_type */
+	int message_id;
 	const char *resolvemsg;
 	int rebasing;
 };
@@ -118,6 +119,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	git_config_get_bool("am.threeway", &state->threeway);
 
 	state->utf8 = 1;
+
+	git_config_get_bool("am.messageid", &state->message_id);
 }
 
 /**
@@ -390,6 +393,9 @@ static void am_load(struct am_state *state)
 	else
 		state->keep = KEEP_FALSE;
 
+	read_state_file(&sb, state, "messageid", 1);
+	state->message_id = !strcmp(sb.buf, "t");
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -598,6 +604,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "keep"), 1, "%s", str);
 
+	write_file(am_path(state, "messageid"), 1, state->message_id ? "t" : "f");
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -779,6 +787,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die("BUG: invalid value for state->keep");
 	}
 
+	if (state->message_id)
+		argv_array_push(&cp.args, "-m");
+
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1522,6 +1533,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("pass -k flag to git-mailinfo"), KEEP_TRUE),
 		OPT_SET_INT(0, "keep-non-patch", &state.keep,
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
+		OPT_BOOL('m', "message-id", &state.message_id,
+			N_("pass -m flag to git-mailinfo")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc2.110.gb39b692
