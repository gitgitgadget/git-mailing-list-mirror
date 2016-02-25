From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 06/21] completion tests: add tests for the __git_refs() helper function
Date: Thu, 25 Feb 2016 23:50:35 +0100
Message-ID: <1456440650-32623-7-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:52:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4lt-00067C-Vo
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbcBYWwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:52:30 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35765 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751968AbcBYWw3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:52:29 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4ll-0007uU-7U; Thu, 25 Feb 2016 23:52:26 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440746.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287455>

Check how __git_refs() lists refs in different scenarios, i.e.

  - short and full refs,
  - from a local or from a remote repository,
  - remote specified via path, name or URL,
  - with or without a repository specified on the command line,
  - non-existing remote,
  - unique remote branches for 'git checkout's tracking DWIMery,
  - not in a git repository, and
  - interesting combinations of the above.

Seven of these tests expect failure, mostly demonstrating bugs related
to listing refs from a remote repository:

  - ignoring the repository specified on the command line (2 tests),
  - listing refs from the wrong place when the name of a configured
    remote happens to match a directory,
  - listing only 'HEAD' but no short refs from a remote given as URL,
  - listing 'HEAD' even from non-existing remotes (2 tests), and
  - listing 'HEAD' when not in a repository.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 266 ++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 257 insertions(+), 9 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1e8794747efd..7ab398568594 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -370,6 +370,263 @@ test_expect_success '__git_remotes - list remotes=
 from $GIT_DIR/remotes and from
 	test_cmp expect actual
 '
=20
+test_expect_success 'setup for ref completion' '
+	echo content >file1 &&
+	echo more >file2 &&
+	git add file1 file2 &&
+	git commit -m one &&
+	git branch mybranch &&
+	git tag mytag &&
+	(
+		cd otherrepo &&
+		>file &&
+		git add file &&
+		git commit -m initial &&
+		git branch branch
+	) &&
+	git remote add remote "$ROOT/otherrepo/.git" &&
+	git update-ref refs/remotes/remote/branch master &&
+	git update-ref refs/remotes/remote/master master &&
+	git init thirdrepo
+'
+
+test_expect_success '__git_refs - simple' '
+	cat >expected <<-EOF &&
+	HEAD
+	master
+	mybranch
+	remote/branch
+	remote/master
+	mytag
+	EOF
+	(
+		cur=3D &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/master
+	refs/heads/mybranch
+	EOF
+	(
+		cur=3Drefs/heads/ &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - repo given on the command line' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch
+	master
+	EOF
+	(
+		__git_dir=3D"$ROOT/otherrepo/.git" &&
+		cur=3D &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - remote on local file system' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch
+	master
+	EOF
+	(
+		cur=3D &&
+		__git_refs otherrepo >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - remote on local file system - full r=
efs' '
+	cat >expected <<-EOF &&
+	refs/heads/branch
+	refs/heads/master
+	EOF
+	(
+		cur=3Drefs/heads/ &&
+		__git_refs otherrepo >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - configured remote' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch
+	master
+	EOF
+	(
+		cur=3D &&
+		__git_refs remote >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - configured remote - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/branch
+	refs/heads/master
+	EOF
+	(
+		cur=3Drefs/heads/ &&
+		__git_refs remote >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - configured remote - repo given on th=
e command line' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch
+	master
+	EOF
+	(
+		cd thirdrepo &&
+		__git_dir=3D"$ROOT/.git" &&
+		cur=3D &&
+		__git_refs remote >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - configured remote - full refs - repo=
 given on the command line' '
+	cat >expected <<-EOF &&
+	refs/heads/branch
+	refs/heads/master
+	EOF
+	(
+		cd thirdrepo &&
+		__git_dir=3D"$ROOT/.git" &&
+		cur=3Drefs/heads/ &&
+		__git_refs remote >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - configured remote - remote name matc=
hes a directory' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch
+	master
+	EOF
+	mkdir remote &&
+	test_when_finished "rm -rf remote" &&
+	(
+		cur=3D &&
+		__git_refs remote >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - URL remote' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch
+	master
+	EOF
+	(
+		cur=3D &&
+		__git_refs "file://$ROOT/otherrepo/.git" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - URL remote - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/branch
+	refs/heads/master
+	EOF
+	(
+		cur=3Drefs/heads/ &&
+		__git_refs "file://$ROOT/otherrepo/.git" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - non-existing remote' '
+	(
+		cur=3D &&
+		__git_refs non-existing >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_success '__git_refs - non-existing remote - full refs' '
+	(
+		cur=3Drefs/heads/ &&
+		__git_refs non-existing >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_failure '__git_refs - non-existing URL remote' '
+	(
+		cur=3D &&
+		__git_refs "file://$ROOT/non-existing" >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_success '__git_refs - non-existing URL remote - full refs'=
 '
+	(
+		cur=3Drefs/heads/ &&
+		__git_refs "file://$ROOT/non-existing" >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_success '__git_refs - unique remote branches for git check=
out DWIMery' '
+	cat >expected <<-EOF &&
+	HEAD
+	master
+	mybranch
+	otherremote/ambiguous
+	otherremote/otherbranch
+	remote/ambiguous
+	remote/branch
+	remote/master
+	mytag
+	branch
+	master
+	otherbranch
+	EOF
+	for remote_ref in refs/remotes/remote/ambiguous \
+		refs/remotes/otherremote/ambiguous \
+		refs/remotes/otherremote/otherbranch
+	do
+		git update-ref $remote_ref master &&
+		test_when_finished "git update-ref -d $remote_ref"
+	done &&
+	(
+		cur=3D &&
+		__git_refs "" 1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - not in a git repository' '
+	(
+		GIT_CEILING_DIRECTORIES=3D"$ROOT" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd subdir &&
+		cur=3D &&
+		__git_refs >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_success 'remove configured remote used for refs completion=
' '
+	git remote remove remote
+'
+
 test_expect_success '__git_get_config_variables' '
 	cat >expect <<-EOF &&
 	name-1
@@ -488,15 +745,6 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
=20
-test_expect_success 'setup for ref completion' '
-	echo content >file1 &&
-	echo more >file2 &&
-	git add file1 file2 &&
-	git commit -m one &&
-	git branch mybranch &&
-	git tag mytag
-'
-
 test_expect_success 'checkout completes ref names' '
 	test_completion "git checkout m" <<-\EOF
 	master Z
--=20
2.7.2.410.g92cb358
