From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: fix completion after 'git -C path'
Date: Mon,  5 Oct 2015 14:02:15 +0200
Message-ID: <1444046535-18316-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 14:18:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj4io-0003G0-Dq
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 14:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbbJEMSQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2015 08:18:16 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:40969 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810AbbJEMSQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 08:18:16 -0400
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2015 08:18:15 EDT
Received: from x590c1d09.dyn.telefonica.de ([89.12.29.9] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1Zj4Ta-00080x-Bg; Mon, 05 Oct 2015 14:02:44 +0200
X-Mailer: git-send-email 2.6.0.rc2.22.g7128296
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1444046564.
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1444047494.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279057>

The main completion function finds the name of the git command by
iterating through all the words on the command line in search for the
first non-option-looking word.  As it is not aware of 'git -C's
mandatory path argument, if the '-C path' option is present, 'path' wil=
l
be the first such word and it will be mistaken for a git command.  This
breaks the completion script in various ways:

 - If 'path' happens to match one of the commands supported by the
   completion script, then its options will be offered.

 - If 'path' doesn't match a supported command and doesn't contain any
   characters not allowed in Bash identifier names, then the completion
   script does basically nothing and lets Bash to fall back to filename
   completion.

 - Otherwise, if 'path' contains such unallowed characters, then it
   leads to a more or less ugly error in the middle of the command line=
=2E
   The standard '/' directory separator is such a character, and it
   happens to trigger one of the uglier errors:

     $ git -C some/path <TAB>sh.exe": declare: `_git_some/path': not a =
valid identifier
     error: invalid key: alias.some/path

=46ix this by skipping 'git -C's mandatory path argument while iteratin=
g
over the words on the command line.  Extend the relevant test with this
case and, while at it, with cases that needed similar treatment in the
past ('--git-dir', '-c', '--work-tree' and '--namespace').
Additionally, shut up standard error of the 'declare' commands looking
for the associated completion function and of the 'git config' query fo=
r
the aliased command, so if git learns a new option with a mandatory
argument in the future, then at least the command line will not be
utterly disrupted by those error messages.

Note, that this change merely fixes the breakage related to 'git -C
path', but the completion script will not take it into account as it
does '--git-dir path'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 8 ++++----
 t/t9902-completion.sh                  | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 482ca84b45..80dc717fe2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -763,7 +763,7 @@ __git_aliases ()
 __git_aliased_command ()
 {
 	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
-		config --get "alias.$1")
+		config --get "alias.$1" 2>/dev/null)
 	for word in $cmdline; do
 		case "$word" in
 		\!gitk|gitk)
@@ -2571,7 +2571,7 @@ __git_main ()
 		--git-dir)   ((c++)) ; __git_dir=3D"${words[c]}" ;;
 		--bare)      __git_dir=3D"." ;;
 		--help) command=3D"help"; break ;;
-		-c|--work-tree|--namespace) ((c++)) ;;
+		-c|-C|--work-tree|--namespace) ((c++)) ;;
 		-*) ;;
 		*) command=3D"$i"; break ;;
 		esac
@@ -2604,13 +2604,13 @@ __git_main ()
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
index 2ba62fbc17..f5a669918d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -480,7 +480,12 @@ test_expect_success 'general options plus command'=
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
2.6.0.rc2.22.g7128296
