From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 15/21] completion: fix completion after 'git -C <path>'
Date: Thu, 25 Feb 2016 23:50:44 +0100
Message-ID: <1456440650-32623-16-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:53:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4n9-0006tG-5G
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbcBYWxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:53:48 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35846 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWxr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:53:47 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4my-0007uU-LY; Thu, 25 Feb 2016 23:53:42 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440822.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287464>

The main completion function finds the name of the git command by
iterating through all the words on the command line in search for the
first non-option-looking word.  As it is not aware of 'git -C's
mandatory path argument, if the '-C <path>' option is present, 'path'
will be the first such word and it will be mistaken for a git command.
This breaks completion in various ways:

 - If 'path' happens to match one of the commands supported by the
   completion script, then options of that command will be offered.

 - If 'path' doesn't match a supported command and doesn't contain any
   characters not allowed in Bash identifier names, then the
   completion script does basically nothing and Bash in turn falls
   back to filename completion for all subsequent words.

 - Otherwise, if 'path' does contain such an unallowed character, then
   it leads to a more or less ugly error message in the middle of the
   command line.  The standard '/' directory separator is such a
   character, and it happens to trigger one of the uglier errors:

     $ git -C some/path <TAB>sh.exe": declare: `_git_some/path': not a =
valid identifier
     error: invalid key: alias.some/path

=46ix this by skipping 'git -C's mandatory path argument while iteratin=
g
over the words on the command line.  Extend the relevant test with
this case and, while at it, with cases that needed similar treatment
in the past ('--git-dir', '-c', '--work-tree' and '--namespace').

Additionally, silence the standard error of the 'declare' builtins
looking for the completion function associated with the git command
and of the 'git config' query for the aliased command.  So if git ever
learns a new option with a mandatory argument in the future, then,
though the completion script will again misbehave, at least the
command line will not be utterly disrupted by those error messages.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 8 ++++----
 t/t9902-completion.sh                  | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6027733a4b46..5e5437d7a5c2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -818,7 +818,7 @@ __git_aliases ()
 __git_aliased_command ()
 {
 	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
-		config --get "alias.$1")
+		config --get "alias.$1" 2>/dev/null)
 	for word in $cmdline; do
 		case "$word" in
 		\!gitk|gitk)
@@ -2658,7 +2658,7 @@ __git_main ()
 		--git-dir)   ((c++)) ; __git_dir=3D"${words[c]}" ;;
 		--bare)      __git_dir=3D"." ;;
 		--help) command=3D"help"; break ;;
-		-c|--work-tree|--namespace) ((c++)) ;;
+		-c|-C|--work-tree|--namespace) ((c++)) ;;
 		-*) ;;
 		*) command=3D"$i"; break ;;
 		esac
@@ -2699,13 +2699,13 @@ __git_main ()
 	fi
=20
 	local completion_func=3D"_git_${command//-/_}"
-	declare -f $completion_func >/dev/null && $completion_func && return
+	declare -f $completion_func >/dev/null 2>/dev/null && $completion_fun=
c && return
=20
 	local expansion=3D$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=3D$expansion
 		completion_func=3D"_git_${expansion//-/_}"
-		declare -f $completion_func >/dev/null && $completion_func
+		declare -f $completion_func >/dev/null 2>/dev/null && $completion_fu=
nc
 	fi
 }
=20
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a1f69682e5ec..d172199ed256 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -754,7 +754,12 @@ test_expect_success 'general options plus command'=
 '
 	test_completion "git --namespace=3Dfoo check" "checkout " &&
 	test_completion "git --paginate check" "checkout " &&
 	test_completion "git --info-path check" "checkout " &&
-	test_completion "git --no-replace-objects check" "checkout "
+	test_completion "git --no-replace-objects check" "checkout " &&
+	test_completion "git --git-dir some/path check" "checkout " &&
+	test_completion "git -c conf.var=3Dvalue check" "checkout " &&
+	test_completion "git -C some/path check" "checkout " &&
+	test_completion "git --work-tree some/path check" "checkout " &&
+	test_completion "git --namespace name/space check" "checkout "
 '
=20
 test_expect_success 'git --help completion' '
--=20
2.7.2.410.g92cb358
