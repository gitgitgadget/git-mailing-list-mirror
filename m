From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [RFC PATCH] Chain squash!/fixup! commits on autosquash
Date: Mon, 11 Apr 2011 17:34:24 +0200
Message-ID: <1302536064-3922-1-git-send-email-cmn@elego.de>
Cc: Kevin Ballard <kevin@sb.org>, Pat Notz <patnotz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 11 17:34:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9J8L-0000Ak-BQ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 17:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab1DKPe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 11:34:27 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:51460 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab1DKPe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 11:34:27 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 151364612C;
	Mon, 11 Apr 2011 17:34:13 +0200 (CEST)
Received: (nullmailer pid 4080 invoked by uid 1000);
	Mon, 11 Apr 2011 15:34:24 -0000
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171334>

If one has the following commits

    5154127 fixup! fixup! one
    0d130d8 fixup! one
    0869d30 one

current code will only rearrange 0d130d8 because it thinks it has
already checked for commits that modify it.

Separate the idea of an 'used' and an 'applied' line. Applied lines
are the ones that have been moved to modify some commit whilst used
lines are the ones for which we have tried to find modifications.
---

This supports the case I originally mentioned. It however breaks quite
badly if one has two chains, such as

    0792561 fixup! squash! squash! six
    e72100f squash! squash! six
    90187b8 fixup! fixup! one
    6facd7d fixup! one
    4f48f55 one
    733844b squash! six
    e9de3cc six
    76990c9 five
    db0d525 one

because it will try to add 0792561 as a fixup to e72100f. However, as
it has moved, it is made into a fixup of 90187b8, which is definitely
bad (not that I think anybody would ever have such a chain in real
life).

This should be fixable by modifying the loop a bit so it doesn't read
the next line on each iteration so we can feed it the current
line. Would you be interested in such a patch?  For me this is a bit
more elegant than removing the "fixup!" on commit (though my shell
skills aren't that great).

 git-rebase--interactive.sh |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5873ba4..a681f47 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -692,16 +692,22 @@ rearrange_squash () {
 	test -s "$1.sq" || return
 
 	used=
+	applied=
 	while read -r pick sha1 message
 	do
 		case " $used" in
 		*" $sha1 "*) continue ;;
 		esac
-		printf '%s\n' "$pick $sha1 $message"
+		# If it's been applied, we don't want to output the "pick" line
+		case " $applied" in
+			*" $sha1 "*) ;;
+			*) printf '%s\n' "$pick $sha1 $message";;
+		esac
 		used="$used$sha1 "
 		while read -r squash action msg
 		do
-			case " $used" in
+			# Ignore the commits we've already dealt with
+			case " $used $applied " in
 			*" $squash "*) continue ;;
 			esac
 			emit=0
@@ -716,7 +722,7 @@ rearrange_squash () {
 			esac
 			if test $emit = 1; then
 				printf '%s\n' "$action $squash $action! $msg"
-				used="$used$squash "
+				applied="$applied$squash "
 			fi
 		done <"$1.sq"
 	done >"$1.rearranged" <"$1"
-- 
1.7.4.1
