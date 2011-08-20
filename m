From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v4] fast-import: do not write bad delta for replaced subtrees
Date: Sat, 20 Aug 2011 23:22:26 +0600
Message-ID: <1313860946-1596-1-git-send-email-divanorama@gmail.com>
References: <20110820154356.GB15864@elie.gateway.2wire.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 19:22:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QupFs-0002LX-Lr
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 19:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab1HTRUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 13:20:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58738 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab1HTRUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 13:20:48 -0400
Received: by bke11 with SMTP id 11so2855538bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oGI/2O34BZYX/2jP5Qyxh6EDJXL7def+6rTzVM0Fm2A=;
        b=wBiv+/drYR1pTdRksbsEYT9po44js2vg839TF2y7sjMzhj8YbOUe+L1cbSMfRg5zWa
         Lq+zJ4DwBSKsDj3frx5pSWOiuafOWU1+TkRTHk2XVlcVG6Q9wWs5bpST4LjBJ1ouDlIy
         bD+tYM2qypvyRpcUdj6vB+O0c+nql4ZTJQzFw=
Received: by 10.204.153.27 with SMTP id i27mr236791bkw.323.1313860846970;
        Sat, 20 Aug 2011 10:20:46 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zw12sm1384587bkb.27.2011.08.20.10.20.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 10:20:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <20110820154356.GB15864@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179765>

How about adding a new bit field "no_delta" instead? The patch is
smaller this way. Also could 04000 theoretically be S_IFDIR on some
platform?

Changes:
- switch to a separate no_delta bit in tree_entry, don't assume that it
  is used only for trees. Could be useful for blobs too once their delta
  base logic changes (now it's just delta against blob that was stored
  just before the current one)
- when setting no_delta = 1 don't check for S_ISDIR(versions[0].mode),
  this is a redundant check and logic duplication. Who knows, maybe some
  day we'll want to delta a tree against blob. :)
- removed the asserts on mode, as now "mode" meaning isn't changed
- removed the duplicated signed-of-by :)

-- >8 --
Subject: fast-import: do not write bad delta for replaced subtrees

To produce deltas for tree objects, fast-import tracks two versions of
each tree entry - a base and the current version. The base version on
a tree stands both for a delta base of this tree, and for a entry
inside the delta base of the parent tree. So care needs to be taken to
keep them consistent.

Unfortunately this all gets forgotten when replacing one subtree by
another using tree_content_set.  When writing an entry representing
the new subtree, it keeps the old base sha1, since it is needed by the
parent tree.  But the new tree doesn't have the implied base version
entries, and when it is time to write it to pack, git writes an
invalid delta that is declared to have one base (the old tree name)
but actually has another one (the new tree for an "M" command, or the
tree's old base for an "R" or "C" command).

How to fix it?  Modifying the new subtree's entries to match the
declared base would be expensive, since it requires reading the tree
corresponding to the declared base from the object db and recursively
rewriting children's base versions to match.  Invalidating the parent
trees' bases would involve recursively walking up the tree and
disables deltas for each tree it touches, meaning a larger pack.
Let's just mark the new tree as do-not-delta-me instead. Add a new bit
for tree_entry named no_delta. It is set to 1 when subtree is replaced
and reset back to 0 when we set a new legal delta base, that is when
e->versions[0] is changed.

tree_content_replace is in a similar predicament to tree_content_set,
except that because it is only used to replace the root, just
invalidating the base sha1 there (instead of setting the no-delta bit)
is fine.

Initial hack by Jonathan, test and description by Dmitry.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   27 ++++++++++++++++++++++++++-
 t/t9300-fast-import.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7cc2262..3bae498 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -221,6 +221,7 @@ struct tree_entry {
 		uint16_t mode;
 		unsigned char sha1[20];
 	} versions[2];
+	unsigned no_delta : 1;
 };
 
 struct tree_content {
@@ -1368,6 +1369,7 @@ static void load_tree(struct tree_entry *root)
 		if (!c)
 			die("Corrupt mode in %s", sha1_to_hex(sha1));
 		e->versions[0].mode = e->versions[1].mode;
+		e->no_delta = 0;
 		e->name = to_atom(c, strlen(c));
 		c += e->name->str_len + 1;
 		hashcpy(e->versions[0].sha1, (unsigned char *)c);
@@ -1437,7 +1439,10 @@ static void store_tree(struct tree_entry *root)
 			store_tree(t->entries[i]);
 	}
 
