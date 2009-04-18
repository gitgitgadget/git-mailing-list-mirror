From: Ben Jackson <ben@ben.com>
Subject: [PATCH] Work around ash "alternate value" expansion bug
Date: Sat, 18 Apr 2009 01:47:39 -0700
Message-ID: <1240044459-57227-1-git-send-email-ben@ben.com>
Cc: nanako3@lavabit.com, gitster@pobox.com, ben@ben.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 10:49:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv6En-00033C-6A
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 10:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbZDRIru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 04:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbZDRIrt
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 04:47:49 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:51504 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbZDRIrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 04:47:48 -0400
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n3I8lf5p057250;
	Sat, 18 Apr 2009 01:47:41 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n3I8ldmT057248;
	Sat, 18 Apr 2009 01:47:39 -0700 (PDT)
	(envelope-from bjj)
X-Mailer: git-send-email 1.6.0.1
X-Virus-Scanned: ClamAV 0.93.3/9254/Fri Apr 17 16:36:48 2009 on kronos.home.ben.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116816>

Ash (used as /bin/sh on many distros) has a shell expansion bug
for the form ${var:+word word}.  The result is a single argument
"word word".  Work around by using ${var:+word} ${var:+word} or
equivalent.

Signed-off-by: Ben Jackson <ben@ben.com>
---

I found this by accident while testing another trivial git-am patch.
It was broken about a week ago in git-am.sh by f79d4c8a and one of the
test cases caught it on FreeBSD.

The other instance has been around longer and I found it by grepping.
I added a new testcase (none too exciting) which exposes the problem.
There are more instances of ${x:+alt} which don't have spaces which I
did not touch.

For the curious:

bash on linux:
	$ parent=ok
	$ echo ${parent:+-p $parent}
	-p ok
	$ for i in ${parent:+-p $parent} ; do echo .$i; done
	.-p
	.ok

ash (/bin/sh) on freebsd:
	$ parent=ok
	$ echo ${parent:+-p $parent}
	-p ok
	$ for i in ${parent:+-p $parent} ; do echo .$i; done
	.-p ok

This is probably a bug in ash.  It does expand ${foo:+*} into many words.

 git-am.sh                  |    2 +-
 git-submodule.sh           |    2 +-
 t/t7400-submodule-basic.sh |    8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index bfc50c9..e539c60 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -570,7 +570,7 @@ do
 			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
 			export GIT_COMMITTER_DATE
 		fi &&
-		git commit-tree $tree ${parent:+-p $parent} <"$dotest/final-commit"
+		git commit-tree $tree ${parent:+-p} $parent <"$dotest/final-commit"
 	) &&
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
diff --git a/git-submodule.sh b/git-submodule.sh
index 7c2e060..bb3766d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -204,7 +204,7 @@ cmd_add()
 	else
 
 		module_clone "$path" "$realrepo" || exit
-		(unset GIT_DIR; cd "$path" && git checkout -f -q ${branch:+-b "$branch" "origin/$branch"}) ||
+		(unset GIT_DIR; cd "$path" && git checkout -f -q ${branch:+-b} ${branch:+"$branch"} ${branch:+"origin/$branch"}) ||
 		die "Unable to checkout submodule '$path'"
 	fi
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index af690ec..3c05c27 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -64,6 +64,14 @@ test_expect_success 'submodule add' '
 	)
 '
 
+test_expect_success 'submodule add --branch' '
+	(
+		cd addtest &&
+		git submodule add -b initial "$submodurl" submod-branch &&
+		git submodule init
+	)
+'
+
 test_expect_success 'submodule add with ./ in path' '
 	(
 		cd addtest &&
-- 
1.6.0.1
