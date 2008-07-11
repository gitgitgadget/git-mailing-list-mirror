From: Petr Baudis <pasky@suse.cz>
Subject: [PATCHv3] Fix backwards-incompatible handling of core.sharedRepository
Date: Sat, 12 Jul 2008 01:45:00 +0200
Message-ID: <20080711234257.16449.85447.stgit@rover.dkm.cz>
References: <20080711233841.30916.75885.stgit@rover.dkm.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Heikki Orsila <heikki.orsila@iki.fi>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:47:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHSKT-0002wp-4E
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 01:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYGKXqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 19:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYGKXqL
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 19:46:11 -0400
Received: from rover.dkm.cz ([62.24.64.27]:40128 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbYGKXqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 19:46:10 -0400
Received: from rover.dkm.cz (localhost [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 123D0166748;
	Sat, 12 Jul 2008 01:45:00 +0200 (CEST)
In-Reply-To: <20080711233841.30916.75885.stgit@rover.dkm.cz>
User-Agent: StGIT/0.14.3.171.ge0e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88206>

The 06cbe8550324e0fd2290839bf3b9a92aa53b70ab core.sharedRepository
handling extension broke backwards compatibility; before, shared=1 meant
that Git merely ensured the repository is group-writable, not that it's
_only_ group-writable, which is the current behaviour. Thus, with umask 002,
Git creates repository with /rw.rw.--./, this patch fixes it back to
/rw.rw.r-./.

Maybe it makes sense to provide the current semantics in some way too,
but that cannot be done at the expense of ditching backwards
compatibility; this bug has just wasted me two hours and broke
repo.or.cz pushing for several hours.

Cc: Heikki Orsila <heikki.orsila@iki.fi>
Signed-off-by: Petr Baudis <pasky@rover.dkm.cz>
---

  Oops, this testcase wouldn't really remove its test subrepository
after itself properly, though the testsuite would still pass; of course
this bug slipped through all the previous visual inspections of mine.

  Sorry for the continuous noise. :-)

 path.c                 |    2 +-
 t/t1301-shared-repo.sh |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletions(-)


diff --git a/path.c b/path.c
index 5983255..75c5915 100644
--- a/path.c
+++ b/path.c
@@ -269,7 +269,7 @@ int adjust_shared_perm(const char *path)
 	mode = st.st_mode;
 
 	if (shared_repository) {
-		int tweak = shared_repository;
+		int tweak = (mode & 0777) | shared_repository;
 		if (!(mode & S_IWUSR))
 			tweak &= ~0222;
 		mode = (mode & ~0777) | tweak;
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 6c78c8b..3fe485c 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -17,6 +17,26 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 	test $ret != "0"
 '
 
+test_expect_success 'shared=1 does not override sane umask' '
+	mkdir sub &&
+	cd sub &&
+	umask 002 &&
+	git init --shared=1 &&
+	test 1 = $(git config core.sharedrepository) &&
+	actual="$(ls -l .git/HEAD)" &&
+	cd .. &&
+	rm -rf sub &&
+	case "$actual" in
+	-rw-rw-r--*)
+		: happy
+		;;
+	*)
+		echo Oops, .git/HEAD is not 0664 but $actual
+		false
+		;;
+	esac
+'
+
 test_expect_success 'shared=all' '
 	mkdir sub &&
 	cd sub &&
