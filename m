Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EF92013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbdBOAfV (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:21 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:38522 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdBOAfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:18 -0500
Received: by mail-it0-f53.google.com with SMTP id c7so54692955itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=joeQ17P4XaDO25u9DJyK3uu3XlvM5fZRUv+MT831Eiw=;
        b=uZtOeoV+4qg2qVwgISbOMskfbiLXunXG8Kxj97VQbuzduglE7xAhp7XaUMzf2/oPZ5
         7rjQGfew3jDbLL38gAgZ0/G2+QrCkBTY3B/ZdLDNaEUdLI7FuK8mV1bdaBwSS8MHJIPH
         5K6QMz3Pk8M5e6LwUB8+wmKTEDKSZRC8b7hy0fKb97U8DlxwXIMg/+FgBQ7PWG3+t2Qj
         lhwUCbzvC6cE4ddN6cKFYGcchnQRjmeaYX3QY7TAQj1Bh2GHKCUubmBz0qJVUMsq4v97
         eEMwztoBVRvs+9tcDZe/eZIIyRdAvwfTXP7oqKsKLc3ttYF1/4ovmUTEDUOuMJD3YO+W
         yazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=joeQ17P4XaDO25u9DJyK3uu3XlvM5fZRUv+MT831Eiw=;
        b=PyUCXYjxi0oWU8J0uyL3zWO34RKqpN4Qf8PcsziunuSgn0qxEkV4QLgXjK2d6o2jrB
         6bM/W996yofeCq+x/MYJKgEqfeCw0CtL63+oUY3LWFnixaswguJ+DpSLQTT/mYPkSuBH
         tnh27cCJ0Zl02qLBrtTu9ck4rxBfWhznjHLxAM0wYcqgzFsb1XCueQ4yOrC42/I4ZPtT
         C199qjqUGrgoa5j/IPTnyrKJx5ZJgaHxW0jtfMTFGTBuwPIIAYPS74SwSe3A7UQ39egE
         eTXmrt5hrOMvGU+d5RKi+HbP9xZdc8hT4FSHHoKbl4odQ+5V4fVjAkbkLzZgIitkxJxb
         jQUA==
X-Gm-Message-State: AMke39lmAiNZxwV2OXh9gwnSOhAUXkF6jJfkCOenrPbXL4BEax0o9fjS8xI4yL1QSq7IbZ68
X-Received: by 10.84.233.194 with SMTP id m2mr14335244pln.126.1487118917398;
        Tue, 14 Feb 2017 16:35:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id t6sm3387337pgt.8.2017.02.14.16.35.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/14] unpack-trees: check if we can perform the operation for submodules
Date:   Tue, 14 Feb 2017 16:34:20 -0800
Message-Id: <20170215003423.20245-12-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
 unpack-trees.h |  1 +
 2 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 616a0ae4b2..6805cb9549 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -10,6 +10,7 @@
 #include "attr.h"
 #include "split-index.h"
 #include "dir.h"
+#include "submodule.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -45,6 +46,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 
 	/* ERROR_WOULD_LOSE_ORPHANED_REMOVED */
 	"Working tree file '%s' would be removed by sparse checkout update.",
+
+	/* ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE */
+	"Submodule '%s' cannot be deleted as it contains untracked files.",
 };
 
 #define ERRORMSG(o,type) \
@@ -161,6 +165,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
 		_("The following working tree files would be removed by sparse checkout update:\n%s");
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE] =
+		_("Submodule '%s' cannot be deleted as it contains untracked files.");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
@@ -240,12 +246,44 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		fprintf(stderr, _("Aborting\n"));
 }
 
