From: Michael Spang <mspang@uwaterloo.ca>
Subject: git-svn test suite failures due to Subversion race
Date: Sun, 11 Feb 2007 22:32:46 -0500
Message-ID: <45CFDFDE.8080907@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070107080702020509070200"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 04:53:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGSFq-0002zR-Jh
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 04:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960AbXBLDxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 22:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932962AbXBLDxX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 22:53:23 -0500
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:46934 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932960AbXBLDxV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Feb 2007 22:53:21 -0500
X-Greylist: delayed 1208 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Feb 2007 22:53:21 EST
Received: from [192.168.0.11] (CPE00045a842fd6-CM000a73a11526.cpe.net.cable.rogers.com [74.108.158.132])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l1C3WoKh027160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 11 Feb 2007 22:33:04 -0500 (EST)
User-Agent: Icedove 1.5.0.9 (X11/20061220)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sun, 11 Feb 2007 22:33:12 -0500 (EST)
X-Miltered: at psyche with ID 45CFDFE3.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.88.7, clamav-milter version 0.88.7 on localhost
X-Virus-Status: Clean
X-UUID: eedc7bb9-fcbb-40bc-8b6a-382d44dec51b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39354>

This is a multi-part message in MIME format.
--------------070107080702020509070200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Some of the git-svn tests can fail on fast machines due to a race in
Subversion: if a file is modified in the same second it was checked out
(or in for that matter), Subversion will not consider it modified.
Apparently there is also a "racy Subversion" problem parallel to the
"racy-git" problem. The machine is an Athlon 64 X2 3800+.

For example, test #3 of t9106-git-svn-commit-diff-clobber.sh will fail
if Subversion happens to fail to make any commit in test #2 of the same
file. Test #2 will silently pass if no commit was made, as it is not an
error to commit nothing. The commit in #3 is supposed to conflict with
the one from #2, but obviously won't if that commit wasn't made. So in
this case test #3's commit succeeds when failure is expected, and the
test fails. The [annotated] output of a test run where this happens is
attached. A couple of other tests have the same problem.

This may be a known issue, but my search of the archives was fruitless
and it doesn't appear to be documented anywhere. It's obviously one that
would need to ultimately be fixed in Subversion, although a workaround
in the test suite might help those whose builds depend on a passing test
suite. It's problematic for me to have the git test suite fail because
the git package for Debian runs the test suite while building, and will
abort the build if there are failures.

Until this race is fixed in Subversion I guess I'm stuck either skipping
the git-svn tests or inserting `sleep 1` in a few places to work around
it. A patch that works around this problem in all of the tests that
failed for me is attached in case its useful to someone. Even faster
machines may reveal more instances of the problem. I did not attempt to
"fix" any tests that will still pass if commits are lost.

Cheers,
Michael Spang

--------------070107080702020509070200
Content-Type: text/x-patch;
 name="0001-Work-around-Subversion-race-in-git-svn-tests.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Work-around-Subversion-race-in-git-svn-tests.patch"

>From 97e90fcd7cf600726ec468016eb37d1e1de38dde Mon Sep 17 00:00:00 2001
From: Michael Spang <mspang@uwaterloo.ca>
Date: Sun, 11 Feb 2007 20:56:22 -0500
Subject: [PATCH] Work around Subversion race in git-svn tests.

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---
 t/t9103-git-svn-graft-branches.sh      |    1 +
 t/t9106-git-svn-commit-diff-clobber.sh |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/t9103-git-svn-graft-branches.sh b/t/t9103-git-svn-graft-branches.sh
index 4e55778..f90f3a8 100755
--- a/t/t9103-git-svn-graft-branches.sh
+++ b/t/t9103-git-svn-graft-branches.sh
@@ -14,6 +14,7 @@ test_expect_success 'initialize repo' "
 	svn cp -m 'tag a' $svnrepo/trunk $svnrepo/tags/a &&
 	svn cp -m 'branch a' $svnrepo/trunk $svnrepo/branches/a &&
 	svn co $svnrepo wc &&
