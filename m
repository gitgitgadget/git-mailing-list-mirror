From: Eric Blake <ebb9@byu.net>
Subject: bug with .gitattributes diff and embedded NUL
Date: Tue, 18 Dec 2007 22:07:27 -0700
Message-ID: <4768A70F.8020904@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 06:04:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4r6z-0000J9-8v
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 06:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXLSFEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 00:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbXLSFEW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 00:04:22 -0500
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:35344
	"EHLO QMTA02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750696AbXLSFEV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 00:04:21 -0500
Received: from OMTA09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by QMTA02.westchester.pa.mail.comcast.net with comcast
	id SR8r1Y0050SCNGk050Ld00; Wed, 19 Dec 2007 05:04:19 +0000
Received: from [192.168.0.103] ([67.166.125.73])
	by OMTA09.westchester.pa.mail.comcast.net with comcast
	id SV4H1Y0071b8C2B3V00000; Wed, 19 Dec 2007 05:04:19 +0000
X-Authority-Analysis: v=1.0 c=1 a=mBAY3FxBtroA:10 a=IL53ShC4jU4M4qnDuboA:9 a=yNL3VbfnqP1fkdRjM--DcnjDyX8A:4 a=eDFNAWYWrCwA:10 a=XF7b4UCPwd8A:10
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68854>

The man page for gitattributes suggests that one use of the diff attribute
is to force text-based diffs, even when the file contains embedded NULs.
Yet actually trying this falls flat, since git generates invalid diffs
when encountering embedded NUL.

Here is a pared-down example showing the bug.  I based it off of what I
was trying to do in the git repository for GNU m4, where I was working on
adding testcases to make m4 seamlessly handle embedded NUL.

$ git --version
git version 1.5.4.rc0.67.gf9c5
$ mkdir sample
$ cd sample
$ git init
Initialized empty Git repository in .git/
$ printf 'context with\0embedded nul\nbefore\nmore context\n' > file
$ git add file
$ git commit -m initial
Created initial commit 25108f6: initial
 1 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file
$ git tag t1
$ sed -i 's/before/after/' file
$ git add file
$ git commit -m later
Created commit a5ee10c: later
 1 files changed, 0 insertions(+), 0 deletions(-)
$ git tag t2
$ git reset --hard t1
HEAD is now at 25108f6... initial
$ sed -i 's/more/some &/' file
$ echo 'file diff' > .gitattributes
$ git add .gitattributes file
$ git commit -m 'switch file to text mode'
Created commit 0f2a9b2: switch file to text mode
 2 files changed, 2 insertions(+), 1 deletions(-)
 create mode 100644 .gitattributes
$ git tag t3
$ git reset --hard t2
HEAD is now at a5ee10c... later
$ git rebase --onto t3 t1
First, rewinding head to replay your work on top of it...
HEAD is now at 0f2a9b2... switch file to text mode
Applying later
error: patch failed: file:1
error: file: patch does not apply
Using index info to reconstruct a base tree...
error: patch failed: file:1
error: file: patch does not apply
Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Cannot fall back to three-way merge.
Patch failed at 0001.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

Looking closer at .dotest/0001, the diff is indeed invalid, containing the
single line

 context with-before

instead of the desired two lines

 context with^@embedded nul
-before

I'm also wondering if using GIT_EXTERNAL_DIFF would provide a way to work
around this bug in git diff, since GNU diffutils doesn't seem to have any
problems when doing text-mode diffs with embedded NUL:

$ diff -u -a <(git show t1:file) <(git show t2:file) | cat -v
--- /dev/fd/63	2006-11-30 17:00:00.000000000 -0700
+++ /dev/fd/62	2006-11-30 17:00:00.000000000 -0700
@@ -1,3 +1,3 @@
 context with^@embedded nul
-before
+after
 more context

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