+static int submodule_check_from_to(const struct cache_entry *ce, const char *old_id, const char *new_id, struct unpack_trees_options *o)
+{
+	if (submodule_go_from_to(ce->name, old_id,
+				 new_id, 1, o->reset))
+		return o->gently ? -1 :
+			add_rejected_path(o, ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE, ce->name);
+	return 0;
+}
+
+static void reload_gitmodules_file(struct index_state *index,
+				   struct checkout *state)
+{
+	int i;
+	for (i = 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce = index->cache[i];
+		if (ce->ce_flags & CE_UPDATE) {
+
+			int r = strcmp(ce->name, ".gitmodules");
+			if (r < 0)
+				continue;
+			else if (r == 0) {
+				checkout_entry(ce, state, NULL);
+			} else
+				break;
+		}
+	}
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+}
+
 /*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
 static void unlink_entry(const struct cache_entry *ce)
 {
+	if (is_interesting_submodule(ce))
+		submodule_go_from_to(ce->name, "HEAD", NULL, 0, 1);
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
 	if (remove_or_warn(ce->ce_mode, ce->name))
@@ -301,6 +339,9 @@ static int check_updates(struct unpack_trees_options *o)
 	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
+	if (submodules_interesting_for_update() && o->update && !o->dry_run)
+		reload_gitmodules_file(index, &state);
+
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -1358,17 +1399,27 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 	if (!lstat(ce->name, &st)) {
 		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
 		unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);
+
+		if (is_interesting_submodule(ce)) {
+			int r;
+			r = submodule_check_from_to(ce,
+				"HEAD", oid_to_hex(&ce->oid), o);
+			if (r)
+				return o->gently ? -1 :
+					add_rejected_path(o, error_type, ce->name);
+			return 0;
+		}
+
 		if (!changed)
 			return 0;
 		/*
-		 * NEEDSWORK: the current default policy is to allow
-		 * submodule to be out of sync wrt the superproject
-		 * index.  This needs to be tightened later for
-		 * submodules that are marked to be automatically
-		 * checked out.
+		 * Historic default policy was to allow submodule to be out
+		 * of sync wrt the superproject index. If the submodule was
+		 * not considered interesting above, we don't care here.
 		 */
 		if (S_ISGITLINK(ce->ce_mode))
 			return 0;
+
 		errno = 0;
 	}
 	if (errno == ENOENT)
@@ -1412,7 +1463,12 @@ static int verify_clean_submodule(const char *old_sha1,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
-	return 0;
+	if (!is_interesting_submodule(ce))
+		return 0;
+
+	return submodule_check_from_to(ce,
+				       old_sha1,
+				       oid_to_hex(&ce->oid), o);
 }
 
 static int verify_clean_subdirectory(const struct cache_entry *ce,
@@ -1578,9 +1634,15 @@ static int verify_absent_1(const struct cache_entry *ce,
 		path = xmemdupz(ce->name, len);
 		if (lstat(path, &st))
 			ret = error_errno("cannot stat '%s'", path);
-		else
-			ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
-						 &st, error_type, o);
+		else {
+			if (is_interesting_submodule(ce))
+				ret = submodule_check_from_to(ce,
+							oid_to_hex(&ce->oid),
+							NULL, o);
+			else
+				ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
+							 &st, error_type, o);
+		}
 		free(path);
 		return ret;
 	} else if (lstat(ce->name, &st)) {
@@ -1588,6 +1650,10 @@ static int verify_absent_1(const struct cache_entry *ce,
 			return error_errno("cannot stat '%s'", ce->name);
 		return 0;
 	} else {
+		if (is_interesting_submodule(ce))
+			return submodule_check_from_to(ce, oid_to_hex(&ce->oid),
+						       NULL, o);
+
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 					  ce_to_dtype(ce), ce, &st,
 					  error_type, o);
@@ -1643,6 +1709,16 @@ static int merged_entry(const struct cache_entry *ce,
 			return -1;
 		}
 		invalidate_ce_path(merge, o);
+
+		if (is_interesting_submodule(ce)) {
+			int ret = submodule_check_from_to(ce,
+							  oid_to_hex(&old->oid),
+							  oid_to_hex(&ce->oid),
+							  o);
+			if (ret)
+				return ret;
+		}
+
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
 		/*
 		 * See if we can re-use the old CE directly?
@@ -1663,6 +1739,10 @@ static int merged_entry(const struct cache_entry *ce,
 			update |= old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
 			invalidate_ce_path(old, o);
 		}
+		if (is_interesting_submodule(ce)) {
+			if (submodule_check_from_to(ce, oid_to_hex(&old->oid), oid_to_hex(&ce->oid), o))
+				return -1;
+		}
 	} else {
 		/*
 		 * Previously unmerged entry left as an existence
diff --git a/unpack-trees.h b/unpack-trees.h
index 36a73a6d00..c0427ce082 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -21,6 +21,7 @@ enum unpack_trees_error_types {
 	ERROR_SPARSE_NOT_UPTODATE_FILE,
 	ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_ORPHANED_REMOVED,
+	ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE,
 	NB_UNPACK_TREES_ERROR_TYPES
 };
 
-- 
2.12.0.rc0.16.gd1691994b4.dirty

