Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2658201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 02:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdKNCFE (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 21:05:04 -0500
Received: from cp-27.webhostbox.net ([208.91.198.76]:45686 "EHLO
        cp-27.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdKNCFD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 21:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unimetic.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ErRXHEn4Wk1hCHbaSs2l2RWBO2TKh8tUQ9qadIlXRXA=; b=em6tqV8vbZZpRKybfQu7AWL81
        +l0GRzIeeuf2GznA6K59PF+M0uyEceBP1OMASy6lHpp4SgPWeSfzroH8zhdXykVZzDkAWPtA6KiOi
        CBBD9kVy0tPPzuP1pao12mLBLXSqiJDC310Yk+VSR+kSKln65FvlFGcWyb6FfaLUQqrl6R/CM7upa
        /PVm/vTAsvA/pyylCDqde7eUcMClERhcUy2/dplklm1ZIOJvX0Fo+0WoDETjvWgYUfU/YxcT63cXN
        IA7ZCB6zNXmSdu8ioVHkDL9BzMiqaNjhEjQ8UPGeTuorbcfl7Dck0enGhm4aOzPlZClf0Rec6AoQX
        +9UVoxnUQ==;
Received: from [90.192.114.32] (port=62707 helo=localhost)
        by cp-27.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA256:128)
        (Exim 4.89)
        (envelope-from <hsed@unimetic.com>)
        id 1eEQaz-000stz-Pw; Tue, 14 Nov 2017 02:05:03 +0000
From:   hsed@unimetic.com
To:     peff@peff.net
Cc:     git@vger.kernel.org, hsed@unimetic.com
Subject: [PATCH V2] config: add --expiry-date
Date:   Tue, 14 Nov 2017 02:04:33 +0000
Message-Id: <1510625073-8842-1-git-send-email-hsed@unimetic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20171112145535.gb4nafdhhdslknex@sigill.intra.peff.net>
References: <20171112145535.gb4nafdhhdslknex@sigill.intra.peff.net>
X-Authenticated_sender: hsed@unimetic.com
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-27.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unimetic.com
X-Get-Message-Sender-Via: cp-27.webhostbox.net: authenticated_id: hsed@unimetic.com
X-Authenticated-Sender: cp-27.webhostbox.net: hsed@unimetic.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Haaris <hsed@unimetic.com>

Description:
This patch adds a new option to the config command.

Uses flag --expiry-date as a data-type to covert date-strings to
timestamps when reading from config files (GET).
This flag is ignored on write (SET) because the date-string is stored in
config without performing any normalization.

Creates a few test cases and documentation since its a new feature.

Motivation:
A parse_expiry_date() function already existed for api calls,
this patch simply allows the function to be used from the command line.

Signed-off-by: Haaris <hsed@unimetic.com>
---
 Documentation/git-config.txt |  5 +++++
 builtin/config.c             | 10 +++++++++-
 builtin/reflog.c             | 14 ++------------
 config.c                     |  9 +++++++++
 config.h                     |  1 +
 t/helper/test-date.c         | 12 ++++++++++++
 t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++++
 7 files changed, 68 insertions(+), 13 deletions(-)

Update:
Added suggestions, documentation, relative time test case and test
helper function to print out timestamps for comparison. Updated reflog.c
to avoid function duplication.

Sorry for duplicate messages, the other one didn't get threaded properly.

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4edd09f..14da5fc 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -180,6 +180,11 @@ See also <<FILES>>.
 	value (but you can use `git config section.variable ~/`
 	from the command line to let your shell do the expansion).
 
+--expiry-date::
+	`git config` will ensure that the output is converted from
+	a fixed or relative date-string to a timestamp. This option
+	has no effect when setting the value.
+
 -z::
 --null::
 	For all options that output values and/or keys, always
diff --git a/builtin/config.c b/builtin/config.c
index d13daee..afdb021 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -52,6 +52,7 @@ static int show_origin;
 #define TYPE_INT (1<<1)
 #define TYPE_BOOL_OR_INT (1<<2)
 #define TYPE_PATH (1<<3)
+#define TYPE_EXPIRY_DATE (1<<4)
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
@@ -80,6 +81,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
+	OPT_BIT(0, "expiry-date", &types, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
@@ -159,6 +161,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 				return -1;
 			strbuf_addstr(buf, v);
 			free((char *)v);
+		} else if (types == TYPE_EXPIRY_DATE) {
+			timestamp_t t;
+			if(git_config_expiry_date(&t, key_, value_) < 0)
+				return -1;
+			strbuf_addf(buf, "%"PRItime, t);
 		} else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
@@ -273,12 +280,13 @@ static char *normalize_value(const char *key, const char *value)
 	if (!value)
 		return NULL;
 
-	if (types == 0 || types == TYPE_PATH)
+	if (types == 0 || types == TYPE_PATH || types == TYPE_EXPIRY_DATE)
 		/*
 		 * We don't do normalization for TYPE_PATH here: If
 		 * the path is like ~/foobar/, we prefer to store
 		 * "~/foobar/" in the config file, and to expand the ~
 		 * when retrieving the value.
+		 * Also don't do normalization for expiry dates.
 		 */
 		return xstrdup(value);
 	if (types == TYPE_INT)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index ab31a3b..2233725 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -416,16 +416,6 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 	return ent;
 }
 
