From: Jeff King <peff@peff.net>
Subject: [PATCH] filter-branch: return to original dir after filtering
Date: Tue, 2 Apr 2013 10:22:19 -0400
Message-ID: <20130402142219.GB23828@sigill.intra.peff.net>
References: <1364905941.19800.24.camel@mas>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 16:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN26u-0007ju-B1
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 16:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761036Ab3DBOWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 10:22:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52153 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760688Ab3DBOWX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 10:22:23 -0400
Received: (qmail 9815 invoked by uid 107); 2 Apr 2013 14:24:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 10:24:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 10:22:19 -0400
Content-Disposition: inline
In-Reply-To: <1364905941.19800.24.camel@mas>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219772>

The first thing filter-branch does is to create a temporary
directory, either ".git-rewrite" in the current directory
(which may be the working tree or the repository if bare),
or in a directory specified by "-d". We then chdir to
$tempdir/t as our temporary working directory in which to run
tree filters.

After finishing the filter, we then attempt to go back to
the original directory with "cd ../..". This works in the
.git-rewrite case, but if "-d" is used, we end up in a
random directory. The only thing we do after this chdir is
to run git-read-tree, but that means that:

  1. The working directory is not updated to reflect the
     filtered history.

  2. We dump random files into "$tempdir/.." (e.g., if you
     use "-d /tmp/foo", we dump junk into /tmp).

Fix it by recording the full path to the original directory
and returning there explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
On Tue, Apr 02, 2013 at 02:32:21PM +0200, Martin Erik Werner wrote:

> I think I have stumbled on a bug in the -d option of git filter-branch.
> 
> It seems like in the final stage of filter-branch, regardless of where
> -d is set, it will make updates to the "working directory" as being the
> parent of the -d directory, and the actual working directory is left as
> it were before the filtering.

Yep, definitely a bug. Thanks for reporting.

 git-filter-branch.sh     |  5 +++--
 t/t7003-filter-branch.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5314249..ac2a005 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -199,6 +199,7 @@ esac
 	test -d "$tempdir" &&
 		die "$tempdir already exists, please remove it"
 esac
+orig_dir=$(pwd)
 mkdir -p "$tempdir/t" &&
 tempdir="$(cd "$tempdir"; pwd)" &&
 cd "$tempdir/t" &&
@@ -206,7 +207,7 @@ die ""
 die ""
 
 # Remove tempdir on exit
-trap 'cd ../..; rm -rf "$tempdir"' 0
+trap 'cd "$orig_dir"; rm -rf "$tempdir"' 0
 
 ORIG_GIT_DIR="$GIT_DIR"
 ORIG_GIT_WORK_TREE="$GIT_WORK_TREE"
@@ -469,7 +470,7 @@ fi
 	done
 fi
 
-cd ../..
+cd "$orig_dir"
 rm -rf "$tempdir"
 
 trap - 0
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 1e7a209..9496736 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -64,6 +64,20 @@ test_expect_success 'correct GIT_DIR while using -d' '
 	grep drepo "$TRASHDIR/backup-refs"
 '
 
+test_expect_success 'tree-filter works with -d' '
+	git init drepo-tree &&
+	(
+		cd drepo-tree &&
+		test_commit one &&
+		git filter-branch -d "$TRASHDIR/dfoo" \
+			--tree-filter "echo changed >one.t" &&
+		echo changed >expect &&
+		git cat-file blob HEAD:one.t >actual &&
+		test_cmp expect actual &&
+		test_cmp one.t actual
+	)
+'
+
 test_expect_success 'Fail if commit filter fails' '
 	test_must_fail git filter-branch -f --commit-filter "exit 1" HEAD
 '
-- 
1.8.2.rc0.33.gd915649
