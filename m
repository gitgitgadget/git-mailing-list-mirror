From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] use persistent memory for rejected paths
Date: Mon, 15 Nov 2010 20:52:19 +0100
Message-ID: <20101115195219.GB3297@localhost>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
 <20101114130205.GA27560@localhost>
 <vpq62vymmsz.fsf@bauges.imag.fr>
 <20101115194133.GA3297@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 20:52:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI56P-0001Sb-W7
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 20:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212Ab0KOTwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 14:52:23 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61180 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758208Ab0KOTwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 14:52:22 -0500
Received: by bwz15 with SMTP id 15so5538753bwz.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 11:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=KzaUvHRKfQUtqn+Y/mFA/tHJtb3LRl8yGMWOgMumX1k=;
        b=WLS1zVA3/0i5CHtXbaMO1OBf2J1dmdPYJ3HWBmaZigrgU9UsbTUZoEBDxUAl7Eoy4R
         +ZTgxsD8KWWt2L0ptsPcsv1/UbYvgj0Iwa/seGCETFekPxD8y82s7kpYWyaU+UqNOGU7
         r+FPm7RiUBx5+CAf4vf+FYcgoQ24QyHnLBUus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=RL1adlPgVkZxOAXf/jc2Wif4V7xrXrf5EyG3TWSMvu/sQbUnwZKx5IkYHi7TVCdhli
         KOgOWW//Jp6pKGtW+XoAG5yWFutJDTqCagjjTZvIvfWFH2ci9WubHit3A1US1T0MJXeT
         1qCyFh05v9jiKw7OgPJnxW34bG6we7DoK71Tc=
Received: by 10.204.84.144 with SMTP id j16mr6369687bkl.92.1289850740301;
        Mon, 15 Nov 2010 11:52:20 -0800 (PST)
Received: from darc.lan (p549A63CB.dip.t-dialin.net [84.154.99.203])
        by mx.google.com with ESMTPS id r21sm197973bkj.10.2010.11.15.11.52.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 11:52:18 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PI56B-0000um-Ar; Mon, 15 Nov 2010 20:52:19 +0100
Content-Disposition: inline
In-Reply-To: <20101115194133.GA3297@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161507>

An aborted merge prints the list of rejected paths as part of the
error message. Since commit f66caaf9 (do not overwrite files in
leading path), some of those paths do not have static buffers, so
we have to keep a copy. Use string_list's to accomplish this.

This changes the order of the list to the order in which the paths
are processed. Previously, it was reversed.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I clarified above which commit introduces this problem and I
removed the now unused struct rejected_paths_list.

Clemens

 t/t7607-merge-overwrite.sh     |   19 ++++++++++++++++---
 t/t7609-merge-co-error-msgs.sh |   16 ++++++++--------
 unpack-trees.c                 |   36 +++++++++++-------------------------
 unpack-trees.h                 |    9 +++------
 4 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index e49dd80..9137866 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -15,7 +15,9 @@ test_expect_success 'setup' '
 	git reset --hard c0 &&
 	mkdir sub &&
 	echo "sub/f" > sub/f &&
-	git add sub/f &&
+	mkdir sub2 &&
+	echo "sub2/f" > sub2/f &&
+	git add sub/f sub2/f &&
 	git commit -m sub &&
 	git tag sub &&
 	echo "VERY IMPORTANT CHANGES" > important
@@ -100,13 +102,24 @@ test_expect_success 'will not overwrite untracked subtree' '
 	test_cmp important sub/f/important
 '
 
+cat >expect <<\EOF
+error: The following untracked working tree files would be overwritten by merge:
+	sub
+	sub2
+Please move or remove them before you can merge.
+EOF
+
 test_expect_success 'will not overwrite untracked file in leading path' '
 	git reset --hard c0 &&
 	rm -rf sub &&
 	cp important sub &&
-	test_must_fail git merge sub &&
+	cp important sub2 &&
+	test_must_fail git merge sub 2>out &&
+	test_cmp out expect &&
 	test_path_is_missing .git/MERGE_HEAD &&
-	test_cmp important sub
+	test_cmp important sub &&
+	test_cmp important sub2 &&
+	rm -f sub sub2
 '
 
 test_expect_failure SYMLINKS 'will not overwrite untracked symlink in leading path' '
diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index 114d2bd..c994836 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -27,10 +27,10 @@ test_expect_success 'setup' '
 
 cat >expect <<\EOF
 error: The following untracked working tree files would be overwritten by merge:
-	two
-	three
-	four
 	five
+	four
+	three
+	two
 Please move or remove them before you can merge.
 EOF
 
@@ -49,9 +49,9 @@ test_expect_success 'untracked files overwritten by merge (fast and non-fast for
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by merge:
-	two
-	three
 	four
