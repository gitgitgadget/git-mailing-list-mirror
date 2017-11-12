Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF983201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 12:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbdKLMTj (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 07:19:39 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:47174
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750735AbdKLMTi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 07:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1510489176;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Yamfu3W0C2VFrDEkMWgnM7gtwTOBYHXQg1PpLGOBLJA=;
        b=HoSLL/bUvFd1D42bZQ8QPeDX9scKIGHfbTGpIgM2EJxs/zmLg7yLi/DT+bVAWpB+
        DUIMVtC8Gpfr6PAlQbErJdVUreSeR5ycJjaGi4oBHxm4oxYvGPqkGZlk5O49m4TfM6d
        k6UpDuB/vIgCAxUTitKYuPygB+hkplHuyr3Uj37g=
From:   Haaris <hsed@unimetic.com>
To:     git@vger.kernel.org
Message-ID: <0102015fb02bb5be-02c77f83-5a20-4ca1-8bab-5e9519cbd758-000000@eu-west-1.amazonses.com>
Subject: [PATCH] config: added --expiry-date type support
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Nov 2017 12:19:35 +0000
X-SES-Outgoing: 2017.11.12-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/config.c       | 11 ++++++++++-
 config.c               |  9 +++++++++
 config.h               |  1 +
 t/t1300-repo-config.sh | 25 +++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index d13daeeb55927..41cd9f5ca7cde 100644
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
@@ -159,6 +161,12 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 				return -1;
 			strbuf_addstr(buf, v);
 			free((char *)v);
+		} else if (types == TYPE_EXPIRY_DATE) {
+			timestamp_t *t = malloc(sizeof(*t));
+			if(git_config_expiry_date(&t, key_, value_) < 0)
+				return -1;
+			strbuf_addf(buf, "%"PRItime, *t);
+			free((timestamp_t *)t);
 		} else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
@@ -273,12 +281,13 @@ static char *normalize_value(const char *key, const char *value)
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
diff --git a/config.c b/config.c
index 903abf9533b18..caa2fd5fb6915 100644
--- a/config.c
+++ b/config.c
@@ -990,6 +990,15 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_expiry_date(timestamp_t **timestamp, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (!!parse_expiry_date(value, *timestamp))
+		die(_("failed to parse date_string in: '%s'"), value);
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/config.h b/config.h
index a49d264416225..2d127d9d23c90 100644
--- a/config.h
+++ b/config.h
@@ -58,6 +58,7 @@ extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
+extern int git_config_expiry_date(timestamp_t **, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 364a537000bbb..59a35be89e511 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -901,6 +901,31 @@ test_expect_success 'get --path barfs on boolean variable' '
 	test_must_fail git config --get --path path.bool
 '
 
+test_expect_success 'get --expiry-date' '
+	cat >.git/config <<-\EOF &&
+	[date]
+	valid1 = "Fri Jun 4 15:46:55 2010"
+	valid2 = "2017/11/11 11:11:11PM"
+	valid3 = "2017/11/10 09:08:07 PM"
+	valid4 = "never"
+	invalid1 = "abc"
+	EOF
+	cat >expect <<-\EOF &&
+	1275666415
+	1510441871
+	1510348087
+	0
+	EOF
+	{
+		git config --expiry-date date.valid1 &&
+		git config --expiry-date date.valid2 &&
+		git config --expiry-date date.valid3 &&
+		git config --expiry-date date.valid4
+	} >actual &&
+	test_cmp expect actual &&
+	test_must_fail git config --expiry-date date.invalid1
+'
+
 cat > expect << EOF
 [quote]
 	leading = " test"

--
https://github.com/git/git/pull/433
