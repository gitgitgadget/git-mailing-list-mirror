From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated commits
Date: Tue, 26 May 2015 23:38:38 +0200
Message-ID: <1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 23:38:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMYi-00005t-N5
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbbEZVio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 17:38:44 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:46099 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217AbbEZVin (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 17:38:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 56090271E;
	Tue, 26 May 2015 23:38:42 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OUs3h7FxV4NS; Tue, 26 May 2015 23:38:42 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 44D8B26FF;
	Tue, 26 May 2015 23:38:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 3FD4E20D8;
	Tue, 26 May 2015 23:38:42 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RTNfTE3MvRTA; Tue, 26 May 2015 23:38:42 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.univnautes.lan (eduspot-condillac.crous-grenoble.fr [193.52.241.183])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 2000120D4;
	Tue, 26 May 2015 23:38:42 +0200 (CEST)
X-Mailer: git-send-email 2.4.1.174.g28bfe8e
In-Reply-To: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269979>

Check if commits were removed (i.e. a line was deleted) or dupplicated
(e.g. the same commit is picked twice), can print warnings or abort
git rebase according to the value of the configuration variable
rebase.checkLevel.

Add the configuration variable rebase.checkLevel.
    - When unset or set to "IGNORED", no checking is done.
    - When set to "WARN", the commits are checked, warnings are
      displayed but git rebase still proceeds.
    - When set to "ERROR", the commits are checked, warnings are
      displayed and the rebase is aborted.

Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
---
 This part of the patch has no test yet, it is more for rfc.

 Documentation/config.txt     |  8 +++++
 Documentation/git-rebase.txt |  5 +++
 git-rebase--interactive.sh   | 76 ++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 89 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d44bc85..2152e27 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2204,6 +2204,14 @@ rebase.autoStash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
=20
+rebase.checkLevel::
+	If set to "warn", git rebase -i will print a warning if some
+	commits are removed (i.e. a line was deleted) or if some
+	commits appear more than one time (e.g. the same commit is
+	picked twice), however the rebase will still proceed. If set
+	to "error", it will print the previous warnings and abort the
+	rebase.
+
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
 	capability to its clients. If you don't want to this capability
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 3cd2ef2..cb05cbb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -213,6 +213,11 @@ rebase.autoSquash::
 rebase.autoStash::
 	If set to true enable '--autostash' option by default.
=20
+rebase.checkLevel::
+	If set to "warn" print warnings about removed commits and
+	duplicated commits in interactive mode. If set to "error"
+	print the warnings and abort the rebase. No check by default.
+
 OPTIONS
 -------
 --onto <newbase>::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cb749e8..8a837ca 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -837,6 +837,80 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
=20
+# Print the list of the sha-1 of the commits
+# from a todo list in a file.
+# $1 : todo-file, $2 : outfile
+todo_list_to_sha_list () {
+	todo_list=3D$(git stripspace --strip-comments < "$1")
+	temp_file=3D$(mktemp)
+	echo "$todo_list" > "$temp_file"
+	while read -r command sha1 rest < "$temp_file"
+	do
+		case "$command" in
+		x|"exec")
+			;;
+		*)
+			echo "$sha1" >> "$2"
+			;;
+		esac
+		sed -i '1d' "$temp_file"
+	done
+	rm "$temp_file"
+}
+
+# Check if the user dropped some commits by mistake
+# or if there are two identical commits.
+# Behaviour determined by .gitconfig.
+check_commits () {
+	checkLevel=3D$(git config --get rebase.checkLevel)
+	checkLevel=3D${checkLevel:-"IGNORE"}
+	# To uppercase
+	checkLevel=3D$(echo "$checkLevel" | tr '[:lower:]' '[:upper:]')
+
+	case "$checkLevel" in
+	"WARN"|"ERROR")
+		todo_list_to_sha_list "$todo".backup "$todo".oldsha1
+		todo_list_to_sha_list "$todo" "$todo".newsha1
+
+		duplicates=3D$(sort "$todo".newsha1 | uniq -d)
+
+		echo "$(sort -u "$todo".oldsha1)" > "$todo".oldsha1
+		echo "$(sort -u "$todo".newsha1)" > "$todo".newsha1
+		missing=3D$(comm -2 -3 "$todo".oldsha1 "$todo".newsha1)
+
+		# check missing commits
+		if ! test -z "$missing"
+		then
+			warn "Warning : some commits may have been dropped accidentally."
+			warn "Dropped commits:"
+			warn "$missing"
+			warn "To avoid this message, use \"drop\" to explicitely remove a c=
ommit."
+			warn "Use git --config rebase.checkLevel to change"
+			warn "the level of warnings (ignore,warn,error)."
+			warn ""
+
+			if test "$checkLevel" =3D "ERROR"
+			then
+				die_abort "Rebase aborted due to dropped commits."
+			fi
+		fi
+
+		# check duplicate commits
+		if ! test -z "$duplicates"
+		then
+			warn "Warning : some commits have been used twice:"
+			warn "$duplicates"
+			warn ""
+		fi
+		;;
+	"IGNORE")
+		;;
+	*)
+		warn "Unrecognized setting for option rebase.checkLevel in git rebas=
e -i"
+		;;
+	esac
+}
+
 # The whole contents of this file is run by dot-sourcing it from
 # inside a shell function.  It used to be that "return"s we see
 # below were not inside any function, and expected to return
@@ -1082,6 +1156,8 @@ has_action "$todo" ||
=20
 expand_todo_ids
=20
+check_commits
+
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_pi=
cks
=20
 GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION: checkout $onto_name"
--=20
2.4.1.174.g28bfe8e
