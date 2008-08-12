From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2] pack-objects: Allow missing base objects when creating
	thin packs
Date: Tue, 12 Aug 2008 11:31:06 -0700
Message-ID: <20080812183106.GE31092@spearce.org>
References: <20080811182839.GJ26363@spearce.org> <7vk5enuqfg.fsf@gitster.siamese.dyndns.org> <20080811224404.GQ26363@spearce.org> <20080812012859.GT26363@spearce.org> <alpine.LFD.1.10.0808120023250.22892@xanadu.home> <20080812164149.GB31092@spearce.org> <alpine.LFD.1.10.0808121402440.22892@xanadu.home> <20080812181843.GD31092@spearce.org> <alpine.LFD.1.10.0808121426100.22892@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:32:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSyfJ-0003CL-Eq
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 20:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbYHLSbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 14:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYHLSbI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 14:31:08 -0400
Received: from george.spearce.org ([209.20.77.23]:46021 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbYHLSbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 14:31:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 378B038375; Tue, 12 Aug 2008 18:31:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808121426100.22892@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92128>

If we are building a thin pack and one of the base objects we would
consider for deltification is missing its OK, the other side already
has that base object.  We may be able to get a delta from another
object, or we can simply send the new object whole (no delta).

This change allows a shallow clone to store only the objects which
are unique to it, as well as the boundary commit and its trees, but
avoids storing the boundary blobs.  This special form of a shallow
clone is able to represent just the difference between two trees.

Pack objects change suggested by Nicolas Pitre.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Nicolas Pitre <nico@cam.org> wrote:
 > On Tue, 12 Aug 2008, Shawn O. Pearce wrote:
 > I'm not talking about the last command but the "test $(git rev-parse 
 > HEAD) = $B" line.
 
 Oh, right.  Good catch.

 builtin-pack-objects.c |   15 ++++++--
 t/t5306-pack-nobase.sh |   80 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 4 deletions(-)
 create mode 100755 t/t5306-pack-nobase.sh

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2dadec1..a90302d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1096,9 +1096,12 @@ static void check_object(struct object_entry *entry)
 	}
 
 	entry->type = sha1_object_info(entry->idx.sha1, &entry->size);
-	if (entry->type < 0)
-		die("unable to get type of object %s",
-		    sha1_to_hex(entry->idx.sha1));
+	/*
+ 	 * The error condition is checked in prepare_pack().  This is
+ 	 * to permit a missing preferred base object to be ignored
+ 	 * as a preferred base.  Doing so can result in a larger
+ 	 * pack file, but the transfer will still take place.
+ 	 */
 }
 
 static int pack_offset_sort(const void *_a, const void *_b)
@@ -1722,8 +1725,12 @@ static void prepare_pack(int window, int depth)
 		if (entry->no_try_delta)
 			continue;
 
-		if (!entry->preferred_base)
+		if (!entry->preferred_base) {
 			nr_deltas++;
+			if (entry->type < 0)
+				die("unable to get type of object %s",
+				    sha1_to_hex(entry->idx.sha1));
+		}
 
 		delta_list[n++] = entry;
 	}
diff --git a/t/t5306-pack-nobase.sh b/t/t5306-pack-nobase.sh
new file mode 100755
index 0000000..f4931c0
--- /dev/null
+++ b/t/t5306-pack-nobase.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Google Inc.
+#
+
+test_description='git-pack-object with missing base
+
+'
+. ./test-lib.sh
+
+# Create A-B chain
+#
+test_expect_success \
+    'setup base' \
+    'for a in a b c d e f g h i; do echo $a >>text; done &&
+     echo side >side &&
+     git update-index --add text side &&
+     A=$(echo A | git commit-tree $(git write-tree)) &&
+
+     echo m >>text &&
+     git update-index text &&
+     B=$(echo B | git commit-tree $(git write-tree) -p $A) &&
+     git update-ref HEAD $B
+    '
+
+# Create repository with C whose parent is B.
+# Repository contains C, C^{tree}, C:text, B, B^{tree}.
+# Repository is missing B:text (best delta base for C:text).
+# Repository is missing A (parent of B).
+# Repository is missing A:side.
+#
+test_expect_success \
+    'setup patch_clone' \
+    'base_objects=$(pwd)/.git/objects &&
+     (mkdir patch_clone &&
+      cd patch_clone &&
+      git init &&
+      echo "$base_objects" >.git/objects/info/alternates &&
+      echo q >>text &&
+      git read-tree $B &&
+      git update-index text &&
+      git update-ref HEAD $(echo C | git commit-tree $(git write-tree) -p $B) &&
+      rm .git/objects/info/alternates &&
+
+      git --git-dir=../.git cat-file commit $B |
+      git hash-object -t commit -w --stdin &&
+
+      git --git-dir=../.git cat-file tree "$B^{tree}" |
+      git hash-object -t tree -w --stdin
+     ) &&
+     C=$(git --git-dir=patch_clone/.git rev-parse HEAD)
+    '
+
+# Clone patch_clone indirectly by cloning base and fetching.
+#
+test_expect_success \
+    'indirectly clone patch_clone' \
+    '(mkdir user_clone &&
+      cd user_clone &&
+      git init &&
+      git pull ../.git &&
+      test $(git rev-parse HEAD) = $B &&
+
+      git pull ../patch_clone/.git &&
+      test $(git rev-parse HEAD) = $C
+     )
+    '
+
+# Cloning the patch_clone directly should fail.
+#
+test_expect_success \
+    'clone of patch_clone is incomplete' \
+    '(mkdir user_direct &&
+      cd user_direct &&
+      git init &&
+      test_must_fail git fetch ../patch_clone/.git
+     )
+    '
+
+test_done
-- 
1.6.0.rc2.22.g71b99


-- 
Shawn.
