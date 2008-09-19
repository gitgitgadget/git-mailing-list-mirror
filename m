From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@strlen.de>
Subject: [PATCH] [TOPGIT] Use git-mailinfo to extract author informations from .topmsg
Date: Fri, 19 Sep 2008 23:27:57 +0200
Message-ID: <1221859677-8558-1-git-send-email-ukleinek@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 23:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgnXO-0003aB-Hn
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 23:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbYISV2G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 17:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbYISV2F
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 17:28:05 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:56407 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751263AbYISV2E (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2008 17:28:04 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1KgnWD-0003Xr-7M; Fri, 19 Sep 2008 23:28:01 +0200
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96317>

This has the benefit that the [PATCH] prefixes are stripped and so it
might help to prevent you sending mails with two prefixes.  (As happend
to me after I git-format-patch'd an exported series and sent it out wit=
h
git-send-email.)

Moreover it should make the code more robust and it allows to remove a
helper function.
And it allows you to set add a Date: line to .topmsg which is then used
as author date.

Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@strlen.de>
---
 tg-export.sh |   45 +++++++++++++--------------------------------
 1 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 654b38b..335f698 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -38,17 +38,6 @@ trap 'rm -rf "$playground"' EXIT
=20
 ## Collapse driver
=20
-# Trusty Cogito code:
-load_author()
-{
-	if [ -z "$GIT_AUTHOR_NAME" ] && echo "$1" | grep -q '^[^< ]'; then
-		export GIT_AUTHOR_NAME=3D"$(echo "$1" | sed 's/ *<.*//')"
-	fi
-	if [ -z "$GIT_AUTHOR_EMAIL" ] && echo "$1" | grep -q '<.*>'; then
-		export GIT_AUTHOR_EMAIL=3D"$(echo "$1" | sed 's/.*<\(.*\)>.*/\1/')"
-	fi
-}
-
 # pretty_tree NAME
 # Output tree ID of a cleaned-up tree without tg's artifacts.
 pretty_tree()
@@ -69,19 +58,16 @@ collapsed_commit()
 	>"$playground/^body"
=20
 	# Get commit message and authorship information
-	git cat-file blob "$name:.topmsg" >"$playground/^msg"
-	while read line; do
-		if [ -z "$line" ]; then
-			# end of header
-			cat >"$playground/^body"
-			break
-		fi
-		case "$line" in
-		From:*) load_author "${line#From: }";;
-		Subject:*) echo "${line#Subject: }" >>"$playground/^pre";;
-		*) echo "$line" >>"$playground/^post";;
-		esac
-	done <"$playground/^msg"
+	git cat-file blob "$name:.topmsg" | git mailinfo "$playground/^msg" /=
dev/null > "$playground/^info"
+
+	GIT_AUTHOR_NAME=3D"$(sed -n '/^Author/ s/Author: //p' "$playground/^i=
nfo")"
+	GIT_AUTHOR_EMAIL=3D"$(sed -n '/^Email/ s/Email: //p' "$playground/^in=
fo")"
+	GIT_AUTHOR_DATE=3D"$(sed -n '/^Date/ s/Date: //p' "$playground/^info"=
)"
+	SUBJECT=3D"$(sed -n '/^Subject/ s/Subject: //p' "$playground/^info")"
+
+	test -n "$GIT_AUTHOR_NAME" && export GIT_AUTHOR_NAME
+	test -n "$GIT_AUTHOR_EMAIL" && export GIT_AUTHOR_EMAIL
+	test -n "$GIT_AUTHOR_DATE" && export GIT_AUTHOR_DATE
=20
 	# Determine parent
 	parent=3D"$(cut -f 1 "$playground/$name^parents")"
@@ -95,14 +81,9 @@ collapsed_commit()
 			$(for p in $parent; do echo -p $p; done))"
 	fi
=20
-	{
-		if [ -s "$playground/^pre" ]; then
-			cat "$playground/^pre"
-			echo
-		fi
-		cat "$playground/^body"
-		[ ! -s "$playground/^post" ] || cat "$playground/^post"
-	} | git commit-tree "$(pretty_tree "$name")" -p "$parent"
+	(printf '%s\n\n' "$SUBJECT"; cat "$playground/^msg") |
+	git stripspace |
+	git commit-tree "$(pretty_tree "$name")" -p "$parent"
=20
 	echo "$name" >>"$playground/^ticker"
 }
--=20
1.5.6.5