-	le = find_object(root->versions[0].sha1);
+	if (root->no_delta)
+		le = NULL;
+	else
+		le = find_object(root->versions[0].sha1);
 	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
 		mktree(t, 0, &old_tree);
 		lo.data = old_tree;
@@ -1453,6 +1458,7 @@ static void store_tree(struct tree_entry *root)
 		struct tree_entry *e = t->entries[i];
 		if (e->versions[1].mode) {
 			e->versions[0].mode = e->versions[1].mode;
+			e->no_delta = 0;
 			hashcpy(e->versions[0].sha1, e->versions[1].sha1);
 			t->entries[j++] = e;
 		} else {
@@ -1471,6 +1477,7 @@ static void tree_content_replace(
 {
 	if (!S_ISDIR(mode))
 		die("Root cannot be a non-directory");
+	hashclr(root->versions[0].sha1);
 	hashcpy(root->versions[1].sha1, sha1);
 	if (root->tree)
 		release_tree_content_recursive(root->tree);
@@ -1515,11 +1522,28 @@ static int tree_content_set(
 				if (e->tree)
 					release_tree_content_recursive(e->tree);
 				e->tree = subtree;
+
+				/*
+				 * We need to leave e->versions[0].sha1 alone
+				 * to avoid modifying the preimage tree used
+				 * when writing out the parent directory.
+				 * But after replacing the subdir with a
+				 * completely different one, e->versions[0]
+				 * is not a good delta base any more, and
+				 * besides, we've thrown away the tree
+				 * entries needed to make a delta against it.
+				 *
+				 * Let's just disable deltas when the time
+				 * comes to write this subtree to pack.
+				 */
+				e->no_delta = 1;
+
 				hashclr(root->versions[1].sha1);
 				return 1;
 			}
 			if (!S_ISDIR(e->versions[1].mode)) {
 				e->tree = new_tree_content(8);
+				e->no_delta = 1;
 				e->versions[1].mode = S_IFDIR;
 			}
 			if (!e->tree)
@@ -1537,6 +1561,7 @@ static int tree_content_set(
 	e = new_tree_entry();
 	e->name = to_atom(p, n);
 	e->versions[0].mode = 0;
+	e->no_delta = 0;
 	hashclr(e->versions[0].sha1);
 	t->entries[t->entry_count++] = e;
 	if (slash1) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f256475..04fa70d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -734,6 +734,46 @@ test_expect_success \
 	 git diff-tree --abbrev --raw L^ L >output &&
 	 test_cmp expect output'
 
+cat >input <<INPUT_END
+blob
+mark :1
+data <<EOF
+the data
+EOF
+
+commit refs/heads/L2
+committer C O Mitter <committer@example.com> 1112912473 -0700
+data <<COMMIT
+init L2
+COMMIT
+M 644 :1 a/b/c
+M 644 :1 a/b/d
+M 644 :1 a/e/f
+
+commit refs/heads/L2
+committer C O Mitter <committer@example.com> 1112912473 -0700
+data <<COMMIT
+update L2
+COMMIT
+C a g
+C a/e g/b
+M 644 :1 g/b/h
+INPUT_END
+
+cat <<EOF >expect
+g/b/f
+g/b/h
+EOF
+
+test_expect_success \
+    'L: modifying a copied tree does not produce a corrupt pack' \
+	'test_when_finished "git update-ref -d refs/heads/L2" &&
+	git fast-import <input &&
+	git ls-tree L2 g/b/ >tmp &&
+	cut -f 2 <tmp >actual &&
+	test_cmp expect actual &&
+	git fsck L2'
+
 ###
 ### series M
 ###
-- 
1.7.3.4
