From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Make git-prune submodule aware (and fix a SEGFAULT in the process)
Date: Mon, 2 Jul 2007 13:56:58 +0100
Message-ID: <200707021356.58553.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 14:57:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5LSx-0004Zq-Qp
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 14:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbXGBM5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 08:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461AbXGBM5J
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 08:57:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:19863 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbXGBM5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 08:57:05 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1249823ugf
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 05:57:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=N30eK89Dl56LnmaSV1WGE27Bws3v5JESqD3npTfvB97h+JeYLfGm8AXZpDD8vNjEnTzeH6N5BvC7hRugWx4RbLag2XaVm0M1EVuTTUAtf0aEImwtwvdlYwAn1gSP/XqqF1LFZYz1teEFVzKvaMD9pF0ZDlvTf/bttBnVh1bNGfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=bicU26p6rnnKcw14YpoA/9SQzC9QjGQW/WpwMNTnLbcGAMlbf0Fi0CW1FNseqn7k16r4aLTJ+Qu6j82mHYVmFOoLaKVXXSEWstfcmOF3JUnVvOdKYvKsC55v3RPNbs9Kd7UXAjGLAR6xmfitLl83Z46K9OMeLCuDJS74F96aDDc=
Received: by 10.82.160.2 with SMTP id i2mr12882394bue.1183381023024;
        Mon, 02 Jul 2007 05:57:03 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c22sm16677359ika.2007.07.02.05.57.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Jul 2007 05:57:02 -0700 (PDT)
X-TUID: a0c630b9e667e646
X-UID: 318
X-Length: 4219
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51361>

I ran git-prune on a repository and got this:

 $ git-prune
 error: Object 228f8065b930120e35fc0c154c237487ab02d64a is a blob, not a commit
 Segmentation fault (core dumped)

This repository was a strange one in that it was being used to provide
its own submodule.  That is, the repository was cloned into a
subdirectory, an independent branch checked out in that subdirectory,
and then it was marked as a submodule.  git-prune then failed in the
above manner.

The problem was that git-prune was not submodule aware in two areas.

Linus said:

 > So what happens is that something traverses a tree object, looks at each
 > entry, sees that it's not a tree, and tries to look it up as a blob. But
 > subprojects are commits, not blobs, and then when you look at the object
 > more closely, you get the above kind of object type confusion.

and included a patch to add an S_ISGITLINK() test to reachable.c's
process_tree() function.  That fixed the first git-prune error, and
stopped it from trying to process the gitlink entries in trees as if
they were pointers to other trees (and of course failing, because
gitlinks _aren't_ trees).  That part of this patch is his.

The second area is add_cache_refs().  This is called before starting the
reachability analysis, and was calling lookup_blob() on every object
hash found in the index.  However, it is no longer true that every hash
in the index is a pointer to a blob, some of them are gitlinks, and are
not backed by any object at all, they are commits in another repository.
Normally this bug was not causing any problems, but in the case of the
self-referencing repository described above, it meant that the gitlink
hash was being marked as being of type OBJ_BLOB by add_cache_refs() call
to lookup_blob().  Then later, because that hash was also pointed to by
a ref, add_one_ref() would treat it as a commit; lookup_commit() would
return a NULL because that object was already noted as being an
OBJ_BLOB, not an OBJ_COMMIT; and parse_commit_buffer() would SEGFAULT on
that NULL pointer.

The fix made by this patch is to not blindly call lookup_blob() in
reachable.c's add_cache_refs(), and instead skip any index entries that
are S_ISGITLINK().

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
The two parts go together logically so I've put them in this single patch
from me, but half of this patch should be credited to Linus. (I don't know
how one deals with multiple authorship on a single commit in git though)

I suspect that Linus has enough credit to keep him happy and won't mind
that I've edited him out in this case :-)


 reachable.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/reachable.c b/reachable.c
index ff3dd34..6383401 100644
--- a/reachable.c
+++ b/reachable.c
@@ -21,6 +21,14 @@ static void process_blob(struct blob *blob,
 	/* Nothing to do, really .. The blob lookup was the important part */
 }
 
+static void process_gitlink(const unsigned char *sha1,
+			    struct object_array *p,
+			    struct name_path *path,
+			    const char *name)
+{
+	/* I don't think we want to recurse into this, really. */
+}
+
 static void process_tree(struct tree *tree,
 			 struct object_array *p,
 			 struct name_path *path,
@@ -47,6 +55,8 @@ static void process_tree(struct tree *tree,
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
 			process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
+		else if (S_ISGITLINK(entry.mode))
+			process_gitlink(entry.sha1, p, &me, entry.path);
 		else
 			process_blob(lookup_blob(entry.sha1), p, &me, entry.path);
 	}
@@ -159,6 +169,16 @@ static void add_cache_refs(struct rev_info *revs)
 
 	read_cache();
 	for (i = 0; i < active_nr; i++) {
+		/*
+		 * The index can contain blobs and GITLINKs, GITLINKs are hashes
+		 * that don't actually point to objects in the repository, it's
+		 * almost guaranteed that they are NOT blobs, so we don't call
+		 * lookup_blob() on them, to avoid populating the hash table
+		 * with invalid information
+		 */
+		if (S_ISGITLINK(ntohl(active_cache[i]->ce_mode)))
+			continue;
+
 		lookup_blob(active_cache[i]->sha1);
 		/*
 		 * We could add the blobs to the pending list, but quite
-- 
1.5.2.2.253.g2d8b
