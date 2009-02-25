From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] [TOPGIT] make creating a commit from a topgit branch a function
Date: Wed, 25 Feb 2009 21:03:59 +0100
Message-ID: <1235592240-12616-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090225195856.GA12372@pengutronix.de>
 <1235592240-12616-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1235592240-12616-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1235592240-12616-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 21:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcQ0w-0007ne-4p
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758327AbZBYUEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 15:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758324AbZBYUEM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:04:12 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45155 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758160AbZBYUEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 15:04:02 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0002li-B8
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0003I0-8L
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1235592240-12616-3-git-send-email-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111489>

This helps avoiding code duplication for the next commit.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 tg-export.sh |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 9e6940f..dea24d9 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -71,14 +71,11 @@ pretty_tree()
 	 git write-tree)
 }
=20
-# collapsed_commit NAME
-# Produce a collapsed commit of branch NAME.
-collapsed_commit()
+create_tg_commit()
 {
 	name=3D"$1"
-
-	rm -f "$playground/^pre" "$playground/^post"
-	>"$playground/^body"
+	tree=3D"$2"
+	parent=3D"$3"
=20
 	# Get commit message and authorship information
 	git cat-file blob "$name:.topmsg" | git mailinfo "$playground/^msg" /=
dev/null > "$playground/^info"
@@ -92,6 +89,20 @@ collapsed_commit()
 	test -n "$GIT_AUTHOR_EMAIL" && export GIT_AUTHOR_EMAIL
 	test -n "$GIT_AUTHOR_DATE" && export GIT_AUTHOR_DATE
=20
+	(printf '%s\n\n' "$SUBJECT"; cat "$playground/^msg") |
+	git stripspace |
+	git commit-tree "$tree" -p "$parent"
+}
+
+# collapsed_commit NAME
+# Produce a collapsed commit of branch NAME.
+collapsed_commit()
+{
+	name=3D"$1"
+
+	rm -f "$playground/^pre" "$playground/^post"
+	>"$playground/^body"
+
 	# Determine parent
 	parent=3D"$(cut -f 1 "$playground/$name^parents")"
 	if [ "$(cat "$playground/$name^parents" | wc -l)" -gt 1 ]; then
@@ -107,9 +118,7 @@ collapsed_commit()
 	if branch_empty "$name"; then
 		echo "$parent";
 	else
-		(printf '%s\n\n' "$SUBJECT"; cat "$playground/^msg") |
-		git stripspace |
-		git commit-tree "$(pretty_tree "$name")" -p "$parent"
+		create_tg_commit "$name" "$(pretty_tree $name)" "$parent"
 	fi;
=20
 	echo "$name" >>"$playground/^ticker"
--=20
1.5.6.5
