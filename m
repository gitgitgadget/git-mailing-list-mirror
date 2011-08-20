From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] fast-import: do not write bad delta for replaced subtrees
Date: Fri, 19 Aug 2011 20:09:02 -0500
Message-ID: <20110820010901.GA2512@elie.sbx02827.chicail.wayport.net>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
 <1313346744-30340-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 03:13:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qua7U-00079m-QA
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 03:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab1HTBJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 21:09:21 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57975 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab1HTBJU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 21:09:20 -0400
Received: by pzk37 with SMTP id 37so5727800pzk.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=z1AfLGP3AAnW5tuanCcdX1r9VhiL5WmyEcikH7HTikY=;
        b=ZlJe11VzOgYvq4ACOthseO4Ievoi69LJD8WCtJBE11kL3R6uHXmp5np4yw952Zhjm2
         Ebn0+xmyQV5AeZUVkYlOrNHEpTCEMJfSbtD9XQYN4ZMOOyT2FNIEnbbV6R2vYxlLpJeS
         /F4mprWd+N2Dg8x5t7ixfRQMoVdC0u5+4GuxA=
Received: by 10.142.151.27 with SMTP id y27mr5150wfd.229.1313802560253;
        Fri, 19 Aug 2011 18:09:20 -0700 (PDT)
Received: from elie.sbx02827.chicail.wayport.net ([64.134.196.199])
        by mx.google.com with ESMTPS id f8sm2763558pbk.22.2011.08.19.18.09.15
        (version=SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 18:09:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313346744-30340-3-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179748>

Dmitry Ivankov wrote:

> To produce deltas for tree objects fast-import tracks two versions
> of tree's entries - base and current one. Base version stands both
> for a delta base of this tree, and for a entry inside a delta base
> of a parent tree. So care should be taken to keep it in sync.

Thanks again for this.  Abusing (S_ISDIR | S_ISUID) still leaves a bad
taste in my mouth, but after your description I'm convinced that
behavior-wise it's the right thing to do.

I'm thinking of queueing the following to svn-fe-maint.  If there's
something wrong with it, I'd be happy to hear that now; otherwise,
we can put fixes on top.  In other words, "please speak now or forever
hold your peace".  Changes since v2:

 - clarify description

 - some tiny style nitpicks in the code and test

 - made a pass through checking uses of "mode" to make sure we are
   scrubbing out the S_ISUID bit before passing it to code that is not
   aware of that bit.

   The result is a few assert() calls to document those cases that
   required a second's thought and some extra scrubbing in tecmp0()
   when passing the mode to base_name_compare.  Although the latter is
   not needed and base_name_compare() only pays attention to the
   S_IFDIR bit, it seems best to stick to the expected interface and
   pass a real mode.

 - take care of a missed case where NO_DELTA was not being set:

	create branch "basis":

		M 100644 inline dir/hello.c
		data <<EOF
		hello
		EOF
		C dir/hello.c unrelated

	on branch "master":

		from refs/heads/basis
		D dir

	corrupt the subtree

		C unrelated dir/nothello.c

The patch has way too few tests.  Oh, well.

Bugs?  Improvements?

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
Let's just mark the new tree as do-not-delta-me instead.  We abuse the
setuid bit in the base "mode" field for this purpose.

tree_content_replace is in a similar predicament to tree_content_set,
except that because it is only used to replace the root, just
invalidating the base sha1 there (instead of setting the no-delta bit)
is fine.

Initial hack by Jonathan, test and description by Dmitry.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c          |   55 ++++++++++++++++++++++++++++++++++++++++++-----
 t/t9300-fast-import.sh |   40 ++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 65d65bf8..95919b63 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -170,6 +170,11 @@ Format of STDIN stream:
 #define DEPTH_BITS 13
 #define MAX_DEPTH ((1<<DEPTH_BITS)-1)
 
+/*
+ * We abuse the setuid bit on directories to mean "do not delta".
+ */
+#define NO_DELTA S_ISUID
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	struct object_entry *next;
@@ -1380,9 +1385,12 @@ static int tecmp0 (const void *_a, const void *_b)
 {
 	struct tree_entry *a = *((struct tree_entry**)_a);
 	struct tree_entry *b = *((struct tree_entry**)_b);
+
 	return base_name_compare(
-		a->name->str_dat, a->name->str_len, a->versions[0].mode,
-		b->name->str_dat, b->name->str_len, b->versions[0].mode);
+		a->name->str_dat, a->name->str_len,
+					a->versions[0].mode & ~NO_DELTA,
+		b->name->str_dat, b->name->str_len,
+					b->versions[0].mode & ~NO_DELTA);
 }
 
 static int tecmp1 (const void *_a, const void *_b)
