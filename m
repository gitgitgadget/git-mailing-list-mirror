From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 09/21] completion: respect 'git --git-dir=<path>' when listing remote refs
Date: Thu, 25 Feb 2016 23:50:38 +0100
Message-ID: <1456440650-32623-10-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:52:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4mI-0006N2-0X
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbcBYWwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:52:54 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35792 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699AbcBYWwy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:52:54 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4mA-0007uU-1I; Thu, 25 Feb 2016 23:52:51 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440771.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287458>

In __git_refs() the git commands listing refs, both short and full,
from a given remote repository are run without giving them the path to
the git repository which might have been specified on the command line
via 'git --git-dir=3D<path>'.  This is bad, those git commands should
access the 'refs/remotes/<remote>/' hierarchy or the remote and
credentials configuration in that specified repository.

Use the __gitdir() helper only to find the path to the .git directory
and pass the resulting path to the 'git ls-remote' and 'for-each-ref'
executions that list remote refs.

Don't use __gitdir() to check that the given remote is on the file
system: basically it performs only a single if statement for us at the
considerable cost of fork()ing a subshell for a command substitution.
We are better off to perform all the necessary checks of the remote in
__git_refs().

Though __git_refs() was the last remaining callsite that passed a
remote to __gitdir(), don't delete __gitdir()'s remote-handling part
yet, just in case some users' custom completion scriptlets depend on
it.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 22 +++++++++++++++++-----
 t/t9902-completion.sh                  |  4 ++--
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 59dffe7f39c2..adc968acea9d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -342,9 +342,21 @@ __git_tags ()
 #    'git checkout's tracking DWIMery (optional; ignored, if set but e=
mpty).
 __git_refs ()
 {
-	local i hash dir=3D"$(__gitdir "${1-}")" track=3D"${2-}"
+	local i hash dir=3D"$(__gitdir)" track=3D"${2-}"
+	local from_local=3Dy remote=3D"${1-}"
 	local format refs
-	if [ -d "$dir" ]; then
+
+	if [ -n "$remote" ]; then
+		if [ -d "$remote/.git" ]; then
+			dir=3D"$remote/.git"
+		elif [ -d "$remote" ]; then
+			dir=3D"$remote"
+		else
+			from_local=3Dn
+		fi
+	fi
+
+	if [ "$from_local" =3D y ] && [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
 			format=3D"refname"
@@ -380,7 +392,7 @@ __git_refs ()
 	fi
 	case "$cur" in
 	refs|refs/*)
-		git ls-remote "$dir" "$cur*" 2>/dev/null | \
+		git --git-dir=3D"$dir" ls-remote "$remote" "$cur*" 2>/dev/null | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -390,8 +402,8 @@ __git_refs ()
 		;;
 	*)
 		echo "HEAD"
-		git for-each-ref --format=3D"%(refname:short)" -- \
-			"refs/remotes/$dir/" 2>/dev/null | sed -e "s#^$dir/##"
+		git --git-dir=3D"$dir" for-each-ref --format=3D"%(refname:short)" --=
 \
+			"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 809856110235..f9993d2c005a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -490,7 +490,7 @@ test_expect_success '__git_refs - configured remote=
 - full refs' '
 	test_cmp expected "$actual"
 '
=20
-test_expect_failure '__git_refs - configured remote - repo given on th=
e command line' '
+test_expect_success '__git_refs - configured remote - repo given on th=
e command line' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch
@@ -505,7 +505,7 @@ test_expect_failure '__git_refs - configured remote=
 - repo given on the command
 	test_cmp expected "$actual"
 '
=20
-test_expect_failure '__git_refs - configured remote - full refs - repo=
 given on the command line' '
+test_expect_success '__git_refs - configured remote - full refs - repo=
 given on the command line' '
 	cat >expected <<-EOF &&
 	refs/heads/branch
 	refs/heads/master
--=20
2.7.2.410.g92cb358
