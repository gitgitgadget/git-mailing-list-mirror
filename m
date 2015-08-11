From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 1/2] refs: refs/worktree/* become per-worktree
Date: Tue, 11 Aug 2015 00:56:18 -0400
Message-ID: <1439268979-10456-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, mhagger@alum.mit.edu,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 06:56:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP1cD-0000nS-HG
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 06:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbHKE4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 00:56:40 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34600 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbHKE4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 00:56:39 -0400
Received: by qgeg42 with SMTP id g42so96106744qge.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 21:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9+AUxTvwB/lomvEhOdrJBHZva8lPJqX+GhXnpaPXx6Y=;
        b=bK0BpEpfHKJICmnTIc3ovVdciBEdewPr3mP6cj/TgoEm/smWpvt/7CLlrNPAfpQgqF
         dt4hw5JctGzJRrlfIkl6JnN+P5rnGKpY9Z0IibFW6aF9d7dUe2zmTjLqvFHlSFT4wfxP
         COqb25v4tX1xXYoTwfJ/EIrjBXfxULcMeoix41CU8szmWLR+aSiqEWnYO4XGfHMcllf3
         YA9hHflBDZRQp3dgw8bSId4v5vTCrBXZ/Mnm1YT/L5CFEPDLkcSkP995i8zbKoH7Sw/f
         zwNTO30FZf6IJbd6Tj+u8zPNTmTcXMrdOYCXPkvAx6oPhUlnzDsy6Ld5MG6Ed899WIeM
         Go7Q==
X-Gm-Message-State: ALoCoQmCUHTz3jypiWRGzjxB9N3Zb+5zMVTp5VkbkWqqGa5o28HG5IUX5mSQSXeM3a1C+spTUf2p
X-Received: by 10.140.237.204 with SMTP id i195mr7816335qhc.93.1439268998111;
        Mon, 10 Aug 2015 21:56:38 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id z33sm495417qkg.44.2015.08.10.21.56.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Aug 2015 21:56:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275673>

We need a place to stick refs for bisects in progress that is not
shared between worktrees.  So we use the refs/worktree/ hierarchy.

The is_per_worktree_ref function and associated docs learn that
refs/worktree/ is per-worktree, as does the git_path code in path.c

The ref-packing functions learn that refs beginning with
refs/worktree/ should not be packed (since packed-refs is common
rather than per-worktree).

Signed-off-by: David Turner <dturner@twopensource.com>
---

This implements the very simple solution of making refs/worktree/
per-worktree, as we discussed on the PATCH/RFC first version of this
patch.

Note that git for-each-ref may have inconsistent behavior (I think; I
haven't confirmed this), sometimes showing refs/worktree/* and sometimes
not.  In the long run, we should fix this, but right now, I don't know
that it matters, since the only refs affected are these bisect refs.

---
 Documentation/glossary-content.txt |  5 +++--
 path.c                             | 15 ++++++++++++---
 refs.c                             |  7 ++++++-
 t/t1400-update-ref.sh              | 16 ++++++++++++++++
 t/t3210-pack-refs.sh               |  7 +++++++
 5 files changed, 44 insertions(+), 6 deletions(-)

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
index 10f4cbf..da0f767 100644
--- a/path.c
+++ b/path.c
@@ -92,8 +92,9 @@ static void replace_dir(struct strbuf *buf, int len, const char *newdir)
 }
 
 static const char *common_list[] = {
+	"/refs", /* special case, since refs/worktree/ is per-worktree */
 	"/branches", "/hooks", "/info", "!/logs", "/lost-found",
-	"/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
+	"/objects", "/remotes", "/worktrees", "/rr-cache", "/svn",
 	"config", "!gc.pid", "packed-refs", "shallow",
 	NULL
 };
@@ -116,8 +117,16 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len)
 			is_dir = 1;
 		}
 		if (is_dir && dir_prefix(base, path)) {
-			replace_dir(buf, git_dir_len, get_git_common_dir());
-			return;
+			/*
+			 * The first entry in common_list is refs, and
+			 * refs/worktree is *not* common.
+			 */
+
+			if (p != common_list ||
+			    !dir_prefix(base, "refs/worktree")) {
+				replace_dir(buf, git_dir_len, get_git_common_dir());
+				return;
+			}
 		}
 		if (!is_dir && !strcmp(base, path)) {
 			replace_dir(buf, git_dir_len, get_git_common_dir());
diff --git a/refs.c b/refs.c
index e6fc3fe..d43bfe1 100644
--- a/refs.c
+++ b/refs.c
@@ -2656,6 +2656,10 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *packed_entry;
 	int is_tag_ref = starts_with(entry->name, "refs/tags/");
 
+	/* Do not pack per-worktree refs: */
+	if (starts_with(entry->name, "refs/worktree/"))
+		return 0;
+
 	/* ALWAYS pack tags */
 	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref)
 		return 0;
@@ -2850,7 +2854,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 static int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD");
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/worktree/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 9d21c19..c9fd1ca 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1131,4 +1131,20 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches
 )
 '
 
+test_expect_success 'handle per-worktree refs in refs/worktree' '
+	git commit --allow-empty -m "initial commit" &&
+	git worktree add -b branch worktree &&
+	(
+		cd worktree &&
+		git commit --allow-empty -m "test commit"  &&
+		git update-ref refs/worktree/something HEAD &&
+		git rev-parse refs/worktree/something > ../worktree-head
+	) &&
+	! test -e .git/refs/worktree &&
+	test_must_fail git rev-parse refs/worktree/something &&
+	git update-ref refs/worktree/something HEAD &&
+	git rev-parse refs/worktree/something > main-head &&
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
