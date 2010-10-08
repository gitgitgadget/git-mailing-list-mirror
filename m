From: =?UTF-8?q?Andreas=20K=C3=B6hler?= <andi5.py@gmx.net>
Subject: [PATCH] submodule sync: Update "submodule.<name>.url" for empty directories
Date: Fri,  8 Oct 2010 03:07:48 +0200
Message-ID: <1286500068-31345-1-git-send-email-andi5.py@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Andreas=20K=C3=B6hler?= <andi5.py@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 03:12:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P41VJ-0006Kq-TP
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 03:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283Ab0JHBH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 21:07:57 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:55876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751014Ab0JHBH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 21:07:57 -0400
Received: (qmail invoked by alias); 08 Oct 2010 01:07:55 -0000
Received: from g230243026.adsl.alicedsl.de (EHLO localhost.localdomain) [92.230.243.26]
  by mail.gmx.net (mp070) with SMTP; 08 Oct 2010 03:07:55 +0200
X-Authenticated: #15850232
X-Provags-ID: V01U2FsdGVkX1+MWDMNBiiMoJMX/EvdHdaQQJlgpJ5IlCF8ncO0Ga
	6UUv9cKrq4CS3L
X-Mailer: git-send-email 1.7.0.4
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158468>

If a submodule directory has not been filled by "git submodule update"
yet, then "git submodule sync" must still update the super-project's
configuration for submodule.<name>.url.

This situation occurs when switching between branches with a module fro=
m
different urls and other branches without the submodule.

Signed-off-by: Andreas K=C3=B6hler <andi5.py@gmx.net>
---
 git-submodule.sh          |    5 +++--
 t/t7403-submodule-sync.sh |   12 +++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9ebbab7..c291eed 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -836,11 +836,12 @@ cmd_sync()
 			;;
 		esac
=20
+		say "Synchronizing submodule url for '$name'"
+		git config submodule."$name".url "$url"
+
 		if test -e "$path"/.git
 		then
 		(
-			say "Synchronizing submodule url for '$name'"
-			git config submodule."$name".url "$url"
 			clear_local_git_env
 			cd "$path"
 			remote=3D$(get_default_remote)
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 02522f9..e5b1953 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -23,7 +23,9 @@ test_expect_success setup '
 	 git commit -m "submodule"
 	) &&
 	git clone super super-clone &&
-	(cd super-clone && git submodule update --init)
+	(cd super-clone && git submodule update --init) &&
+	git clone super empty-clone &&
+	(cd empty-clone && git submodule init)
 '
=20
 test_expect_success 'change submodule' '
@@ -64,4 +66,12 @@ test_expect_success '"git submodule sync" should upd=
ate submodule URLs' '
 	)
 '
=20
+test_expect_success '"git submodule sync" should update submodule URLs=
 if not yet cloned' '
+	(cd empty-clone &&
+	 git pull &&
+	 git submodule sync &&
+	 test -d "$(git config submodule.submodule.url)"
+	)
+'
+
 test_done
--=20
1.7.0.4
