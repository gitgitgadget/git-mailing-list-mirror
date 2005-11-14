From: Alex Riesen <raa.lkml@gmail.com>
Subject: allow git-update-ref create refs with slashes in names
Date: Mon, 14 Nov 2005 23:10:59 +0100
Message-ID: <20051114221059.GA20233@steel.home>
References: <20051114215905.GA5714@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:11:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbmXh-0002aW-P0
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 23:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVKNWLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 17:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVKNWLK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 17:11:10 -0500
Received: from devrace.com ([198.63.210.113]:41989 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932198AbVKNWLJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 17:11:09 -0500
Received: from tigra.home (p54A0FD16.dip.t-dialin.net [84.160.253.22])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAEMB3j5063025;
	Mon, 14 Nov 2005 16:11:04 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EbmXT-0000KY-00; Mon, 14 Nov 2005 23:10:59 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EbmXT-0005GT-K1; Mon, 14 Nov 2005 23:10:59 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051114215905.GA5714@steel.home>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.7 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11855>

Sorry for the previuos untested patch, the tradition seem to be
catching... This one is actualy tested.

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
index d79dc52..e6fbddb 100644
--- a/update-ref.c
+++ b/update-ref.c
@@ -19,7 +19,8 @@ static int re_verify(const char *path, u
 int main(int argc, char **argv)
 {
 	char *hex;
-	const char *refname, *value, *oldval, *path, *lockpath;
+	const char *refname, *value, *oldval, *path;
+	char *lockpath;
 	unsigned char sha1[20], oldsha1[20], currsha1[20];
 	int fd, written;
 
@@ -49,6 +50,8 @@ int main(int argc, char **argv)
 	}
 	path = strdup(path);
 	lockpath = mkpath("%s.lock", path);
+	if (safe_create_leading_directories(lockpath) < 0)
+		die("Unable to create all of %s", lockpath);
 
 	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0)
