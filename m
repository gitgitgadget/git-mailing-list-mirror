From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 3/3] refs: make refs/bisect/* per-worktree
Date: Mon, 31 Aug 2015 22:13:11 -0400
Message-ID: <1441073591-639-4-git-send-email-dturner@twopensource.com>
References: <1441073591-639-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:13:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWb4z-0005Zc-2T
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 04:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbbIACNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 22:13:37 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34071 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbbIACNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 22:13:35 -0400
Received: by qkct7 with SMTP id t7so26871135qkc.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 19:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gbCxQIZVMYEom0UHPic1Q8Q5cnvV8GYaevh0toCpe5Y=;
        b=iBFZc5HLFiMgkhTVg1IMMwzGwwEhzKomhjq+kCYvF4gwxn3GPa1Br8fVsCUphykVd8
         zEvVPS+mWK6GkJCBSQKt3jr7NY+PAw8qW0c2nIE8+FrFxT9cudq1pXQvVQgfqsV/iL8B
         mGFYXd2i1+/zibspQ65IwxcxmsbwIJ7dk44wUG0mLIFUVvk1lMD0qdk3jTHs4PZYEeXq
         5MpYDnb+8RqvpnQwqyojkML8YobgMsFhiT0wXIanyXYDZ55NP5jIcKm1/L9yY4mWG0sw
         SW7nCT/QrR/S/9Ziuttcdg4zi1sjI52QqEvjjWBK5ek3HaCRBbmT2D6BDDxg3OGgV7n9
         sQ7w==
X-Gm-Message-State: ALoCoQmRsOrkG8Q3wfpl8GAYPzt/WD3Jjwco+h8I2HLpe2l3Ilug+p845JEBLqUvW7ZOcNTPxKol
X-Received: by 10.55.22.143 with SMTP id 15mr15413911qkw.38.1441073614681;
        Mon, 31 Aug 2015 19:13:34 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id j207sm9926375qhc.17.2015.08.31.19.13.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 19:13:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441073591-639-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276963>

We need the place we stick refs for bisects in progress to not be
shared between worktrees.  So we make the refs/bisect/ hierarchy
per-worktree.

The is_per_worktree_ref function and associated docs learn that
refs/bisect/ is per-worktree, as does the git_path code in path.c

The ref-packing functions learn that per-worktree refs should not be
packed (since packed-refs is common rather than per-worktree).

Since refs/bisect is per-worktree, logs/refs/bisect should be too.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/glossary-content.txt |  5 +++--
 path.c                             |  2 ++
 refs.c                             | 32 +++++++++++++++++++++++++++++++-
 t/t0060-path-utils.sh              |  5 +++++
 t/t1400-update-ref.sh              | 19 +++++++++++++++++++
 t/t3210-pack-refs.sh               |  7 +++++++
 6 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8c6478b..e225974 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -413,8 +413,9 @@ exclude;;
 
 [[def_per_worktree_ref]]per-worktree ref::
 	Refs that are per-<<def_working_tree,worktree>>, rather than
-	global.  This is presently only <<def_HEAD,HEAD>>, but might
-	later include other unusual refs.
+	global.  This is presently only <<def_HEAD,HEAD>> and any refs
+	that start with `refs/bisect/`, but might later include other
+	unusual refs.
 
 [[def_pseudoref]]pseudoref::
 	Pseudorefs are a class of files under `$GIT_DIR` which behave
diff --git a/path.c b/path.c
index c87f44a..26723a9 100644
--- a/path.c
+++ b/path.c
@@ -107,9 +107,11 @@ struct common_dir common_list[] = {
 	{ 0, 0, 1, "info/sparse-checkout" },
 	{ 1, 1, 0, "logs" },
 	{ 1, 1, 1, "logs/HEAD" },
+	{ 0, 1, 1, "logs/refs/bisect" },
 	{ 0, 1, 0, "lost-found" },
 	{ 0, 1, 0, "objects" },
 	{ 0, 1, 0, "refs" },
+	{ 0, 1, 1, "refs/bisect" },
 	{ 0, 1, 0, "remotes" },
 	{ 0, 1, 0, "worktrees" },
 	{ 0, 1, 0, "rr-cache" },
diff --git a/refs.c b/refs.c
index 4e15f60..24401f7 100644
--- a/refs.c
+++ b/refs.c
@@ -304,6 +304,11 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
+static int search_ref_dir(struct ref_dir *dir, const char *refname, size_t len);
+static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
+					  const char *dirname, size_t len,
+					  int incomplete);
+static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -312,6 +317,24 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	dir = &entry->u.subdir;
 	if (entry->flag & REF_INCOMPLETE) {
 		read_loose_refs(entry->name, dir);
+
+		/*
+		 * Manually add refs/bisect, which, being
+		 * per-worktree, might not appear in the directory
+		 * listing for refs/ in the main repo.
+		 */
+		if (!strcmp(entry->name, "refs/")) {
+			int pos = search_ref_dir(dir, "refs/bisect/", 12);
+			if (pos < 0) {
+				struct ref_entry *child_entry;
+				child_entry = create_dir_entry(dir->ref_cache,
+							       "refs/bisect/",
+							       12, 1);
+				add_entry_to_dir(dir, child_entry);
+				read_loose_refs("refs/bisect",
+						&child_entry->u.subdir);
+			}
+		}
 		entry->flag &= ~REF_INCOMPLETE;
 	}
 	return dir;