+	sleep 1 &&
 	cd wc &&
 	echo feedme >> branches/a/readme &&
 	svn commit -m hungry &&
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 59b6425..70c9f58 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -16,6 +16,7 @@ test_expect_success 'initialize repo' "
 	"
 test_expect_success 'commit change from svn side' "
 	svn co $svnrepo t.svn &&
+	sleep 1 &&
 	cd t.svn &&
 	echo second line from svn >> file &&
 	svn commit -m 'second line from svn' &&
@@ -43,6 +44,7 @@ test_expect_failure 'dcommit fails to commit because of conflict' "
 	git-svn fetch &&
 	git reset --hard refs/remotes/git-svn &&
 	svn co $svnrepo t.svn &&
+	sleep 1 &&
 	cd t.svn &&
 	echo fourth line from svn >> file &&
 	svn commit -m 'fourth line from svn' &&
-- 
1.5.0.rc4.gcc46a


--------------070107080702020509070200
Content-Type: text/plain;
 name="t9106-git-svn-commit-diff-clobber.sh.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="t9106-git-svn-commit-diff-clobber.sh.out"

001    $ sh t9106-git-svn-commit-diff-clobber.sh -v
002    * expecting success:
003            mkdir import &&
004            cd import &&
005            echo initial > file &&
006            svn import -m 'initial' . file:///users/mspang/src/git/git/t/trash/svnrepo &&
007            cd .. &&
008            echo initial > file &&
009            git update-index --add file &&
010            git commit -a -m 'initial'
011
012    Adding         file
013
014    Committed revision 1.
015    Created initial commit 39d53013acc58c2675a4d856da562282c21f5235
016     1 files changed, 1 insertions(+), 0 deletions(-)
017     create mode 100644 file
018    *   ok 1: initialize repo
019
020    * expecting success:
021            svn co file:///users/mspang/src/git/git/t/trash/svnrepo t.svn &&
022            cd t.svn &&
023            echo second line from svn >> file &&
024            svn commit -m 'second line from svn' &&
025            cd .. &&
026            rm -rf t.svn
027
028    A    t.svn/file
029    Checked out revision 1.

[missing]   Sending        file
[missing]   Transmitting file data .
[missing]   Committed revision 2.

030    *   ok 2: commit change from svn side
031
032    * expecting failure:
033            echo second line from git >> file &&
034            git commit -a -m 'second line from git' &&
035            git-svn commit-diff -r1 HEAD~1 HEAD file:///users/mspang/src/git/git/t/trash/svnrepo
036
037    Created commit eafa51760d91bfcfa1ce7e4f18bd0854cc723333
038     1 files changed, 1 insertions(+), 0 deletions(-)
039    diff-tree HEAD~1 HEAD
040            M       file
041    Committed 2
042    * FAIL 3: commit conflicting change from git

[fails due to last missing commit]

043
044                    echo second line from git >> file &&
045                    git commit -a -m 'second line from git' &&
046                    git-svn commit-diff -r1 HEAD~1 HEAD file:///users/mspang/src/git/git/t/trash/svnrepo
047
048
049    * expecting success:
050            git reset --hard HEAD~1 &&
051            echo second line from svn >> file &&
052            git commit -a -m 'second line from svn' &&
053            echo third line from git >> file &&
054            git commit -a -m 'third line from git' &&
055            git-svn commit-diff -r2 HEAD~1 HEAD file:///users/mspang/src/git/git/t/trash/svnrepo
056
057    HEAD is now at 39d5301... initial
058    Created commit c8ce91056ec7f8082bc1f86f5233b3c73f952ff5
059     1 files changed, 1 insertions(+), 0 deletions(-)
060    Created commit c6cfbf71727661a3ca3d25144fe0c579ff8e02fb
061     1 files changed, 1 insertions(+), 0 deletions(-)
062    diff-tree HEAD~1 HEAD
063            M       file
064    Committed 3
065    *   ok 4: commit complementing change from git
066
067    * expecting failure:
068            git-svn init file:///users/mspang/src/git/git/t/trash/svnrepo &&
069            git-svn fetch &&
070            git reset --hard refs/remotes/git-svn &&
071            svn co file:///users/mspang/src/git/git/t/trash/svnrepo t.svn &&
072            cd t.svn &&
073            echo fourth line from svn >> file &&
074            svn commit -m 'fourth line from svn' &&
075            cd .. &&
076            rm -rf t.svn &&
077            echo 'fourth line from git' >> file &&
078            git commit -a -m 'fourth line from git' &&
079            git-svn dcommit
080
081    Fetching git-svn
082    r0 = 103011a5e58371b0034e4655e82bbda686e3e60b
083            A       file
084    r1 = 2555b1052c176cd6de86b775797b9e7924c1ea04
085            M       file
086    r2 = 3e520e5a40bda6e97c37e1ae37dbb0583608e7e1
087            M       file
088    r3 = e47289f12d30749c4b25762d402cc1762afbdd01
089    HEAD is now at e47289f... third line from git
090    A    t.svn/file
091    Checked out revision 3.

