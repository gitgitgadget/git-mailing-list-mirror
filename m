From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 13/39] i18n: git-sh-setup.sh: mark strings for translation
Date: Wed,  1 Jun 2016 16:41:03 +0000
Message-ID: <1464799289-7639-14-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:44:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Fv-0005CT-3l
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161791AbcFAQnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:43:49 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:49263 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161776AbcFAQns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:43:48 -0400
Received: (qmail 21272 invoked from network); 1 Jun 2016 16:43:32 -0000
Received: (qmail 16351 invoked from network); 1 Jun 2016 16:43:32 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:43:27 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296109>

Positional arguments, such as $0, $1, etc, need to be stored on shell
variables for use in translatable strings, according to gettext manual
[1].

Add git-sh-setup.sh to LOCALIZED_SH variable in Makefile to enable
extraction of string marked for translation by xgettext.

Although git-sh-setup.sh is a shell library to be sourced by other shell
scripts, it is necessary to source git-sh-i18n at this point, because
some scripts don't do it themselves. Not sourcing git-sh-i18n would lead
to failure due to, for instance, gettextln not being found.

Source "$(git --exec-path)"/git-sh-i18n instead of simply git-sh-i18n,
because latter case would fail test t2300-cd-to-toplevel.sh.

[1] http://www.gnu.org/software/gettext/manual/html_node/Preparing-Shell-Scripts.html

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Makefile        |  4 +++-
 git-sh-setup.sh | 62 +++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 0d59718..4e0c4eb 100644
--- a/Makefile
+++ b/Makefile
@@ -2062,7 +2062,9 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
-LOCALIZED_SH = $(SCRIPT_SH) git-parse-remote.sh
+LOCALIZED_SH = $(SCRIPT_SH)
+LOCALIZED_SH += git-parse-remote.sh
+LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
 
 ifdef XGETTEXT_INCLUDE_TESTS
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c48139a..61a3d95 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -2,6 +2,10 @@
 # to set up some variables pointing at the normal git directories and
 # a few helper shell functions.
 
+# Some shell scripts source git-sh-setup (i.e. this scriplet) but
+# don't source git-sh-i18n which is needed here for gettext support.
+. "$(git --exec-path)"/git-sh-i18n
+
 # Having this variable in your environment would break scripts because
 # you would cause "cd" to be taken to unexpected places.  If you
 # like CDPATH, define it for your interactive shell sessions without
@@ -83,14 +87,14 @@ if test -n "$OPTIONS_SPEC"; then
 else
 	dashless=$(basename -- "$0" | sed -e 's/-/ /')
 	usage() {
-		die "usage: $dashless $USAGE"
+		die "$(gettext usage:) $dashless $USAGE"
 	}
 
 	if [ -z "$LONG_USAGE" ]
 	then
-		LONG_USAGE="usage: $dashless $USAGE"
+		LONG_USAGE="$(gettext usage:) $dashless $USAGE"
 	else
-		LONG_USAGE="usage: $dashless $USAGE
+		LONG_USAGE="$(gettext usage:) $dashless $USAGE
 
 $LONG_USAGE"
 	fi
@@ -182,7 +186,7 @@ is_bare_repository () {
 cd_to_toplevel () {
 	cdup=$(git rev-parse --show-toplevel) &&
 	cd "$cdup" || {
-		echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
+		gettextln "Cannot chdir to \$cdup, the toplevel of the working tree" >&2
 		exit 1
 	}
 }
@@ -190,13 +194,16 @@ cd_to_toplevel () {
 require_work_tree_exists () {
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
-		die "fatal: $0 cannot be used without a working tree."
+		program_name=$0
+		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
 	fi
 }
 
 require_work_tree () {
-	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
-	die "fatal: $0 cannot be used without a working tree."
+	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true || {
+		program_name=$0
+		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
+	}
 }
 
 require_clean_work_tree () {
@@ -206,24 +213,49 @@ require_clean_work_tree () {
 
 	if ! git diff-files --quiet --ignore-submodules
 	then
-		echo >&2 "Cannot $1: You have unstaged changes."
+		action=$1
+		case "$action" in
+		rebase)
+			gettextln "Cannot rebase: You have unstaged changes." >&2
+			;;
+		"rewrite branches")
+			gettextln "Cannot rewrite branches: You have unstaged changes." >&2
+			;;
+		"pull with rebase")
+			gettextln "Cannot pull with rebase: You have unstaged changes." >&2
+			;;
+		*)
+			eval_gettextln "Cannot \$action: You have unstaged changes." >&2
+			;;
+		esac
 		err=1
 	fi
 
 	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
 	then
-		if [ $err = 0 ]
+		if test $err = 0
 		then
-		    echo >&2 "Cannot $1: Your index contains uncommitted changes."
+			action=$1
+			case "$action" in
+			rebase)
+				gettextln "Cannot rebase: Your index contains uncommitted changes." >&2
+				;;
+			"pull with rebase")
+				gettextln "Cannot pull with rebase: Your index contains uncommitted changes." >&2
+				;;
+			*)
+				eval_gettextln "Cannot \$action: Your index contains uncommitted changes." >&2
+				;;
+			esac
 		else
-		    echo >&2 "Additionally, your index contains uncommitted changes."
+		    gettextln "Additionally, your index contains uncommitted changes." >&2
 		fi
 		err=1
 	fi
 
-	if [ $err = 1 ]
+	if test $err = 1
 	then
-		test -n "$2" && echo >&2 "$2"
+		test -n "$2" && echo "$2" >&2
 		exit 1
 	fi
 }
@@ -336,12 +368,12 @@ git_dir_init () {
 	then
 		test -z "$(git rev-parse --show-cdup)" || {
 			exit=$?
-			echo >&2 "You need to run this command from the toplevel of the working tree."
+			gettextln "You need to run this command from the toplevel of the working tree." >&2
 			exit $exit
 		}
 	fi
 	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
-		echo >&2 "Unable to determine absolute path of git directory"
+		gettextln "Unable to determine absolute path of git directory" >&2
 		exit 1
 	}
 	: ${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}
-- 
2.7.3
