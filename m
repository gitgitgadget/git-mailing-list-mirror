From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 25/31] am: implement --[no-]message-id, am.messageid
Date: Thu, 18 Jun 2015 19:25:37 +0800
Message-ID: <1434626743-8552-26-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xz2-0005cI-Ho
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbbFRL1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:41 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33347 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbbFRL1T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:19 -0400
Received: by pdjn11 with SMTP id n11so64841430pdj.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeuxcEFL/JOpW83ga044TBBfbA2CHu3mYE/ImVEYtF4=;
        b=WeKlJYRuPl416Cw7ueQqWNoy7Es5QBdW0RdMvAkDLT383HOr/tDiJcfmPO9zhFBmyy
         iTzBdF8c+cSRZOvfseBdRC1/2ErhY9i+OI66DSBjLvULwhCWaR88z0miLVN5NMEbmfHc
         ldf/hgyaxmL/VZrZHwdJmDNOxQAHyDNBcuD1fAHziNcSDdea37kq4OaaH8L+Ocm2eW1W
         SgLI6NmaWq5d0rdksx+TVt/LOBraKcgY581ryJTZ9Z7AcTsJzENoKi68WOwrZUjoFEAk
         N8NMVe1LQ9dS2gaPYhA4zLWj1JH8zMzV8yuXjaRJArKaul6m2gfkazyRudVoOqxLy1Mi
         Thgw==
X-Received: by 10.70.29.164 with SMTP id l4mr20300631pdh.32.1434626839253;
        Thu, 18 Jun 2015 04:27:19 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:17 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271991>

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
index b73549f..4cec380 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -113,6 +113,9 @@ struct am_state {
 	/* one of the enum keep_type values */
 	int keep;
 
+	/* pass -m flag to git-mailinfo */
+	int message_id;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -140,6 +143,8 @@ static void am_state_init(struct am_state *state)
 	quiet = getenv("GIT_QUIET");
 	if (quiet && *quiet)
 		state->quiet = 1;
+
+	git_config_get_bool("am.messageid", &state->message_id);
 }
 
 /**
@@ -350,6 +355,9 @@ static void am_load(struct am_state *state)
 	else
 		state->keep = KEEP_FALSE;
 
+	read_state_file(&sb, am_path(state, "messageid"), 2, 1);
+	state->message_id = !strcmp(sb.buf, "t");
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -560,6 +568,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	}
 	write_file(am_path(state, "keep"), 1, "%s", str);
 
+	write_file(am_path(state, "messageid"), 1, state->message_id ? "t" : "f");
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -700,6 +710,9 @@ static int parse_patch(struct am_state *state, const char *patch)
 		die("BUG: invalid value for state->keep");
 	}
 
+	if (state->message_id)
+		argv_array_push(&cp.args, "-m");
+
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1377,6 +1390,8 @@ static struct option am_options[] = {
 		N_("pass -k flag to git-mailinfo"), KEEP_TRUE),
 	OPT_SET_INT(0, "keep-non-patch", &state.keep,
 		N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
+	OPT_BOOL('m', "message-id", &state.message_id,
+		N_("pass -m flag to git-mailinfo")),
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
-- 
2.1.4
