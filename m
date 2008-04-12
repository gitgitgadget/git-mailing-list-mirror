From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Remove broken branch creation subtest
Date: Sat, 12 Apr 2008 14:44:15 +0200
Message-ID: <20080412124212.27748.21332.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 14:45:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkf6Y-0006rM-6p
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 14:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757964AbYDLMo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 08:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759132AbYDLMo2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 08:44:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1624 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757786AbYDLMo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 08:44:27 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jkf5c-0003h7-00; Sat, 12 Apr 2008 13:44:16 +0100
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79351>

This subtest has started to cause subsequent subtests to fail with
recent versions of git. And I don't think we can blame this one on
git. What the subtest does is:

  1. Remove all files or directories called "foo" under .git/. This is
     supposed to delete the "foo" branch and associated StGit files,
     but what about packed refs? This isn't actually malfunctioning
     yet as far as I can tell, but it's a ticking bomb.

  2. Create an empty file .git/refs/heads/foo. This is supposed to be
     a "broken branch", and indeed it is -- for example, git show-ref
     barfs on such a repository even if asked to only show a branch
     other than foo!

  3. Makes sure that stg branch won't successfully create a "foo"
     branch. I'm pretty sure this fails because git thinks the repo is
     broken, not because stg handles it gracefully. This is what the
     test is supposed to be testing, but if we wanted that, we'd need
     a more detailed test.

  4. Doesn't clean up the broken ref, which causes some subsequent
     subtests to fail.

What probably happened is that git got ever so slightly fussier about
broken refs, so that (4) became a problem.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

This should go to the stable branch. (master is affected too, but a
merge will fix that.)

 t/t1000-branch-create.sh |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)


diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
index d6cf34a..298eb1a 100755
--- a/t/t1000-branch-create.sh
+++ b/t/t1000-branch-create.sh
@@ -54,13 +54,6 @@ test_expect_success \
 '
=20
 test_expect_success \
-    'Create an invalid refs/heads/ entry' '
-    find .git -name foo | xargs rm -rf &&
-    touch .git/refs/heads/foo &&
-    ! stg branch -c foo
-'
-
-test_expect_success \
     'Setup two commits including removal of generated files' '
     git init &&
     touch a.c a.o &&
