From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Cogito: Support for implicit remote branches in cloned repositories
Date: Fri, 4 Nov 2005 17:01:48 +0100
Message-ID: <200511041701.48881.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 17:03:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY415-0001YF-46
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 17:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbVKDQBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 11:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbVKDQBx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 11:01:53 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:27362 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1161155AbVKDQBv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 11:01:51 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 90EB8233E;
	Fri,  4 Nov 2005 17:01:50 +0100 (MET)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11139>

This allows to specify remote branch names from the
repository this one was cloned from (= remote repository of
"origin" branch), without explicitly adding a branch for them.
Therefore, these remote branches are called implicit.

Use them together with cg-fetch or cg-update.
Example: Your current repository was cloned with

  cg-clone git+ssh://remotehost:/path myrep

If this remote repository contains a branch "foo",
you can say inside of myrep:

  cg-fetch foo

This fetches "git+ssh://remotehost:/path#foo" into
a local branch "foo" (created if not existing).
Similarily, a "cg-update foo" will fetch the remote
branch and merge it into your current local branch.

After fetching from an implicit remote branch, cg-status
will show the corresponding local branch, but still without
an "R", because that is only shown for explicit branches.
The implicit remote branch in the example above can be
made explicit with

  cg-branch-add foo git+ssh://remotehost:/path#foo

Note that cg-update now always tries to fetch from a
remote repository, as every non-explicit branch
name is supposed to be an implicit remote branch.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

This patch is RFC. IMHO, it simplifies the usage of Cogito
quite a lot. One difference of cloning with GIT vs. with
Cogito is that Git always clones all remote branches. This can
be limiting if you want to work with multiple repositories,
but allows you to immediatly work with all the branches.

Cogito instead clones only one remote branch, and requires
you to explicitly add further branches with "cg-branch-add".
This is not necessary with implicit remote branches, and
they should cover the standard use case which works with
branches from the repository you clone from.

The nice thing here is that the patch is really small for
the added functionality. If you accept it, I will provide
updates for the documentation and tutorial.

Josef

 cg-fetch  |   10 +++++++++-
 cg-update |    6 +-----
 2 files changed, 10 insertions(+), 6 deletions(-)

applies-to: 22948869bcf0ec216ed9aa14e1c5ecc22114d66b
769aa2148fc2b583b071354e8eef3dae74e09c14
diff --git a/cg-fetch b/cg-fetch
index 759488a..5a5aeb1 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -262,7 +262,15 @@ name=${ARGS[0]}
 
 [ "$name" ] || { [ -s "$_git/branches/origin" ] && name=origin; }
 [ "$name" ] || die "where to fetch from?"
-uri=$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch: $name"
+uri=$(cat "$_git/branches/$name" 2>/dev/null) || \
+    { if [ -s "$_git/branches/origin" ]; then
+	uri=$(cat "$_git/branches/origin" 2>/dev/null)
+	uri="$(echo "$uri" | cut -d '#' -f 1)#$name"
+	echo Fetching implicit remote branch "$uri".
+      else
+        die "unknown branch: $name"
+      fi
+    }
 
 rembranch=
 if echo "$uri" | grep -q '#'; then
diff --git a/cg-update b/cg-update
index 96035c5..534bf4a 100755
--- a/cg-update
+++ b/cg-update
@@ -39,11 +39,7 @@ name=${ARGS[0]}
 [ "$name" ] || { [ -s $_git/branches/origin ] && name=origin; }
 [ "$name" ] || die "where to update from?"
 
-if [ -s "$_git/branches/$name" ]; then
-	cg-fetch $force $name || exit 1
-else
-	echo "Updating from a local branch."
-fi
+cg-fetch $force $name || exit 1
 echo
 echo "Applying changes..."
 cg-merge $name
