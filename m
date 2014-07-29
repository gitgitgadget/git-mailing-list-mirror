From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 0/6] Rewrite `git_config()` using config-set API
Date: Tue, 29 Jul 2014 04:28:16 -0700
Message-ID: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:29:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC5b3-00032D-DX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 13:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbaG2L31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 07:29:27 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:42878 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbaG2L3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 07:29:24 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so12197511pad.37
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 04:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gGUsI5OAvwKZDaWbpmqt64Ycf/jwvY5nv3MyF0IFArs=;
        b=J6bfX61mkXHRLsYD2PHNucsuyr6Q4foq7SGj3Vm4ocTBti8R5KJVV6fyj6U9qBa1/L
         5IMnWO8+VuWYuUolQlTXQwX7BFmk1kXosYj+CGYyOlx1dM8xvbSNpmWROeA4+GNkSG6T
         YQINn9ExderCDsK0AAKVOdhbvK2fVGjwJBbsKaGTWt0hDmMEOi3NaQNb8VkSdA+OOpRu
         xMrQ76QU18AwQtoDtxW0dX8lqdPa/Wmj1Cv2oeOzgAoaoeCdx6n7xVvQd3h9XM8zB8u/
         0tPUBmFsux6Y0aYLkccDhFnZpCOG+5M3ehefTKeGlcJGRQAhks5Pls6fFIhORl7fmVO2
         cvSg==
X-Received: by 10.68.167.133 with SMTP id zo5mr1359535pbb.21.1406633363933;
        Tue, 29 Jul 2014 04:29:23 -0700 (PDT)
Received: from localhost.localdomain ([223.184.138.24])
        by mx.google.com with ESMTPSA id z2sm28554774pdj.16.2014.07.29.04.29.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 04:29:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254412>

[PATCH v4]: One style nit corrected, also added key to error messages.
	Diff with v3 at the bottom for easy review.

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

Tanay Abhra (6):
  config.c: fix accuracy of line number in errors
  add line number and file name info to `config_set`
  rewrite git_config() to use the config-set API
  add a test for semantic errors in config files
  config: add `git_die_config()` to the config-set API
  add tests for `git_config_get_string_const()`

 Documentation/technical/api-config.txt |   5 ++
 cache.h                                |  25 +++++++
 config.c                               | 118 +++++++++++++++++++++++++++++----
 t/t1308-config-set.sh                  |  21 ++++++
 t/t4055-diff-context.sh                |   2 +-
 test-config.c                          |  10 +++
 6 files changed, 167 insertions(+), 14 deletions(-)

-- 
1.9.0.GIT

-- >8 --
diff --git a/config.c b/config.c
index f2d1811..16e99bf 100644
--- a/config.c
+++ b/config.c
@@ -1251,9 +1251,10 @@ static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 		if (fn(entry->key, values->items[value_index].string, data) < 0) {
 			kv_info = values->items[value_index].util;
 			if (!kv_info->linenr)
-				die("unable to parse command-line config");
+				die("unable to parse '%s' from command-line config", entry->key);
 			else
-				die("bad config file line %d in %s",
+				die("bad config variable '%s' at file line %d in %s",
+					entry->key,
 					kv_info->linenr,
 					kv_info->filename);
 		}
@@ -1566,9 +1567,12 @@ void git_die_config(const char *key)
 	values = git_config_get_value_multi(key);
 	kv_info = values->items[values->nr - 1].util;
 	if (!kv_info->linenr)
-		die("unable to parse command-line config");
+		die("unable to parse '%s' from command-line config", key);
 	else
-		die("bad config file line %d in %s", kv_info->linenr, kv_info->filename);
+		die("bad config variable '%s' at file line %d in %s",
+			key,
+			kv_info->linenr,
+			kv_info->filename);
  }
 
 /*
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 3217b4d..f012dd6 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -126,7 +126,7 @@ test_expect_success 'find string value for a key' '
 
 test_expect_success 'check line error when NULL string is queried' '
 	test_expect_code 128 test-config get_string case.foo 2>result &&
-	grep "fatal: bad config file line 7 in .git/config" result
+	grep "fatal: bad config variable '\''case.foo'\'' at file line 7 in .git/config" result
 '
 
 test_expect_success 'find integer if value is non parse-able' '
@@ -215,7 +215,7 @@ test_expect_success 'check line errors for malformed values' '
 		br
 	EOF
 	test_expect_code 128 git br 2>result &&
-	grep "fatal: bad config file line 2 in .git/config" result
+	grep "fatal: bad config variable '\''alias.br'\'' at file line 2 in .git/config" result
 '
 
 test_done
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index cd04543..741e080 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -79,7 +79,7 @@ test_expect_success 'non-integer config parsing' '
 test_expect_success 'negative integer config parsing' '
 	git config diff.context -1 &&
 	test_must_fail git diff 2>output &&
-	test_i18ngrep "bad config file" output
+	test_i18ngrep "bad config variable" output
 '
 
 test_expect_success '-U0 is valid, so is diff.context=0' '
-- >8 --
