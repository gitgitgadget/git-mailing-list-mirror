From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 12/21] completion: list short refs from a remote given as a URL
Date: Thu, 25 Feb 2016 23:50:41 +0100
Message-ID: <1456440650-32623-13-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:53:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4mk-0006fF-8h
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbcBYWxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:53:22 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35819 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750984AbcBYWxW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:53:22 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4mb-0007uU-T8; Thu, 25 Feb 2016 23:53:19 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440799.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287460>

e832f5c09680 (completion: avoid ls-remote in certain scenarios,
2013-05-28) turned a 'git ls-remote <remote>' query into a 'git
for-each-ref refs/remotes/<remote>/' to improve responsiveness of
remote refs completion by avoiding potential network communication.
However, it inadvertently made impossible to complete short refs from
a remote given as a URL, e.g. 'git fetch git://server.com/repo.git
<TAB>', because there is, of course, no such thing as
'refs/remotes/git://server.com/repo.git'.

Since the previous commit we tell apart configured remotes, i.e. those
that can have a hierarchy under 'refs/remotes/', from others that
don't, including remotes given as URL, so we know when we can't use
the faster 'git for-each-ref'-based approach.

Resurrect the old, pre-e832f5c09680 'git ls-remote'-based code for the
latter case to support listing short refs from remotes given as a URL.
The code is slightly updated from the original to

  - take into account the path to the repository given on the command
    line (if any), and
  - omit 'ORIG_HEAD' from the query, as 'git ls-remote' will never
    list it anyway.

When the remote given to __git_refs() doesn't exist, then it will be
handled by this resurrected 'git ls-remote' query.  This code path
doesn't list 'HEAD' unconditionally, which has the nice side effect of
fixing two more expected test failures.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 22 ++++++++++++++++++----
 t/t9902-completion.sh                  |  6 +++---
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index f6ccfb708451..6932d2a276eb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -338,12 +338,13 @@ __git_tags ()
 # Lists refs from the local (by default) or from a remote repository.
 # It accepts 0, 1 or 2 arguments:
 # 1: The remote to lists refs from (optional; ignored, if set but empt=
y).
+#    Can be the name of a configured remote, a path, or a URL.
 # 2: In addition to local refs, list unique branches from refs/remotes=
/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but e=
mpty).
 __git_refs ()
 {
 	local i hash dir=3D"$(__gitdir)" track=3D"${2-}"
-	local from_local=3Dy remote=3D"${1-}"
+	local from_local=3Dy remote=3D"${1-}" named_remote=3Dn
 	local format refs
=20
 	if [ -z "$dir" ] && [ -z "$remote" ]; then
@@ -355,6 +356,7 @@ __git_refs ()
 			# configured remote takes precedence over a
 			# local directory with the same name
 			from_local=3Dn
+			named_remote=3Dy
 		else
 			if [ -d "$remote/.git" ]; then
 				dir=3D"$remote/.git"
@@ -411,9 +413,21 @@ __git_refs ()
 		done
 		;;
 	*)
-		echo "HEAD"
-		git --git-dir=3D"$dir" for-each-ref --format=3D"%(refname:short)" --=
 \
-			"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
+		if [ "$named_remote" =3D y ]; then
+			echo "HEAD"
+			git --git-dir=3D"$dir" for-each-ref --format=3D"%(refname:short)" -=
- \
+				"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
+		else
+			git --git-dir=3D"$dir" ls-remote "$remote" HEAD \
+				'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' 2>/dev/null |
+			while read -r hash i; do
+				case "$i" in
+				*^{})	;;
+				refs/*)	echo "${i#refs/*/}" ;;
+				*)	echo "$i" ;;
+				esac
+			done
+		fi
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f42a9ba9058f..a1f69682e5ec 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -543,7 +543,7 @@ test_expect_success '__git_refs - configured remote=
 - remote name matches a dire
 	test_cmp expected "$actual"
 '
=20
-test_expect_failure '__git_refs - URL remote' '
+test_expect_success '__git_refs - URL remote' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch
@@ -568,7 +568,7 @@ test_expect_success '__git_refs - URL remote - full=
 refs' '
 	test_cmp expected "$actual"
 '
=20
-test_expect_failure '__git_refs - non-existing remote' '
+test_expect_success '__git_refs - non-existing remote' '
 	(
 		cur=3D &&
 		__git_refs non-existing >"$actual"
@@ -584,7 +584,7 @@ test_expect_success '__git_refs - non-existing remo=
te - full refs' '
 	test_must_be_empty "$actual"
 '
=20
-test_expect_failure '__git_refs - non-existing URL remote' '
+test_expect_success '__git_refs - non-existing URL remote' '
 	(
 		cur=3D &&
 		__git_refs "file://$ROOT/non-existing" >"$actual"
--=20
2.7.2.410.g92cb358
