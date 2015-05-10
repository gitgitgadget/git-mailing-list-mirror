From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] completion: add a helper function to get config variables
Date: Sun, 10 May 2015 14:50:17 +0200
Message-ID: <1431262218-7304-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 14:53:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrQjw-0001Wu-AY
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 14:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbbEJMxq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 08:53:46 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44984 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751196AbbEJMxp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2015 08:53:45 -0400
Received: from x590d7ec1.dyn.telefonica.de ([89.13.126.193] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YrQjl-0001mT-Fn; Sun, 10 May 2015 14:53:43 +0200
X-Mailer: git-send-email 1.9.5.msysgit.0
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1431262423.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268731>

Currently there are a few completion functions that perform similar 'gi=
t
config' queries and filtering to get config variable names: the complet=
ion
of pretty aliases, aliases, and remote groups for 'git remote update'.

Unify those 'git config' queries in a helper function to eliminate code
duplication.

Though the helper functions to get pretty aliases and alieses are reduc=
ed
to mere one-liner wrappers around the newly added function, keep these
helpers still, because users' completion functions out there might depe=
nd
on them.  And they keep their callers a tad easier to read, too.

Add tests for the pretty alias and alias helper to show that they work
as before; not for the remote groups query, though, because that's not
extracted into a helper function and it's not worth the effort to do so
for a sole callsite.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 34 ++++++++++++++------------=
--------
 t/t9902-completion.sh                  | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5944c824ab..6973620857 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -740,30 +740,29 @@ __git_compute_porcelain_commands ()
 	__git_porcelain_commands=3D$(__git_list_porcelain_commands)
 }
=20
-__git_pretty_aliases ()
+# Lists all set config variables starting with the given section prefi=
x,
+# with the prefix removed.
+__git_get_config_variables ()
 {
-	local i IFS=3D$'\n'
-	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "pretty\=
=2E.*" 2>/dev/null); do
+	local section=3D"$1" i IFS=3D$'\n'
+	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "$sectio=
n\..*" 2>/dev/null); do
 		case "$i" in
-		pretty.*)
-			i=3D"${i#pretty.}"
+		$section.*)
+			i=3D"${i#$section.}"
 			echo "${i/ */}"
 			;;
 		esac
 	done
 }
=20
+__git_pretty_aliases ()
+{
+	__git_get_config_variables "pretty"
+}
+
 __git_aliases ()
 {
-	local i IFS=3D$'\n'
-	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "alias\.=
=2E*" 2>/dev/null); do
-		case "$i" in
-		alias.*)
-			i=3D"${i#alias.}"
-			echo "${i/ */}"
-			;;
-		esac
-	done
+	__git_get_config_variables "alias"
 }
=20
 # __git_aliased_command requires 1 argument
@@ -2260,12 +2259,7 @@ _git_remote ()
 		__git_complete_remote_or_refspec
 		;;
 	update)
-		local i c=3D'' IFS=3D$'\n'
-		for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "remote=
s\..*" 2>/dev/null); do
-			i=3D"${i#remotes.}"
-			c=3D"$c ${i/ */}"
-		done
-		__gitcomp "$c"
+		__gitcomp "$(__git_get_config_variables "remotes")"
 		;;
 	*)
 		;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4a14a5892e..07f2478c9b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -370,6 +370,28 @@ test_expect_success '__git_remotes - list remotes =
from $GIT_DIR/remotes and from
 	test_cmp expect actual
 '
=20
+test_expect_success '__git_pretty_aliases' '
+	cat >expect <<-EOF &&
+	author
+	hash
+	EOF
+	test_config pretty.author "%an %ae" &&
+	test_config pretty.hash %H &&
+	__git_pretty_aliases >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_aliases' '
+	cat >expect <<-EOF &&
+	ci
+	co
+	EOF
+	test_config alias.ci commit &&
+	test_config alias.co checkout &&
+	__git_aliases >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'basic' '
 	run_completion "git " &&
 	# built-in
--=20
1.9.5.msysgit.0
