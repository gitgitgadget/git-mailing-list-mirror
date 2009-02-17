From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH v3] filter-branch -d: Export GIT_DIR earlier
Date: Tue, 17 Feb 2009 19:05:40 +0100
Message-ID: <20090217180540.GB3564@lars.home.noschinski.de>
References: <20090217083146.GA7338@lars.home.noschinski.de> <alpine.DEB.1.00.0902171327270.6185@intel-tinevez-2-302> <20090217175959.GA3564@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZULf-0003Xs-U4
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 19:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbZBQSFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 13:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbZBQSFo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 13:05:44 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:42764 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbZBQSFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 13:05:43 -0500
Received: from [87.78.91.107] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZUKD-00088D-7e; Tue, 17 Feb 2009 19:05:41 +0100
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZUKC-00015w-JH; Tue, 17 Feb 2009 19:05:40 +0100
Content-Disposition: inline
In-Reply-To: <20090217175959.GA3564@lars.home.noschinski.de>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110430>

The improved error handling catches a bug in filter-branch when using
-d pointing to a path outside any git repository:

$ mkdir foo
$ cd foo
$ git init
$ touch bar
$ git add bar
$ git commit -m bar
$ git filter-branch -d /tmp/filter master
fatal: Not a git repository (or any of the parent directories): .git

This error message comes from git for-each-ref in line 224. GIT_DIR is
set correctly by git-sh-setup (to the foo.git repository), but not
exported (yet).

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
  git-filter-branch.sh     |   12 ++++++------
  t/t7003-filter-branch.sh |   12 ++++++++++++
  2 files changed, 18 insertions(+), 6 deletions(-)

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
index 56b5ecc..329c851 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -48,6 +48,18 @@ test_expect_success 'result is really identical' '
  	test $H = $(git rev-parse HEAD)
  '
  
+TRASHDIR=$(pwd)
+test_expect_success 'correct GIT_DIR while using -d' '
+	mkdir drepo &&
+	( cd drepo &&
+	git init &&
+	test_commit drepo &&
+	git filter-branch -d "$TRASHDIR/dfoo" \
+		--index-filter "cp \"$TRASHDIR\"/dfoo/backup-refs \"$TRASHDIR\"" \
+	) &&
+	grep drepo "$TRASHDIR/backup-refs"
+'
+
  test_expect_success 'Fail if commit filter fails' '
  	test_must_fail git filter-branch -f --commit-filter "exit 1" HEAD
  '
-- 
1.6.2.rc0.91.g0bb0.dirty
