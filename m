From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 25/44] builtin-am: implement --[no-]message-id, am.messageid
Date: Tue,  7 Jul 2015 22:20:43 +0800
Message-ID: <1436278862-2638-26-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmD-00051M-62
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759AbbGGOXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:03 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:32831 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757695AbbGGOW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:27 -0400
Received: by pdbdz6 with SMTP id dz6so31988519pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LarOTTEJ5TBYRA3OyIJb/h+2YNvyE0xd9rC6cYOnj1E=;
        b=MHWlMCN4W82iZzakkX14PghdLJ7IINl2i2dLE4MXd0XzWH3u7XL7LASt4yMx0kyOZh
         mwpqUdB2eqlOoNubSQcvDmPT9bMgYgCiZu1Le22a9u2qO6eWD26GNwmN4JeOBxHfyQBD
         6aoCu2uTPHibt6o9hKhZMU1E5VdzAW4wibEIzXy2LNAe9Pm3PdpGO6evYvY2tVdNE+Xq
         z1iTTZQ/mUMCFFowxWUlGd0v77TvBULLiq6UEt0NJMgpiyIvHw/zqXvEWVzBfwUdbvj+
         bJcosd5spec7B6XbNFNO2XSH4G5CmN8Y1uRdllThHvfE0kuCHh2DqWv2vKey340qND31
         KdPg==
X-Received: by 10.70.53.99 with SMTP id a3mr9420467pdp.169.1436278946712;
        Tue, 07 Jul 2015 07:22:26 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273541>

Since a078f73 (git-am: add --message-id/--no-message-id, 2014-11-25),
git-am.sh supported the --[no-]message-id options, and the
"am.messageid" setting which specifies the default option.

--[no-]message-id tells git-am whether or not the -m option should be
passed to git-mailinfo.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 4e1ee7f..099c6ed 100644
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
 
@@ -125,6 +128,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	git_config_get_bool("am.threeway", &state->threeway);
 
 	state->utf8 = 1;
+
+	git_config_get_bool("am.messageid", &state->message_id);
 }
 
 /**
@@ -414,6 +419,9 @@ static void am_load(struct am_state *state)
 	else
 		state->keep = KEEP_FALSE;
 
+	read_state_file(&sb, state, "messageid", 1);
+	state->message_id = !strcmp(sb.buf, "t");
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -622,6 +630,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "keep"), 1, "%s", str);
 
+	write_file(am_path(state, "messageid"), 1, state->message_id ? "t" : "f");
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -808,6 +818,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die("BUG: invalid value for state->keep");
 	}
 
+	if (state->message_id)
+		argv_array_push(&cp.args, "-m");
+
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1528,6 +1541,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("pass -k flag to git-mailinfo"), KEEP_TRUE),
 		OPT_SET_INT(0, "keep-non-patch", &state.keep,
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
+		OPT_BOOL('m', "message-id", &state.message_id,
+			N_("pass -m flag to git-mailinfo")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc1.76.gf60a929