+	three
+	two
 Please, commit your changes or stash them before you can merge.
 error: The following untracked working tree files would be overwritten by merge:
 	five
@@ -68,8 +68,8 @@ test_expect_success 'untracked files or local changes ovewritten by merge' '
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
-	rep/two
 	rep/one
+	rep/two
 Please, commit your changes or stash them before you can switch branches.
 EOF
 
@@ -89,8 +89,8 @@ test_expect_success 'cannot switch branches because of local changes' '
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
-	rep/two
 	rep/one
+	rep/two
 Please, commit your changes or stash them before you can switch branches.
 EOF
 
@@ -102,8 +102,8 @@ test_expect_success 'not uptodate file porcelain checkout error' '
 
 cat >expect <<\EOF
 error: Updating the following directories would lose untracked files in it:
-	rep2
 	rep
+	rep2
 
 EOF
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 6816113..d5a4530 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -53,6 +53,7 @@ const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd)
 {
+	int i;
 	const char **msgs = opts->msgs;
 	const char *msg;
 	char *tmp;
@@ -96,6 +97,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		"The following Working tree files would be removed by sparse checkout update:\n%s";
 
 	opts->show_all_errors = 1;
+	/* rejected paths may not have a static buffer */
+	for (i = 0; i < ARRAY_SIZE(opts->unpack_rejects); i++)
+		opts->unpack_rejects[i].strdup_strings = 1;
 }
 
 static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
@@ -124,7 +128,6 @@ static int add_rejected_path(struct unpack_trees_options *o,
 			     enum unpack_trees_error_types e,
 			     const char *path)
 {
-	struct rejected_paths_list *newentry;
 	if (!o->show_all_errors)
 		return error(ERRORMSG(o, e), path);
 
@@ -132,45 +135,28 @@ static int add_rejected_path(struct unpack_trees_options *o,
 	 * Otherwise, insert in a list for future display by
 	 * display_error_msgs()
 	 */
-	newentry = xmalloc(sizeof(struct rejected_paths_list));
-	newentry->path = (char *)path;
-	newentry->next = o->unpack_rejects[e];
-	o->unpack_rejects[e] = newentry;
+	string_list_append(&o->unpack_rejects[e], path);
 	return -1;
 }
 
 /*
- * free all the structures allocated for the error <e>
- */
-static void free_rejected_paths(struct unpack_trees_options *o,
-				enum unpack_trees_error_types e)
-{
-	while (o->unpack_rejects[e]) {
-		struct rejected_paths_list *del = o->unpack_rejects[e];
-		o->unpack_rejects[e] = o->unpack_rejects[e]->next;
-		free(del);
-	}
-	free(o->unpack_rejects[e]);
-}
-
-/*
  * display all the error messages stored in a nice way
  */
 static void display_error_msgs(struct unpack_trees_options *o)
 {
-	int e;
+	int e, i;
 	int something_displayed = 0;
 	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
-		if (o->unpack_rejects[e]) {
-			struct rejected_paths_list *rp;
+		struct string_list *rejects = &o->unpack_rejects[e];
+		if (rejects->nr > 0) {
 			struct strbuf path = STRBUF_INIT;
 			something_displayed = 1;
-			for (rp = o->unpack_rejects[e]; rp; rp = rp->next)
-				strbuf_addf(&path, "\t%s\n", rp->path);
+			for (i = 0; i < rejects->nr; i++)
+				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
 			error(ERRORMSG(o, e), path.buf);
 			strbuf_release(&path);
-			free_rejected_paths(o, e);
 		}
+		string_list_clear(rejects, 0);
 	}
 	if (something_displayed)
 		printf("Aborting\n");
diff --git a/unpack-trees.h b/unpack-trees.h
index 7c0187d..cd11a08 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -1,6 +1,8 @@
 #ifndef UNPACK_TREES_H
 #define UNPACK_TREES_H
 
+#include "string-list.h"
+
 #define MAX_UNPACK_TREES 8
 
 struct unpack_trees_options;
@@ -29,11 +31,6 @@ enum unpack_trees_error_types {
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd);
 
-struct rejected_paths_list {
-	char *path;
-	struct rejected_paths_list *next;
-};
-
 struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
@@ -59,7 +56,7 @@ struct unpack_trees_options {
 	 * Store error messages in an array, each case
 	 * corresponding to a error message type
 	 */
-	struct rejected_paths_list *unpack_rejects[NB_UNPACK_TREES_ERROR_TYPES];
+	struct string_list unpack_rejects[NB_UNPACK_TREES_ERROR_TYPES];
 
 	int head_idx;
 	int merge_size;
-- 
1.7.3.1.105.g84915
