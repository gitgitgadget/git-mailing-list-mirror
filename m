From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] [TOPGIT] make creating a commit from a topgit branch a function
Date: Wed, 14 Jan 2009 22:27:23 +0100
Message-ID: <1231968443-13960-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1231968443-13960-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@debian.org>, Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 22:29:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNDIW-0001jy-Jq
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 22:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbZANV1g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 16:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757463AbZANV1e
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 16:27:34 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57934 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756920AbZANV1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 16:27:33 -0500
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LNDGr-0001iX-7m; Wed, 14 Jan 2009 22:27:32 +0100
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1231968443-13960-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105704>

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
