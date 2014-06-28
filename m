From: David Turner <dturner@twopensource.com>
Subject: [PATCH 3/3] cache-tree: Write index with updated cache-tree after commit
Date: Fri, 27 Jun 2014 17:20:56 -0700
Message-ID: <1403914856-3546-3-git-send-email-dturner@twitter.com>
References: <1403914856-3546-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 02:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0gOi-0002d1-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 02:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbaF1AVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 20:21:35 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:54442 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbaF1AVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 20:21:33 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so136111qgf.14
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 17:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJT6q2BheTwt2I6hGnGwAgDc+uSOArxwrZJ52ypcrFc=;
        b=iW3LPqst9EesKixpq1piQgY0TCyL2KnY5K4CZFs4XkfNAPYhMdNcpOTWynj7+bOz4O
         0RQtfIPMggtNDMi90LQ/R4+sJM4LBLLc1j8DEMtffAb8KrEnCOi90g2oMsGBtzntb2kO
         4IctZWcKT4QyFdc2NCMM2xq37U0Bn7xGAMoTgL21RFI20HkMPPoy1fNogXS0hUgR/Idz
         Taf1ISGoOOXq2WuklKNx/y6VMajf58lsY504bskr6+W1DCsMfCAvw8pLJfGnbbJS/BJt
         ZzXqKDNuXW/L3VvY4hKd4oeZF6Wlpw0UV9tALBwD1yUJ3gzuTFav799mXtyBbhF8xlVy
         yQkg==
X-Gm-Message-State: ALoCoQmy5WztB+2rXlikXvfv9oW9owNNNdYnTaspJKdqx1e6eIEiuUaHfDR28EzPzMnhf87OrWST
X-Received: by 10.140.84.168 with SMTP id l37mr36810072qgd.104.1403914893069;
        Fri, 27 Jun 2014 17:21:33 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id j1sm18940941qaa.11.2014.06.27.17.21.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jun 2014 17:21:32 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1403914856-3546-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252587>

During the commit process, the cache-tree is updated. We need to write
this updated cache-tree so that it's ready for subsequent commands.

Add test code which demonstrates that git commit now writes the cache
tree.  Also demonstrate that  cache-tree invalidation is correct.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/commit.c      |  6 ++++++
 t/t0090-cache-tree.sh | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..6814e87 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -607,6 +607,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
 	int old_display_comment_prefix;
+	static struct lock_file index_lock;
+	int index_fd;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -872,6 +874,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		error(_("Error building trees"));
 		return 0;
 	}
+	/* After updating the cache-tree, rewrite the index */
+	index_fd = hold_locked_index(&index_lock, 0);
+	if (index_fd >= 0 && write_index(&the_index, index_fd) >= 0)
+		commit_locked_index(&index_lock);
 
 	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
 			    git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 5383258..ef012b9 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -16,8 +16,31 @@ cmp_cache_tree () {
 # We don't bother with actually checking the SHA1:
 # test-dump-cache-tree already verifies that all existing data is
 # correct.
+generate_expected_cache_tree () {
+	if [ -n "$1" ]
+	then
+		local dir="$1/"
+	else
+		local dir="$1"
+	fi
+	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
+	# We want to count only foo because it's the only direct child
+	local subtrees=$(git ls-files|egrep '/' |cut -d / -f 1|uniq) &&
+	local subtree_count=$(echo "$subtrees"|grep -c .) &&
+	local files_count=$(git ls-files|grep -v /|wc -l) &&
+	local entries=$(expr "$subtree_count" + "$files_count") &&
+	printf "SHA $dir (%d entries, %d subtrees)\n" $entries $subtree_count &&
+	local subtree &&
+	for subtree in $subtrees
+	do
+	    cd "$subtree"
+	    generate_expected_cache_tree "$dir$subtree" || return 1
+	    cd ..
+	done
+}
+
 test_shallow_cache_tree () {
-	printf "SHA  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >expect &&
+	generate_expected_cache_tree > expect &&
 	cmp_cache_tree expect
 }
 
@@ -35,7 +58,7 @@ test_no_cache_tree () {
 	cmp_cache_tree expect
 }
 
-test_expect_failure 'initial commit has cache-tree' '
+test_expect_success 'initial commit has cache-tree' '
 	test_commit foo &&
 	test_shallow_cache_tree
 '
@@ -60,15 +83,28 @@ test_expect_success 'git-add in subdir invalidates cache-tree' '
 	test_invalid_cache_tree
 '
 
+cat >before <<\EOF
+SHA  (3 entries, 2 subtrees)
+SHA dir1/ (1 entries, 0 subtrees)
+SHA dir2/ (1 entries, 0 subtrees)
+EOF
+
+cat >expect <<\EOF
+invalid                                   (2 subtrees)
+invalid                                  dir1/ (0 subtrees)
+SHA dir2/ (1 entries, 0 subtrees)
+EOF
+
 test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
 	git tag no-children
 	test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
 	mkdir dir1 dir2 &&
 	test_commit dir1/a &&
 	test_commit dir2/b &&
+	cmp_cache_tree before &&
 	echo "I changed this file" > dir1/a &&
 	git add dir1/a &&
-	test_invalid_cache_tree dir1/
+	cmp_cache_tree expect
 '
 
 test_expect_success 'update-index invalidates cache-tree' '
@@ -95,6 +131,14 @@ test_expect_success 'second commit has cache-tree' '
 	test_shallow_cache_tree
 '
 
+test_expect_success 'commit in child dir has cache-tree' '
+	mkdir dir &&
+	>dir/child.t &&
+	git add dir/child.t &&
+	git commit -m dir/child.t
+	test_shallow_cache_tree
+'
+
 test_expect_success 'reset --hard gives cache-tree' '
 	test-scrap-cache-tree &&
 	git reset --hard &&
-- 
2.0.0.390.gcb682f8