@@ -1405,6 +1413,14 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 		qsort(t->entries,t->entry_count,sizeof(t->entries[0]),tecmp1);
 
 	for (i = 0; i < t->entry_count; i++) {
+		/*
+		 * A hypothetical mode == (0 | NO_DELTA) would mean
+		 * "this version does not exist, and please don't
+		 * make deltas against it when writing a tree object
+		 * based on it".  That is spelled as "mode == 0".
+		 */
+		assert(t->entries[i]->versions[v].mode != NO_DELTA);
+
 		if (t->entries[i]->versions[v].mode)
 			maxlen += t->entries[i]->name->str_len + 34;
 	}
@@ -1415,8 +1431,9 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 		struct tree_entry *e = t->entries[i];
 		if (!e->versions[v].mode)
 			continue;
-		strbuf_addf(b, "%o %s%c", (unsigned int)e->versions[v].mode,
-					e->name->str_dat, '\0');
+		strbuf_addf(b, "%o %s%c",
+			(unsigned int)(e->versions[v].mode & ~NO_DELTA),
+			e->name->str_dat, '\0');
 		strbuf_add(b, e->versions[v].sha1, 20);
 	}
 }
@@ -1436,7 +1453,10 @@ static void store_tree(struct tree_entry *root)
 			store_tree(t->entries[i]);
 	}
 
-	le = find_object(root->versions[0].sha1);
+	if (root->versions[0].mode & NO_DELTA)
+		le = NULL;
+	else
+		le = find_object(root->versions[0].sha1);
 	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
 		mktree(t, 0, &old_tree);
 		lo.data = old_tree;
@@ -1470,6 +1490,7 @@ static void tree_content_replace(
 {
 	if (!S_ISDIR(mode))
 		die("Root cannot be a non-directory");
+	hashclr(root->versions[0].sha1);
 	hashcpy(root->versions[1].sha1, sha1);
 	if (root->tree)
 		release_tree_content_recursive(root->tree);
@@ -1514,11 +1535,30 @@ static int tree_content_set(
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
+				if (S_ISDIR(e->versions[0].mode))
+					e->versions[0].mode |= NO_DELTA;
+
 				hashclr(root->versions[1].sha1);
 				return 1;
 			}
 			if (!S_ISDIR(e->versions[1].mode)) {
 				e->tree = new_tree_content(8);
+				if (S_ISDIR(e->versions[0].mode))
+					e->versions[0].mode |= NO_DELTA;
 				e->versions[1].mode = S_IFDIR;
 			}
 			if (!e->tree)
@@ -2918,6 +2958,9 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 		S_ISDIR(mode) ? tree_type :
 		blob_type;
 
+	/* NO_DELTA is only used with tree objects. */
+	assert(mode != NO_DELTA);
+
 	if (!mode) {
 		/* missing SP path LF */
 		strbuf_reset(&line);
@@ -2928,7 +2971,7 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 		/* mode SP type SP object_name TAB path LF */
 		strbuf_reset(&line);
 		strbuf_addf(&line, "%06o %s %s\t",
-				mode, type, sha1_to_hex(sha1));
+				mode & ~NO_DELTA, type, sha1_to_hex(sha1));
 		quote_c_style(path, &line, NULL, 0);
 		strbuf_addch(&line, '\n');
 	}
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6b1ba6c8..180d357b 100755
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
1.7.6
