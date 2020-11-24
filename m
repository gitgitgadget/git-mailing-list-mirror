Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB07CC63777
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 16:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40240204FD
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 16:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390517AbgKXQh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 11:37:57 -0500
Received: from out0.migadu.com ([94.23.1.103]:35436 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390077AbgKXQh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 11:37:57 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1606235907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gJmEKl58piPsU3KD54O4x9NMbg9joXuv282nUENexhw=;
        b=IDv3naPIsx52/FODSgdu10s94vM+X8t4zmUdI52le8jAP6i/eESTL7fPT3OxQ03AapjP++
        cvl1zxv4qWRcmrpxngN1QWtrLylRoCf1T4gpGnAMe6b/ZxdX5YASNH7IocQ3QJjH5ZDARL
        xBUFhVZT/FCC5MjUyV8rkhd26aJArRhoZGJi7zpDjpdMc9SFV+SSsJdLH65nbFGfO43YSw
        5koANKHRSvCPhGYCHO419vrnx8wHls5sqgVrvwLUxDVvtxcqlHQ90Ajtgnux9anFD9Nv5B
        PqioG3062AMWM5ikBIThuHsyVp09Tnl4xWvKJ6peg5tsHoyIhElRasUbfvzT7A==
From:   Drew DeVault <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, lanodan <contact+git@hacktivis.me>
Subject: [PATCH v5] help.c: expand options for help.autocorrect
Date:   Tue, 24 Nov 2020 11:37:52 -0500
Message-Id: <20201124163752.20306-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While help.autocorrect can be set to 0 to decline auto-execution of
possibly mistyped commands, it still spends cycles to compute the
suggestions, and it wastes screen real estate.

Update help.autocorrect to accept the string "never" to just exit
with error upon mistyped commands to help users who prefer to never
see suggested corrections at all.

While at it, introduce "immediate" as a more readable way to
immediately execute the auto-corrected command, which can be done
with negative value.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v5 incorporates Junio's suggested commit message and test.

 Documentation/config/help.txt | 16 +++++++++-------
 help.c                        | 25 ++++++++++++++++++++++---
 t/t9003-help-autocorrect.sh   | 13 +++++++++++++
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 224bbf5a28..e07abd32d7 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -8,13 +8,15 @@ help.format::
 	the default. 'web' and 'html' are the same.
 
 help.autoCorrect::
-	Automatically correct and execute mistyped commands after
-	waiting for the given number of deciseconds (0.1 sec). If more
-	than one command can be deduced from the entered text, nothing
-	will be executed.  If the value of this option is negative,
-	the corrected command will be executed immediately. If the
-	value is 0 - the command will be just shown but not executed.
-	This is the default.
+	If git detects typos and can identify exactly one valid command similar
+	to the error, git will automatically run the intended command after
+	waiting a duration of time defined by this configuration value in
+	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
+	will be shown, but not executed. If "immediate", the suggested command
+	is run immediately. If "never", suggestions are not shown at all. The
+	default value is zero.
++
+Negative integers are interpreted as "immediately" for historical reasons.
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 919cbb9206..3c3bdec213 100644
--- a/help.c
+++ b/help.c
@@ -472,12 +472,26 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 static int autocorrect;
 static struct cmdnames aliases;
 
+#define AUTOCORRECT_NEVER (-2)
+#define AUTOCORRECT_IMMEDIATELY (-1)
+
 static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
 	const char *p;
 
-	if (!strcmp(var, "help.autocorrect"))
-		autocorrect = git_config_int(var,value);
+	if (!strcmp(var, "help.autocorrect")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcmp(value, "never")) {
+			autocorrect = AUTOCORRECT_NEVER;
+		} else if (!strcmp(value, "immediate")) {
+			autocorrect = AUTOCORRECT_IMMEDIATELY;
+		} else {
+			int v = git_config_int(var, value);
+			autocorrect = (v < 0)
+				? AUTOCORRECT_IMMEDIATELY : v;
+		}
+	}
 	/* Also use aliases for command lookup */
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&aliases, p, strlen(p));
@@ -525,6 +539,11 @@ const char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(git_unknown_cmd_config, NULL);
 
+	if (autocorrect == AUTOCORRECT_NEVER) {
+		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
+		exit(1);
+	}
+
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	add_cmd_list(&main_cmds, &aliases);
@@ -594,7 +613,7 @@ const char *help_unknown_cmd(const char *cmd)
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
 			   cmd);
-		if (autocorrect < 0)
+		if (autocorrect == AUTOCORRECT_IMMEDIATELY)
 			fprintf_ln(stderr,
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index b1c7919c4a..8f1035c3c2 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -49,4 +49,17 @@ test_expect_success 'autocorrect running commands' '
 	test_cmp expect actual
 '
 
+test_expect_success 'autocorrect can be declined altogether' '
+	git config help.autocorrect never &&
+
+	test_must_fail git lfg 2>actual &&
+	if test_have_prereq C_LOCALE_OUTPUT
+	then
+		: cannot test with poisoned i18n
+	else
+		grep "is not a git command" actual &&
+		test_line_count = 1 actual
+	fi
+'
+
 test_done
-- 
2.29.2

