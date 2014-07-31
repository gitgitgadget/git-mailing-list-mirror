From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v6 0/7] Rewrite `git_config()` using config-set API
Date: Thu, 31 Jul 2014 08:47:35 -0700
Message-ID: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 17:48:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCsax-00085u-Ew
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbaGaPsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:48:39 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:58333 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaGaPsi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:48:38 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so3664819pde.37
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Zta87houCu46u26PzpZdfSgm1U1f4lXeFbJIklg3z0U=;
        b=g4YyCp3IF9ZMRbNY8ZAZQFJZlQrI/QNO+akoWbO0GSisivgj/XF8mx3HHwhHg556jK
         aZ3tEVMrq4HtaJRepMOVVwbBwmsXfkqBGclGm6sBT8DIrRuIqhelMiZmRCLSNirLPOih
         8B6wdWTsc1MOZz5Bo2lltyEeEmcjzR/IJGyfoHFsuuDe+NbVgi8C0XofeHWpkt5EH1qB
         IG6SBl2Nz2Q70SfkmoNzisVSWkQ6on1myjaTAUcptckT/s8K2qZXF23mfZnb49JOOC23
         10Iq3Mm4/7aqTQKN/mO8v8UqfM/0pUkaOIcq/kvRLFnn5EYmEWFSjdWpOZwDCAP7xWwg
         60Zw==
X-Received: by 10.68.229.193 with SMTP id ss1mr4298417pbc.158.1406821713418;
        Thu, 31 Jul 2014 08:48:33 -0700 (PDT)
Received: from localhost.localdomain ([223.229.21.143])
        by mx.google.com with ESMTPSA id n16sm8837555pdj.41.2014.07.31.08.48.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 08:48:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254580>

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

Tanay Abhra (7):
  config.c: fix accuracy of line number in errors
  add line number and file name info to `config_set`
  change `git_config()` return value to void
  rewrite git_config() to use the config-set API
  add a test for semantic errors in config files
  config: add `git_die_config()` to the config-set API
  add tests for `git_config_get_string_const()`

 Documentation/technical/api-config.txt |   5 ++
 branch.c                               |   5 +-
 cache.h                                |  27 ++++++-
 config.c                               | 131 +++++++++++++++++++++++++++++----
 t/t1308-config-set.sh                  |  21 ++++++
 t/t4055-diff-context.sh                |   2 +-
 test-config.c                          |  10 +++
 7 files changed, 181 insertions(+), 20 deletions(-)

-- 
1.9.0.GIT

-- 8< --
diff --git a/branch.c b/branch.c
index 46e8aa8..735767d 100644
--- a/branch.c
+++ b/branch.c
@@ -161,10 +161,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 	cb.config_name = name.buf;
 	cb.value = NULL;
-	if (git_config(read_branch_desc_cb, &cb) < 0) {
-		strbuf_release(&name);
-		return -1;
-	}
+	git_config(read_branch_desc_cb, &cb);
 	if (cb.value)
 		strbuf_addstr(buf, cb.value);
 	strbuf_release(&name);
diff --git a/cache.h b/cache.h
index 8512225..243f618 100644
--- a/cache.h
+++ b/cache.h
@@ -1295,7 +1295,7 @@ extern int git_config_from_buf(config_fn_t fn, const char *name,
 			       const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
-extern int git_config(config_fn_t fn, void *);
+extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
 				   int respect_includes);
diff --git a/config.c b/config.c
index f9bf60a..15fcd91 100644
--- a/config.c
+++ b/config.c
@@ -1229,12 +1229,24 @@ struct key_value_info {
 	int linenr;
 };
 
-static int git_config_raw(config_fn_t fn, void *data)
+static void git_config_raw(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL, 1);
+	if (git_config_with_options(fn, data, NULL, 1) < 0)
+		/*
+		 * git_config_with_options() normally returns only
+		 * positive values, as most errors are fatal, and
+		 * non-fatal potential errors are guarded by "if"
+		 * statements that are entered only when no error is
+		 * possible.
+		 *
+		 * If we ever encounter a non-fatal error, it means
+		 * something went really wrong and we should stop
+		 * immediately.
+		 */
+		die(_("unknown error occured while reading the configuration files"));
 }
 
-static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
@@ -1249,23 +1261,22 @@ static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 		if (fn(entry->key, values->items[value_index].string, data) < 0) {
 			kv_info = values->items[value_index].util;
 			if (!kv_info->linenr)
-				die("unable to parse '%s' from command-line config", entry->key);
+				die(_("unable to parse '%s' from command-line config"), entry->key);
 			else
-				die("bad config variable '%s' at file line %d in %s",
+				die(_("bad config variable '%s' at file line %d in %s"),
 					entry->key,
 					kv_info->linenr,
 					kv_info->filename);
 		}
 	}
-	return 0;
 }
 
 static void git_config_check_init(void);
 
-int git_config(config_fn_t fn, void *data)
+void git_config(config_fn_t fn, void *data)
 {
 	git_config_check_init();
-	return configset_iter(&the_config_set, fn, data);
+	configset_iter(&the_config_set, fn, data);
 }
 
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
@@ -1565,9 +1576,9 @@ void git_die_config(const char *key)
 	values = git_config_get_value_multi(key);
 	kv_info = values->items[values->nr - 1].util;
 	if (!kv_info->linenr)
-		die("unable to parse '%s' from command-line config", key);
+		die(_("unable to parse '%s' from command-line config"), key);
 	else
-		die("bad config variable '%s' at file line %d in %s",
+		die(_("bad config variable '%s' at file line %d in %s"),
 			key,
 			kv_info->linenr,
 			kv_info->filename);
-- 8< --
