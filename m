From: =?us-ascii?B?PT9VVEYtOD9xP0Nhcmxvcz0yME1hcnQ9QzM9QURuPTIwTmlldG8/?=
	 =?us-ascii?Q?=3D?= <cmn@elego.de>
Subject: [RFC PATCH v2] Chain squash!/fixup! commits on autosquash
Date: Tue, 19 Apr 2011 17:54:22 +0200
Message-ID: <20110419155417.GA13042@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 17:54:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCDG2-0005MP-TK
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 17:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab1DSPyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 11:54:24 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:40345 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192Ab1DSPyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 11:54:24 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id E222846132
	for <git@vger.kernel.org>; Tue, 19 Apr 2011 17:54:07 +0200 (CEST)
Received: (nullmailer pid 13063 invoked by uid 1000);
	Tue, 19 Apr 2011 15:54:22 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171798>

Separate the idea of an 'used' and an 'applied' line. Applied lines
are the ones that have been moved to modify some commit whilst used
lines are the ones for which we have tried to find
modifications. Applied lines are given priority when looking for
modifications. Thus, if one has these commits

    944f57d fixup! squash! six
    3512067 fixup! squash! squash! six
    49af780 fixup! fixup! one
    df6f708 fixup! one
    6ac57d9 one
    6e754da squash! squash! six
    733844b squash! six
    e9de3cc six
    76990c9 five

they will be correctly reordered to

    pick e9de3cc six
    squash 733844b squash! six
    squash 6e754da squash! squash! six
    fixup 944f57d fixup! squash! six
    fixup 3512067 fixup! squash! squash! six
    pick 6ac57d9 one
    fixup df6f708 fixup! one
    fixup 49af780 fixup! fixup! one
---

To be honest, I'm not sure if we want to support something like this,
but it seemed too crazy not to try.

This is an attempt to fix
http://thread.gmane.org/gmane.comp.version-control.git/170883 (rebase
autosquash doesn't recognise a chain of fixups, 2011-04-05)

Cheers,
   cmn

 git-rebase--interactive.sh |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5873ba4..5e7b393 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -692,16 +692,28 @@ rearrange_squash () {
 	test -s "$1.sq" || return
 
 	used=
+	applied=
+	RE="$1.re"
+	skiplines=0
+	# Initialize the list with the first line from the input
+	head -n 1 "$1" > $RE
 	while read -r pick sha1 message
 	do
+		echo "dealing with $sha1 skiplines=$skiplines" >> "rebase.log"
 		case " $used" in
-		*" $sha1 "*) continue ;;
+		*" $sha1 "*) next_input_line "$skiplines" "$1" "$RE"; skiplines="$(expr $skiplines + 1)"; continue ;;
+		esac
+		# If it's been applied, we don't want to output the "pick" line
+		case " $applied" in
+			*" $sha1 "*) ;;
+			*) printf '%s\n' "$pick $sha1 $message";;
 		esac
-		printf '%s\n' "$pick $sha1 $message"
 		used="$used$sha1 "
+		emitted=0;
 		while read -r squash action msg
 		do
-			case " $used" in
+			# Ignore the commits we've already dealt with
+			case " $used $applied " in
 			*" $squash "*) continue ;;
 			esac
 			emit=0
@@ -715,15 +727,29 @@ rearrange_squash () {
 				case "$message" in "$msg"*) emit=1;; esac ;;
 			esac
 			if test $emit = 1; then
+				emitted=1
 				printf '%s\n' "$action $squash $action! $msg"
-				used="$used$squash "
+				applied="$applied$squash "
+				echo "$action $squash $action! $msg" >> "$RE"
 			fi
 		done <"$1.sq"
-	done >"$1.rearranged" <"$1"
+
+		# If no lines were emitted, it means we don't need take an
+		# early look to any more lines, so put the next one from the input into the queue
+		if test "$emmited" != 1; then
+			next_input_line "$skiplines" "$1" "$RE"
+			skiplines="$(expr $skiplines + 1)"
+		fi
+
+	done >"$1.rearranged" <"$RE"
 	cat "$1.rearranged" >"$1"
 	rm -f "$1.sq" "$1.rearranged"
 }
 
+next_input_line () {
+	tail --lines="+$1" "$2" | head -n 1 >> "$3"
+}
+
 LF='
 '
 parse_onto () {
-- 
1.7.4.2.437.g4fc7e.dirty
