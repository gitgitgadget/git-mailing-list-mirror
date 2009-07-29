From: Stephen Boyd <bebarino@gmail.com>
Subject: [RFC/PATCH] technical-docs: document tree-walking API
Date: Tue, 28 Jul 2009 22:23:15 -0700
Message-ID: <1248844995-13769-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 07:23:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW1dY-0003ST-RV
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 07:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbZG2FXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 01:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbZG2FXV
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 01:23:21 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:36012 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbZG2FXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 01:23:20 -0400
Received: by pzk42 with SMTP id 42so376261pzk.33
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 22:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=TlYITM/A8dlREd6ONlC5HAcwnW7j76/snLyVnTT4zi8=;
        b=oTfuRWNe7z0L44l+ufm+fA/F/ipduhuKNMsWn98PtZgiiSZVVMo8MX2AEgRz66sj2z
         DLAbQ1f3W8MUyruzf7Vuz0mWcYjDHk0tSDvLeRbhPGIM8mVUMPRF+GvE4c18ccBSDP37
         q8WDAeGBcMeY1fANZZIjnCn8sHhTd/Pr6i0Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AT21GkXCCqLUYKlryDW66ZVcs4mc9+O/YlN/EX9/alIXwWc0Ce1HsdHMXobQ/hLOOz
         /bW8TF9Kztx8GT8tUE7o3f1yI1rxE3tWzcWmsK/tjc3rNCMmzlP2trr+9QIeWr9ntsbh
         rftJio2uqEL/PeHE0POVpco2VcVsMpNwSZ2YI=
Received: by 10.141.12.18 with SMTP id p18mr5984389rvi.101.1248844999573;
        Tue, 28 Jul 2009 22:23:19 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id b39sm3539851rvf.13.2009.07.28.22.23.16
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 22:23:19 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 28 Jul 2009 22:23:15 -0700
X-Mailer: git-send-email 1.6.4.rc2.22.g65174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124305>

---

Since it's rc time right now I've decided to look into documenting one of the
simpler API's, or so I thought ;-) This is my first attempt and I would
appreciate any and all feedback.

Some things to get you started:

        - the traversal callback mask parameter
	- a better general usage description at the top
	- add an authors section?

 Documentation/technical/api-tree-walking.txt |  142 ++++++++++++++++++++++++-
 1 files changed, 136 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-tree-walking.txt b/Documentation/technical/api-tree-walking.txt
index e3ddf91..baa382d 100644
--- a/Documentation/technical/api-tree-walking.txt
+++ b/Documentation/technical/api-tree-walking.txt
@@ -1,12 +1,142 @@
 tree walking API
 ================
 
-Talk about <tree-walk.h>, things like
+The tree walking API is used to traverse and inspect trees.
 
-* struct tree_desc
-* init_tree_desc
-* tree_entry_extract
-* update_tree_entry
-* get_tree_entry
+Data Structures
+---------------
+
+`struct name_entry`::
+
+	An entry in a tree. Each entry has a sha1 identifier, pathname, and
+	mode.
+
+`struct tree_desc`::
+
+	A semi-opaque data structure used to maintain the current state of the
+	walk. 
++
+* `buffer` is a pointer into the memory representation of the tree. It always
+points at the current entry being visited.
+
+* `size` counts the number of bytes left in the `buffer`.
+
+* `entry` points to the current entry being visited.
+
+`struct traverse_info`::
+
+	A structure used to maintain the state of a traversal. The members are
+	as follows
++
+* `prev` points to the traverse_info which was used to descend into the
+current tree. If this is the top-level tree `prev` will point to
+a dummy traverse_info. 
+
+* `name` is the entry for the current tree (if the tree is a subtree).
+
+* `pathlen` is the length of the full path for the current tree.
+
+* `conflicts` can be used by callbacks to maintain directory-file conflicts.
+
+* `fn` is a callback called for each entry in the tree. See Traversing for more
+information.
+
+* `data` can be anything the `fn` callback would want to use.
+
+Initializing
+------------
+
+`init_tree_desc`::
+
+	Initialize a `tree_desc` and decode its first entry. The buffer and
+	size parameters are assumed to be the same as the buffer and size
+	members of `struct tree`.
+
+`fill_tree_descriptor`::
+
+	Initialize a `tree_desc` and decode its first entry given the sha1 of
+	a tree. Returns the `buffer` member if the sha1 is a valid tree
+	identifier and NULL otherwise.
+
+`setup_traverse_info`::
+
+	Initialize a `traverse_info` given the pathname of the tree to start
+	traversing from. The `base` argument is assumed to be the `path`
+	member of the `name_entry` being recursed into unless the tree is a
+	top-level tree in which case the empty string ("") is used.
+
+Walking
+-------
+
+`tree_entry`::
+
+	Visit the next entry in a tree. Returns 1 when there are more entries
+	left to visit and 0 when all entries have been visited. This is
+	commonly used in the test of a while loop.
+
+`tree_entry_len`::
+
+	Calculate the length of a tree entry's pathname. This utilizes the
+	memory structure of a tree entry to avoid the overhead of using a
+	generic strlen().
+
+`update_tree_entry`::
+
+	Walk to the next entry in a tree. This is commonly used in conjunction
+	with `tree_entry_extract` to inspect the current entry.
+
+`tree_entry_extract`::
+
+	Decode the entry currently being visited (the one pointed to by
+	`tree_desc's` `entry` member) and return the sha1 of the entry. The
+	`pathp` and `modep` arguments are set to the entry's pathname and mode
+	respectively.
+
+`get_tree_entry`::
+
+	Find an entry in a tree given a pathname and the sha1 of a tree to
+	search. Returns 0 if the entry is found and -1 otherwise. The third
+	and fourth parameters are set to the entry's sha1 and mode
+	respectively.
+
+Traversing
+----------
+
+`traverse_trees`::
+
+	Traverse `n` number of trees in parallel. The `fn` callback member of
+	`traverse_info` is called once for each tree entry.
+
+`traverse_callback_t`::
+	The arguments passed to the traverse callback are as follows:
++
+* `n` counts the number of tree's being traversed.
+
+* `mask` has its nth bit set if the nth tree's entry is valid. (or different?)
+
+* `dirmask` has its nth bit set if the nth tree's entry is a directory.
+
+* `entry` is an array of size `n` where the nth entry is from the nth tree.
+
+* `info` maintains the state of the traversal.
+
++
+Returning a negative value will terminate the traversal. Otherwise the
+return value is treated as an update mask. If the nth bit is set the nth tree
+will be updated and if the bit is not set the nth tree entry will be the
+same in the next callback invocation.
+
+`make_traverse_path`::
+
+	Generate the full pathname of a tree entry based from the root of the
+	traversal. For example, if the traversal has recursed into another
+	tree named "bar" the pathname of an entry "baz" in the "bar"
+	tree would be "bar/baz".
+
+`traverse_path_len`::
+
+	Calculate the length of a pathname returned by `make_traverse_path`.
+	This utilizes the memory structure of a tree entry to avoid the
+	overhead of using a generic strlen().
 
 (JC, Linus)
-- 
1.6.4.rc2.22.g65174
