From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 2/2] rebase-i: loosen over-eager check_bad_cmd check
Date: Thu,  1 Oct 2015 10:18:42 +0200
Message-ID: <1443687522-14311-2-git-send-email-Matthieu.Moy@imag.fr>
References: <xmqq8u7n7ikl.fsf@gitster.mtv.corp.google.com>
 <1443687522-14311-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 01 10:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhZ55-0006B5-24
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 10:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbbJAITI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 04:19:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56125 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756169AbbJAITC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 04:19:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t918IlNn032225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 1 Oct 2015 10:18:48 +0200
Received: from estrop.imag.fr (estrop.imag.fr [129.88.7.56])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t918Imn3025610;
	Thu, 1 Oct 2015 10:18:48 +0200
Received: from moy by estrop.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZhZ4i-0003nM-RE; Thu, 01 Oct 2015 10:18:48 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
In-Reply-To: <1443687522-14311-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Oct 2015 10:18:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t918IlNn032225
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1444292331.76246@NpHxVG7oGNo7l+csJQ7UvA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278890>

804098bb (git rebase -i: add static check for commands and SHA-1,
2015-06-29) tried to check all insns before running any in the todo
list, but it did so by implementing its own parser that is a lot
stricter than necessary.  We used to allow lines that are indented
(including comment lines), and we used to allow a whitespace between
the insn and the commit object name to be HT, among other things,
that are flagged as an invalid line by mistake.

Fix this by using the same tokenizer that is used to parse the todo
list file in the new check.

Whether it's a good thing to accept indented comments is
debatable (other commands like "git commit" do not accept them), but we
already accepted them in the past, and some people and scripts rely on
this behavior. Also, a line starting with space followed by a '#' cannot
have any meaning other than being a comment, hence it doesn't harm to
accept them as comments.

Largely based on patch by: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I went back to Junio's version, plus [ ] (space-tab) instead of just
space to split the line.

 git-rebase--interactive.sh    | 62 ++++++++++++++++++++-----------------------
 t/t3404-rebase-interactive.sh | 15 +++++++++++
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0d77429..d65c06e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -857,7 +857,8 @@ add_exec_commands () {
 # Check if the SHA-1 passed as an argument is a
 # correct one, if not then print $2 in "$todo".badsha
 # $1: the SHA-1 to test
-# $2: the line to display if incorrect SHA-1
+# $2: the line number of the input
+# $3: the input filename
 check_commit_sha () {
 	badsha=0
 	if test -z $1
@@ -873,9 +874,10 @@ check_commit_sha () {
 
 	if test $badsha -ne 0
 	then
+		line="$(sed -n -e "${2}p" "$3")"
 		warn "Warning: the SHA-1 is missing or isn't" \
 			"a commit in the following line:"
-		warn " - $2"
+		warn " - $line"
 		warn
 	fi
 
@@ -886,37 +888,31 @@ check_commit_sha () {
 # from the todolist in stdin
 check_bad_cmd_and_sha () {
 	retval=0
-	git stripspace --strip-comments |
-	(
-		while read -r line
-		do
-			IFS=' '
-			set -- $line
-			command=$1
-			sha1=$2
-
-			case $command in
-			''|noop|x|"exec")
-				# Doesn't expect a SHA-1
-				;;
-			pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
-				if ! check_commit_sha $sha1 "$line"
-				then
-					retval=1
-				fi
-				;;
-			*)
-				warn "Warning: the command isn't recognized" \
-					"in the following line:"
-				warn " - $line"
-				warn
+	lineno=0
+	while read -r command rest
+	do
+		lineno=$(( $lineno + 1 ))
+		case $command in
+		"$comment_char"*|''|noop|x|exec)
+			# Doesn't expect a SHA-1
+			;;
+		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
+			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"
+			then
 				retval=1
-				;;
-			esac
-		done
-
-		return $retval
-	)
+			fi
+			;;
+		*)
+			line="$(sed -n -e "${lineno}p" "$1")"
+			warn "Warning: the command isn't recognized" \
+				"in the following line:"
+			warn " - $line"
+			warn
+			retval=1
+			;;
+		esac
+	done <"$1"
+	return $retval
 }
 
 # Print the list of the SHA-1 of the commits
@@ -1010,7 +1006,7 @@ check_todo_list () {
 		;;
 	esac
 
-	if ! check_bad_cmd_and_sha <"$todo"
+	if ! check_bad_cmd_and_sha "$todo"
 	then
 		raise_error=t
 	fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d26e3f5..3da3ba3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1227,6 +1227,21 @@ test_expect_success 'static check of bad command' '
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'tabs and spaces are accepted in the todolist' '
+	rebase_setup_and_clean indented-comment &&
+	write_script add-indent.sh <<-\EOF &&
+	(
+		# Turn single spaces into space/tab mix
+		sed "1s/ /\t/g; 2s/ /  /g; 3s/ / \t/g" "$1"
+		printf "\n\t# comment\n #more\n\t # comment\n"
+	) >$1.new
+	mv "$1.new" "$1"
+	EOF
+	test_set_editor "$(pwd)/add-indent.sh" &&
+	git rebase -i HEAD^^^ &&
+	test E = $(git cat-file commit HEAD | sed -ne \$p)
+'
+
 cat >expect <<EOF
 Warning: the SHA-1 is missing or isn't a commit in the following line:
  - edit XXXXXXX False commit
-- 
2.5.0.402.g8854c44
