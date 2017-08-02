Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC4A20899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbdHBTt4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:49:56 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36892 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdHBTtk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:49:40 -0400
Received: by mail-pg0-f45.google.com with SMTP id y129so25101293pgy.4
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4WwNlPS6ILayXxGk8PMHAzLHYX9/Ri5GKqr/Qrk+Q1g=;
        b=grZ6KBV2WPJfTx3aDcmWSeuhrgPA1ghqvdhp4cUwoC6DR2GVLh3nXfcA7U4sJ2IoPo
         VkKKhXo2jAccoY6rdpU8Dqep0Pu+hDkE860lp3Ghzvrz1pDDTf3SxnkCPApLHouvsSf6
         v/I1vrMvQt2VEEIXAs/lKm2yAO4277u9mFdngnhp7afASX+Gl388An/aHGNXfry7qmB0
         8QAye/4FHdsHDflM3S1IsO3Gzpe9Jqwxy6t+ljrZlg7u/7a5zwahvqQjhVzrlPyQF8Qg
         SQuJ5U2IuqE0MDkiWCeIW5TbGY1JQ+bP22nGF2JhGQ4MzlkM0WGLS5QzaGvsBoXXo/9B
         iXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4WwNlPS6ILayXxGk8PMHAzLHYX9/Ri5GKqr/Qrk+Q1g=;
        b=j8ytj9mbDJDP9eZOGgTpAUi9gAl7nR6NeqQcb+/TmD16ROqcqKghGeimk2NiAJ9mgC
         NhGqUSlanal9I7eUgFZoCsW0aVCXvf4mbMsidM5jiXns6sgFgzFKquz2f11F0H96U3lM
         w6799zOAvx4TB0m5JE8tPKtBB+l6EyR5X4Gqken4sfn2+5tYAqWSqYe1rRAV5dI597qA
         aokzVLpohgUf0F0l8+lBRP4/xlrgwaKK+hN4VlWjAmuYfua1JklnavcamRSKCEeTI96R
         cX7KHPSAHBER5XWxV24fnkf0UiC/15+4sCIJ9zYS2FppkMGmBpUBYpZ5hH6V/SWJy3dL
         F8jw==
X-Gm-Message-State: AIVw1122M899GCxm8eSNtaqMHQXfhjrTG8+168Q+WItTjqtOIEl1W3nV
        i77LsrCFVkwJMRWU+uLdBw==
X-Received: by 10.98.11.135 with SMTP id 7mr24331695pfl.45.1501703379537;
        Wed, 02 Aug 2017 12:49:39 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e64sm63401460pfb.129.2017.08.02.12.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:49:38 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 07/10] submodule: check for unstaged .gitmodules outside of config parsing
Date:   Wed,  2 Aug 2017 12:49:20 -0700
Message-Id: <20170802194923.88239-8-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170802194923.88239-1-bmwill@google.com>
References: <20170718190527.78049-1-bmwill@google.com>
 <20170802194923.88239-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'is_staging_gitmodules_ok()' to be able to determine in the
'.gitmodules' file has unstaged changes based on the passed in index
instead of relying on a global variable which is set during the
submodule-config parsing.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/mv.c |  2 +-
 builtin/rm.c |  2 +-
 submodule.c  | 32 +++++++++++++++++---------------
 submodule.h  |  2 +-
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index dcf6736b5..94fbaaa5d 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -81,7 +81,7 @@ static void prepare_move_submodule(const char *src, int first,
 	struct strbuf submodule_dotgit = STRBUF_INIT;
 	if (!S_ISGITLINK(active_cache[first]->ce_mode))
 		die(_("Directory %s is in index and no submodule?"), src);
-	if (!is_staging_gitmodules_ok())
+	if (!is_staging_gitmodules_ok(&the_index))
 		die(_("Please stage your changes to .gitmodules or stash them to proceed"));
 	strbuf_addf(&submodule_dotgit, "%s/.git", src);
 	*submodule_gitfile = read_gitfile(submodule_dotgit.buf);
diff --git a/builtin/rm.c b/builtin/rm.c
index 52826d137..4057e73fa 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -286,7 +286,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		list.entry[list.nr].name = xstrdup(ce->name);
 		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
 		if (list.entry[list.nr++].is_submodule &&
-		    !is_staging_gitmodules_ok())
+		    !is_staging_gitmodules_ok(&the_index))
 			die (_("Please stage your changes to .gitmodules or stash them to proceed"));
 	}
 
diff --git a/submodule.c b/submodule.c
index 1d9d2ce09..677b5c401 100644
--- a/submodule.c
+++ b/submodule.c
@@ -37,18 +37,25 @@ static struct oid_array ref_tips_after_fetch;
 static int gitmodules_is_unmerged;
 
 /*
- * This flag is set if the .gitmodules file had unstaged modifications on
- * startup. This must be checked before allowing modifications to the
- * .gitmodules file with the intention to stage them later, because when
- * continuing we would stage the modifications the user didn't stage herself
- * too. That might change in a future version when we learn to stage the
- * changes we do ourselves without staging any previous modifications.
+ * Check if the .gitmodules file has unstaged modifications.  This must be
+ * checked before allowing modifications to the .gitmodules file with the
+ * intention to stage them later, because when continuing we would stage the
+ * modifications the user didn't stage herself too. That might change in a
+ * future version when we learn to stage the changes we do ourselves without
+ * staging any previous modifications.
  */
-static int gitmodules_is_modified;
-
-int is_staging_gitmodules_ok(void)
+int is_staging_gitmodules_ok(const struct index_state *istate)
 {
-	return !gitmodules_is_modified;
+	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
+
+	if ((pos >= 0) && (pos < istate->cache_nr)) {
+		struct stat st;
+		if (lstat(GITMODULES_FILE, &st) == 0 &&
+		    ce_match_stat(istate->cache[pos], &st, 0) & DATA_CHANGED)
+			return 0;
+	}
+
+	return 1;
 }
 
 /*
@@ -231,11 +238,6 @@ void gitmodules_config(void)
 				    !memcmp(ce->name, GITMODULES_FILE, 11))
 					gitmodules_is_unmerged = 1;
 			}
-		} else if (pos < active_nr) {
-			struct stat st;
-			if (lstat(GITMODULES_FILE, &st) == 0 &&
-			    ce_match_stat(active_cache[pos], &st, 0) & DATA_CHANGED)
-				gitmodules_is_modified = 1;
 		}
 
 		if (!gitmodules_is_unmerged)
diff --git a/submodule.h b/submodule.h
index 29a1ecd19..b14660585 100644
--- a/submodule.h
+++ b/submodule.h
@@ -33,7 +33,7 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
-extern int is_staging_gitmodules_ok(void);
+extern int is_staging_gitmodules_ok(const struct index_state *istate);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
 extern void stage_updated_gitmodules(void);
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

