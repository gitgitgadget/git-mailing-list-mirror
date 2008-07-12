From: Petr Baudis <pasky@suse.cz>
Subject: [PATCHv4] Fix backwards-incompatible handling of core.sharedRepository
Date: Sat, 12 Jul 2008 03:15:03 +0200
Message-ID: <20080712011231.19745.48052.stgit@rover.dkm.cz>
References: <7vhcawhs1e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Heikki Orsila <heikki.orsila@iki.fi>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 03:17:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHTjc-0003pM-J0
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 03:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbYGLBQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 21:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbYGLBQO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 21:16:14 -0400
Received: from rover.dkm.cz ([62.24.64.27]:36281 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbYGLBQO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 21:16:14 -0400
Received: from rover.dkm.cz (localhost [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id A5950166748;
	Sat, 12 Jul 2008 03:15:03 +0200 (CEST)
In-Reply-To: <7vhcawhs1e.fsf@gitster.siamese.dyndns.org>
User-Agent: StGIT/0.14.3.171.ge0e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88213>

06cbe85 (Make core.sharedRepository more generic, 2008-04-16) broke the
traditional setting of core.sharedRepository to true, which was to make
the repository group writable: with umask 022, it would clear the
permission bits for 'other'. (umask 002 did not exhibit this behaviour
since pre-chmod() check in adjust_shared_perm() fails in that case.)

The call to adjust_shared_perm() should only loosen the permission.
If the user has umask like 022 or 002 that allow others to read, the
resulting files should be made readable and writable by group, without
restricting the readability by others.

This patch fixes the adjust_shared_perm() mode tweak based on Junio's
suggestion and adds the appropriate tests to t/t1301-shared-repo.sh.

Cc: Heikki Orsila <heikki.orsila@iki.fi>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  Fourth iteration. The problem is in fact triggered with umask 022,
not 002; fixed the description and extended the testsuite appropriately.
Improved patch description as well as the adjust_shared_perm() fix based
on Junio's suggestions here and on #git, so by now it's more of his
patch than mine. :-)

 path.c                 |    2 +-
 t/t1301-shared-repo.sh |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletions(-)


diff --git a/path.c b/path.c
index 5983255..504eae0 100644
--- a/path.c
+++ b/path.c
@@ -272,7 +272,7 @@ int adjust_shared_perm(const char *path)
 		int tweak = shared_repository;
 		if (!(mode & S_IWUSR))
 			tweak &= ~0222;
-		mode = (mode & ~0777) | tweak;
+		mode |= tweak;
 	} else {
 		/* Preserve old PERM_UMASK behaviour */
 		if (mode & S_IWUSR)
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 6c78c8b..4c6d0b6 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -17,6 +17,28 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 	test $ret != "0"
 '
 
+for u in 002 022; do
+	test_expect_success "shared=1 does not clear bits preset by umask $u" '
+		mkdir sub &&
+		cd sub &&
+		umask $u &&
+		git init --shared=1 &&
+		test 1 = $(git config core.sharedrepository) &&
+		actual="$(ls -l .git/HEAD)" &&
+		cd .. &&
+		rm -rf sub &&
+		case "$actual" in
+		-rw-rw-r--*)
+			: happy
+			;;
+		*)
+			echo Oops, .git/HEAD is not 0664 but $actual
+			false
+			;;
+		esac
+	'
+done
+
 test_expect_success 'shared=all' '
 	mkdir sub &&
 	cd sub &&