@@ -2649,6 +2672,8 @@ struct pack_refs_cb_data {
 	struct ref_to_prune *ref_to_prune;
 };
 
+static int is_per_worktree_ref(const char *refname);
+
 /*
  * An each_ref_entry_fn that is run over loose references only.  If
  * the loose reference can be packed, add an entry in the packed ref
@@ -2662,6 +2687,10 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *packed_entry;
 	int is_tag_ref = starts_with(entry->name, "refs/tags/");
 
+	/* Do not pack per-worktree refs: */
+	if (is_per_worktree_ref(entry->name))
+		return 0;
+
 	/* ALWAYS pack tags */
 	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref)
 		return 0;
@@ -2856,7 +2885,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 static int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD");
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/bisect/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 1ca49e1..627ef85 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -266,6 +266,10 @@ test_expect_success 'setup common repository' 'git --git-dir=bar init'
 test_git_path GIT_COMMON_DIR=bar index                    .git/index
 test_git_path GIT_COMMON_DIR=bar HEAD                     .git/HEAD
 test_git_path GIT_COMMON_DIR=bar logs/HEAD                .git/logs/HEAD
+test_git_path GIT_COMMON_DIR=bar logs/refs/bisect/foo     .git/logs/refs/bisect/foo
+test_git_path GIT_COMMON_DIR=bar logs/refs/bisec/foo      bar/logs/refs/bisec/foo
+test_git_path GIT_COMMON_DIR=bar logs/refs/bisec          bar/logs/refs/bisec
+test_git_path GIT_COMMON_DIR=bar logs/refs/bisectfoo      bar/logs/refs/bisectfoo
 test_git_path GIT_COMMON_DIR=bar objects                  bar/objects
 test_git_path GIT_COMMON_DIR=bar objects/bar              bar/objects/bar
 test_git_path GIT_COMMON_DIR=bar info/exclude             bar/info/exclude
@@ -276,6 +280,7 @@ test_git_path GIT_COMMON_DIR=bar remotes/bar              bar/remotes/bar
 test_git_path GIT_COMMON_DIR=bar branches/bar             bar/branches/bar
 test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master   bar/logs/refs/heads/master
 test_git_path GIT_COMMON_DIR=bar refs/heads/master        bar/refs/heads/master
+test_git_path GIT_COMMON_DIR=bar refs/bisect/foo          .git/refs/bisect/foo
 test_git_path GIT_COMMON_DIR=bar hooks/me                 bar/hooks/me
 test_git_path GIT_COMMON_DIR=bar config                   bar/config
 test_git_path GIT_COMMON_DIR=bar packed-refs              bar/packed-refs
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 97406fa..af1b20d 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1130,4 +1130,23 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches
 )
 '
 
+test_expect_success 'handle per-worktree refs in refs/bisect' '
+	git commit --allow-empty -m "initial commit" &&
+	git worktree add -b branch worktree &&
+	(
+		cd worktree &&
+		git commit --allow-empty -m "test commit"  &&
+		git for-each-ref >for-each-ref.out &&
+		! grep refs/bisect for-each-ref.out &&
+		git update-ref refs/bisect/something HEAD &&
+		git rev-parse refs/bisect/something >../worktree-head &&
+		git for-each-ref | grep refs/bisect/something
+	) &&
+	test_path_is_missing .git/refs/bisect &&
+	test_must_fail git rev-parse refs/bisect/something &&
+	git update-ref refs/bisect/something HEAD &&
+	git rev-parse refs/bisect/something >main-head &&
+	! test_cmp main-head worktree-head
+'
+
 test_done
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 7b5b6d4..db244d2 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -160,6 +160,13 @@ test_expect_success 'pack ref directly below refs/' '
 	test_path_is_missing .git/refs/top
 '
 
+test_expect_success 'do not pack ref in refs/bisect' '
+	git update-ref refs/bisect/local HEAD &&
+	git pack-refs --all --prune &&
+	! grep refs/bisect/local .git/packed-refs >/dev/null &&
+	test_path_is_file .git/refs/bisect/local
+'
+
 test_expect_success 'disable reflogs' '
 	git config core.logallrefupdates false &&
 	rm -rf .git/logs
-- 
2.0.4.315.gad8727a-twtrsrc
