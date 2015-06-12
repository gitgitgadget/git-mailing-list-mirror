From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v4] git-rebase--interactive.sh: add config option for custom instruction format
Date: Thu, 11 Jun 2015 22:23:28 -0400
Message-ID: <1434075808-43453-2-git-send-email-rappazzo@gmail.com>
References: <1434075808-43453-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Jun 12 04:23:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3EdP-0002S7-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 04:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbbFLCXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 22:23:45 -0400
Received: from mail-vn0-f45.google.com ([209.85.216.45]:45761 "EHLO
	mail-vn0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbFLCXn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 22:23:43 -0400
Received: by vnbf62 with SMTP id f62so3737639vnb.12
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 19:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qEQlRFWOvizmw44jXjFDk6yhLzEXFKkHof7PN+9ssEI=;
        b=sRSH8UsP9gN3/suEutHAe2jQltLo6IywbOok7w5SwK37ixdb0tAP7KDG2/+Lz/cZ3o
         XMYLVSxHiJnP0duC40T8M29u3VPU/M/gbYGQ/knsnf2wcKcUKA+bfwgbzBOKeX1TfOD8
         FmIKVLIEajaflS1lIdGEf9c9R5zPvG4ZbwXATG6Z2pvCWn6IxWtKddKKEGYsgsH7vU0t
         yu9VizmkyemgZYjvKw0cUOZKLLXhrXxz2J3wAevmy7Omo2lhEI9pSgcEDeJcHdFPr1yE
         4SizlB6o8S6NNNRJVY++Q9wnppetEXl8cZmDlhbQNII+inUD5P5RRpdtUW9A5l5NntpH
         IETA==
X-Received: by 10.52.122.52 with SMTP id lp20mr5591930vdb.64.1434075822035;
        Thu, 11 Jun 2015 19:23:42 -0700 (PDT)
Received: from MRappazzo-2.local.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by mx.google.com with ESMTPSA id p13sm3010344vdj.15.2015.06.11.19.23.41
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 19:23:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434075808-43453-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271467>

A config option 'rebase.instructionFormat' can override the
default 'oneline' format of the rebase instruction list.

Since the list is parsed using the left, right or boundary mark plus
the sha1, they are prepended to the instruction format.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/git-rebase.txt |  7 +++++++
 git-rebase--interactive.sh   | 20 +++++++++++++++++---
 t/t3415-rebase-autosquash.sh | 21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

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
index dc3133f..755f9c1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -740,10 +740,15 @@ collapse_todo_ids() {
 # "pick sha1 fixup!/squash! msg" appears in it so that the latter
 # comes immediately after the former, and change "pick" to
 # "fixup"/"squash".
+#
+# Note that if the config has specified a custom instruction format
+# each log message will be re-retrieved in order to normalize the 
+# autosquash arrangement
 rearrange_squash () {
 	# extract fixup!/squash! lines and resolve any referenced sha1's
 	while read -r pick sha1 message
 	do
+		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
 		case "$message" in
 		"squash! "*|"fixup! "*)
 			action="${message%%!*}"
@@ -785,6 +790,7 @@ rearrange_squash () {
 		*" $sha1 "*) continue ;;
 		esac
 		printf '%s\n' "$pick $sha1 $message"
+		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
 		used="$used$sha1 "
 		while read -r squash action msg_prefix msg_content
 		do
@@ -802,8 +808,13 @@ rearrange_squash () {
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
@@ -977,7 +988,10 @@ else
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
index 41370ab..10bed4c 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -250,4 +250,25 @@ test_expect_success 'squash! fixup!' '
 	test_auto_fixup_fixup squash fixup
 '
 
+test_expect_success 'autosquash with custom inst format matching on sha1' '
+	git reset --hard base &&
+	git config --add rebase.instructionFormat "[%an @ %ar] %s"  &&
+	echo 2 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! $(git rev-parse --short HEAD^)" &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! $(git log -n 1 --format=%s HEAD~2)" &&
+	git tag final-squash-instFmt &&
+	test_tick &&
+	git rebase --autosquash -i HEAD~4 &&
+	git log --oneline >actual &&
+	test_line_count = 3 actual &&
+	git diff --exit-code final-squash-instFmt &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
+'
+
 test_done
-- 
2.4.2
