From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: Random failure after "git config core.autocrlf false" then "git reset
 --hard"
Date: Tue, 12 May 2009 22:48:03 -0400
Message-ID: <4A0A34E3.9050801@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 04:48:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M44Vu-00009p-CL
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 04:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbZEMCsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 22:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbZEMCr7
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 22:47:59 -0400
Received: from mail28.messagelabs.com ([216.82.249.131]:7252 "HELO
	mail28.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752086AbZEMCr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 22:47:58 -0400
X-VirusChecked: Checked
X-Env-Sender: Don.Slutz@SierraAtlantic.com
X-Msg-Ref: server-4.tower-28.messagelabs.com!1242182879!30436238!1
X-StarScan-Version: 6.0.0; banners=sierraatlantic.com,-,-
X-Originating-IP: [206.86.29.5]
Received: (qmail 4798 invoked from network); 13 May 2009 02:47:59 -0000
Received: from seng.sierraatl.com (HELO USFREEX1.us.corp.sa) (206.86.29.5)
  by server-4.tower-28.messagelabs.com with SMTP; 13 May 2009 02:47:59 -0000
Received: from usbosex2.us.corp.sa ([192.168.17.38]) by USFREEX1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 May 2009 19:47:59 -0700
Received: from [10.2.0.44] ([76.119.170.128]) by usbosex2.us.corp.sa over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 22:47:57 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-OriginalArrivalTime: 13 May 2009 02:47:57.0382 (UTC) FILETIME=[38C4B660:01C9D375]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118978>

While work on the report:

    http://article.gmane.org/gmane.comp.version-control.git/118857


I tried the following change:

top:~/git-a>./git-diff
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index bf39e45..ecbd97a 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -8,6 +8,8 @@ test_description='git mergetool
 Testing basic merge tool invocation'
 
 . ./test-lib.sh
+autocrlf=$(git config core.autocrlf)
+test -z "$autocrlf" && autocrlf=false
 
 # All the mergetool test work by checking out a temporary branch based
 # off 'branch1' and then merging in master and checking the results of
@@ -48,12 +50,13 @@ test_expect_success 'custom mergetool' '
     test_cat_eq file1 "master updated" &&
     test_cat_eq file2 "master new" &&
     test_cat_eq subdir/file3 "master new sub" &&
+    git status
     git commit -m "branch1 resolved with mergetool"
 '
 
 test_expect_success 'mergetool crlf' '
     git config core.autocrlf true &&
-    git checkout -b test2 branch1
+    git checkout -b test2 branch1 &&
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
@@ -61,17 +64,35 @@ test_expect_success 'mergetool crlf' '
     test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
     test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
     test "$(printf x | cat subdir/file3 -)" = "$(printf "master new 
sub\r\nx")"
+    git status
     git commit -m "branch1 resolved with mergetool - autocrlf" &&
+    git status
+    git config core.autocrlf $autocrlf &&
+    git reset --hard
+'
+
+test_expect_success 'mergetool lf' '
     git config core.autocrlf false &&
+    git status
+    git checkout -b test3 branch1 &&
+    test_must_fail git merge master >/dev/null 2>&1 &&
+    ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
+    test "$(printf x | cat file1 -)" = "$(printf "master updated\nx")" &&
+    test "$(printf x | cat file2 -)" = "$(printf "master new\nx")" &&
+    test "$(printf x | cat subdir/file3 -)" = "$(printf "master new 
sub\nx")" &
+    git commit -m "branch1 resolved with mergetool - autocrlf2" &&
+    git config core.autocrlf $autocrlf &&
     git reset --hard
 '
 
 test_expect_success 'mergetool in subdir' '
-    git checkout -b test3 branch1
+    git checkout -b test4 branch1 &&
     cd subdir && (
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
-    test "$(cat file3)" = "master new sub" )
+    test_cat_eq file3 "master new sub" )
 '
 
 # We can't merge files from parent directories when running mergetool


This both works and fails with either file2 & subdir/file3 "modified" or 
just subdir/file3.  I have found that "git reset --hard" looks to be the 
issue.  If you have autocrlf=true, and a clean work tree and then set 
autocrlf=false; then
"git reset --hard" does not change the work tree files.  However 
sometimes (which so far I have only been able to reproduce with this 
test) git diff will report the difference.

You do need 1 & 2 from:
   http://thread.gmane.org/gmane.comp.version-control.git/118830



System info:

top:~/git-a/t/trash directory.t7610-mergetool>uname -a
Linux top 2.6.18-92.1.22.el5xen #1 SMP Tue Dec 16 13:08:49 EST 2008 i686 
i686 i386 GNU/Linux
top:~/git-a/t/trash directory.t7610-mergetool>p /etc/redhat-release
CentOS release 5.2 (Final)
top:~/git-a>./git --version
git version 1.6.3.15.g49878


Command I have been using to test:

  GIT_TEST_AUTO_CRLF=true GIT_TEST_OPTS="-v -d -i" make -C t/ 
t7610-mergetool.sh

