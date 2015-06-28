From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 23/44] builtin-am: implement -u/--utf8
Date: Sun, 28 Jun 2015 22:05:45 +0800
Message-ID: <1435500366-31700-24-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DG5-0002ab-IF
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbbF1OI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:27 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36220 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbF1OIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:01 -0400
Received: by pdcu2 with SMTP id u2so101482836pdc.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2EPGB7kWyv8f8Y4ju7ejqZNqp8hvUiAIDkKA136XHY=;
        b=I01xClqwAfidUV3sju25+CbKe1ZdmPoi0znp63F61Ce3fTJEB8lhNCL4fBwMhdmJRs
         6dP3g79VJPJYzDM3/gHwUZn5/Y/ixQQ0TJ/yF7rCuu/LmFODGm87RU6GAGDMl+3HJ5e2
         Eg278nLE9vQCBv5PVmjvAeBae3wIV6VWnr+ajwyNYtfYX4QCwiLJHbwJqjvWJ3AI6Lex
         KIDjEo7xRHrdsFp85yN+XjYS0IoXbtZx9WnVOPOlx0gU9mR2eTkXRyCCwjsb3PWlSaaf
         F3RwTGyFRWzoXoQezlmnnSQjjMyZ7wxSN2NZAdspJTWiD1acJXX3BFSurpg1/tgc2JuA
         yk1g==
X-Received: by 10.68.138.230 with SMTP id qt6mr22755975pbb.160.1435500480644;
        Sun, 28 Jun 2015 07:08:00 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272899>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh supported the -u,--utf8 option. If set, the -u option will be
passed to git-mailinfo to re-code the commit log message and authorship
in the charset specified by i18n.commitencoding. If unset, the -n option
will be passed to git-mailinfo, which disables the re-encoding.

Since d84029b (--utf8 is now default for 'git-am', 2007-01-08), --utf8
is specified by default in git-am.sh.

Re-implement the above in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 49a6840..bc44225 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -92,6 +92,8 @@ struct am_state {
 
 	int append_signoff;
 
+	int utf8;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
@@ -118,6 +120,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	quiet = getenv("GIT_QUIET");
 	if (quiet && *quiet)
 		state->quiet = 1;
+
+	state->utf8 = 1;
 }
 
 /**
@@ -396,6 +400,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "sign", 1);
 	state->append_signoff = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "utf8", 1);
+	state->utf8 = !strcmp(sb.buf, "t");
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -585,6 +592,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "sign"), 1, state->append_signoff ? "t" : "f");
 
+	write_file(am_path(state, "utf8"), 1, state->utf8 ? "t" : "f");
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -756,6 +765,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	cp.out = xopen(am_path(state, "info"), O_WRONLY | O_CREAT, 0777);
 
 	argv_array_push(&cp.args, "mailinfo");
+	argv_array_push(&cp.args, state->utf8 ? "-u" : "-n");
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1470,6 +1480,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_BOOL('s', "signoff", &state.append_signoff,
 			N_("add a Signed-off-by line to the commit message")),
+		OPT_BOOL('u', "utf8", &state.utf8,
+			N_("recode into utf8 (default)")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc0.76.gb2c6e93
