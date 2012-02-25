From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] am: don't infloop for an empty input file
Date: Sat, 25 Feb 2012 18:34:26 +0100
Message-ID: <87399y24wt.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 25 18:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1LWS-0003E8-8x
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 18:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296Ab2BYReg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 12:34:36 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:49406 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756589Ab2BYRef (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 12:34:35 -0500
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 68604D48049
	for <git@vger.kernel.org>; Sat, 25 Feb 2012 18:34:28 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id BB30860052
	for <git@vger.kernel.org>; Sat, 25 Feb 2012 18:34:26 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191539>

Today, "git am" surprised me.
I mistakenly ran it on an empty file and it went into an infinite loop.

  : > e && git am e

To fix it, I made a failing bourne shell "read" break out
of the offending loop.  Looking through git-am.sh for other
instances, I did find one, but didn't try to address it here.


	    action=again
	    while test "$action" = again
	    do
		gettextln "Commit Body is:"
		echo "--------------------------"
		cat "$dotest/final-commit"
		echo "--------------------------"
		# TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
		# in your translation. The program will only accept English
		# input at this point.
		gettext "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
may infloop->	read reply
		case "$reply" in

In that case (when someone hits ^D in response to that prompt?),
you may want to exit altogether.

In the test addition, I didn't try to handle potentially-inflooping code.
In coreutils tests, it's easy (since it includes the timeout program):
I would just prefix the command with something like "timeout 10", but
the timeout command is not universally available.  And besides, the
infloop is supposed to be fixed, now.

Here's a patch for the infloop I triggered:
[Noticed with and tested against master v1.7.9.2-262-gba998d3,
 but seems to apply also to maint. ]

-- >8 --

git-am.sh's check_patch_format function would attempt to preview
the patch to guess its format, but would go into an infinite loop
when the patch file happened to be empty.  The solution: exit the
loop when "read" fails, not when the line var, "$l1" becomes empty.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 git-am.sh     |    2 +-
 t/t4150-am.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 64d8e2a..906f91f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -202,7 +202,7 @@ check_patch_format () {
 		l1=
 		while test -z "$l1"
 		do
-			read l1
+			read l1 || break
 		done
 		read l2
 		read l3
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index f1b60b8..6f77fff 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -505,4 +505,14 @@ test_expect_success 'am -q is quiet' '
 	! test -s output.out
 '

+test_expect_success 'am empty-file does not infloop' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	touch empty-file &&
+	test_tick &&
+	{ git am empty-file > actual 2>&1 && false || :; } &&
+	echo Patch format detection failed. >expected &&
+	test_cmp expected actual
+'
+
 test_done
--
1.7.9.2.263.g9be8b7
