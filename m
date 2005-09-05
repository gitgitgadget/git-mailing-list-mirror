From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/4] Document the trivial merge rules for 3(+more ancestors)-way
 merges.
Date: Mon, 5 Sep 2005 02:05:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509050204500.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050151240.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 08:02:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECA2q-00044A-4X
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 08:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVIEGBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 02:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVIEGBZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 02:01:25 -0400
Received: from iabervon.org ([66.92.72.58]:34578 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932225AbVIEGBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 02:01:25 -0400
Received: (qmail 22889 invoked by uid 1000); 5 Sep 2005 02:05:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Sep 2005 02:05:17 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0509050151240.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8088>

Signed-off-by: Daniel Barkalow
---

 Documentation/technical/trivial-merge.txt |   92 +++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/trivial-merge.txt

7544be0a8eda7b796150729a7795c2639278da62
diff --git a/Documentation/technical/trivial-merge.txt b/Documentation/technical/trivial-merge.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/technical/trivial-merge.txt
@@ -0,0 +1,92 @@
+Trivial merge rules
+===================
+
+This document describes the outcomes of the trivial merge logic in read-tree.
+
+One-way merge
+-------------
+
+This replaces the index with a different tree, keeping the stat info
+for entries that don't change, and allowing -u to make the minimum
+required changes to the working tree to have it match.
+
+   index   tree    result
+   -----------------------
+   *       (empty) (empty)
+   (empty) tree    tree
+   index+  tree    tree
+   index+  index   index+
+
+Two-way merge
+-------------
+
+
+
+Three-way merge
+---------------
+
+It is permitted for the index to lack an entry; this does not prevent
+any case from applying.
+
+If the index exists, it is an error for it not to match either the
+head or (if the merge is trivial) the result.
+
+If multiple cases apply, the one used is listed first.
+
+A result of "no merge" means that index is left in stage 0, ancest in
+stage 1, head in stage 2, and remote in stage 3 (if any of these are
+empty, no entry is left for that stage). Otherwise, the given entry is
+left in stage 0, and there are no other entries.
+
+A result of "no merge" is an error if the index is not empty and not
+up-to-date.
+
+*empty* means that the tree must not have a directory-file conflict
+ with the entry.
+
+For multiple ancestors or remotes, a '+' means that this case applies
+even if only one ancestor or remote fits; normally, all of the
+ancestors or remotes must be the same.
+
+case  ancest    head    remote    result
+----------------------------------------
+1     (empty)+  (empty) (empty)   (empty)
+2ALT  (empty)+  *empty* remote    remote
+2ALT  (empty)+  *empty* remote    remote
+2     (empty)^  (empty) remote    no merge
+3ALT  (empty)+  head    *empty*   head
+3     (empty)^  head    (empty)   no merge
+4     (empty)^  head    remote    no merge
+5ALT  *         head    head      head
+6     ancest^   (empty) (empty)   no merge
+8ALT  ancest    (empty) ancest    (empty)
+7     ancest+   (empty) remote    no merge
+9     ancest+   head    (empty)   no merge
+10ALT ancest    ancest  (empty)   (empty)
+11    ancest+   head    remote    no merge
+16    anc1/anc2 anc1    anc2      no merge
+13    ancest+   head    ancest    head
+14    ancest+   ancest  remote    remote
+14ALT ancest+   ancest  remote    remote
+
+Only #2ALT and #3ALT use *empty*, because these are the only cases
+where there can be conflicts that didn't exist before. Note that we
+allow directory-file conflicts between things in different stages
+after the trivial merge.
+
+A possible alternative for #6 is (empty), which would make it like
+#1. This is not used, due to the likelihood that it arises due to
+moving the file to multiple different locations or moving and deleting
+it in different branches.
+
+Case #1 is included for completeness, and also in case we decide to
+put on '+' markings; any path that is never mentioned at all isn't
+handled.
+
+Note that #16 is when both #13 and #14 apply; in this case, we refuse
+the trivial merge, because we can't tell from this data which is
+right. This is a case of a reverted patch (in some direction, maybe
+multiple times), and the right answer depends on looking at crossings
+of history or common ancestors of the ancestors.
+
+The status as of Sep 5 is that multiple remotes are not supported
\ No newline at end of file
