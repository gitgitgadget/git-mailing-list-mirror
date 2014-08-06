From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v8 0/8] Rewrite `git_config()` using config-set API
Date: Wed,  6 Aug 2014 07:53:04 -0700
Message-ID: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 17:01:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF2hn-0008F3-4i
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbaHFPAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:00:39 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:38061 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbaHFPAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:00:38 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so3437365pdb.5
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=flcNhp3UcPH2UK4iG0UTnqTwLP6gu0r8xY7IyGXO1/8=;
        b=vfR/LO+dLAv9Si2TMwBIM5D5yk3VxlQEEX8IOuKtEgOtsx1o+R6ElwwGkerCu0gN4Q
         kmcnvvNVAb8Y9TenkmoSim0ECPdrmXsMGYwcWQYcZ6OfKkNDDxjI3HH+/sQLQ9BVvmQN
         UFHUlp24hKpWQjdILXjQy6vg+ev/edvwJnJaPTyAIMIhOi66k4RVNDcdEcP08QQ6lu+0
         lX49YTOgh0rochZvoOBBqAFS8HnyQtMZFAiMddmmb07LhseH86U645ZeYFsZxzILVLLk
         AjAAP5ARE70CMuS9Kd5LGdu1055cCcb4et3G97wdLsnC/N8EIH8mwP6Y0pmytfOgAgsz
         LpCQ==
X-Received: by 10.68.230.194 with SMTP id ta2mr11719786pbc.51.1407337237878;
        Wed, 06 Aug 2014 08:00:37 -0700 (PDT)
Received: from localhost.localdomain ([223.176.214.188])
        by mx.google.com with ESMTPSA id u2sm1547305pbs.42.2014.08.06.08.00.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:00:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254857>

[Patch v8]: git_die_config now allows custom error messages.
	new tests are now not too reliant on specific strings. Diff
	between v7 & v8 is appended at the bottom. Thanks to Junio &
	Matthieu for their suggestions.

[Patch v7]: style nit corrected. (1/8) is Matthieu's translation patch.
	git_die_config_linenr() helper function added. Diff between v6
	and v7 appended for review.

[Patch v6]: Added _(....) to error messages.
	Diff between v6 and v4 at the bottom.

[PATCH v5]: New patch added (3/7). git_config() now returns void.

[PATCH v4]: One style nit corrected, also added key to error messages.

[PATCH V3]:All the suggestions in [3] applied. Built on top of [1].

[PATCH V2]: All the suggestions in [2] incorporated. git_config() now follows
	correct parsing order. Reordered the patches. Removed xfuncname patch
	as it was unnecssary.

This series builds on the top of topic[1] in the mailing list with name
"git config cache & special querying API utilizing the cache".

This series aims to do these three things,

* Use the config-set API to rewrite git_config().

* Solve any legacy bugs in the previous system while at it.

* To be feature complete compared to the previous git_config() implementation,
	which I think it is now. (added the line number and file name info just for
	completeness)

Also, I haven't yet checked the exact improvements but still as a teaser,
git status now only rereads the configuration files twice instead of four
times.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/254286
[2]: http://thread.gmane.org/gmane.comp.version-control.git/254101
[3]: http://thread.gmane.org/gmane.comp.version-control.git/254211

Matthieu Moy (1):
  config.c: mark error and warnings strings for translation

Tanay Abhra (7):
  config.c: fix accuracy of line number in errors
  add line number and file name info to `config_set`
  change `git_config()` return value to void
  config: add `git_die_config()` to the config-set API
  rewrite git_config() to use the config-set API
  add a test for semantic errors in config files
  add tests for `git_config_get_string_const()`

 Documentation/technical/api-config.txt |  13 +++
 branch.c                               |   5 +-
 cache.h                                |  34 +++++++-
 config.c                               | 152 +++++++++++++++++++++++++++------
 t/t1308-config-set.sh                  |  21 +++++
 t/t4055-diff-context.sh                |   2 +-
 test-config.c                          |  10 +++
 7 files changed, 207 insertions(+), 30 deletions(-)

-- 
1.9.0.GIT

