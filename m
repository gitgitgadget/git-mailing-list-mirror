From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv2 2/2] rebase: teach --autosquash to match on sha1 in addition to message
Date: Thu,  4 Nov 2010 15:36:32 -0700
Message-ID: <1288910192-10247-2-git-send-email-kevin@sb.org>
References: <7vr5f0vrbn.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 23:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE8QM-000358-L9
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab0KDWgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 18:36:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58646 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab0KDWgn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 18:36:43 -0400
Received: by pwj7 with SMTP id 7so372517pwj.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:36:42 -0700 (PDT)
Received: by 10.142.199.19 with SMTP id w19mr914339wff.390.1288910202868;
        Thu, 04 Nov 2010 15:36:42 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id y42sm591214wfd.22.2010.11.04.15.36.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 15:36:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.202.g3b863.dirty
In-Reply-To: <7vr5f0vrbn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160788>

Support lines of the form "fixup! 7a235b" that specify an exact commit
in addition to the normal "squash! Old commit message" form.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
This version attempts to resolve all single-word fixup!/squash! messages to
full sha1s. It only tries this once per line and records the results in the
$TODO.sq file. The reasoning for the duplication of such lines is to allow
a line like

  fixup! 8a23b5f 7a5436

to still prefix-match "7a5436" against commit messages in addition to matching
the fullly-resolved sha1 against the other sha1's.

 git-rebase--interactive.sh   |   40 +++++++++++++++++++++++++++++++++-------
 t/t3415-rebase-autosquash.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 379bbac..c2383bf 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -675,9 +675,27 @@ get_saved_options () {
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
@@ -693,12 +711,20 @@ rearrange_squash () {
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
1.7.3.2.202.g3b863.dirty
