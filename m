From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv3 1/2] Warnings before rebasing -i published history
Date: Mon, 11 Jun 2012 23:56:20 +0200
Message-ID: <1339451781-29324-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 23:56:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCbB-0005PM-KD
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab2FKV41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:56:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59769 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab2FKV40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:56:26 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5BLlQtB004765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 23:47:26 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BLuLHa022920;
	Mon, 11 Jun 2012 23:56:21 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q5BLuLPv029670;
	Mon, 11 Jun 2012 23:56:21 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q5BLuLre029669;
	Mon, 11 Jun 2012 23:56:21 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Jun 2012 23:47:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BLlQtB004765
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1340056050.2532@tcpTIABjx90N413LebGfOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199740>

"git rebase -i" can be very dangerous if used on an already published
history. This code detects that one is rewriting a commit that is an
ancestor of a remote-tracking branch, and warns the user through the
editor. This feature is controlled by a new config key
rebase.checkremoterefs.

Here is an example of the behaviour of this feature:

   pick <id> commit pushed_one
   # Commits above this line appear in origin/master
   pick <id> commit pushed_two
   pick <id> commit pushed_three
   # Commits above this line appear in origin/next
   pick <id> commit local

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
The remote points are now only shown once. The behavior of
git branch --contains is the same than in v2 (not optimized).

 Documentation/config.txt      |    5 +++++
 Documentation/git-rebase.txt  |    5 +++++
 git-rebase--interactive.sh    |   32 ++++++++++++++++++++++++++++++++
 git-rebase.sh                 |    2 ++
 t/lib-rebase.sh               |   11 +++++++++++
 t/t3404-rebase-interactive.sh |   27 +++++++++++++++++++++++++++
 6 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..e47f6e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1753,6 +1753,11 @@ rebase.stat::
 rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
 
+rebase.checkremoterefs::
+	If it is set to 'true', git rebase -i will show after each
+	commit ancestor of a remote-tracking branch the name of these
+	branches through the editor.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 147fa1a..b68a80b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -208,6 +208,11 @@ rebase.stat::
 rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
 
+rebase.checkremoterefs::
+	If it is set to 'true', git rebase -i will show after each
+	commit ancestor of a remote-tracking branch the name of these
+	branches through the editor.
+
 OPTIONS
 -------
 <newbase>::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..7e4ae16 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -684,6 +684,37 @@ rearrange_squash () {
 	rm -f "$1.sq" "$1.rearranged"
 }
 
+# Add the name of the branches after each pick, fixup or squash commit that
+# is an ancestor of a remote-tracking branch.
+add_remoterefs () {
+	to_print=
+	branches_name=
+	while read -r command sha1 message
+	do
+		git branch -r --contains "$sha1" >"$1.branch"
+		if test -s "$1.branch"
+		then
+			while read -r branch
+			do
+				branches_name="$branches_name $branch"
+			done <"$1.branch"
+		fi
+
+		if test "$to_print" != "$branches_name"
+		then
+			if test -n "$to_print"
+			then
+				printf '%s\n' "# Commits above this line appear in:$to_print"
+			fi
+			to_print=$branches_name
+		fi
+		branches_name=
+		printf '%s\n' "$command $sha1 $message"
+	done >"$1.published" <"$1"
+	cat "$1.published" >"$1"
+	rm -f "$1.published" "$1.branch"
+}
+
 case "$action" in
 continue)
 	# do we have anything to commit?
@@ -857,6 +888,7 @@ fi
 
 test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
+test -n "$checkremoterefs" && add_remoterefs "$todo"
 cat >> "$todo" << EOF
 
 # Rebase $shortrevisions onto $shortonto
diff --git a/git-rebase.sh b/git-rebase.sh
index e616737..f8675b5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -99,7 +99,9 @@ action=
 preserve_merges=
 autosquash=
 keep_empty=
+checkremoterefs=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+test "$(git config --bool rebase.checkremoterefs)" = "true" && checkremoterefs=t
 
 read_basic_state () {
 	head_name=$(cat "$state_dir"/head-name) &&
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6ccf797..4906867 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -65,3 +65,14 @@ EOF
 	test_set_editor "$(pwd)/fake-editor.sh"
 	chmod a+x fake-editor.sh
 }
+
+
+set_copy_editor () {
+	echo "#!$SHELL_PATH" >editor.sh
+	cat >> editor.sh <<\EOF
+cat "$1" >"$TODO_DUMP"
+EOF
+
+	test_set_editor "$(pwd)/editor.sh"
+	chmod a+x editor.sh
+}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 025c1c6..72934a5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -755,4 +755,31 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'warn before rewriting published history' '
+	test_when_finished "rm -rf git.git git" &&
+	git init git.git &&
+	git clone git &&
+	(
+		cd git &&
+		git config rebase.checkremoterefs true &&
+		test_commit one_commit main.txt one_commit &&
+		test_commit two_commit main.txt two_commit &&
+		test_commit three_commit main.txt three_commit &&
+		git push --all &&
+		test_commit four_commit main.txt four_commit &&
+		set_copy_editor &&
+		TODO_DUMP=actual EDITOR=./editor.sh git rebase -i HEAD~3 &&
+		tmp=$(cat actual | sed -n 1,5p) &&
+		echo "$tmp" >actual &&
+		two_sha1=$(git rev-parse --short HEAD~2) &&
+		three_sha1=$(git rev-parse --short HEAD~1) &&
+		four_sha1=$(git rev-parse --short HEAD) &&
+		echo "pick $two_sha1 two_commit" >expected &&
+		echo "pick $three_sha1 three_commit" >>expected &&
+		echo "# Commits above this line appear in: origin/master" >>expected &&
+		echo "pick $four_sha1 four_commit" >>expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
-- 
1.7.8
