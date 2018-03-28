Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787431F404
	for <e@80x24.org>; Wed, 28 Mar 2018 23:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbeC1Xrn (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 19:47:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42526 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1Xrm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 19:47:42 -0400
Received: by mail-pg0-f67.google.com with SMTP id f10so1849426pgs.9
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 16:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ykXhhY+8Qp08K6tV43P2gDO5c5E45gXJc8u4X9x5ZEM=;
        b=LnZNsMSSMBm693eNr91h3zKyHF8oYem4GcAEcw84z15V8eL4OBTHTZERpso2GfqQ0o
         kjImxRw1oo1qMfEmtjGpg7YKvru2cbSfkTaRlJUrEUhkIjCd3wsAN0sScL86BmVWZuaS
         aLPJbh2uzgSmGFLfpShV/P982IT0PAPPh882U3RcEY4Cfm5LlbkZE1D64z2EbedoYs8e
         vCwsif8vVhLD3N+dSo+uty8DGFDjMzgn8dvuRXoHM1q5vbca+JyB/1S5+bPb2r+rZ31z
         XCDO0cu59hUl5dv5z8s0jfWzfWpPqubwOiiCVc18YKK4UY8rxv4I0P4he222Vnk/SlQr
         RdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ykXhhY+8Qp08K6tV43P2gDO5c5E45gXJc8u4X9x5ZEM=;
        b=TXYKoeAL+rNCquFtG4iIVgql8ARtsCJLEQNCVQTIqAoLk3LpeE/t7/jHcd3hMFWJKo
         MjSYq8Ak8XwWntPPwX3j7vpoNyiSKHw+2JKHhX7iPZeZ16WUbWEPKWcbHNAQLSC6/y1b
         76cyoGrVL3am7C7uUXHzgiNuOPUwKDhPFIpTZ7grDwy0FHX8tCXTE9FrH9rzy2vqCH5p
         nJNDP1ubP3XotIUc7mjqnCd0CjGMFgLe2ctL0aykn5kKc3sGEMl8NmUiZM6VAwGo5ApI
         p3WkylSM0bxfh7ShY77NDYFQMFxcHNtXDYhitFg1dh/MP93bJOfPR51iRCsnx8xdEm3t
         mZAw==
X-Gm-Message-State: AElRT7FriNYP1otl977fcu62y5J7WWbrQoPRi8VsQkxgjK9aSRw3J8/d
        cmR0mZWckvnDhA0VgRPFeLyMMg==
X-Google-Smtp-Source: AIpwx49saSd+Q4z6YYYeZ2pKn+bSP+/BBoJRKu73MegxbzOrxek08kJxCV/b3SDS80+nlBIIHl3TTQ==
X-Received: by 10.101.101.139 with SMTP id u11mr3899511pgv.436.1522280861195;
        Wed, 28 Mar 2018 16:47:41 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id b8sm8330478pgv.17.2018.03.28.16.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 16:47:39 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     peff@peff.net
Cc:     Taylor Blau <me@ttaylorr.com>, gitster@pobox.com,
        git@vger.kernel.org
Subject: [PATCH] builtin/config.c: prefer `--type=bool` over `--bool`, etc.
Date:   Wed, 28 Mar 2018 16:47:19 -0700
Message-Id: <20180328234719.595-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git config` has long allowed the ability for callers to provide a 'type
specifier', which instructs `git config` to (1) ensure that incoming
values are satisfiable under that type, and (2) that outgoing values are
canonicalized under that type.

In another series, we propose to add extend this functionality with
`--color` and `--default` to replace `--get-color`.

However, we traditionally use `--color` to mean "colorize this output",
instead of "this value should be treated as a color".

Currently, `git config` does not support this kind of colorization, but
we should be careful to avoid inhabiting this option too soon, so that
`git config` can support `--color` (in the traditional sense) in the
future, if that is desired.

In this patch, we prefer `--type=[int|bool|bool-or-int|...]` over
`--int`, `--bool`, and etc. This allows the aforementioned other patch
to add `--color` (in the non-traditional sense) via `--type=color`,
instead of `--color`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 66 +++++++++++++++++++-----------------
 builtin/config.c             | 25 ++++++++++++++
 t/t1300-repo-config.sh       | 21 ++++++++++++
 3 files changed, 80 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e09ed5d7d..a4a5ffb41 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,13 +9,13 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
-'git config' [<file-option>] [type] --add name value
-'git config' [<file-option>] [type] --replace-all name value [value_regex]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
-'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name URL
+'git config' [<file-option>] [--type] [--show-origin] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [--type] --add name value
+'git config' [<file-option>] [--type] --replace-all name value [value_regex]
+'git config' [<file-option>] [--type] [--show-origin] [-z|--null] --get name [value_regex]
+'git config' [<file-option>] [--type] [--show-origin] [-z|--null] --get-all name [value_regex]
+'git config' [<file-option>] [--type] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [--type] [-z|--null] --get-urlmatch name URL
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
@@ -38,12 +38,10 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
-The type specifier can be either `--int` or `--bool`, to make
-'git config' ensure that the variable(s) are of the given type and
-convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool), or `--path`, which does some
-path expansion (see `--path` below).  If no type specifier is passed, no
-checks or transformations are performed on the value.
+A type specifier may be given as an argument to `--type` to make 'git config'
+ensure that the variable(s) are of the given type and convert the value to the
+canonical form. If no type specifier is passed, no checks or transformations are
+performed on the value.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
@@ -160,30 +158,34 @@ See also <<FILES>>.
 --list::
 	List all variables set in config file, along with their values.
 
---bool::
-	'git config' will ensure that the output is "true" or "false"
+--type [type]::
+  'git config' will ensure that any input output is valid under the given type
+  constraint(s), and will canonicalize outgoing values in `[type]`'s canonical
+  form.
++
+Valid `[type]`'s include:
++
+- 'bool': canonicalize  values as either "true" or "false".
+- 'int': canonicalize  values as simple decimla numbers. An optional suffix of
+  'k', 'm', or 'g' will cause the value to be multiplied by 1024, 1048576, or
+  1073741824 prior to output.
+- 'bool-or-int': canonicalize according to either 'bool' or 'int', as described
+  above.
+- 'path': canonicalize by adding a leading `~` to the value of `$HOME` and
+  `~user` to the home directory for the specified user. This specifier has no
+  effect when setting the value (but you can use `git config section.variable
+  ~/` from the command line to let your shell do the expansion.)
+- 'expiry-date': canonicalize by converting from a fixed or relative ate-string
+  to a timestamp. This specifier has no effect when setting the value.
++
 
+--bool::
 --int::
-	'git config' will ensure that the output is a simple
-	decimal number.  An optional value suffix of 'k', 'm', or 'g'
-	in the config file will cause the value to be multiplied
-	by 1024, 1048576, or 1073741824 prior to output.
-
 --bool-or-int::
-	'git config' will ensure that the output matches the format of
-	either --bool or --int, as described above.
-
 --path::
-	`git config` will expand a leading `~` to the value of
-	`$HOME`, and `~user` to the home directory for the
-	specified user.  This option has no effect when setting the
-	value (but you can use `git config section.variable ~/`
-	from the command line to let your shell do the expansion).
-
 --expiry-date::
-	`git config` will ensure that the output is converted from
-	a fixed or relative date-string to a timestamp. This option
-	has no effect when setting the value.
+  Historical options for selecting a type specifier. Prefer instead `--type`,
+  (see: above).
 
 -z::
 --null::
diff --git a/builtin/config.c b/builtin/config.c
index 01169dd62..ea7923493 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -26,6 +26,7 @@ static char term = '\n';
 static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
 static int actions, types;
+static char *type;
 static int end_null;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
@@ -84,6 +85,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
+	OPT_STRING('t', "type", &type, N_("type"), N_("value is given this type")),
 	OPT_BIT(0, "bool", &types, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
@@ -493,6 +495,21 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
 
+static int type_name_to_specifier(char *name)
+{
+	if (!(strcmp(name, "bool")))
+		return TYPE_BOOL;
+	else if (!(strcmp(name, "int")))
+		return TYPE_INT;
+	else if (!(strcmp(name, "bool-or-int")))
+		return TYPE_BOOL_OR_INT;
+	else if (!(strcmp(name, "path")))
+		return TYPE_PATH;
+	else if (!(strcmp(name, "expiry-date")))
+		return TYPE_EXPIRY_DATE;
+	die(_("unexpected --type argument, %s"), name);
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
@@ -601,6 +618,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (type) {
+		if (types != 0) {
+			error("usage of --type is ambiguous");
+			usage_with_options(builtin_config_usage, builtin_config_options);
+		}
+		types = type_name_to_specifier(type);
+	}
+
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4f8e6f5fd..12dc94bd2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1611,4 +1611,25 @@ test_expect_success '--local requires a repo' '
 	test_expect_code 128 nongit git config --local foo.bar
 '
 
+cat >.git/config <<-\EOF &&
+[core]
+foo = true
+EOF
+
+test_expect_success '--type allows valid type specifiers' '
+	echo "true" >expect &&
+	git config --type=bool core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--type rejects unknown specifiers' '
+	test_must_fail git config --type=nonsense core.foo 2>error &&
+	test_i18ngrep "unexpected --type argument" error
+'
+
+test_expect_success '--type does not allow for ambiguity' '
+	test_must_fail git config --type=bool --bool core.foo 2>error &&
+	test_i18ngrep "usage of --type is ambiguous" error
+'
+
 test_done
-- 
2.16.2.440.gc6284da4f

