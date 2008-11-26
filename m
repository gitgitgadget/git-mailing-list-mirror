From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] tg-export: add flag -n to get numbered patches
Date: Wed, 26 Nov 2008 22:17:35 +0100
Message-ID: <1227734255-30425-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@debian.org>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 22:19:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Rmw-000760-SC
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 22:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbYKZVRn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 16:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbYKZVRn
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 16:17:43 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47589 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbYKZVRm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 16:17:42 -0500
Received: from themisto.ext.pengutronix.de ([92.198.50.58] helo=localhost.localdomain)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <u.kleine-koenig@pengutronix.de>)
	id 1L5RlR-0003Cf-LG; Wed, 26 Nov 2008 22:17:40 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101769>

This eases sending the patches out in the right order using git
send-email.  Of course this only works nicely if all patches end in the
same directory (e.g. all dependant patches use the same prefix)

Note this patch depends a bit on my previous one that deprecates using
-n for not exporting empty patches.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: martin f. krafft <madduck@debian.org>
Cc: Petr Baudis <pasky@suse.cz>
---
 tg-export.sh |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index f133fb8..b667b82 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -7,6 +7,7 @@ name=3D
 branches=3D
 output=3D
 driver=3Dcollapse
+numbered=3Dfalse
=20
=20
 ## Parse options
@@ -20,6 +21,8 @@ while [ -n "$1" ]; do
 		driver=3Dquilt;;
 	--collapse)
 		driver=3Dcollapse;;
+	-n)
+		numbered=3Dtrue;;
 	-*)
 		echo "Usage: tg [...] export ([--collapse] NEWBRANCH | [-b BRANCH1,B=
RANCH2...] --quilt DIRECTORY)" >&2
 		exit 1;;
@@ -34,6 +37,9 @@ done
 [ -z "$branches" -o "$driver" =3D "quilt" ] ||
 	die "-b works only with the quilt driver"
=20
+[ "$driver" =3D "quilt" ] || ! "$numbered" ||
+	die "-n works only with the quilt driver"
+
 if [ -z "$branches" ]; then
 	# this check is only needed when no branches have been passed
 	name=3D"$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
@@ -134,19 +140,31 @@ quilt()
 		return
 	fi
=20
-	filename=3D"$output/$_dep.diff"
-	if [ -e "$filename" ]; then
+	if "$numbered"; then
+		number=3D$(printf "%04u" $((number + 1)))
+		bn=3D"$(basename "$_dep.diff")";
+		dn=3D"$(dirname "$_dep.diff")";
+		num_dep=3D"$dn/$number-$bn"
+	else
+		num_dep=3D"$_dep.diff";
+	fi
+	filename=3D"$output/$num_dep"
+
+	if [ -e "$playground/$_dep" ]; then
 		# We've already seen this dep
 		return
 	fi
=20
+	mkdir -p "$playground/$(dirname "$_dep")"
+	touch "$playground/$_dep"
+
 	if branch_empty "$_dep"; then
 		echo "Skip empty patch $_dep";
 	else
 		echo "Exporting $_dep"
 		mkdir -p "$(dirname "$filename")"
 		$tg patch "$_dep" >"$filename"
-		echo "$_dep.diff -p1" >>"$output/series"
+		echo "$num_dep.diff -p1" >>"$output/series"
 	fi
 }
=20
@@ -166,6 +184,8 @@ elif [ "$driver" =3D "quilt" ]; then
 		die "target directory already exists: $output"
=20
 	mkdir -p "$output"
+
+	number=3D"0000";
 fi
=20
=20
--=20
1.5.6.5
