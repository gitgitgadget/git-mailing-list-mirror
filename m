From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] diffcore: make addremove/modified/unmerged return a
 filepair
Date: Wed, 20 Apr 2011 18:07:45 -0700
Message-ID: <7vei4wza1q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 03:08:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCiNH-0002jw-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 03:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371Ab1DUBH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 21:07:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1DUBH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 21:07:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B0DF5DBA;
	Wed, 20 Apr 2011 21:09:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=B
	eGY5wxmjX15iYVxSJXTSq8q8fU=; b=Gn2IMaPDL5zhUKUF/YyzcFtD4N3JbPdMv
	dh5FL2A7iS4yPQQE7aTo5AZ4xWbVdDKdNjiJuOPdyjkmS7KYcO5rutZWC/KUMWjc
	h5TaLOTD1InlJgKFMxSv7t3I5NKKMfxoJwHxawcz97MsJjiBzhExk+n9Ff0lRdWD
	vyb6WUXG+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=C8n
	yrnzU+FDs7mCrBNS+iPVR4CXRklXs+6IwasTgu8x4aoFKhpAVV9bMArP7kDLKvr1
	Ine0qDbDrxW5Dw3fCgjq7bUTAdv7i893pJSFwqg5CRdFuevIrYEkGK0JMWPGKZyw
	W6xp8nfx2gwJwJM27gu08oBnATSE3irf0usqhvM8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A1935DB9;
	Wed, 20 Apr 2011 21:09:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7EC945DB8; Wed, 20 Apr 2011
 21:09:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E08E76E-6BB4-11E0-870B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171884>

The return value from the underlying diff_queue() function these helper
functions wrap are meant to be further manipulated by the caller, but
the helpers discarded it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Strictly speaking, I only need this patch for diff_unmerged(), but 
   fixed all the three helpers for consistency.

 diff.c     |   29 ++++++++++++++++++-----------
 diff.h     |   10 +++++-----
 revision.c |    6 ++++--
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index 9a5c77c..41b91cb 100644
--- a/diff.c
+++ b/diff.c
@@ -4225,15 +4225,16 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 	return ignored;
 }
 
-void diff_addremove(struct diff_options *options,
+struct diff_filepair *diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
 		    const char *concatpath, unsigned dirty_submodule)
 {
 	struct diff_filespec *one, *two;
+	struct diff_filepair *elem;
 
 	if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
-		return;
+		return NULL;
 
 	/* This may look odd, but it is a preparation for
 	 * feeding "there are unchanged files which should
@@ -4253,7 +4254,7 @@ void diff_addremove(struct diff_options *options,
 
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
@@ -4265,12 +4266,13 @@ void diff_addremove(struct diff_options *options,
 		two->dirty_submodule = dirty_submodule;
 	}
 
-	diff_queue(&diff_queued_diff, one, two);
+	elem = diff_queue(&diff_queued_diff, one, two);
 	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
 		DIFF_OPT_SET(options, HAS_CHANGES);
+	return elem;
 }
 
-void diff_change(struct diff_options *options,
+struct diff_filepair *diff_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
@@ -4278,10 +4280,11 @@ void diff_change(struct diff_options *options,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
 	struct diff_filespec *one, *two;
+	struct diff_filepair *elem;
 
 	if (S_ISGITLINK(old_mode) && S_ISGITLINK(new_mode) &&
 	    is_submodule_ignored(concatpath, options))
-		return;
+		return NULL;
 
 	if (DIFF_OPT_TST(options, REVERSE_DIFF)) {
 		unsigned tmp;
@@ -4294,7 +4297,7 @@ void diff_change(struct diff_options *options,
 
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
@@ -4303,25 +4306,29 @@ void diff_change(struct diff_options *options,
 	one->dirty_submodule = old_dirty_submodule;
 	two->dirty_submodule = new_dirty_submodule;
 
-	diff_queue(&diff_queued_diff, one, two);
+	elem = diff_queue(&diff_queued_diff, one, two);
 	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
 		DIFF_OPT_SET(options, HAS_CHANGES);
+	return elem;
 }
 
-void diff_unmerge(struct diff_options *options,
+struct diff_filepair *diff_unmerge(struct diff_options *options,
 		  const char *path,
 		  unsigned mode, const unsigned char *sha1)
 {
 	struct diff_filespec *one, *two;
+	struct diff_filepair *elem;
 
 	if (options->prefix &&
 	    strncmp(path, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(path);
 	two = alloc_filespec(path);
 	fill_filespec(one, sha1, mode);
-	diff_queue(&diff_queued_diff, one, two)->is_unmerged = 1;
+	elem = diff_queue(&diff_queued_diff, one, two);
+	elem->is_unmerged = 1;
+	return elem;
 }
 
 static char *run_textconv(const char *pgm, struct diff_filespec *spec,
diff --git a/diff.h b/diff.h
index bf2f44d..d71965f 100644
--- a/diff.h
+++ b/diff.h
@@ -13,14 +13,14 @@ struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
 
-typedef void (*change_fn_t)(struct diff_options *options,
+typedef struct diff_filepair *(*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
 		 const char *fullpath,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule);
 
-typedef void (*add_remove_fn_t)(struct diff_options *options,
+typedef struct diff_filepair *(*add_remove_fn_t)(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
 		    const char *fullpath, unsigned dirty_submodule);
@@ -196,20 +196,20 @@ extern void diff_tree_combined_merge(const unsigned char *sha1, int, struct rev_
 
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b);
 
-extern void diff_addremove(struct diff_options *,
+extern struct diff_filepair *diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
 			   const unsigned char *sha1,
 			   const char *fullpath, unsigned dirty_submodule);
 
-extern void diff_change(struct diff_options *,
+extern struct diff_filepair *diff_change(struct diff_options *,
 			unsigned mode1, unsigned mode2,
 			const unsigned char *sha1,
 			const unsigned char *sha2,
 			const char *fullpath,
 			unsigned dirty_submodule1, unsigned dirty_submodule2);
 
-extern void diff_unmerge(struct diff_options *,
+extern struct diff_filepair *diff_unmerge(struct diff_options *,
 			 const char *path,
 			 unsigned mode,
 			 const unsigned char *sha1);
diff --git a/revision.c b/revision.c
index b1c1890..614e5d9 100644
--- a/revision.c
+++ b/revision.c
@@ -276,7 +276,7 @@ static int everybody_uninteresting(struct commit_list *orig)
  */
 static int tree_difference = REV_TREE_SAME;
 
-static void file_add_remove(struct diff_options *options,
+static struct diff_filepair *file_add_remove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
 		    const char *fullpath, unsigned dirty_submodule)
@@ -286,9 +286,10 @@ static void file_add_remove(struct diff_options *options,
 	tree_difference |= diff;
 	if (tree_difference == REV_TREE_DIFFERENT)
 		DIFF_OPT_SET(options, HAS_CHANGES);
+	return NULL;
 }
 
-static void file_change(struct diff_options *options,
+static struct diff_filepair *file_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
@@ -297,6 +298,7 @@ static void file_change(struct diff_options *options,
 {
 	tree_difference = REV_TREE_DIFFERENT;
 	DIFF_OPT_SET(options, HAS_CHANGES);
+	return NULL;
 }
 
 static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct commit *commit)
-- 
1.7.5.rc3
