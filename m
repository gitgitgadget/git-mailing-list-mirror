From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH v2] filter-branch -d: Export GIT_DIR earlier
Date: Tue, 17 Feb 2009 09:31:46 +0100
Message-ID: <20090217083146.GA7338@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:33:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLOH-0005SV-O8
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbZBQIbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbZBQIbu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:31:50 -0500
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:33137 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbZBQIbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:31:49 -0500
Received: from [87.78.71.97] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay09.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZLMp-0007k0-CC; Tue, 17 Feb 2009 09:31:47 +0100
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZLMo-0001ue-IC; Tue, 17 Feb 2009 09:31:46 +0100
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110331>

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

The tests copies backup-ref into another directory and checks
that it contains a branch from the rewritten repository.

  git-filter-branch.sh     |   12 ++++++------
  t/t7003-filter-branch.sh |    9 +++++++++
  2 files changed, 15 insertions(+), 6 deletions(-)

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
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 56b5ecc..446700b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -48,6 +48,15 @@ test_expect_success 'result is really identical' '
  	test $H = $(git rev-parse HEAD)
  '
  
+TRASHDIR=$(pwd)
+test_expect_success 'correct GIT_DIR while using -d' '
+        mkdir drepo && cd drepo && git init && make_commit drepo &&
+        git filter-branch -d "$TRASHDIR/dfoo" \
+            --index-filter "cp \"$TRASHDIR\"/dfoo/backup-refs \"$TRASHDIR\"" &&
+        cd .. &&
+        grep drepo "$TRASHDIR/backup-refs"
+'
+
  test_expect_success 'Fail if commit filter fails' '
  	test_must_fail git filter-branch -f --commit-filter "exit 1" HEAD
  '
-- 
1.6.1.3
