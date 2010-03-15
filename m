From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/5] t/t1304: use 'test -r' to test readability rather than looking at mode bits
Date: Mon, 15 Mar 2010 12:14:35 -0500
Message-ID: <YowxgPZqaOkg2MZzY1CxL61O63C5ULimj64t69Bc-wsW3IlWf4Zc9WmA3ihonAb8UtR5thcko00@cipher.nrlssc.navy.mil>
References: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
Cc: Matthieu.Moy@imag.fr, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 18:16:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDtV-0004dk-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965527Ab0CORPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:15:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43472 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965521Ab0CORPU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:15:20 -0400
Received: by mail.nrlssc.navy.mil id o2FHF9Jd002251; Mon, 15 Mar 2010 12:15:09 -0500
In-Reply-To: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 15 Mar 2010 17:15:09.0467 (UTC) FILETIME=[10B64EB0:01CAC463]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142232>

From: Brandon Casey <drafnel@gmail.com>

This test was using the group read permission bit as an indicator of the
default ACL mask.  This behavior is valid on Linux but not on other
platforms like Solaris.  So, rather than looking at mode bits, just test
readability for the user.  This, along with the checks for the existence
of the ACL's that were set on the parent directories, should be enough.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t1304-default-acl.sh |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 3a1532b..52246d7 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -20,21 +20,8 @@ if ! setfacl -m u:root:rwx .; then
     test_done
 fi
 
-modebits () {
-	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
-}
-
 check_perms_and_acl () {
-	actual=$(modebits "$1") &&
-	case "$actual" in
-	-r--r-----*)
-		: happy
-		;;
-	*)
-		echo "Got permission '$actual', expected '-r--r-----'"
-		false
-		;;
-	esac &&
+	test -r "$1" &&
 	getfacl "$1" > actual &&
 	grep -q "user:root:rwx" actual &&
 	grep -q "user:${LOGNAME}:rwx" actual &&
-- 
1.6.6.2
