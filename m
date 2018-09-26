Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F671F453
	for <e@80x24.org>; Wed, 26 Sep 2018 10:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeIZQi7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 12:38:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39998 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeIZQi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 12:38:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id t22-v6so12987649lfb.7
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dMFzkXD1dT1P0RomVvaRyYKn+VbA1NCoWtxdTHE/XRs=;
        b=f85sRGnlbgTya0w0wMgkmNz/xkIIYPhMyfU/N9aHnnU0M8yNS004GdYFIUo9d1QF34
         0emFKvvhEMXGnulmZOLNezqyZIZnNqdXQsJAAr3znCc5xGcTpF8ROAcFZtTzloqQw28g
         PiaEuIw1Zx3iP00CLkO5GxNzyN6fvkDurUZgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dMFzkXD1dT1P0RomVvaRyYKn+VbA1NCoWtxdTHE/XRs=;
        b=sGbWD+rEAGrPxnn/OBoRUyOI/ieuGyniTk0ouhzyu4yC6tuWV9oK7amN4NtYA71FJc
         5QG1LR1tM3TqW1w5hGB7tYNKjQYidWxDk/epMUCSCr5qy77fKt7qeWrZr7n7Zy7TMeiV
         XPSfMXgA0FclEgEf9Z7XxIBxQJ3ke5KqdI6koIVbPpWD+68VlSU1Z/g4EcAqgoqoGmNK
         GOx+csSOcSiXOm/iPBywRYdSXzuiP8cJGrxLEuGHZnGHyA0jv1oeoE0YzKM2m76xCR7R
         yqaU1cazWpoQ1mvUCm86W6i+HCZQBzUyBqXfcyl5KSiEheab9rXhkTQchE8dUgf7NW4V
         r/Fg==
X-Gm-Message-State: ABuFfogryt0TuNNEZyHyrWeb+Zg1hDIfcsKZXkqA1Gz2fxjMHQTzUIiE
        /2Kkn2CtoepiueWJQpXZ459vqnbY9n9Mv7qk
X-Google-Smtp-Source: ACcGV6376gjTKNeKl219Kykzi6YXN7okK9orgcrZBQgTyT5pxK9cNu/5PGlpUbNxYQ0ic4Ug2lGoWQ==
X-Received: by 2002:a19:2a8c:: with SMTP id q12-v6mr3701121lfq.95.1537957600833;
        Wed, 26 Sep 2018 03:26:40 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s140-v6sm932128lfs.91.2018.09.26.03.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 03:26:39 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] help: allow redirecting to help for aliased command
Date:   Wed, 26 Sep 2018 12:26:36 +0200
Message-Id: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I often use 'git <cmd> --help' as a quick way to get the documentation
for a command. However, I've also trained my muscle memory to use my
aliases (cp=cherry-pick, co=checkout etc.), which means that I often end
up doing

  git cp --help

to which git correctly informs me that cp is an alias for
cherry-pick. However, I already knew that, and what I really wanted was
the man page for the cherry-pick command.

This introduces a help.followAlias config option that transparently
redirects to (the first word of) the alias text (provided of course it
is not a shell command), similar to the option for autocorrect of
misspelled commands.

The documentation in config.txt could probably be improved. Also, I
mimicked the autocorrect case in that the "Continuing to ..." text goes
to stderr, but because of that, I also print the "is aliased to" text to
stderr, which is different from the current behaviour of using
stdout. I'm not sure what the most correct thing is, but I assume --help
is mostly used interactively with stdout and stderr pointing at the same
place.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 Documentation/config.txt | 10 ++++++++++
 builtin/help.c           | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad0f4510c3..8a1fc8064e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2105,6 +2105,16 @@ help.autoCorrect::
 	value is 0 - the command will be just shown but not executed.
 	This is the default.
 
+help.followAlias::
+	When requesting help for an alias, git prints a line of the
+	form "'<alias>' is aliased to '<string>'". If this option is
+	set to a positive integer, git proceeds to show the help for
+	the first word of <string> after the given number of
+	deciseconds. If the value of this option is negative, the
+	redirect happens immediately. If the value is 0 (which is the
+	default), or <string> begins with an exclamation point, no
+	redirect takes place.
+
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
 	and URLs are supported. HTML pages will be prefixed with this path when
diff --git a/builtin/help.c b/builtin/help.c
index 8d4f6dd301..ef1c3f0916 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -34,6 +34,7 @@ enum help_format {
 };
 
 static const char *html_path;
+static int follow_alias;
 
 static int show_all = 0;
 static int show_guides = 0;
@@ -273,6 +274,10 @@ static int git_help_config(const char *var, const char *value, void *cb)
 		html_path = xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "help.followalias")) {
+		follow_alias = git_config_int(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "man.viewer")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -415,9 +420,34 @@ static const char *check_git_cmd(const char* cmd)
 
 	alias = alias_lookup(cmd);
 	if (alias) {
-		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
-		free(alias);
-		exit(0);
+		const char **argv;
+		int count;
+
+		if (!follow_alias || alias[0] == '!') {
+			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
+			free(alias);
+			exit(0);
+		}
+		fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);
+
+		/*
+		 * We use split_cmdline() to get the first word of the
+		 * alias, to ensure that we use the same rules as when
+		 * the alias is actually used. split_cmdline()
+		 * modifies alias in-place.
+		 */
+		count = split_cmdline(alias, &argv);
+		if (count < 0)
+			die("Bad alias.%s string: %s", cmd,
+			    split_cmdline_strerror(count));
+
+		if (follow_alias > 0) {
+			fprintf_ln(stderr,
+				   _("Continuing to help for %s in %0.1f seconds."),
+				   alias, follow_alias/10.0);
+			sleep_millisec(follow_alias * 100);
+		}
+		return alias;
 	}
 
 	if (exclude_guides)
-- 
2.16.4

