From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] config: support mixed-case aliases
Date: Sat, 15 Jun 2013 21:56:28 +0530
Message-ID: <1371313588-6180-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 18:28:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UntL0-0004ez-R9
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 18:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466Ab3FOQ2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 12:28:21 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44493 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab3FOQ2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 12:28:20 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so1471660pdj.40
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=otavBhm0XXdRaYUElWM1d5X0KOOWPGp8hDA1fpPFF8w=;
        b=uJ7eN9Z2kTVIKSC6rFbzAsSm/9/eMfodR66eO7c6lOd/7GF5gGBleyfv39499CjRzY
         3RWLyDU7GFzeVpRtLfabTQbc13GCyr1xeVJGT1KprQ9/wFTCInlOdzoBdA5+leq8Whlb
         dNynqk/Nzn9J3DEoVLQsk5OSUiXlELVyO1llmys6FYkdWFvgL7BwDCOEaCDPb/jIWeBm
         UKHRE2EAvCMJNvQjXnlag+1htlHxkXttdLeiqi3/Q4C9mHb5DRQ9/7uLSQ+HiiWN2AYh
         zR1irYDF+bmF95DNn0SR6p5n1yWx8fbcAO4EWTYOdKnnr0mkKdgW1gu5yvzeATWhpb5f
         52ug==
X-Received: by 10.66.149.170 with SMTP id ub10mr6818203pab.206.1371313699413;
        Sat, 15 Jun 2013 09:28:19 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id vb8sm6833859pbc.11.2013.06.15.09.28.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 09:28:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.436.gbdff0e3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227959>

To support mixed-case aliases like:

  bM = branch -M
  bD = branch -D

add an argument to git_config_with_options() to block the tolower()
calls on key characters.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 The static variable is somewhat disturbing, but it's the most obvious
 choice to avoid refactoring config.c heavily.  What do you think?

 alias.c                |  2 +-
 builtin/config.c       |  8 ++++----
 cache.h                |  2 +-
 config.c               | 13 ++++++++++---
 t/t1300-repo-config.sh |  7 +++++++
 5 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/alias.c b/alias.c
index eb9f08b..c428592 100644
--- a/alias.c
+++ b/alias.c
@@ -18,7 +18,7 @@ char *alias_lookup(const char *alias)
 {
 	alias_key = alias;
 	alias_val = NULL;
-	git_config(alias_lookup_cb, NULL);
+	git_config_with_options(alias_lookup_cb, NULL, NULL, 1, 1);
 	return alias_val;
 }
 
diff --git a/builtin/config.c b/builtin/config.c
index 19ffcaf..633b38a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -218,7 +218,7 @@ static int get_value(const char *key_, const char *regex_)
 	}
 
 	git_config_with_options(collect_config, &values,
-				given_config_file, respect_includes);
+				given_config_file, respect_includes, 0);
 
 	ret = !values.nr;
 
@@ -302,7 +302,7 @@ static void get_color(const char *def_color)
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	git_config_with_options(git_get_color_config, NULL,
-				given_config_file, respect_includes);
+				given_config_file, respect_includes, 0);
 
 	if (!get_color_found && def_color)
 		color_parse(def_color, "command line", parsed_color);
@@ -330,7 +330,7 @@ static int get_colorbool(int print)
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
 	git_config_with_options(git_get_colorbool_config, NULL,
-				given_config_file, respect_includes);
+				given_config_file, respect_includes, 0);
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
@@ -438,7 +438,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
 					    given_config_file,
-					    respect_includes) < 0) {
+					    respect_includes, 0) < 0) {
 			if (given_config_file)
 				die_errno("unable to read config file '%s'",
 					  given_config_file);
diff --git a/cache.h b/cache.h
index 820aa05..27d201e 100644
--- a/cache.h
+++ b/cache.h
@@ -1161,7 +1161,7 @@ extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
-				   const char *filename, int respect_includes);
+				const char *filename, int respect_includes, int respect_mixedcase);
 extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index 7a85ebd..53ad448 100644
--- a/config.c
+++ b/config.c
@@ -23,6 +23,7 @@ typedef struct config_file {
 static config_file *cf;
 
 static int zlib_compression_seen;
+static int allow_mixedcase_keys;
 
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =
@@ -270,7 +271,9 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 			break;
 		if (!iskeychar(c))
 			break;
-		strbuf_addch(name, tolower(c));
+		if (!allow_mixedcase_keys)
+			c = tolower(c);
+		strbuf_addch(name, c);
 	}
 
 	while (c == ' ' || c == '\t')
@@ -1005,7 +1008,8 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 }
 
 int git_config_with_options(config_fn_t fn, void *data,
-			    const char *filename, int respect_includes)
+			const char *filename, int respect_includes,
+			int respect_mixedcase)
 {
 	char *repo_config = NULL;
 	int ret;
@@ -1018,6 +1022,9 @@ int git_config_with_options(config_fn_t fn, void *data,
 		data = &inc;
 	}
 
+	/* For mixed-case aliases */
+	allow_mixedcase_keys = respect_mixedcase ? 1 : 0;
+
 	/*
 	 * If we have a specific filename, use it. Otherwise, follow the
 	 * regular lookup sequence.
@@ -1034,7 +1041,7 @@ int git_config_with_options(config_fn_t fn, void *data,
 
 int git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL, 1);
+	return git_config_with_options(fn, data, NULL, 1, 0);
 }
 
 /*
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index c4a7d84..db661a9 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1021,6 +1021,13 @@ test_expect_success 'git -c works with aliases of builtins' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git -c works with mixed-case aliases of builtins' '
+	git config alias.checkConfig "-c foo.check=bar config foo.check" &&
+	echo bar >expect &&
+	git checkConfig >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git -c does not split values on equals' '
 	echo "value with = in it" >expect &&
 	git -c core.foo="value with = in it" config core.foo >actual &&
-- 
1.8.3.1.436.gbdff0e3.dirty
