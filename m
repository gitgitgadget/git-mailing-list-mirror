Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79785C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DA024198
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 15:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgKQPZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 10:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbgKQPZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 10:25:40 -0500
X-Greylist: delayed 73810 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Nov 2020 07:25:40 PST
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA04C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 07:25:40 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1605626738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W+a9OcsOe68hrvFz/8Sl4S+a7+FtLisP6CTcvRMniC0=;
        b=MSgZYhrLdmKmJtlZEB3LjwLN4SCwM9DmmiUL4tCI7vSZRXdvYnp7SS2V+ys62J0AYISAaB
        42aSRUdDqhf8UKqdwItW0OT0BgIi2mCXLyLkaQ88GeBj0fuIh3xmuZKLefvOEKnLRfIGiH
        1NW+9vh9P5KWXkeDwvAbcvGALOHotKaHYLTJp9M9KV9/leKgGtd2KJcAAd9gsopoEad9o7
        esSSsrC0zLzdqzV+guxS+ZP970AWcrzqRRScFHQ7keuGWbD9oUaQBy8OGA6S+wcXilpdCG
        Jm4XHJShzU46iimtvN6MImg307PVFfP7vuEuXjJ6+lNXXUs50H5wA+DdFSV8Lg==
From:   Drew DeVault <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, lanodan <contact+git@hacktivis.me>
Subject: [PATCH v2] help.c: configurable suggestions
Date:   Tue, 17 Nov 2020 10:25:35 -0500
Message-Id: <20201117152535.9795-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows users to disable guessing the commands or options that they
meant to use.
---
 Documentation/config/help.txt | 14 +++++++-------
 help.c                        | 27 ++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 224bbf5a28..99d1e33750 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -8,13 +8,13 @@ help.format::
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
+	deciseconds (0.1 sec). If this value is 0, the suggested corrections
+	will be shown, but not executed. If -1, the suggested command is run
+	immediately. If -2, suggestions are not shown at all. The default value
+	is zero.
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 919cbb9206..2fd27cffb0 100644
--- a/help.c
+++ b/help.c
@@ -472,12 +472,18 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
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
+	if (!strcasecmp(var, "help.autocorrect")) {
+		if (!value)
+			return config_error_nonbool(var);
+		autocorrect = git_config_int(var, value);
+	}
 	/* Also use aliases for command lookup */
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&aliases, p, strlen(p));
@@ -525,6 +531,11 @@ const char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(git_unknown_cmd_config, NULL);
 
+	if (autocorrect == AUTOCORRECT_NEVER) {
+		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
+		exit(1);
+	}
+
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	add_cmd_list(&main_cmds, &aliases);
@@ -586,7 +597,7 @@ const char *help_unknown_cmd(const char *cmd)
 		     n++)
 			; /* still counting */
 	}
-	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
+	if (autocorrect != 0 && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
 		clean_cmdnames(&main_cmds);
@@ -594,7 +605,7 @@ const char *help_unknown_cmd(const char *cmd)
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
 			   cmd);
-		if (autocorrect < 0)
+		if (autocorrect == AUTOCORRECT_IMMEDIATELY)
 			fprintf_ln(stderr,
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
@@ -706,10 +717,16 @@ NORETURN void help_unknown_ref(const char *ref, const char *cmd,
 			       const char *error)
 {
 	int i;
-	struct string_list suggested_refs = guess_refs(ref);
+	struct string_list suggested_refs;
 
 	fprintf_ln(stderr, _("%s: %s - %s"), cmd, ref, error);
 
+	if (autocorrect == AUTOCORRECT_NEVER) {
+		exit(1);
+	}
+
+	suggested_refs = guess_refs(ref);
+
 	if (suggested_refs.nr > 0) {
 		fprintf_ln(stderr,
 			   Q_("\nDid you mean this?",
-- 
2.29.2

