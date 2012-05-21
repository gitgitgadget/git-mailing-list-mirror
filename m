From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/7] Properly free unpack trees error messages
Date: Mon, 21 May 2012 16:56:09 +0200
Message-ID: <20120521145610.1911.31963.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWUGH-0004Lk-9n
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 17:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab2EUPK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 11:10:58 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40569 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab2EUPK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 11:10:57 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E3167A6285;
	Mon, 21 May 2012 17:10:45 +0200 (CEST)
X-git-sha1: 652803787d61cea3bef3015bd86f291ce7d0d0be 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198114>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/checkout.c | 1 +
 builtin/merge.c    | 6 ++++--
 merge-recursive.c  | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3ddda34..df8fef0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -435,6 +435,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
+		free_unpack_error_msgs(&topts);
 		if (ret == -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either
diff --git a/builtin/merge.c b/builtin/merge.c
index 470fc57..b96a9ae 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -768,7 +768,7 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
 	struct tree_desc t[MAX_UNPACK_TREES];
-	int i, fd, nr_trees = 0;
+	int i, fd, res, nr_trees = 0;
 	struct dir_struct dir;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
@@ -805,7 +805,9 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
-	if (unpack_trees(nr_trees, t, &opts))
+	res = unpack_trees(nr_trees, t, &opts);
+	free_unpack_error_msgs(&opts);
+	if (res)
 		return -1;
 	if (write_cache(fd, active_cache, active_nr) ||
 		commit_locked_index(lock_file))
diff --git a/merge-recursive.c b/merge-recursive.c
index 9c3570a..e196c45 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -239,6 +239,7 @@ static int git_merge_trees(int index_only,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &opts);
+	free_unpack_error_msgs(&opts);
 	cache_tree_free(&active_cache_tree);
 	return rc;
 }
-- 
1.7.10.2.555.g6528037
