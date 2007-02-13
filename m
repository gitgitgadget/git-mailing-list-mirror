From: Michael Spang <mcspang@gmail.com>
Subject: Re: git-svn test suite failures due to Subversion race
Date: Mon, 12 Feb 2007 21:34:04 -0500
Message-ID: <45D1239C.4040706@gmail.com>
References: <45CFDFDE.8080907@uwaterloo.ca> <20070212103822.GA21413@localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060109010103010403020005"
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 03:34:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGnUk-0002VY-EH
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 03:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965474AbXBMCeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 21:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965475AbXBMCeJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 21:34:09 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:14842 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965474AbXBMCeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 21:34:07 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1828659nze
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 18:34:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=QAo/uGi+hKdyBEbM46d6+bNvg07DOYDhuEC4M1/2X7p4YVOKXmmztqYYUYaYPevWxvgtYZHBVdJfDn8rk3LcA35upumg7bEs50dmWJb3H98QQ7NUO8BoqW7liQTp0iJfqyiAgpaBYSY7+tRXKOa5GKkJ6OptpLcDlaMclaR7dPU=
Received: by 10.65.84.6 with SMTP id m6mr10840526qbl.1171334045966;
        Mon, 12 Feb 2007 18:34:05 -0800 (PST)
Received: from ?192.168.0.11? ( [74.108.158.132])
        by mx.google.com with ESMTP id e17sm3228977qbe.2007.02.12.18.34.04;
        Mon, 12 Feb 2007 18:34:05 -0800 (PST)
User-Agent: Icedove 1.5.0.9 (X11/20061220)
In-Reply-To: <20070212103822.GA21413@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39482>

This is a multi-part message in MIME format.
--------------060109010103010403020005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Eric Wong wrote:
> This is disconcerting.  Given that hardware is still getting faster, I
> suspect there will be many more problems with the svn tests in the
> future.  I have no plans for upgrading hardware in the near future; so I
> won't be hitting these problems myself.
>
> I'm alright with adding the `sleep 1` in several more places where this
> can be an issue.  If it gets bad enough for people with slower
> computers, I'll probably just create a function that sleeps only if a
> variable is not set (TOO_SLOW_TO_RACE=1 :)
>
> I've been considering rewriting the tests to use the Perl SVN::
> libraries exclusively; but that runs the risk of introducing new bugs.
>   

I've prepared a somewhat cleaner patch that solves the problem without
using sleep. It increases the modification time by one second
immediately prior to each commit. I added calls everywhere I think the
problem could potentially occur.

I've had no failures with the patch (without it, they are quite frequent).

Cheers,
Michael Spang

--------------060109010103010403020005
Content-Type: text/x-patch;
 name="0001-Work-around-Subversion-race-in-git-svn-tests.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Work-around-Subversion-race-in-git-svn-tests.patch"

>From f3a86250469df6607b71da235ac69ccb82d59fd9 Mon Sep 17 00:00:00 2001
From: Michael Spang <mspang@uwaterloo.ca>
Date: Mon, 12 Feb 2007 19:33:37 -0500
Subject: [PATCH] Work around Subversion race in git-svn tests.

Some of the git-svn tests can fail on fast machines due to a race in
Subversion: if a file is modified in the same second it was checked out
(or in for that matter), Subversion will not consider it modified. This
works around the problem by increasing the timestamp by one second
before each commit.

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---
 t/lib-git-svn.sh                       |    3 +++
 t/t9101-git-svn-props.sh               |    7 +++++--
 t/t9103-git-svn-graft-branches.sh      |    1 +
 t/t9104-git-svn-follow-parent.sh       |    2 ++
 t/t9106-git-svn-commit-diff-clobber.sh |    2 ++
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index bb1d7b8..71e8010 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -45,3 +45,6 @@ fi
 svnrepo="file://$svnrepo"
 
 
+poke() {
+	touch -r "$1" -d +1sec "$1"
+}
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index a2c4dc3..e8133d8 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -56,11 +56,14 @@ test_expect_success 'checkout working copy from svn' "svn co $svnrepo test_wc"
 test_expect_success 'setup some commits to svn' \
 	'cd test_wc &&
 		echo Greetings >> kw.c &&
+		poke kw.c &&
 		svn commit -m "Not yet an Id" &&
 		echo Hello world >> kw.c &&
+		poke kw.c &&
 		svn commit -m "Modified file, but still not yet an Id" &&
 		svn propset svn:keywords Id kw.c &&
-		svn commit -m "Propset Id"
+		poke kw.c &&
+		svn commit -m "Propset Id" &&
 	cd ..'
 
 test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
@@ -83,7 +86,7 @@ test_expect_success "propset CR on crlf files" \
 		svn propset svn:eol-style CR empty &&
 		svn propset svn:eol-style CR crlf &&
 		svn propset svn:eol-style CR ne_crlf &&
-		svn commit -m "propset CR on crlf files"
+		svn commit -m "propset CR on crlf files" &&
 	 cd ..'
 
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
diff --git a/t/t9103-git-svn-graft-branches.sh b/t/t9103-git-svn-graft-branches.sh
index 4e55778..183ae3b 100755
--- a/t/t9103-git-svn-graft-branches.sh
+++ b/t/t9103-git-svn-graft-branches.sh
@@ -16,6 +16,7 @@ test_expect_success 'initialize repo' "
 	svn co $svnrepo wc &&
 	cd wc &&
 	echo feedme >> branches/a/readme &&
+	poke branches/a/readme &&
 	svn commit -m hungry &&
 	cd trunk &&
 	svn merge -r3:4 $svnrepo/branches/a &&
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 8d2e2fe..405b555 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -16,11 +16,13 @@ test_expect_success 'initialize repo' "
 	svn co $svnrepo wc &&
 	cd wc &&
 	echo world >> trunk/readme &&
+	poke trunk/readme &&
 	svn commit -m 'another commit' &&
 	svn up &&
 	svn mv -m 'rename to thunk' trunk thunk &&
 	svn up &&
 	echo goodbye >> thunk/readme &&
+	poke thunk/readme &&
 	svn commit -m 'bye now' &&
 	cd ..
 	"
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 59b6425..6f132f2 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -18,6 +18,7 @@ test_expect_success 'commit change from svn side' "
 	svn co $svnrepo t.svn &&
 	cd t.svn &&
 	echo second line from svn >> file &&
+	poke file &&
 	svn commit -m 'second line from svn' &&
 	cd .. &&
 	rm -rf t.svn
@@ -45,6 +46,7 @@ test_expect_failure 'dcommit fails to commit because of conflict' "
 	svn co $svnrepo t.svn &&
 	cd t.svn &&
 	echo fourth line from svn >> file &&
+	poke file &&
 	svn commit -m 'fourth line from svn' &&
 	cd .. &&
 	rm -rf t.svn &&
-- 
1.5.0.rc4.26.gcc46a


--------------060109010103010403020005--
