Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA22C63777
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F4D24905
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgKRRuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:50:39 -0500
Received: from out1.migadu.com ([91.121.223.63]:57724 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgKRRuj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 12:50:39 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1605721836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ve9805BIICnYcVFJl6jTBg7viU8YpR1S3E9jKufJ7/k=;
        b=TZNdl+75zeCcfWFyyrDT9SLtccl/Tr4mDHvRe3wgu9mjIyDM35FjCuDEMskKbJ8w5T6lU7
        Y5f2U8l7Dl7sUL5o+y7LaP6v2Iua+reCMsNaowYiJF0spm3Qj2BMfSF51pDeabgVyAvXe1
        C+3TxmZXQL8S8AuhnQv3TznJbrMxId5RzRDXuRay00C+jZ3+fLkgp4JR4v+FwviWmgi084
        W9boNOES13zE4pySO/8sQNiX70eCuWLWKtisFA4iO8JH55ZKnh8eJp+HTbLyLHabRFqv4S
        Mb2Td6LkPxembBgC+ZTimvXXZ21AUJLV3lhHbX6wIEwWny5/niLgrQ2lIOWXog==
From:   Drew DeVault <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, lanodan <contact+git@hacktivis.me>
Subject: [PATCH v5] help.c: expand options for help.autocorrect
Date:   Wed, 18 Nov 2020 12:49:14 -0500
Message-Id: <20201118174913.3372-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users would prefer to never suggest corrections at all. For
example, they may want the mistake over with sooner so that they can
issue the correct command, especially on low-end hardware which may take
a while to calculate suggestions.

This updates help.autocorrect to accept the strings "immediate" and
"never" for this purpose, the former assuming the prior behavior of
negative values for autocorrect, and the latter skipping auto-correction
entirely.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
v4 -> v5: More detailed commit message.

 Documentation/config/help.txt | 16 +++++++++-------
 help.c                        | 25 ++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 10 deletions(-)

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
-- 
2.29.2

