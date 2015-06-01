From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Mon,  1 Jun 2015 13:52:03 +0200
Message-ID: <1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
References: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stephen Kelly <steveire@gmail.com>,
	=?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 01 13:52:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzOGT-0000ns-SI
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 13:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbbFALwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 07:52:18 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:43762 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422AbbFALwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 07:52:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4891F48841;
	Mon,  1 Jun 2015 13:52:13 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ubqCw4HRE3RD; Mon,  1 Jun 2015 13:52:13 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2A51D48836;
	Mon,  1 Jun 2015 13:52:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 1F53520E4;
	Mon,  1 Jun 2015 13:52:13 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id meW3YmeGvu0K; Mon,  1 Jun 2015 13:52:13 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.grenet.fr (eduroam-032225.grenet.fr [130.190.32.225])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id C19AE20DD;
	Mon,  1 Jun 2015 13:52:12 +0200 (CEST)
X-Mailer: git-send-email 2.4.1.363.g9535a9c
In-Reply-To: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270405>

Check if commits were removed (i.e. a line was deleted) and print
warnings or abort git rebase according to the value of the
configuration variable rebase.checkLevel.

Add the configuration variable rebase.checkLevel.
    - When unset or set to "ignore", no checking is done.
    - When set to "warn", the commits are checked, warnings are
      displayed but git rebase still proceeds.
    - When set to "error", the commits are checked, warnings are
      displayed and the rebase is aborted.

rebase.checkLevel defaults to "ignore".

Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
---
 Documentation/config.txt      |   9 ++++
 Documentation/git-rebase.txt  |   6 +++
 git-rebase--interactive.sh    | 105 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t3404-rebase-interactive.sh |  10 +++-
 4 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f76e8c..e2e5554 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2160,6 +2160,15 @@ rebase.autoStash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
=20
+rebase.checkLevel::
+	If set to "warn", git rebase -i will print a warning if some
+	commits are removed (i.e. a line was deleted) or if some
+	commits appear more than one time (e.g. the same commit is
+	picked twice), however the rebase will still proceed. If set
+	to "error", it will print the previous warnings and abort the
+	rebase. If set to "ignore", no checking is done.  Defaults to
+	"ignore".
+
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
 	capability to its clients. If you don't want to this capability
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 9cf3760..d348ca2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -213,6 +213,12 @@ rebase.autoSquash::
 rebase.autoStash::
 	If set to true enable '--autostash' option by default.
=20
+rebase.checkLevel::
+	If set to "warn" print warnings about removed commits and
+	duplicated commits in interactive mode. If set to "error"
+	print the warnings and abort the rebase. If set to "ignore" no
+	checking is done. "ignore" by default.
+
 OPTIONS
 -------
 --onto <newbase>::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2882276..58da6ee 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -837,6 +837,109 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
=20
+# Print the list of the SHA-1 of the commits
+# from a todo list in a file.
+# $1: todo-file, $2: outfile
+todo_list_to_sha_list () {
+	todo_list=3D$(git stripspace --strip-comments <"$1")
+	temp_file=3D$(mktemp)
+	echo "$todo_list" >$temp_file
+	while read -r command sha1 rest
+	do
+		case $command in
+		x|"exec")
+			;;
+		*)
+			printf "%s\n" "$sha1"
+			;;
+		esac
+	done <$temp_file >"$2"
+	rm $temp_file
+}
+
+# Transforms SHA-1 list in argument
+# to a list of commits (in place)
+# Doesn't check if the SHA-1 are commits.
+# $1: file with long SHA-1 list
+long_sha_to_commit_list () {
+	short_missing=3D""
+	git_command=3D"git show --oneline"
+	get_line_command=3D"head -n 1"
+	temp_file=3D$(mktemp)
+	while read -r sha
+	do
+		if test -n "$sha"
+		then
+			commit=3D$($git_command $sha | $get_line_command)
+			if test -n "$commit"
+			then
+				printf "%s\n" "$commit"
+			fi
+		fi
+	done <"$1" >$temp_file
+	mv $temp_file "$1"
+}
+
+# Use warn for each line of a file
+# $1: file to warn
+warn_file () {
+	while read -r line
+	do
+		warn " - $line"
+	done <"$1"
+}
+
+# Check if the user dropped some commits by mistake
+# Behaviour determined by .gitconfig.
+check_commits () {
+	checkLevel=3D$(git config --get rebase.checkLevel)
+	checkLevel=3D${checkLevel:-ignore}
+	# To lowercase
+	checkLevel=3D$(echo "$checkLevel" | tr 'A-Z' 'a-z')
+
+	case "$checkLevel" in
+	warn|error)
+		# Get the SHA-1 of the commits
+		todo_list_to_sha_list "$todo".backup "$todo".oldsha1
+		todo_list_to_sha_list "$todo" "$todo".newsha1
+
+		# Sort the SHA-1 and compare them
+		echo "$(sort -u "$todo".oldsha1)" >"$todo".oldsha1
+		echo "$(sort -u "$todo".newsha1)" >"$todo".newsha1
+		echo "$(comm -2 -3 "$todo".oldsha1 "$todo".newsha1)" >"$todo".miss
+
+		# Make the list user-friendly
+		long_sha_to_commit_list "$todo".miss
+
+		# Check missing commits
+		if test -s "$todo".miss
+		then
+			warn "Warning : some commits may have been dropped" \
+				"accidentally."
+			warn "Dropped commits (in no relevent order):"
+			warn_file "$todo".miss
+			warn ""
+			warn "To avoid this message, use \"drop\" to" \
+				"explicitly remove a commit."
+			warn "Use git --config rebase.checkLevel to change" \
+				"the level of warnings (ignore,warn,error)."
+			warn ""
+
+			if test "$checkLevel" =3D error
+			then
+				die_abort "Rebase aborted due to dropped commits."
+			fi
+		fi
+		;;
+	ignore)
+		;;
+	*)
+		warn "Unrecognized setting $checkLevel for option" \
+			"rebase.checkLevel in git rebase -i."
+		;;
+	esac
+}
+
 # The whole contents of this file is run by dot-sourcing it from
 # inside a shell function.  It used to be that "return"s we see
 # below were not inside any function, and expected to return
@@ -1079,6 +1182,8 @@ has_action "$todo" ||
=20
 expand_todo_ids
=20
+check_commits
+
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_pi=
cks
=20
 GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION: checkout $onto_name"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 1bad068..d3a9ed5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1103,7 +1103,6 @@ test_expect_success 'rebase -i commits that overw=
rite untracked files (no ff)' '
 '
=20
 test_expect_success 'drop' '
-	git checkout master &&
 	test_when_finished "git checkout master" &&
 	git checkout -b dropBranchTest master &&
 	set_fake_editor &&
@@ -1113,4 +1112,13 @@ test_expect_success 'drop' '
 	test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
 '
=20
+test_expect_success 'rebase -i respects rebase.checkLevel' '
+	test_config rebase.checkLevel error &&
+	test_when_finished "git checkout master" &&
+	git checkout -b tmp2 master &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES=3D"1 2 3 4" git rebase -i --root &&
+	test E =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
 test_done
--=20
2.4.1.363.g9535a9c
