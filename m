From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 1/2] git-clone: Keep remote names when cloning unless explicitly told not to.
Date: Thu, 10 Nov 2005 12:58:08 +0100 (CET)
Message-ID: <20051110115808.418125BF88@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 10 12:58:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaB4J-0003Yr-5e
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 12:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVKJL6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 06:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVKJL6L
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 06:58:11 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:45208 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750791AbVKJL6J
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 06:58:09 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 5FC7B6BCFF
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 12:58:08 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 418125BF88; Thu, 10 Nov 2005 12:58:08 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11479>


With this patch the following commands all clone into the local directory
"repo". If repo exists, it will still barf.

	git-clone git://host.xz/repo.git
	git-clone /path/to/repo/.git
	git-clone host.xz:repo.git

I ended up doing the same source-to-target sed'ing for all our company
projects, so it was easier to add it directly to git-clone.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-clone.txt |   12 +++++++-----
 git-clone.sh                |    2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

applies-to: 6466c53ae80cddbb581c5fdb2332f9321fade867
fe6fb0e830253803798a2b70222d72e4107db1c1
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index fefd298..83f58ae 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -8,7 +8,7 @@ git-clone - Clones a repository.
 
 SYNOPSIS
 --------
-'git-clone' [-l [-s]] [-q] [-n] [-u <upload-pack>] <repository> <directory>
+'git-clone' [-l [-s]] [-q] [-n] [-u <upload-pack>] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -68,9 +68,11 @@ OPTIONS
 	be any URL git-fetch supports.
 
 <directory>::
-	The name of a new directory to be cloned into.  It is an
-	error to specify an existing directory.
-
+	The name of a new directory to clone into.  The	"humanish"
+	part of the source repository is used if no directory is
+	explicitly given ("repo" for "/path/to/repo.git" and "foo"
+	for "host.xz:foo/.git").  Cloning into an existing directory
+	is not allowed.
 
 Author
 ------
@@ -78,7 +80,7 @@ Written by Linus Torvalds <torvalds@osdl
 
 Documentation
 --------------
-Documentation by Junio C Hamano.
+Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 
 GIT
diff --git a/git-clone.sh b/git-clone.sh
index 4fdd652..70cf7a2 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -96,6 +96,8 @@ if base=$(get_repo_base "$repo"); then
 fi
 
 dir="$2"
+# Try using "humanish" part of source repo if user didn't specify one
+[ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's#/*\.git$##' -e 's#.*[/:]##')
 mkdir "$dir" &&
 D=$(
 	(cd "$dir" && git-init-db && pwd)
---
0.99.9.GIT
