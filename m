From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv3 2/2] rebase: teach --autosquash to match on sha1 in addition to message
Date: Mon,  8 Nov 2010 02:48:03 -0800
Message-ID: <1289213283-24294-2-git-send-email-kevin@sb.org>
References: <alpine.DEB.2.00.1011051401090.7611@ds9.cixit.se>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 11:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFPGt-0004Rd-IG
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 11:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab0KHKsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 05:48:15 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45380 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab0KHKsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 05:48:14 -0500
Received: by mail-iw0-f174.google.com with SMTP id 41so3935366iwn.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 02:48:13 -0800 (PST)
Received: by 10.231.37.12 with SMTP id v12mr1763676ibd.69.1289213293727;
        Mon, 08 Nov 2010 02:48:13 -0800 (PST)
Received: from localhost.localdomain ([24.130.32.253])
        by mx.google.com with ESMTPS id d21sm5901520ibg.9.2010.11.08.02.48.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 02:48:12 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.195.gc69dde
In-Reply-To: <alpine.DEB.2.00.1011051401090.7611@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160922>

Support lines of the form "fixup! 7a235b" that specify an exact commit
in addition to the normal "squash! Old commit message" form.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---

The only change from v2 is I've added the manpage change from Peter Krefting's
previous patch on this subject (http://www.spinics.net/lists/git/msg133571.html),
as referenced in message id <alpine.DEB.2.00.1011051401090.7611@ds9.cixit.se>.

 Documentation/git-rebase.txt |    8 ++++----
 git-rebase--interactive.sh   |   40 +++++++++++++++++++++++++++++++++-------
 t/t3415-rebase-autosquash.sh |   31 +++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 30e5c0e..17f50cb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -339,10 +339,10 @@ idea unless you know what you are doing (see BUGS below).
 --no-autosquash::
 	When the commit log message begins with "squash! ..." (or
 	"fixup! ..."), and there is a commit whose title begins with
-	the same ..., automatically modify the todo list of rebase -i
-	so that the commit marked for squashing comes right after the
-	commit to be modified, and change the action of the moved
-	commit from `pick` to `squash` (or `fixup`).
+	the same ..., or whose hash is ..., automatically modify the
+	todo list of rebase -i so that the commit marked for squashing
+	comes right after the commit to be modified, and change the
+	action of the moved commit from `pick` to `squash` (or `fixup`).
 +
 This option is only valid when the '--interactive' option is used.
 +
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 56cfdb5..31abbff 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -695,9 +695,27 @@ get_saved_options () {
 # comes immediately after the former, and change "pick" to
 # "fixup"/"squash".
 rearrange_squash () {
-	sed -n -e 's/^pick \([0-9a-f]*\) \(squash\)! /\1 \2 /p' \
-		-e 's/^pick \([0-9a-f]*\) \(fixup\)! /\1 \2 /p' \
-		"$1" >"$1.sq"
+	# extract fixup!/squash! lines and resolve any referenced sha1's
+	while read -r pick sha1 message
+	do
+		case "$message" in
+		"squash! "*|"fixup! "*)
+			action="${message%%!*}"
+			rest="${message#*! }"
+			echo "$sha1 $action $rest"
+			# if it's a single word, try to resolve to a full sha1 and
+			# emit a second copy. This allows us to match on both message
+			# and on sha1 prefix
+			if test "${rest#* }" = "$rest"; then
+				fullsha="$(git rev-parse -q --verify "$rest" 2>/dev/null)"
+				if test -n "$fullsha"; then
+					# prefix the action to uniquely identify this line as
+					# intended for full sha1 match
+					echo "$sha1 +$action $fullsha"
+				fi
+			fi
+		esac
+	done >"$1.sq" <"$1"
 	test -s "$1.sq" || return
 
 	used=
@@ -713,12 +731,20 @@ rearrange_squash () {
 			case " $used" in
 			*" $squash "*) continue ;;
 			esac
-			case "$message" in
-			"$msg"*)
+			emit=0
+			case "$action" in
+			+*)
+				action="${action#+}"
+				# full sha1 prefix test
+				case "$msg" in "$sha1"*) emit=1;; esac ;;
+			*)
+				# message prefix test
+				case "$message" in "$msg"*) emit=1;; esac ;;
+			esac
+			if test $emit = 1; then
 				printf '%s\n' "$action $squash $action! $msg"
 				used="$used$squash "
-				;;
-			esac
+			fi
 		done <"$1.sq"
 	done >"$1.rearranged" <"$1"
 	cat "$1.rearranged" >"$1"
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 712bbe8..ca16b70 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -136,5 +136,36 @@ test_expect_success 'auto squash that matches a commit after the squash' '
 	test 1 = $(git cat-file commit HEAD | grep third | wc -l) &&
 	test 1 = $(git cat-file commit HEAD^ | grep third | wc -l)
 '
+test_expect_success 'auto squash that matches a sha1' '
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! $(git rev-parse --short HEAD^)" &&
+	git tag final-shasquash &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 3 = $(wc -l <actual) &&
+	git diff --exit-code final-shasquash &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+'
+
+test_expect_success 'auto squash that matches longer sha1' '
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! $(git rev-parse --short=11 HEAD^)" &&
+	git tag final-longshasquash &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 3 = $(wc -l <actual) &&
+	git diff --exit-code final-longshasquash &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+'
 
 test_done
-- 
1.7.3.2.195.gc69dde
