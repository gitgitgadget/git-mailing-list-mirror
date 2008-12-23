From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH TOPGIT] tg export: Implement flattening patch paths for quilt mode
Date: Tue, 23 Dec 2008 15:32:23 +0100
Message-ID: <1230042744-24675-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20081223143035.GA24087@cassiopeia.tralala>
 <1230042744-24675-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@debian.org>, Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 15:34:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF8Kn-0006FE-G6
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 15:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbYLWOcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2008 09:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbYLWOcu
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 09:32:50 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55297 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYLWOcu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 09:32:50 -0500
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LF8JD-0006Mo-TE; Tue, 23 Dec 2008 15:32:49 +0100
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1230042744-24675-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.5 tests=AWL,BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103823>

The result of providing the new flag -f is that the exported patches ar=
e
all placed directly in the output directory, not in subdirectories.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 tg-export.sh |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 95aa346..06b9c8d 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -7,6 +7,7 @@ name=3D
 branches=3D
 output=3D
 driver=3Dcollapse
+flatten=3Dfalse
=20
=20
 ## Parse options
@@ -16,6 +17,8 @@ while [ -n "$1" ]; do
 	case "$arg" in
 	-b)
 		branches=3D"$1"; shift;;
+	-f)
+		flatten=3Dtrue;;
 	--quilt)
 		driver=3Dquilt;;
 	--collapse)
@@ -34,6 +37,9 @@ done
 [ -z "$branches" -o "$driver" =3D "quilt" ] ||
 	die "-b works only with the quilt driver"
=20
+[ "$driver" =3D "quilt" ] || ! "$flatten" ||
+	die "-f works only with the quilt driver"
+
 if [ -z "$branches" ]; then
 	# this check is only needed when no branches have been passed
 	name=3D"$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
@@ -138,7 +144,18 @@ quilt()
 		return
 	fi
=20
-	filename=3D"$output/$_dep.diff"
+	if "$flatten"; then
+		bn=3D"$(echo "$_dep.diff" | sed -e 's#_#__#g' -e 's#/#_#g')";
+		dn=3D"";
+	else
+		bn=3D"$(basename "$_dep.diff")";
+		dn=3D"$(dirname "$_dep.diff")/";
+		if [ "x$dn" =3D "x./" ]; then
+			dn=3D"";
+		fi;
+	fi;
+
+	filename=3D"$output/$dn$bn";
 	if [ -e "$filename" ]; then
 		# We've already seen this dep
 		return
@@ -148,9 +165,9 @@ quilt()
 		echo "Skip empty patch $_dep";
 	else
 		echo "Exporting $_dep"
-		mkdir -p "$(dirname "$filename")"
+		mkdir -p "$output/$dn";
 		$tg patch "$_dep" >"$filename"
-		echo "$_dep.diff -p1" >>"$output/series"
+		echo "$dn$bn -p1" >>"$output/series"
 	fi
 }
=20
--=20
1.5.6.5
