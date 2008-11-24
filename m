From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] tg export: implement skipping empty patches for quilt mode
Date: Mon, 24 Nov 2008 22:56:50 +0100
Message-ID: <1227563810-5426-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@debian.org>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 23:29:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4jvc-0004bu-1W
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 23:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbYKXW1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2008 17:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbYKXW1z
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 17:27:55 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53871 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYKXW1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 17:27:54 -0500
X-Greylist: delayed 1843 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Nov 2008 17:27:53 EST
Received: from themisto.ext.pengutronix.de ([92.198.50.58] helo=localhost.localdomain)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <u.kleine-koenig@pengutronix.de>)
	id 1L4jQK-0007v9-NM; Mon, 24 Nov 2008 22:57:08 +0100
X-Mailer: git-send-email 1.5.6.5
X-SA-Exim-Connect-IP: 92.198.50.58
X-SA-Exim-Mail-From: u.kleine-koenig@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=4.5 tests=BAYES_00,HELO_LH_LD,
	RCVD_IN_PBL shortcircuit=no autolearn=no version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101630>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: martin f. krafft <madduck@debian.org>
Cc: Petr Baudis <pasky@suse.cz>
---
 tg-export.sh |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 52af88d..6f1d226 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -7,6 +7,7 @@ name=3D
 branches=3D
 output=3D
 driver=3Dcollapse
+skipempty=3Dfalse
=20
=20
 ## Parse options
@@ -20,6 +21,8 @@ while [ -n "$1" ]; do
 		driver=3Dquilt;;
 	--collapse)
 		driver=3Dcollapse;;
+	-n)
+		skipempty=3Dtrue;;
 	-*)
 		echo "Usage: tg [...] export ([--collapse] NEWBRANCH | [-b BRANCH1,B=
RANCH2...] --quilt DIRECTORY)" >&2
 		exit 1;;
@@ -34,6 +37,9 @@ done
 [ -z "$branches" -o "$driver" =3D "quilt" ] ||
 	die "-b works only with the quilt driver"
=20
+! "$skipempty" || [ "$driver" =3D "quilt" ] ||
+	die "-n is only implemented for the quilt driver"
+
 if [ -z "$branches" ]; then
 	# this check is only needed when no branches have been passed
 	name=3D"$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
@@ -140,10 +146,14 @@ quilt()
 		return
 	fi
=20
-	echo "Exporting $_dep"
-	mkdir -p "$(dirname "$filename")"
-	$tg patch "$_dep" >"$filename"
-	echo "$_dep.diff -p1" >>"$output/series"
+	if "$skipempty" && branch_empty "$_dep"; then
+		echo "Skip empty patch $_dep";
+	else
+		echo "Exporting $_dep"
+		mkdir -p "$(dirname "$filename")"
+		$tg patch "$_dep" >"$filename"
+		echo "$_dep.diff -p1" >>"$output/series"
+	fi
 }
=20
=20
--=20
1.5.6.5