[missing]   Sending        file
[missing]   Transmitting file data .
[missing]   Committed revision 4.

092    Created commit b5ccb76480136befc4d702e1c8764897162cbc72
093     1 files changed, 1 insertions(+), 0 deletions(-)
094    diff-tree b5ccb76480136befc4d702e1c8764897162cbc72~1 b5ccb76480136befc4d702e1c8764897162cbc72
095            M       file
096    Committed 4
097            M       file
098    r4 = acaf5f49b02286596bd8f27139bf374082c7afaf
099    No changes between current HEAD and refs/remotes/git-svn
100    Resetting to the latest refs/remotes/git-svn
101    * FAIL 5: dcommit fails to commit because of conflict

[fails due to last missing commit]

102
103                    git-svn init file:///users/mspang/src/git/git/t/trash/svnrepo &&
104                    git-svn fetch &&
105                    git reset --hard refs/remotes/git-svn &&
106                    svn co file:///users/mspang/src/git/git/t/trash/svnrepo t.svn &&
107                   cd t.svn &&
108                    echo fourth line from svn >> file &&
109                    svn commit -m 'fourth line from svn' &&
110                    cd .. &&
111                    rm -rf t.svn &&
112                    echo 'fourth line from git' >> file &&
113                    git commit -a -m 'fourth line from git' &&
114                    git-svn dcommit
115
116
117    * expecting success:
118            git reset --hard refs/remotes/git-svn &&
119            echo 'index merge' > file2 &&
120            git update-index --add file2 &&
121            git commit -a -m 'index merge' &&
122            echo 'more changes' >> file2 &&
123            git update-index file2 &&
124            git commit -a -m 'more changes' &&
125            git-svn dcommit
126
127    HEAD is now at acaf5f4... fourth line from git
128    Created commit 4f898d08f8011241134e983cc30d98785e926f13
129     1 files changed, 1 insertions(+), 0 deletions(-)
130     create mode 100644 file2
131    Created commit 59cf4e5baa0fd3d444d3a084d5e8a87328ddfcae
132     1 files changed, 1 insertions(+), 0 deletions(-)
133    diff-tree 4f898d08f8011241134e983cc30d98785e926f13~1 4f898d08f8011241134e983cc30d98785e926f13
134            A       file2
135    Committed 5
136    diff-tree 59cf4e5baa0fd3d444d3a084d5e8a87328ddfcae~1 59cf4e5baa0fd3d444d3a084d5e8a87328ddfcae
137            M       file2
138    Committed 6
139            A       file2
140    r5 = caed42b00cded960103b70a51b4c81194f94c960
141            M       file2
142    r6 = 8e8a98024de9b2469e94815fea87492728ef1fc4
143    No changes between current HEAD and refs/remotes/git-svn
144    Resetting to the latest refs/remotes/git-svn
145    *   ok 6: dcommit does the svn equivalent of an index merge
146
147    * failed 2 among 6 test(s)

--------------070107080702020509070200--
