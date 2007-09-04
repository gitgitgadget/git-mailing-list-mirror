From: Gerrit Pape <pape@smarden.org>
Subject: git-commit: if run with <file> arguments, include files removed through git rm
Date: Tue, 4 Sep 2007 14:43:04 +0000
Message-ID: <20070904144304.5920.qmail@42e302a26078dc.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 16:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZkk-0002QC-Ey
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbXIDOvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754313AbXIDOvh
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:51:37 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:45843 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754299AbXIDOvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:51:36 -0400
Received: (qmail 5921 invoked by uid 1000); 4 Sep 2007 14:43:04 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57587>

If git-commit is given a directory as argument to be included in the
commit, it uses git ls-files to find out which files to include; this
misses files previously removed from the working tree and the index
through git rm:

  % git init-db
  Initialized empty Git repository in .git/
  % mkdir bar baz
  % touch bar/file1 baz/file1 baz/file2
  % git add . && git commit -mcommit1
  Created initial commit 1d7dee4: commit1
   0 files changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 bar/file1
   create mode 100644 baz/file1
   create mode 100644 baz/file2
  % git rm baz/file1
  rm 'baz/file1'
  % git commit -- baz/
  # On branch master
  # Changed but not updated:
  #   (use "git add/rm <file>..." to update what will be committed)
  #
  #       deleted:    baz/file1
  #
  no changes added to commit (use "git add" and/or "git commit -a")

This patch lets it additionally use git ls-tree to look for the files in
the HEAD tree, but I guess there's a smarter way to fix this.
---
 git-commit.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 1d04f1f..3ac7c4f 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -381,6 +381,7 @@ t,)
 		fi
 		TMP_INDEX="$GIT_DIR/tmp-index$$"
 		commit_only=`git ls-files --error-unmatch -- "$@"` || exit
+		commit_only="$commit_only "`git ls-tree -r --name-only HEAD -- "$@"` || exit
 
 		# Build a temporary index and update the real index
 		# the same way.
-- 
1.5.3
