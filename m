From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] git-rebase--interactive.sh: add config option for custom instruction format
Date: Wed, 10 Jun 2015 21:30:44 -0400
Message-ID: <1433986244-76038-2-git-send-email-rappazzo@gmail.com>
References: <1433986244-76038-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitset@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Thu Jun 11 03:47:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2rav-0004wR-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 03:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbbFKBrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 21:47:45 -0400
Received: from mail-vn0-f66.google.com ([209.85.216.66]:34357 "EHLO
	mail-vn0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbbFKBro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 21:47:44 -0400
Received: by vnbf7 with SMTP id f7so7100025vnb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 18:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6+WNBe0Ysg6NkOzACioWYDvV5AdqOkYvKF68ia60Whw=;
        b=WjDMe6ik/mvY8hTMyFzJ4pBfOwr39wmKcElelT+mj4XALic1tGZGrBqBIc0cD4GgiY
         VeRlQ2Ly2x8HAbGb9NZBuaB7P96Nf9hNUv26/XtwVzQ6X/ZgrW4vRi+wZNg3WSzkJIcM
         i6KTdV12Ij6RfbhXqdxlJLCHjEdA3LNCY6vBFCEQxhi75pX0kFmoAegYCiSx32m3ld/l
         v8mMd31trfc2g87UH7kDOR/vZzjgmrrut8ytngc+Yn0IUeG/BplnsDDBHvsOpEUCQHrB
         +FaRfgpaTjxAlogr3TyGoSvNXsoVGex11HqRyizXUUuxZg+iV1gRghxONAVmbB64g8O2
         6bHA==
X-Received: by 10.52.179.73 with SMTP id de9mr11739732vdc.28.1433986281237;
        Wed, 10 Jun 2015 18:31:21 -0700 (PDT)
Received: from MRappazzo-2.local.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by mx.google.com with ESMTPSA id jk10sm12888072vdb.13.2015.06.10.18.31.19
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2015 18:31:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433986244-76038-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271373>

A config option 'rebase.instructionFormat' can override the
default 'oneline' format of the rebase instruction list.

Since the list is parsed using the left, right or boundary mark plus
the sha1, they are prepended to the instruction format.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/git-rebase.txt |  7 +++++++
 git-rebase--interactive.sh   | 34 ++++++++++++++++++++++++++++------
 t/t3415-rebase-autosquash.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1d01baa..8ddab77 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -213,6 +213,9 @@ rebase.autoSquash::
 rebase.autoStash::
 	If set to true enable '--autostash' option by default.
 
+rebase.instructionFormat::
+   Custom commit list format to use during an '--interactive' rebase.
+
 OPTIONS
 -------
 --onto <newbase>::
@@ -359,6 +362,10 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 	Make a list of the commits which are about to be rebased.  Let the
 	user edit that list before rebasing.  This mode can also be used to
 	split commits (see SPLITTING COMMITS below).
++
+The commit list format can be changed by setting the configuration option
+rebase.instructionFormat.  A customized instruction format will automatically
+have the long commit hash prepended to the format.
 
 -p::
 --preserve-merges::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..6d14315 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -740,10 +740,19 @@ collapse_todo_ids() {
 # "pick sha1 fixup!/squash! msg" appears in it so that the latter
 # comes immediately after the former, and change "pick" to
 # "fixup"/"squash".
+#
+# Note that if the config has specified a custom instruction format
+# each log message will be re-retrieved in order to normalize the 
+# autosquash arrangement
 rearrange_squash () {
 	# extract fixup!/squash! lines and resolve any referenced sha1's
-	while read -r pick sha1 message
+	while read -r pick sha1 todo_message
 	do
+		message=${todo_message}
+		if test -n "${format}"
+		then
+			message=$(git log -n 1 --format="%s" ${sha1})
+		fi
 		case "$message" in
 		"squash! "*|"fixup! "*)
 			action="${message%%!*}"
@@ -779,12 +788,17 @@ rearrange_squash () {
 	test -s "$1.sq" || return
 
 	used=
-	while read -r pick sha1 message
+	while read -r pick sha1 todo_message
 	do
 		case " $used" in
 		*" $sha1 "*) continue ;;
 		esac
-		printf '%s\n' "$pick $sha1 $message"
+		message=$todo_message
+		if test -n "${format}"
+		then
+			message=$(git log -n 1 --format="%s" ${sha1})
+		fi
+		printf '%s\n' "$pick $sha1 $todo_message"
 		used="$used$sha1 "
 		while read -r squash action msg_prefix msg_content
 		do
@@ -802,8 +816,13 @@ rearrange_squash () {
 				case "$message" in "$msg_content"*) emit=1;; esac ;;
 			esac
 			if test $emit = 1; then
-				real_prefix=$(echo "$msg_prefix" | sed "s/,/! /g")
-				printf '%s\n' "$action $squash ${real_prefix}$msg_content"
+				if test -n "${format}"
+				then
+					msg_content=$(git log -n 1 --format="${format}" ${squash})
+				else
+					msg_content="$(echo "$msg_prefix" | sed "s/,/! /g")$msg_content"
+				fi
+				printf '%s\n' "$action $squash $msg_content"
 				used="$used$squash "
 			fi
 		done <"$1.sq"
@@ -977,7 +996,10 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --reverse --left-right --topo-order \
+format=$(git config --get rebase.instructionFormat)
+# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
+git rev-list $merges_option --format="%m%H ${format:-%s}" \
+	--reverse --left-right --topo-order \
 	$revisions ${restrict_revision+^$restrict_revision} | \
 	sed -n "s/^>//p" |
 while read -r sha1 rest
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 41370ab..1ef96eb 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -250,4 +250,37 @@ test_expect_success 'squash! fixup!' '
 	test_auto_fixup_fixup squash fixup
 '
 
+test_expect_success 'autosquash with custom inst format matching on sha1' '
+	git reset --hard base &&
+	git config --add rebase.instructionFormat "[%an @ %ar] %s"  &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! $(git rev-parse --short HEAD^)" &&
+	git tag final-shasquash-instFmt &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test_line_count = 3 actual &&
+	git diff --exit-code final-shasquash-instFmt &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+'
+
+test_expect_success 'autosquash with custom inst format matching on comment' '
+	git reset --hard base &&
+	git config --add rebase.instructionFormat "[%an @ %ar] %s"  &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! $(git log -n 1 --format=%s HEAD^)" &&
+	git tag final-comment-squash-instFmt &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test_line_count = 3 actual &&
+	git diff --exit-code final-comment-squash-instFmt &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+'
 test_done
-- 
2.4.2
