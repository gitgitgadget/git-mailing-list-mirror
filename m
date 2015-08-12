From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 3/4] refs: make refs/worktree/* per-worktree
Date: Wed, 12 Aug 2015 17:57:24 -0400
Message-ID: <1439416645-19173-3-git-send-email-dturner@twopensource.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, chriscool@tuxfamily.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 12 23:58:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPe21-0003ZI-O5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 23:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbbHLV5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 17:57:54 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35466 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbbHLV5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 17:57:53 -0400
Received: by qkbm65 with SMTP id m65so10050578qkb.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 14:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rQJv9DQvxlcvShR1DyHemiYg8UHgUgPxXWZ/DgRiXJE=;
        b=aEBtvXcqGtK5ut6Ke12GbjGRV0sDT4omLqP8dBpvUK+/OlxVxwlqu7hhB1s5hlRBsA
         bZfIzpIH43IKUOqB4G6o6RsBbhojAAvNP9RR+dp3E9H8z58y9hPpbZAQsV+1Ewocq3F9
         rTCJKlvhj9tPFOgw4lyZqlfn3tAQCw9TW4gU6c5Lrp4kfXMiZpQkAYql/wFgVWVZcfFC
         h8EYfPfTFVDCXRuPdG+4SHyNrhhtntX6DtU/JF5yv2u83rF5crZeMuIy7odB1kLV+sS9
         4NorxhrU9AVtcgGnumDry7lgIvxGm9PwnwuhR5kbgnjr3PhlgN+E1TFUUnrJiJAdbw6c
         iFwA==
X-Gm-Message-State: ALoCoQnymuJErIJUZ2n04EA/qOL74eiqcRw/TM4+NhoWDsd+ByGlAKGnv6ZAoqYWee3EFj4Z6aaG
X-Received: by 10.55.42.131 with SMTP id q3mr63043838qkq.76.1439416672124;
        Wed, 12 Aug 2015 14:57:52 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f71sm110289qhe.7.2015.08.12.14.57.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Aug 2015 14:57:51 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275818>

We need a place to stick refs for bisects in progress that is not
shared between worktrees.  So we use the refs/worktree/ hierarchy.

The is_per_worktree_ref function and associated docs learn that
refs/worktree/ is per-worktree, as does the git_path code in path.c

The ref-packing functions learn that per-worktree refs should not be
packed (since packed-refs is common rather than per-worktree).

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/glossary-content.txt |  5 +++--
 path.c                             |  1 +
 refs.c                             | 32 +++++++++++++++++++++++++++++++-
 t/t0060-path-utils.sh              |  1 +
 t/t1400-update-ref.sh              | 18 ++++++++++++++++++
 t/t3210-pack-refs.sh               |  7 +++++++
 6 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8c6478b..5c707e6 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -413,8 +413,9 @@ exclude;;
 
 [[def_per_worktree_ref]]per-worktree ref::
 	Refs that are per-<<def_working_tree,worktree>>, rather than
-	global.  This is presently only <<def_HEAD,HEAD>>, but might
-	later include other unusual refs.
+	global.  This is presently only <<def_HEAD,HEAD>> and any refs
+	that start with `refs/worktree/`, but might later include other
+	unusual refs.
 
 [[def_pseudoref]]pseudoref::
 	Pseudorefs are a class of files under `$GIT_DIR` which behave
diff --git a/path.c b/path.c
index 21a4ce7..c53f732 100644
--- a/path.c
+++ b/path.c
@@ -110,6 +110,7 @@ struct common_dir common_list[] = {
 	{ "lost-found", 0, 1, 0 },
 	{ "objects", 0, 1, 0 },
 	{ "refs", 0, 1, 0 },
+	{ "refs/worktree", 0, 1, 1 },
 	{ "remotes", 0, 1, 0 },
 	{ "worktrees", 0, 1, 0 },
 	{ "rr-cache", 0, 1, 0 },
diff --git a/refs.c b/refs.c
index e6fc3fe..30331bc 100644
--- a/refs.c
+++ b/refs.c
@@ -298,6 +298,11 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
+static int search_ref_dir(struct ref_dir *dir, const char *refname, size_t len);
+static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
+					  const char *dirname, size_t len,
+					  int incomplete);
+static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -306,6 +311,24 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	dir = &entry->u.subdir;
 	if (entry->flag & REF_INCOMPLETE) {
 		read_loose_refs(entry->name, dir);
+
+		/*
+		 * Manually add refs/worktree, which, being
+		 * per-worktree, might not appear in the directory
+		 * listing for refs/ in the main repo.
+		 */
+		if (!strcmp(entry->name, "refs/")) {
+			int pos = search_ref_dir(dir, "refs/worktree/", 14);
+			if (pos < 0) {
+				struct ref_entry *child_entry;
+				child_entry = create_dir_entry(dir->ref_cache,
+							       "refs/worktree/",
+							       14, 1);
+				add_entry_to_dir(dir, child_entry);
+				read_loose_refs("refs/worktree",
+						&child_entry->u.subdir);
+			}
+		}
 		entry->flag &= ~REF_INCOMPLETE;
 	}
 	return dir;
