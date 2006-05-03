From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/2] Improve "Technical Information" in the tutorial
Date: Wed, 03 May 2006 04:29:33 -0400
Message-ID: <20060503082933.1548.38485.stgit@dv.roinet.com>
References: <20060503082931.1548.14118.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed May 03 10:32:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbCmL-0002xr-H9
	for gcvg-git@gmane.org; Wed, 03 May 2006 10:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWECIcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWECIcK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 04:32:10 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:23237 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965123AbWECIcJ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 May 2006 04:32:09 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FbCki-0001tp-Ly
	for git@vger.kernel.org; Wed, 03 May 2006 04:30:35 -0400
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.61)
	(envelope-from <proski@gnu.org>)
	id 1FbCjl-0000PN-Kh; Wed, 03 May 2006 04:29:33 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
In-Reply-To: <20060503082931.1548.14118.stgit@dv.roinet.com>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19461>

From: Pavel Roskin <proski@gnu.org>

In the "StGIT patch theory", use traditional (old, new) argument order
of diff.  Make formulas more readable.  Add more description.

In the "Layout of the .git directory", update the layout, add more
descriptions, organize layout as a table.  Sort entries alphabetically -
it's easier to find them this way.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 doc/tutorial.txt |  123 +++++++++++++++++++++++++++++++-----------------------
 1 files changed, 70 insertions(+), 53 deletions(-)

diff --git a/doc/tutorial.txt b/doc/tutorial.txt
index 5899c38..ddc0cf9 100644
--- a/doc/tutorial.txt
+++ b/doc/tutorial.txt
@@ -339,75 +339,92 @@ A bit of StGIT patch theory
 ---------------------------
 
 We assume that a patch is a diff between two nodes - bottom and top. A
-node is a commit SHA1 id or tree SHA1 id in the GIT terminology:
+node is a commit SHA1 ID or tree SHA1 ID in the GIT terminology:
 
-  P - patch
-  N - node
-
-  P = diff(Nt, Nb)
+  P = diff(Nb, Nt)
 
-  	Nb - bottom (start) node
-  	Nt - top (end) node
-  	Nf - first node (for log generation)
+  P - patch
+  Nb - bottom (start) node
+  Nt - top (end) node
 
-For an ordered stack of patches:
+The order of diff parameters is (old, new). We use "+" for superposition
+of patches. For an ordered stack of patches:
 
-  P1 = diff(N1, N0)
-  P2 = diff(N2, N1)
+  P1 = diff(N0, N1)
+  P2 = diff(N1, N2)
   ...
+  Ps = P1 + P2 + P3 + ... + Pn = diff(Nsb, Nst)
 
+  Ps  - the big patch of the whole stack
+  Nsb - bottom stack node (= N0)
+  Nst - top stack node (= Nn)
 
-  Ps = P1 + P2 + P3 + ... = diff(Nst, Nsb)
+When pushing a patch P from the stack, it may happen that the patch
+bottom Nb is different from the stack top Nst, i.e. the patch was
+originally applied to a different node. The patch needs to be adjusted
+to its new position in the stack. First, the new stack top is calculated
+by diff3 merging:
 
-  	Ps  - the big patch of the whole stack
-  	Nsb - bottom stack node (= N0)
-  	Nst - top stack node (= Nn)
+  Nst' = diff3(Nst, Nb, Nt)
 
-Applying (pushing) a patch on the stack (Nst can differ from Nb) is done
-by diff3 merging. The new patch becomes:
+The order of diff3 parameters is (branch1, ancestor, branch2). If the
+merge succeeds, the patch is adjusted as following:
 
-  P' = diff(Nt', Nb')
   Nb' = Nst
-  Nt' = diff3(Nst, Nb, Nt)
+  Nt' = Nst'
+  P' = diff(Nb', Nt')
 
-(note that the diff3 parameters order is: branch1, ancestor, branch2)
-The above operation allows easy patch re-ordering.
 Removing (popping) a patch from the stack is done by simply setting the
 Nst to Nb.
 
+This approach allows easy reordering of patches. To reorder applied
+patches, user should pop them first and then push them back to the stack
+in the desired order. Unless the patches modify the same or adjacent
+lines in the same files, StGIT should be able to adjust the patches
+automatically for the new order.
+
 
 Layout of the .git directory
 ----------------------------
 
-  HEAD			-> refs/heads/<something>
-  objects/
-    ??/
-    ...
-  refs/
-    heads/
-      master		- the master commit id
-      ...
-    bases/
-      master		- the bottom id of the stack (to get a big diff)
-      ...
-    tags/
-      ...
-    branches/
-      ...
-    patches/
-      master/
-        applied		- list of applied patches
-        unapplied		- list of not-yet applied patches
-        current		- name of the topmost patch
-        patch1/
-          bottom		- the bottom id of the patch
-          top		- the top id of the patch
-  	description	- the patch description
-  	authname	- author's name
-  	authemail	- author's e-mail
-  	commname	- committer's name
-  	commemail	- committer's e-mail
-        patch2/
-          ...
-        ...
-      ...
+`-----------------------`----------------------------------------------
+`branches/`		remote branches to pull (deprecated)
+`hooks/`		scripts executed by git on some events
+`info/`
+`  exclude`		list of files ignored for the purpose of commit
+`  refs`		list of commit IDs from refs/ (used on servers)
+`objects/`		git objects
+`  ??/`			unpacked objects
+`  info/`
+`    packs`		list of object packs
+`  pack/`		object packs
+`    *.idx`		index files
+`    *.pack`		actual pack files
+`patches/`		storage for StGIT patches
+`  master/`		patches for the master branch
+`    patches/`		storage for individual patches
+`      patch1/`		one of the StGIT patches
+`        authdate`	patch date
+`        authemail`	author's e-mail
+`        authname`	author's name
+`        bottom`	bottom ID of the patch
+`        bottom.old`	old bottom ID of the patch (for undo)
+`        commemail`	committer's e-mail
+`        commname`	committer's name
+`        description`	patch description
+`        top`		top ID of the patch
+`        top.old`	old top ID of the patch (for undo)
+`      patch2/`		another StGIT patch
+`        ...`
+`    applied`		list of applied patches
+`    description`	branch description
+`    current`		name of the topmost patch
+`    unapplied`		list of unapplied patches
+`refs/`			various significant commit IDs
+`  bases/`		bottom commit IDs of the patch stacks
+`  heads/`		top commit IDs of branches
+`  patches/`		commit IDs of StGIT patches
+`  tags/`		commit IDs of tags (commit and tag objects)
+`remotes/`		remote branches to pull and push
+`HEAD`			reference to the current branch
+-----------------------------------------------------------------------
