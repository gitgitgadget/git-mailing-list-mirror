From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: [bug] filter-branch skipping removed files
Date: Sun, 30 Mar 2008 10:35:52 -0400
Message-ID: <CC52AEE1-2F50-48F2-9A17-CD315E2DCB0A@yahoo.ca>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 30 16:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfygW-0003MU-Dt
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 16:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbYC3OiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 10:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYC3OiL
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 10:38:11 -0400
Received: from n14b.bullet.scd.yahoo.com ([209.73.160.81]:32609 "HELO
	n14b.bullet.scd.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752424AbYC3OiK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Mar 2008 10:38:10 -0400
Received: from [66.218.69.2] by n14.bullet.scd.yahoo.com with NNFMP; 30 Mar 2008 14:38:06 -0000
Received: from [68.142.237.91] by t2.bullet.scd.yahoo.com with NNFMP; 30 Mar 2008 14:38:06 -0000
X-yahoo-newman-spamcop: yes
Received: from [68.142.230.29] by n6.bullet.re3.yahoo.com with NNFMP; 30 Mar 2008 14:36:14 -0000
Received: from [69.147.75.191] by t2.bullet.re2.yahoo.com with NNFMP; 30 Mar 2008 14:36:14 -0000
Received: from [127.0.0.1] by omp107.mail.re1.yahoo.com with NNFMP; 30 Mar 2008 14:36:14 -0000
X-Yahoo-Newman-Id: 476000.96536.bm@omp107.mail.re1.yahoo.com
Received: (qmail 94093 invoked from network); 30 Mar 2008 14:36:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:Mime-Version:Content-Transfer-Encoding:Message-Id:Content-Type:To:From:Subject:Date:X-Mailer;
  b=IdfQJdi0agIOz7BQpnCRgbdPVS+/JvYhehLtnI/6O67rchGMSZ7RFx5/t8Id+pb8fldq/kwW05U+wOHLHhbnVeGqVWhjUboiIf5RclFpxU4pnnWDlLVE7BhcvgYFBv23w0Sfms2sQqYKTLS5rV7+p0yOKBJsvk5yVIyk/kjk3Xg=  ;
Received: from unknown (HELO ?10.0.1.3?) (jean_francois_veillette@66.130.96.245 with plain)
  by smtp104.mail.mud.yahoo.com with SMTP; 30 Mar 2008 14:36:13 -0000
X-YMail-OSG: ULVbD1UVM1ld8TfMj3tZgjSphOgLB65MvTkDPpS.J.iGt9n5
X-Yahoo-Newman-Property: ymail-3
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78507>

I'm experimenting with git filter-branch to simplify the change =20
history.  I would like to rewrite the history and remove unwanted =20
files and reformat the sources to remove all the change's noises =20
(whitespace changes, code reformat).
But the new history miss some commits of removed files.
I was preparing a simple test (down bellow) when I thought, why not =20
try to fix it (my first journey inside git).
It turn out I was able to fix the problem, it was almost too easy:

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 22b6ed4..26ebb6c 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -277,7 +277,7 @@ while read commit parents; do
  		die "env filter failed: $filter_env"

   	if [ "$filter_tree" ]; then
-		git checkout-index -f -u -a ||
+		git checkout-index -d -f -u -a ||
  			die "Could not checkout the index"
  		# files that $commit removed are now still in the working tree;
  		# remove them, else they would be added again


It was my first try, just because I noticed that git-clean was giving =20
a 'warning' of non removed directory.  At that point I just wanted to =20
remove the warning ... but that was enough to fix the problem !
I don't know if it's a real fix, but at least it does correct the =20
problem I'm having.
I have no idea of the implication of what I just touched.  the 'real' =20
problem might very well be somewhere else.


Here is a simple test that show the problem.

$: mkdir test ; cd test
$: git init
Initialized empty Git repository in .git/
$: echo 'line A' > a.txt
$: echo 'line B' > b.txt
$: mkdir subdir
$: echo 'line subA' > subdir/a.txt
$: echo 'line subB' > subdir/b.txt
$: git add *
$: git commit -m 'first commit'
Created initial commit f264d57: first commit
  4 files changed, 4 insertions(+), 0 deletions(-)
  create mode 100644 a.txt
  create mode 100644 b.txt
  create mode 100644 subdir/a.txt
  create mode 100644 subdir/b.txt
$: git rm b.txt subdir/b.txt
rm 'b.txt'
rm 'subdir/b.txt'
$: git commit -m 'remove b files'
Created commit b064598: remove b files
  2 files changed, 0 insertions(+), 2 deletions(-)
  delete mode 100644 b.txt
  delete mode 100644 subdir/b.txt
$: echo 'line AA' >> a.txt
$: echo 'line subAA' >> subdir/a.txt
$: git add *
$: git commit -m 'modified a files'
Created commit 0f914cb: modified a files
  2 files changed, 2 insertions(+), 0 deletions(-)
$: git rm subdir/a.txt
rm 'subdir/a.txt'
$: git commit -m 'removed all sub files'
Created commit 41c0de7: removed all sub files
  1 files changed, 0 insertions(+), 2 deletions(-)
  delete mode 100644 subdir/a.txt
$: ls -la
=2E..git   a.txt
$: echo 'line AAA' >> a.txt
$: git add *
$: git commit -m 'modified a.txt'
Created commit c21e292: modified a.txt
  1 files changed, 1 insertions(+), 0 deletions(-)



$: git filter-branch --tree-filter 'ls -lR'   # do nothing, juste =20
rewrite itself
Rewrite f264d57f476858aa4ddbf70358500c3be7298048 (1/5)total 16
-rw-r--r--   1 jfv  jfv    7 30 mar 09:38 a.txt
-rw-r--r--   1 jfv  jfv    7 30 mar 09:38 b.txt
drwxr-xr-x   4 jfv  jfv  136 30 mar 09:38 subdir

=2E../subdir:
total 16
-rw-r--r--   1 jfv  jfv  10 30 mar 09:38 a.txt
-rw-r--r--   1 jfv  jfv  10 30 mar 09:38 b.txt
Rewrite b064598f57b4679febaeddda6dfbde43a935796a (2/5)total 8
-rw-r--r--   1 jfv  jfv    7 30 mar 09:38 a.txt
drwxr-xr-x   3 jfv  jfv  102 30 mar 09:38 subdir

=2E../subdir:
total 8
-rw-r--r--   1 jfv  jfv  10 30 mar 09:38 a.txt
Rewrite 0f914cb21ab65aac5d966a9552bfb63aa73a996a (3/5)total 8
-rw-r--r--   1 jfv  jfv   15 30 mar 09:38 a.txt
drwxr-xr-x   3 jfv  jfv  102 30 mar 09:38 subdir

=2E../subdir:
total 8
-rw-r--r--   1 jfv  jfv  21 30 mar 09:38 a.txt
Rewrite 41c0de77880245c23bb56b0b1936564c7adf63de (4/5)Not removing =20
subdir/
total 8
-rw-r--r--   1 jfv  jfv   15 30 mar 09:38 a.txt
drwxr-xr-x   3 jfv  jfv  102 30 mar 09:38 subdir

=2E../subdir:
total 8
-rw-r--r--   1 jfv  jfv  21 30 mar 09:38 a.txt
Rewrite c21e292486500afa3a0ded69f4edf30de11d42d1 (5/5)Not removing =20
subdir/
total 8
-rw-r--r--   1 jfv  jfv   24 30 mar 09:38 a.txt
drwxr-xr-x   3 jfv  jfv  102 30 mar 09:38 subdir

=2E../subdir:
total 8
-rw-r--r--   1 jfv  jfv  21 30 mar 09:38 a.txt

Ref 'refs/heads/master' was rewritten



$: git log -p
commit c3715041ae38ccc6596986fd1927aff65a3d14bf
Author: Jean-Fran=E7ois Veillette <jfveillette@os.ca>
Date:   Sun Mar 30 09:35:01 2008 -0400

     modified a.txt

diff --git a/a.txt b/a.txt
index 457599c..36d130e 100644
--- a/a.txt
+++ b/a.txt
@@ -1,2 +1,3 @@
  line A
  line AA
+line AAA

commit d45ccff19c3c81f8c78a22ed5c2436c7a5b99f7c
Author: Jean-Fran=E7ois Veillette <jfveillette@os.ca>
Date:   Sun Mar 30 09:33:48 2008 -0400

     removed all sub files

commit 0f914cb21ab65aac5d966a9552bfb63aa73a996a
Author: Jean-Fran=E7ois Veillette <jfveillette@os.ca>
Date:   Sun Mar 30 09:33:07 2008 -0400

     modified a files

diff --git a/a.txt b/a.txt
index 102c5da..457599c 100644
--- a/a.txt
+++ b/a.txt
@@ -1 +1,2 @@
  line A
+line AA
diff --git a/subdir/a.txt b/subdir/a.txt
index 56e593a..b215539 100644
--- a/subdir/a.txt
+++ b/subdir/a.txt
@@ -1 +1,2 @@
  line subA
+line subAA

commit b064598f57b4679febaeddda6dfbde43a935796a
Author: Jean-Fran=E7ois Veillette <jfveillette@os.ca>
Date:   Sun Mar 30 09:32:13 2008 -0400

     remove b files

diff --git a/b.txt b/b.txt
deleted file mode 100644
index 346d560..0000000
--- a/b.txt
+++ /dev/null
@@ -1 +0,0 @@
-line B
diff --git a/subdir/b.txt b/subdir/b.txt
deleted file mode 100644
index 7cbec67..0000000
--- a/subdir/b.txt
+++ /dev/null
@@ -1 +0,0 @@
-line subB

commit f264d57f476858aa4ddbf70358500c3be7298048
Author: Jean-Fran=E7ois Veillette <jfveillette@os.ca>
Date:   Sun Mar 30 09:29:28 2008 -0400

     first commit

diff --git a/a.txt b/a.txt
new file mode 100644
index 0000000..102c5da
--- /dev/null
+++ b/a.txt
@@ -0,0 +1 @@
+line A
diff --git a/b.txt b/b.txt
new file mode 100644
index 0000000..346d560
--- /dev/null
+++ b/b.txt
@@ -0,0 +1 @@
+line B
diff --git a/subdir/a.txt b/subdir/a.txt
new file mode 100644
index 0000000..56e593a
--- /dev/null
+++ b/subdir/a.txt
@@ -0,0 +1 @@
+line subA
diff --git a/subdir/b.txt b/subdir/b.txt
new file mode 100644
index 0000000..7cbec67
--- /dev/null
+++ b/subdir/b.txt
@@ -0,0 +1 @@
+line subB


- jfv
