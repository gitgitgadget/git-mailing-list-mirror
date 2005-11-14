From: Alex Riesen <raa.lkml@gmail.com>
Subject: allow git-update-ref create refs with slashes in names
Date: Mon, 14 Nov 2005 22:59:05 +0100
Message-ID: <20051114215905.GA5714@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:06:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbmOj-0006xI-3m
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 23:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVKNV7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVKNV7g
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 16:59:36 -0500
Received: from devrace.com ([198.63.210.113]:31494 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932188AbVKNV7b (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 16:59:31 -0500
Received: from tigra.home (p54A0FD16.dip.t-dialin.net [84.160.253.22])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAELx6Lp062852;
	Mon, 14 Nov 2005 15:59:08 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EbmLx-0000KW-00; Mon, 14 Nov 2005 22:59:05 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EbmLx-0001V9-EU; Mon, 14 Nov 2005 22:59:05 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.7 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11854>

Make git-update-ref create references with slashes in them. git-branch
and git-checkout already support such reference names.

git-branch can use git-update-ref to create the references in a more
formal manner now.

---

the patch also adds to trivial test cases (just to notice regression,
even if I don't believe that is possible for such a trivial thing).

diff --git a/git-branch.sh b/git-branch.sh
index 67f113a..11d52fd 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -102,6 +102,5 @@ rev=$(git-rev-parse --verify "$head") ||
 git-check-ref-format "heads/$branchname" ||
 	die "we do not like '$branchname' as a branch name."
 
-leading=`expr "refs/heads/$branchname" : '\(.*\)/'` &&
-mkdir -p "$GIT_DIR/$leading" &&
-echo $rev > "$GIT_DIR/refs/heads/$branchname"
+git update-ref "refs/heads/$branchname" $rev
+
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5f98f64..36f7749 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -24,4 +24,12 @@ test_expect_failure \
     'git branch --help should not have created a bogus branch' \
     'test -f .git/refs/heads/--help'
 
+test_expect_success \
+    'git branch abc should create a branch' \
+    'git-branch abc && test -f .git/refs/heads/abc'
+
+test_expect_success \
+    'git branch a/b/c should create a branch' \
+    'git-branch a/b/c && test -f .git/refs/heads/a/b/c'
+
 test_done
diff --git a/update-ref.c b/update-ref.c
index d79dc52..aac04e6 100644
--- a/update-ref.c
+++ b/update-ref.c
@@ -49,6 +49,8 @@ int main(int argc, char **argv)
 	}
 	path = strdup(path);
 	lockpath = mkpath("%s.lock", path);
+	if (safe_create_leading_directories(lockpath) < 0)
+		die("Unable to create all of %s", lockpath);
 
 	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0)
