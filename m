From: David Greene <greened@obbligato.org>
Subject: [PATCH] Support rebase --keep-empty and --keep-redundant
Date: Tue, 15 Dec 2015 21:02:46 -0600
Message-ID: <1450234966-28796-2-git-send-email-greened@obbligato.org>
References: <1450234966-28796-1-git-send-email-greened@obbligato.org>
Cc: john@keeping.me.uk, sandals@crustytoothpaste.net, peff@peff.net,
	gitster@pobox.com, "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 04:03:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a92N4-0002Ui-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 04:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965692AbbLPDDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 22:03:14 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:56229 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965679AbbLPDDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 22:03:13 -0500
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1a92N0-0003Dd-Mf; Tue, 15 Dec 2015 21:03:14 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1450234966-28796-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282530>

From: "David A. Greene" <greened@obbligato.org>

Teach rebase how to invoke cherry-pick to keep empty commits.

Add a new option --keep-redundant equivalent to cherry-pick's
--keep-redundant-commits.  With this option, rebase will
preserve empty commits generated as a result of the merging
process.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 git-rebase--interactive.sh |  11 +++-
 git-rebase.sh              |   5 ++
 t/t3427-rebase-empty.sh    | 127 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100755 t/t3427-rebase-empty.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b938a6d..8466cb9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -393,7 +393,16 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output eval git cherry-pick \
+			cherry_keep_empty=
+			if test -n "$keep_empty"; then
+				cherry_keep_empty="--allow-empty"
+			fi
+			cherry_keep_redundant=
+			if test -n "$keep_redundant"; then
+				cherry_keep_redundant="--keep-redundant-commits"
+			fi
+			output eval git cherry-pick "$cherry_keep_empty" \
+				"$cherry_keep_redundant" \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 				"$strategy_args" "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
diff --git a/git-rebase.sh b/git-rebase.sh
index af7ba5f..1eae688 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -24,6 +24,7 @@ m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
 x,exec=!           add exec lines after each commit of the editable list
 k,keep-empty	   preserve empty commits during rebase
+keep-redundant     preserve redundant commits during rebase
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
@@ -86,6 +87,7 @@ action=
 preserve_merges=
 autosquash=
 keep_empty=
+keep_redundant=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 gpg_sign_opt=
 
@@ -255,6 +257,9 @@ do
 	--keep-empty)
 		keep_empty=yes
 		;;
+	--keep-redundant)
+		keep_redundant=yes
+		;;
 	--preserve-merges)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
diff --git a/t/t3427-rebase-empty.sh b/t/t3427-rebase-empty.sh
new file mode 100755
index 0000000..9e67e00
--- /dev/null
+++ b/t/t3427-rebase-empty.sh
@@ -0,0 +1,127 @@
+#!/bin/sh
+
+test_description='git rebase tests for empty commits
+
+This test runs git rebase and tests handling of empty commits.
+'
+. ./test-lib.sh
+
+addfile() {
+    name=$1
+    echo $(basename ${name}) > ${name}
+    ${git} add ${name}
+    ${git} commit -m "Add $(basename ${name})"
+}
+
+check_equal()
+{
+	test_debug 'echo'
+	test_debug "echo \"check a:\" \"{$1}\""
+	test_debug "echo \"      b:\" \"{$2}\""
+	if [ "$1" = "$2" ]; then
+		return 0
+	else
+		return 1
+	fi
+}
+
+last_commit_message()
+{
+	git log --pretty=format:%s -1
+}
+
+test_expect_success 'setup' '
+	test_commit README &&
+	mkdir files &&
+	cd files &&
+	git init &&
+	test_commit master1 &&
+	test_commit master2 &&
+	test_commit master3 &&
+	cd .. &&
+	test_debug "echo Add project master to master" &&
+	git fetch files master &&
+	git branch files-master FETCH_HEAD &&
+	test_debug "echo Add subtree master to master via subtree" &&
+	git read-tree --prefix=files_subtree files-master &&
+	git checkout -- files_subtree &&
+	tree=$(git write-tree) &&
+	head=$(git rev-parse HEAD) &&
+	rev=$(git rev-parse --verify files-master^0) &&
+	commit=$(git commit-tree -p ${head} -p ${rev} -m "Add subproject master" ${tree}) &&
+	git reset ${commit} &&
+	cd files_subtree &&
+	test_commit master4 &&
+	cd .. &&
+	test_commit files_subtree/master5
+'
+
+# Does not preserve master4 and master5.
+#test_expect_success 'Rebase default' '
+#	git checkout -b rebase-default master &&
+#	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+#	git commit -m "Empty commit" --allow-empty &&
+#	git rebase -Xsubtree=files_subtree  --preserve-merges --onto files-master master &&
+#	check_equal "$(last_commit_message)" "files_subtree/master5"
+#'
+
+test_expect_success 'Rebase --root' '
+	git checkout -b rebase-default-root master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	test_must_fail git rebase -Xsubtree=files_subtree  --preserve-merges --onto files-master --root &&
+	git rebase --abort
+'
+
+# Does not preserve master4, master5 and empty.
+#test_expect_success 'Rebase --keep-empty' '
+#	git checkout -b rebase-keep-empty master &&
+#	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+#	git commit -m "Empty commit" --allow-empty &&
+#	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
+#	check_equal "$(last_commit_message)" "Empty commit"
+#'
+
+test_expect_success 'Rebase --keep-empty --root' '
+	git checkout -b rebase-keep-empty-root master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	test_must_fail git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master --root &&
+	git rebase --abort
+'
+
+# Does not preserve master4 and master5.
+#test_expect_success 'Rebase --keep-redundant' '
+#	git checkout -b rebase-keep-redundant master &&
+#	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+#	git commit -m "Empty commit" --allow-empty &&
+#	git rebase -Xsubtree=files_subtree --keep-redundant --preserve-merges --onto files-master master &&
+#	check_equal "$(last_commit_message)" "files_subtree/master5"
+#'
+
+test_expect_success 'Rebase --keep-redundant --root' '
+	git checkout -b rebase-keep-redundant-root master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --keep-redundant --preserve-merges --onto files-master --root &&
+	check_equal "$(last_commit_message)" "files_subtree/master5"
+'
+
+# Does not preserve master4, master5 and empty.
+#test_expect_success 'Rebase --keep-empty --keep-redundant' '
+#	git checkout -b rebase-keep-empty-keep-redundant master &&
+#	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+#	git commit -m "Empty commit" --allow-empty &&
+#	git rebase -Xsubtree=files_subtree --keep-empty --keep-redundant --preserve-merges --onto files-master master &&
+#	check_equal "$(last_commit_message)" "Empty commit"
+#'
+
+test_expect_success 'Rebase --keep-empty --keep-redundant --root' '
+	git checkout -b rebase-keep-empty-keep-redundant-root master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --keep-empty --keep-redundant --preserve-merges --onto files-master --root &&
+	check_equal "$(last_commit_message)" "Empty commit"
+'
+
+test_done
-- 
2.6.1