-- 8< --
diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index d7d0cf9..0d8b99b 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -155,10 +155,11 @@ as well as retrieval for the queried variable, including:
 	Similar to `git_config_get_string`, but expands `~` or `~user` into
 	the user's home directory when found at the beginning of the path.
 
-`void git_die_config(const char *key)`::
+`git_die_config(const char *key, const char *err, ...)`::
 
-	Dies printing the line number and the file name of the highest
-	priority value for the configuration variable `key`.
+	First prints the error message specified by the caller in `err` and then
+	dies printing the line number and the file name of the highest priority
+	value for the configuration variable `key`.
 
 `void git_die_config_linenr(const char *key, const char *filename, int linenr)`::
 
diff --git a/cache.h b/cache.h
index ff17889..2693a37 100644
--- a/cache.h
+++ b/cache.h
@@ -1406,8 +1406,14 @@ extern int git_config_get_bool(const char *key, int *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
-extern void git_die_config(const char *key);
-extern void git_die_config_linenr(const char *key, const char *filename, int linenr);
+
+struct key_value_info {
+	const char *filename;
+	int linenr;
+};
+
+extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
+extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
diff --git a/config.c b/config.c
index cf9124f..427850a 100644
--- a/config.c
+++ b/config.c
@@ -1224,11 +1224,6 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-struct key_value_info {
-	const char *filename;
-	int linenr;
-};
-
 static void git_config_raw(config_fn_t fn, void *data)
 {
 	if (git_config_with_options(fn, data, NULL, 1) < 0)
@@ -1326,8 +1321,8 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		kv_info->linenr = cf->linenr;
 	} else {
 		/* for values read from `git_config_from_parameters()` */
-		kv_info->filename = strintern("parameter");
-		kv_info->linenr = 0;
+		kv_info->filename = NULL;
+		kv_info->linenr = -1;
 	}
 	si->util = kv_info;
 
@@ -1513,7 +1508,7 @@ int git_config_get_string_const(const char *key, const char **dest)
 	git_config_check_init();
 	ret = git_configset_get_string_const(&the_config_set, key, dest);
 	if (ret < 0)
-		git_die_config(key);
+		git_die_config(key, NULL);
 	return ret;
 }
 
@@ -1559,27 +1554,32 @@ int git_config_get_pathname(const char *key, const char **dest)
 	git_config_check_init();
 	ret = git_configset_get_pathname(&the_config_set, key, dest);
 	if (ret < 0)
-		git_die_config(key);
+		git_die_config(key, NULL);
 	return ret;
 }
 
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
-	if (!linenr)
+	if (!filename)
 		die(_("unable to parse '%s' from command-line config"), key);
 	else
-		die(_("bad config variable '%s' at file line %d in %s"),
-			key,
-			linenr,
-			filename);
+		die(_("bad config variable '%s' in file '%s' at line %d"),
+		    key, filename, linenr);
 }
 
-NORETURN
-void git_die_config(const char *key)
+NORETURN __attribute__((format(printf, 2, 3)))
+void git_die_config(const char *key, const char *err, ...)
 {
 	const struct string_list *values;
 	struct key_value_info *kv_info;
+
+	if (err) {
+		va_list params;
+		va_start(params, err);
+		vreportf("error: ", err, params);
+		va_end(params);
+	}
 	values = git_config_get_value_multi(key);
 	kv_info = values->items[values->nr - 1].util;
 	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index f012dd6..ecc757a 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -126,7 +126,7 @@ test_expect_success 'find string value for a key' '
 
 test_expect_success 'check line error when NULL string is queried' '
 	test_expect_code 128 test-config get_string case.foo 2>result &&
-	grep "fatal: bad config variable '\''case.foo'\'' at file line 7 in .git/config" result
+	grep "line 7.*.git/config\|.git/config.*line 7" result
 '
 
 test_expect_success 'find integer if value is non parse-able' '
@@ -215,7 +215,7 @@ test_expect_success 'check line errors for malformed values' '
 		br
 	EOF
 	test_expect_code 128 git br 2>result &&
-	grep "fatal: bad config variable '\''alias.br'\'' at file line 2 in .git/config" result
+	grep "line 2.*.git/config\|.git/config.*line 2" result
 '
 
 test_done
-- 8< --
