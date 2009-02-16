From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] filter-branch -d: Export GIT_DIR earlier
Date: Mon, 16 Feb 2009 14:09:51 +0100
Message-ID: <20090216130951.GA3769@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 14:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ3SH-00078z-PW
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 14:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbZBPNWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 08:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbZBPNWo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 08:22:44 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:52636 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860AbZBPNWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 08:22:44 -0500
X-Greylist: delayed 770 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Feb 2009 08:22:43 EST
Received: from [134.61.47.191] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZ3EO-0004tZ-A9
	for git@vger.kernel.org; Mon, 16 Feb 2009 14:09:52 +0100
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZ3EN-0000zv-MH
	for git@vger.kernel.org; Mon, 16 Feb 2009 14:09:51 +0100
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110177>

The improved error handling catches a bug in filter-branch when using
-d pointing to a path outside any git repository:

$ mkdir foo
$ cd foo
$ git init
$ touch bar
$ git add bar
$ git commit -m bar
$ cd ..
$ git clone --bare foo
$ cd foo.git
$ git filter-branch -d /tmp/filter master
fatal: Not a git repository (or any of the parent directories): .git

This error message comes from git for-each-ref in line 224. GIT_DIR is
set correctly by git-sh-setup (to the foo.git repository), but not
exported (yet).
---

This fix is not yet ready for commit, as it lacks a test case.

Writing a test case for this bug, I wonder about the preferred way to use a
directory outside any git repository in a test: Using some directory below
git/t/ will not work, as (in most cases) git is a git repository.

Using the system's temp directory via mktemp() or so directory would work most
of the time - but not always. Any ideas?

  - Lars.

  git-filter-branch.sh |   12 ++++++------
  1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 27b57b8..9a09ba1 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -220,6 +220,12 @@ die ""
  # Remove tempdir on exit
  trap 'cd ../..; rm -rf "$tempdir"' 0
  
+ORIG_GIT_DIR="$GIT_DIR"
+ORIG_GIT_WORK_TREE="$GIT_WORK_TREE"
+ORIG_GIT_INDEX_FILE="$GIT_INDEX_FILE"
+GIT_WORK_TREE=.
+export GIT_DIR GIT_WORK_TREE
+
  # Make sure refs/original is empty
  git for-each-ref > "$tempdir"/backup-refs || exit
  while read sha1 type name
@@ -234,12 +240,6 @@ do
  	esac
  done < "$tempdir"/backup-refs
  
-ORIG_GIT_DIR="$GIT_DIR"
-ORIG_GIT_WORK_TREE="$GIT_WORK_TREE"
-ORIG_GIT_INDEX_FILE="$GIT_INDEX_FILE"
-GIT_WORK_TREE=.
-export GIT_DIR GIT_WORK_TREE
-
  # The refs should be updated if their heads were rewritten
  git rev-parse --no-flags --revs-only --symbolic-full-name \
  	--default HEAD "$@" > "$tempdir"/raw-heads || exit
-- 
1.6.2.rc0.90.g0753.dirty
