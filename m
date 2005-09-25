From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Finish documenting trivial merge rules
Date: Sat, 24 Sep 2005 23:50:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509242349270.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 05:46:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJNSl-00032l-6j
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 05:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVIYDpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 23:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVIYDpj
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 23:45:39 -0400
Received: from iabervon.org ([66.92.72.58]:7185 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751071AbVIYDpj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 23:45:39 -0400
Received: (qmail 8032 invoked by uid 1000); 24 Sep 2005 23:50:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Sep 2005 23:50:04 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9256>

Fix missing symbol explanations, a few incorrect cases, and add
two-way merge rules.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

 Documentation/technical/trivial-merge.txt |   49 +++++++++++++++++++++++------
 1 files changed, 39 insertions(+), 10 deletions(-)

ad07d5f3075c8749ec16559566fa338c1be1b873
diff --git a/Documentation/technical/trivial-merge.txt b/Documentation/technical/trivial-merge.txt
--- a/Documentation/technical/trivial-merge.txt
+++ b/Documentation/technical/trivial-merge.txt
@@ -10,6 +10,9 @@ This replaces the index with a different
 for entries that don't change, and allowing -u to make the minimum
 required changes to the working tree to have it match.
 
+Entries marked '+' have stat information. Spaces marked '*' don't
+affect the result.
+
    index   tree    result
    -----------------------
    *       (empty) (empty)
@@ -20,7 +23,30 @@ required changes to the working tree to 
 Two-way merge
 -------------
 
+It is permitted for the index to lack an entry; this does not prevent
+any case from applying.
+
+If the index exists, it is an error for it not to match either the old
+or the result.
+
+If multiple cases apply, the one used is listed first.
+
+A result which changes the index is an error if the index is not empty
+and not up-to-date.
+
+Entries marked '+' have stat information. Spaces marked '*' don't
+affect the result.
 
+ case  index   old     new     result
+ -------------------------------------
+ 0/2   (empty) *       (empty) (empty)
+ 1/3   (empty) *       new     new
+ 4/5   index+  (empty) (empty) index+
+ 6/7   index+  (empty) index   index+
+ 10    index+  index   (empty) (empty)
+ 14/15 index+  old     old     index+
+ 18/19 index+  old     index   index+
+ 20    index+  index   new     new
 
 Three-way merge
 ---------------
@@ -44,30 +70,28 @@ up-to-date.
 *empty* means that the tree must not have a directory-file conflict
  with the entry.
 
-For multiple ancestors or remotes, a '+' means that this case applies
-even if only one ancestor or remote fits; normally, all of the
-ancestors or remotes must be the same.
+For multiple ancestors, a '+' means that this case applies even if
+only one ancestor or remote fits; a '^' means all of the ancestors
+must be the same.
 
 case  ancest    head    remote    result
 ----------------------------------------
 1     (empty)+  (empty) (empty)   (empty)
 2ALT  (empty)+  *empty* remote    remote
-2ALT  (empty)+  *empty* remote    remote
 2     (empty)^  (empty) remote    no merge
 3ALT  (empty)+  head    *empty*   head
 3     (empty)^  head    (empty)   no merge
 4     (empty)^  head    remote    no merge
 5ALT  *         head    head      head
-6     ancest^   (empty) (empty)   no merge
-8ALT  ancest    (empty) ancest    (empty)
+6     ancest+   (empty) (empty)   no merge
+8     ancest^   (empty) ancest    no merge
 7     ancest+   (empty) remote    no merge
+10    ancest^   ancest  (empty)   no merge
 9     ancest+   head    (empty)   no merge
-10ALT ancest    ancest  (empty)   (empty)
-11    ancest+   head    remote    no merge
 16    anc1/anc2 anc1    anc2      no merge
 13    ancest+   head    ancest    head
 14    ancest+   ancest  remote    remote
-14ALT ancest+   ancest  remote    remote
+11    ancest+   head    remote    no merge
 
 Only #2ALT and #3ALT use *empty*, because these are the only cases
 where there can be conflicts that didn't exist before. Note that we
@@ -89,4 +113,9 @@ right. This is a case of a reverted patc
 multiple times), and the right answer depends on looking at crossings
 of history or common ancestors of the ancestors.
 
-The status as of Sep 5 is that multiple remotes are not supported
\ No newline at end of file
+Note that, between #6, #7, #9, and #11, all cases not otherwise
+covered are handled in this table.
+
+For #8 and #10, there is alternative behavior, not currently
+implemented, where the result is (empty). As currently implemented,
+the automatic merge will generally give this effect.