Output at failure:
...
# On branch test2
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working 
directory)
#
#       modified:   file2
#       modified:   subdir/file3
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       file1.orig
#       file2.orig
#       subdir/file3.orig
no changes added to commit (use "git add" and/or "git commit -a")
error: You have local changes to 'file2'; cannot switch branches.
* FAIL 4: mergetool lf

            git config core.autocrlf false &&
            git status
            git checkout -b test3 branch1 &&
...


It looks to be related to the time info on the files:

2 files:

top:~/git-a/t/trash directory.t7610-mergetool>stat file1
  File: `file1'
  Size: 16              Blocks: 8          IO Block: 4096   regular file
Device: fd00h/64768d    Inode: 7867961     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1657/  dslutz)   Gid: ( 1657/  dslutz)
Access: 2009-05-12 22:04:57.000000000 -0400
Modify: 2009-05-12 22:04:56.000000000 -0400
Change: 2009-05-12 22:04:56.000000000 -0400
top:~/git-a/t/trash directory.t7610-mergetool>stat file2
  File: `file2'
  Size: 12              Blocks: 8          IO Block: 4096   regular file
Device: fd00h/64768d    Inode: 7867944     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1657/  dslutz)   Gid: ( 1657/  dslutz)
Access: 2009-05-12 22:04:57.000000000 -0400
Modify: 2009-05-12 22:04:57.000000000 -0400
Change: 2009-05-12 22:04:57.000000000 -0400
top:~/git-a/t/trash directory.t7610-mergetool>stat subdir/file3
  File: `subdir/file3'
  Size: 16              Blocks: 8          IO Block: 4096   regular file
Device: fd00h/64768d    Inode: 7867822     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1657/  dslutz)   Gid: ( 1657/  dslutz)
Access: 2009-05-12 22:04:57.000000000 -0400
Modify: 2009-05-12 22:04:57.000000000 -0400
Change: 2009-05-12 22:04:57.000000000 -0400


one file:

top:~/git-a/t/trash directory.t7610-mergetool>stat file1    
  File: `file1'
  Size: 16              Blocks: 8          IO Block: 4096   regular file
Device: fd00h/64768d    Inode: 7867960     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1657/  dslutz)   Gid: ( 1657/  dslutz)
Access: 2009-05-12 21:44:34.000000000 -0400
Modify: 2009-05-12 21:44:08.000000000 -0400
Change: 2009-05-12 21:44:08.000000000 -0400
top:~/git-a/t/trash directory.t7610-mergetool>stat file2
  File: `file2'
  Size: 12              Blocks: 8          IO Block: 4096   regular file
Device: fd00h/64768d    Inode: 7867943     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1657/  dslutz)   Gid: ( 1657/  dslutz)
Access: 2009-05-12 21:44:41.000000000 -0400
Modify: 2009-05-12 21:44:08.000000000 -0400
Change: 2009-05-12 21:44:08.000000000 -0400
top:~/git-a/t/trash directory.t7610-mergetool>stat subdir/file3
  File: `subdir/file3'
  Size: 16              Blocks: 8          IO Block: 4096   regular file
Device: fd00h/64768d    Inode: 7867821     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1657/  dslutz)   Gid: ( 1657/  dslutz)
Access: 2009-05-12 21:45:03.000000000 -0400
Modify: 2009-05-12 21:44:09.000000000 -0400
Change: 2009-05-12 21:44:09.000000000 -0400

And since the files are all in autocrlf=true

top:~/git-a/t/trash directory.t7610-mergetool>od -c file1
0000000   m   a   s   t   e   r       u   p   d   a   t   e   d  \r  \n
0000020
top:~/git-a/t/trash directory.t7610-mergetool>od -c file2
0000000   m   a   s   t   e   r       n   e   w  \r  \n
0000014
top:~/git-a/t/trash directory.t7610-mergetool>od -c subdir/file3
0000000   m   a   s   t   e   r       n   e   w       s   u   b  \r  \n
0000020
top:~/git-a/t/trash directory.t7610-mergetool>git        diff
diff --git a/subdir/file3 b/subdir/file3
index 54752ce..d31f871 100644
--- a/subdir/file3
+++ b/subdir/file3
@@ -1 +1 @@
-master new sub
+master new sub
top:~/git-a/t/trash directory.t7610-mergetool>git config core.autocrlf
false

and a touch of file1 will add it to the "git diff" output.

This is as far as I know how to get info.

clearly a "rm file1 file2 subdir/file3" before "git reset --hard" will 
fix things, but I think that "git diff" should always be
reporting on all 3 files, not randomly 0, 1, or 2 files.


  -Don

__________________________________________________________________________________________________________________
DISCLAIMER:"The information contained in this message and the attachments (if any) may be privileged and confidential and protected from disclosure. You are hereby notified that any unauthorized use, dissemination, distribution or copying of this communication, review, retransmission, or taking of any action based upon this information, by persons or entities other than the intended recipient, is strictly prohibited. If you are not the intended recipient or an employee or agent responsible for delivering this message, and have received this communication in error, please notify us immediately by replying to the message and kindly delete the original message, attachments, if any, and all its copies from your computer system. Thank you for your cooperation." 
________________________________________________________________________________________________________________
