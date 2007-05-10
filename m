From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of
 builtin-push.
Date: Thu, 10 May 2007 03:45:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705100328260.18541@iabervon.org>
References: <Pine.LNX.4.64.0705092203130.18541@iabervon.org>
 <7vhcqlma1l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 09:45:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm3LL-0008Tl-Kp
	for gcvg-git@gmane.org; Thu, 10 May 2007 09:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758168AbXEJHpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 03:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758011AbXEJHpf
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 03:45:35 -0400
Received: from iabervon.org ([66.92.72.58]:4720 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361AbXEJHpe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 03:45:34 -0400
Received: (qmail 3694 invoked by uid 1000); 10 May 2007 07:45:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 May 2007 07:45:33 -0000
In-Reply-To: <7vhcqlma1l.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46838>

On Thu, 10 May 2007, Junio C Hamano wrote:

> This seems to break t9400, with "fatal: bad repository 'gitcvs.git",
> upon "git push".
> 
> : gitster t/db/remote; sh t9400-git-cvsserver-server.sh -i -v
> * expecting success: cvs -Q co -d cvswork master &&
>    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"
> cvs checkout: Updating cvswork
> U cvswork/empty
> *   ok 1: basic checkout
> 
> * expecting success: echo testfile1 >testfile1 &&
>    git add testfile1 &&
>    git commit -q -m "Add testfile1" &&
>    git push gitcvs.git >/dev/null &&

The man page doesn't think this is valid, since it only claims absolute 
paths to work for local repositories. (Current builtin-push seems to be 
sloppy; it has the die() that triggers in my version, but its 
read_config() always returns a value that doesn't trigger it, suggesting 
that there's some sort of bug.)

Following patch fixes t9400 to use absolute paths (assuming that's what it 
expects "git push gitcvs.git" to mean).

=== cut here ===
Local repository names for git-push are only documented with absolute 
paths, even though current git-push is lenient. Use an absolute path in 
t9400-git-cvsserver-server.sh.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index f17be6b..178b9b4 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -45,7 +45,7 @@ test_expect_success 'cvs update (create new file)' \
   'echo testfile1 >testfile1 &&
    git add testfile1 &&
    git commit -q -m "Add testfile1" &&
-   git push gitcvs.git >/dev/null &&
+   git push $(pwd)/gitcvs.git >/dev/null &&
    cd cvswork &&
    cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
@@ -56,7 +56,7 @@ test_expect_success 'cvs update (update existing file)' \
   'echo line 2 >>testfile1 &&
    git add testfile1 &&
    git commit -q -m "Append to testfile1" &&
-   git push gitcvs.git >/dev/null &&
+   git push $(pwd)/gitcvs.git >/dev/null &&
    cd cvswork &&
    cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.2/" &&
@@ -69,7 +69,7 @@ test_expect_failure "cvs update w/o -d doesn't create subdir (TODO)" \
    echo >test/empty &&
    git add test &&
    git commit -q -m "Single Subdirectory" &&
-   git push gitcvs.git >/dev/null &&
+   git push $(pwd)/gitcvs.git >/dev/null &&
    cd cvswork &&
    cvs -Q update &&
    test ! -d test'
@@ -82,7 +82,7 @@ test_expect_success 'cvs update (subdirectories)' \
       git add $dir;
    done) &&
    git commit -q -m "deep sub directory structure" &&
-   git push gitcvs.git >/dev/null &&
+   git push $(pwd)/gitcvs.git >/dev/null &&
    cd cvswork &&
    cvs -Q update -d &&
    (for dir in A A/B A/B/C A/D E; do
@@ -100,7 +100,7 @@ cd "$WORKDIR"
 test_expect_success 'cvs update (delete file)' \
   'git rm testfile1 &&
    git commit -q -m "Remove testfile1" &&
-   git push gitcvs.git >/dev/null &&
+   git push $(pwd)/gitcvs.git >/dev/null &&
    cd cvswork &&
    cvs -Q update &&
    test -z "$(grep testfile1 CVS/Entries)" &&
@@ -111,7 +111,7 @@ test_expect_success 'cvs update (re-add deleted file)' \
   'echo readded testfile >testfile1 &&
    git add testfile1 &&
    git commit -q -m "Re-Add testfile1" &&
-   git push gitcvs.git >/dev/null &&
+   git push $(pwd)/gitcvs.git >/dev/null &&
    cd cvswork &&
    cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.4/" &&
