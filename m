From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 24/45] builtin-am: implement -u/--utf8
Date: Mon, 20 Jul 2015 00:10:16 +0800
Message-ID: <1437322237-29863-25-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrC1-0006Qd-Kr
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbbGSQLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:51 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34458 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbbGSQLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:49 -0400
Received: by pacan13 with SMTP id an13so89908254pac.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6AZqNUNYgFDUZ/Zq6TNnRd4HyjL107kcqGjyp1o0y5g=;
        b=UaibVO0jcWyJLTVEsFp18c9XhuP7zc+uI7pcAvcohSuz4kgyNCH7K2hqtGN9SC4oDH
         6X0LnBKnwB4D1psL3e2C/3n/da4jZLij6zncSYTmIyl0CHKIaDwvXEjxOmiaJmqsZ1pH
         wTX6optTxWi2amG4vPvcfOwt2vlj5QFnkc5Hsw3KEWFLZLx0ps4xCpLnCZVtkvWk8Q6l
         wxxGNFthWBxEj8G+fzNW4Y5+UTw6OUoKJDFr+NuwRcrKGtSOCN6DK2lH7iZ1/oqT0ftM
         nuo2Ziwsn9z70MDthKaHZBNm39tdmLQHcxDIACg2VHDvBQyJqfG8hN79YYmWaRq9DY/Q
         ownQ==
X-Received: by 10.70.44.13 with SMTP id a13mr2393055pdm.96.1437322308619;
        Sun, 19 Jul 2015 09:11:48 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274246>

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
 builtin/am.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 398debf..a64a859 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -90,6 +90,7 @@ struct am_state {
 	int threeway;
 	int quiet;
 	int append_signoff;
+	int utf8;
 	const char *resolvemsg;
 	int rebasing;
 };
@@ -108,6 +109,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->prec = 4;
 
 	git_config_get_bool("am.threeway", &state->threeway);
+
+	state->utf8 = 1;
 }
 
 /**
@@ -369,6 +372,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "sign", 1);
 	state->append_signoff = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "utf8", 1);
+	state->utf8 = !strcmp(sb.buf, "t");
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -558,6 +564,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "sign"), 1, state->append_signoff ? "t" : "f");
 
+	write_file(am_path(state, "utf8"), 1, state->utf8 ? "t" : "f");
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -724,6 +732,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	cp.out = xopen(am_path(state, "info"), O_WRONLY | O_CREAT, 0777);
 
 	argv_array_push(&cp.args, "mailinfo");
+	argv_array_push(&cp.args, state->utf8 ? "-u" : "-n");
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1461,6 +1470,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_BOOL('s', "signoff", &state.append_signoff,
 			N_("add a Signed-off-by line to the commit message")),
+		OPT_BOOL('u', "utf8", &state.utf8,
+			N_("recode into utf8 (default)")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc2.110.gb39b692