@@ -2643,6 +2666,8 @@ struct pack_refs_cb_data {
 	struct ref_to_prune *ref_to_prune;
 };
 
+static int is_per_worktree_ref(const char *refname);
+
 /*
  * An each_ref_entry_fn that is run over loose references only.  If
  * the loose reference can be packed, add an entry in the packed ref
@@ -2656,6 +2681,10 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *packed_entry;
 	int is_tag_ref = starts_with(entry->name, "refs/tags/");
 
+	/* Do not pack per-worktree refs: */
+	if (is_per_worktree_ref(entry->name))
+		return 0;
+
 	/* ALWAYS pack tags */
 	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref)
 		return 0;
@@ -2850,7 +2879,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 static int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD");
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/worktree/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 93605f4..28e6dff 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -275,6 +275,7 @@ test_git_path GIT_COMMON_DIR=bar remotes/bar              bar/remotes/bar
 test_git_path GIT_COMMON_DIR=bar branches/bar             bar/branches/bar
 test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master   bar/logs/refs/heads/master
 test_git_path GIT_COMMON_DIR=bar refs/heads/master        bar/refs/heads/master
+test_git_path GIT_COMMON_DIR=bar refs/worktree/foo        .git/refs/worktree/foo
 test_git_path GIT_COMMON_DIR=bar hooks/me                 bar/hooks/me
 test_git_path GIT_COMMON_DIR=bar config                   bar/config
 test_git_path GIT_COMMON_DIR=bar packed-refs              bar/packed-refs
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 9d21c19..7ecd33b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1131,4 +1131,22 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches
 )
 '
 
+test_expect_success 'handle per-worktree refs in refs/worktree' '
+	git commit --allow-empty -m "initial commit" &&
+	git worktree add -b branch worktree &&
+	(
+		cd worktree &&
+		git commit --allow-empty -m "test commit"  &&
+		git for-each-ref | test_must_fail grep refs/worktree &&
+		git update-ref refs/worktree/something HEAD &&
+		git rev-parse refs/worktree/something >../worktree-head &&
+		git for-each-ref | grep refs/worktree/something
+	) &&
+	test_path_is_missing .git/refs/worktree &&
+	test_must_fail git rev-parse refs/worktree/something &&
+	git update-ref refs/worktree/something HEAD &&
+	git rev-parse refs/worktree/something >main-head &&
+	! test_cmp main-head worktree-head
+'
+
 test_done
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 8aae98d..c54cd29 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -160,6 +160,13 @@ test_expect_success 'pack ref directly below refs/' '
 	test_path_is_missing .git/refs/top
 '
 
+test_expect_success 'do not pack ref in refs/worktree' '
+	git update-ref refs/worktree/local HEAD &&
+	git pack-refs --all --prune &&
+	! grep refs/worktree/local .git/packed-refs >/dev/null &&
+	test_path_is_file .git/refs/worktree/local
+'
+
 test_expect_success 'disable reflogs' '
 	git config core.logallrefupdates false &&
 	rm -rf .git/logs
-- 
2.0.4.315.gad8727a-twtrsrc