-static int parse_expire_cfg_value(const char *var, const char *value, timestamp_t *expire)
-{
-	if (!value)
-		return config_error_nonbool(var);
-	if (parse_expiry_date(value, expire))
-		return error(_("'%s' for '%s' is not a valid timestamp"),
-			     value, var);
-	return 0;
-}
-
 /* expiry timer slot */
 #define EXPIRE_TOTAL   01
 #define EXPIRE_UNREACH 02
@@ -443,11 +433,11 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(key, "reflogexpire")) {
 		slot = EXPIRE_TOTAL;
-		if (parse_expire_cfg_value(var, value, &expire))
+		if (git_config_expiry_date(&expire, var, value))
 			return -1;
 	} else if (!strcmp(key, "reflogexpireunreachable")) {
 		slot = EXPIRE_UNREACH;
-		if (parse_expire_cfg_value(var, value, &expire))
+		if (git_config_expiry_date(&expire, var, value))
 			return -1;
 	} else
 		return git_default_config(var, value, cb);
diff --git a/config.c b/config.c
index 903abf9..6ded9ce 100644
--- a/config.c
+++ b/config.c
@@ -990,6 +990,15 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (parse_expiry_date(value, timestamp))
+		die(_("failed to parse date_string in: '%s'"), value);
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/config.h b/config.h
index a49d264..fc66c59 100644
--- a/config.h
+++ b/config.h
@@ -58,6 +58,7 @@ extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
+extern int git_config_expiry_date(timestamp_t *, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index f414a3a..ac83687 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -5,6 +5,7 @@ static const char *usage_msg = "\n"
 "  test-date show:<format> [time_t]...\n"
 "  test-date parse [date]...\n"
 "  test-date approxidate [date]...\n"
+"  test-date timestamp [date]...\n"
 "  test-date is64bit\n"
 "  test-date time_t-is64bit\n";
 
@@ -71,6 +72,15 @@ static void parse_approxidate(const char **argv, struct timeval *now)
 	}
 }
 
+static void parse_approx_timestamp(const char **argv, struct timeval *now)
+{
+	for (; *argv; argv++) {
+		timestamp_t t;
+		t = approxidate_relative(*argv, now);
+		printf("%s -> %"PRItime"\n", *argv, t);
+	}
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	struct timeval now;
@@ -95,6 +105,8 @@ int cmd_main(int argc, const char **argv)
 		parse_dates(argv+1, &now);
 	else if (!strcmp(*argv, "approxidate"))
 		parse_approxidate(argv+1, &now);
+	else if (!strcmp(*argv, "timestamp"))
+		parse_approx_timestamp(argv+1, &now);
 	else if (!strcmp(*argv, "is64bit"))
 		return sizeof(timestamp_t) == 8 ? 0 : 1;
 	else if (!strcmp(*argv, "time_t-is64bit"))
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 364a537..cbeb9be 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -901,6 +901,36 @@ test_expect_success 'get --path barfs on boolean variable' '
 	test_must_fail git config --get --path path.bool
 '
 
+test_expect_success 'get --expiry-date' '
+	rel="3.weeks.5.days.00:00" &&
+	rel_out="$rel ->" &&
+	cat >.git/config <<-\EOF &&
+	[date]
+	valid1 = "3.weeks.5.days 00:00"
+	valid2 = "Fri Jun 4 15:46:55 2010"
+	valid3 = "2017/11/11 11:11:11PM"
+	valid4 = "2017/11/10 09:08:07 PM"
+	valid5 = "never"
+	invalid1 = "abc"
+	EOF
+	cat >expect <<-EOF &&
+	$(test-date timestamp $rel)
+	1275666415
+	1510441871
+	1510348087
+	0
+	EOF
+	{
+		echo "$rel_out $(git config --expiry-date date.valid1)"
+		git config --expiry-date date.valid2 &&
+		git config --expiry-date date.valid3 &&
+		git config --expiry-date date.valid4 &&
+		git config --expiry-date date.valid5
+	} >actual &&
+	test_cmp expect actual &&
+	test_must_fail git config --expiry-date date.invalid1
+'
+
 cat > expect << EOF
 [quote]
 	leading = " test"
-- 
2.7.4

