Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A989020899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbdHBTto (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:49:44 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36627 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbdHBTtm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:49:42 -0400
Received: by mail-pg0-f44.google.com with SMTP id v77so19416685pgb.3
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F4pvcclbB7qrMyTfflP6IplDajC5UaK63EAY5wtuBD4=;
        b=pwyUS8N6whlCdbSosb+fMBBscGOjYGapYuu9ngYlgpA0H74TNdPpfBdQAZ1i3BlI5M
         R9jkeIHTvV2iJ8m+NzG9P6zg4+HyWJDe90X8aIVnmSZmqK5ZGlnDsz2609CEQoU13qZf
         fexpjVz7tvWcEOiAyME17z4xTmXHGq/jIRazuiATv4JreVO+VgQDZ6AXLP/Y5sody9kY
         e0QfMP5UJU+R4o/Wm8z4AHoF+zDh6hClWRI8w54cBRfj7a81RuU8khHpOtxSz+0RBm9S
         qQDx9nIe9EggRAqjBH3UuB4Ds2ydU/43rysxugayEO7NVwcDW8g8Gfz8rAtw2r4kk0NK
         E/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F4pvcclbB7qrMyTfflP6IplDajC5UaK63EAY5wtuBD4=;
        b=cWOpsUJ565iyFCt1YTvm4lJLaht9SqesLnFLaLXEx1BmxpQGqXsPOzKCeBs6g5PZ0I
         MbKw8RMguCkIH/9DmvfuBCPI08z3EPhNDPTXIR+QFW9ExTNlWFj4tnub68Ng7NUJbnaM
         Qdb+GwF5F/VXni5nTTSs1E2GPZIwN0uhOBISwjY+DtDXusSdZguulZ8cv4ga0H+zYdez
         Yaay2hcuhMEvnytnn9YDXIBfyna5ybNkywiNVQg+pIkMynRHvQHT2mGEnW/7xdSGPfi4
         tNJgtVFXYWABpDQgqL9UE4rK4oUC0JWUnAOQQw4EJ7+1fbT7u/SVEZrm0gE0Z60aTAo4
         8n6A==
X-Gm-Message-State: AIVw112vY7tvbEPFLq2j3VLoA5/neWykSZEqQQEPNHk1QTMB8x7Z7gh/
        oxOJIlRCO0Ud0704rM/YBQ==
X-Received: by 10.98.193.68 with SMTP id i65mr24294274pfg.142.1501703381183;
        Wed, 02 Aug 2017 12:49:41 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e64sm63401460pfb.129.2017.08.02.12.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:49:40 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 08/10] submodule: check for unmerged .gitmodules outside of config parsing
Date:   Wed,  2 Aug 2017 12:49:21 -0700
Message-Id: <20170802194923.88239-9-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170802194923.88239-1-bmwill@google.com>
References: <20170718190527.78049-1-bmwill@google.com>
 <20170802194923.88239-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add 'is_gitmodules_unmerged()' function which can be used to determine
in the '.gitmodules' file is unmerged based on the passed in index
instead of relying on a global variable which is set during the
submodule-config parsing.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 47 +++++++++++++++++++++++------------------------
 submodule.h |  1 +
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/submodule.c b/submodule.c
index 677b5c401..3b0e70c51 100644
--- a/submodule.c
+++ b/submodule.c
@@ -27,14 +27,25 @@ static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
 
 /*
- * The following flag is set if the .gitmodules file is unmerged. We then
- * disable recursion for all submodules where .git/config doesn't have a
- * matching config entry because we can't guess what might be configured in
- * .gitmodules unless the user resolves the conflict. When a command line
- * option is given (which always overrides configuration) this flag will be
- * ignored.
+ * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
+ * will be disabled because we can't guess what might be configured in
+ * .gitmodules unless the user resolves the conflict.
  */
-static int gitmodules_is_unmerged;
+int is_gitmodules_unmerged(const struct index_state *istate)
+{
+	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
+	if (pos < 0) { /* .gitmodules not found or isn't merged */
+		pos = -1 - pos;
+		if (istate->cache_nr > pos) {  /* there is a .gitmodules */
+			const struct cache_entry *ce = istate->cache[pos];
+			if (ce_namelen(ce) == strlen(GITMODULES_FILE) &&
+			    !strcmp(ce->name, GITMODULES_FILE))
+				return 1;
+		}
+	}
+
+	return 0;
+}
 
 /*
  * Check if the .gitmodules file has unstaged modifications.  This must be
@@ -71,7 +82,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
-	if (gitmodules_is_unmerged)
+	if (is_gitmodules_unmerged(&the_index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
 	submodule = submodule_from_path(null_sha1, oldpath);
@@ -105,7 +116,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
-	if (gitmodules_is_unmerged)
+	if (is_gitmodules_unmerged(&the_index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
 	submodule = submodule_from_path(null_sha1, path);
@@ -156,7 +167,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 	if (submodule) {
 		if (submodule->ignore)
 			handle_ignore_submodules_arg(diffopt, submodule->ignore);
-		else if (gitmodules_is_unmerged)
+		else if (is_gitmodules_unmerged(&the_index))
 			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
 	}
 }
@@ -224,23 +235,12 @@ void gitmodules_config(void)
 	const char *work_tree = get_git_work_tree();
 	if (work_tree) {
 		struct strbuf gitmodules_path = STRBUF_INIT;
-		int pos;
 		strbuf_addstr(&gitmodules_path, work_tree);
 		strbuf_addstr(&gitmodules_path, "/" GITMODULES_FILE);
 		if (read_cache() < 0)
 			die("index file corrupt");
-		pos = cache_name_pos(GITMODULES_FILE, 11);
-		if (pos < 0) { /* .gitmodules not found or isn't merged */
-			pos = -1 - pos;
-			if (active_nr > pos) {  /* there is a .gitmodules */
-				const struct cache_entry *ce = active_cache[pos];
-				if (ce_namelen(ce) == 11 &&
-				    !memcmp(ce->name, GITMODULES_FILE, 11))
-					gitmodules_is_unmerged = 1;
-			}
-		}
 
-		if (!gitmodules_is_unmerged)
+		if (!is_gitmodules_unmerged(&the_index))
 			git_config_from_file(git_modules_config,
 				gitmodules_path.buf, NULL);
 		strbuf_release(&gitmodules_path);
@@ -1198,8 +1198,7 @@ static int get_next_submodule(struct child_process *cp,
 					default_argv = "on-demand";
 				}
 			} else {
-				if ((spf->default_option == RECURSE_SUBMODULES_OFF) ||
-				    gitmodules_is_unmerged)
+				if (spf->default_option == RECURSE_SUBMODULES_OFF)
 					continue;
 				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
 					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
diff --git a/submodule.h b/submodule.h
index b14660585..8022faa59 100644
--- a/submodule.h
+++ b/submodule.h
@@ -33,6 +33,7 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
+extern int is_gitmodules_unmerged(const struct index_state *istate);
 extern int is_staging_gitmodules_ok(const struct index_state *istate);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

