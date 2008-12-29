From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH v3] Add a commit.signoff configuration option to always use --signoff in commit
Date: Mon, 29 Dec 2008 12:16:45 +0100
Message-ID: <1230549405-10000-1-git-send-email-dato@net.com.org.es>
References: <20081227120128.GA11322@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 29 12:18:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHG8x-0002kl-By
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 12:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbYL2LQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 06:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbYL2LQu
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 06:16:50 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4608
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbYL2LQt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 06:16:49 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 1D276802791D;
	Mon, 29 Dec 2008 12:16:47 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LHG73-0002eS-IH; Mon, 29 Dec 2008 12:16:45 +0100
X-Mailer: git-send-email 1.6.1.307.g07803
In-Reply-To: <20081227120128.GA11322@chistera.yi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104096>

The intent is that it only applies when the user runs `git commit`
themselves, hence a number of commands (rebase and revert/cherry-pick)
have started passing --no-signoff when invoking commit.

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---

Hello, I've worked a bit more on this patch, and I'd like to know if
it's going in a good direction or not. Changes since v2:

 t/t7500-commit.sh        |   22 ++++++++++++++++++++++

   * add tests to check that commit.signoff works correctly, and that=20
     is overriden by --no-signoff

 git-rebase.sh            |    2 +-
 t/t3402-rebase-merge.sh  |    6 +++++-

   * make git-rebase pass --no-signoff when invoking `git commit`, and
     add a test for it
  =20
 builtin-revert.c         |    2 ++

   * make revert/cherry-pick pass --no-signoff unless -s was given by
     the user (missing test)
  =20
 Documentation/config.txt |    4 ++--

   * improve config.txt wording as per <20081227120128.GA11322@chistera=
=2Eyi.org>

(I don't know if it's customary to send a diff from v2 to v3, if it is
please let me know.)

Thanks,

 Documentation/config.txt     |    9 +++++++++
 Documentation/git-commit.txt |    3 ++-
 builtin-commit.c             |    5 +++++
 builtin-revert.c             |    2 ++
 git-rebase.sh                |    2 +-
 t/t3402-rebase-merge.sh      |    6 +++++-
 t/t7500-commit.sh            |   22 ++++++++++++++++++++++
 7 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 52786c7..13f2200 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -591,6 +591,15 @@ color.ui::
 commit.template::
 	Specify a file to use as the template for new commit messages.
=20
+commit.signoff::
+	If set, 'git commit' will behave as if '-s' option was given.
+	Please use this option with care: by enabling it globally, you'd
+	be stating that all your commits will invariably meet the S-o-b
+	requirements for any project you send patches to. It's probably
+	best to only use it from your private repositories' .git/config
+	file, and only for projects who require a S-o-b as proof of
+	provenance of the patch, and not of its correctness or quality.
+
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
 	files, do not consider stat-only change as changed.
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index b5d81be..abab839 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -96,7 +96,8 @@ OPTIONS
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.
+	log message. This overrides the `commit.signoff` configuration
+	variable.
=20
 -n::
 --no-verify::
diff --git a/builtin-commit.c b/builtin-commit.c
index e88b78f..fc09539 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -929,6 +929,11 @@ static int git_commit_config(const char *k, const =
char *v, void *cb)
 	if (!strcmp(k, "commit.template"))
 		return git_config_string(&template_file, k, v);
=20
+	if (!strcmp(k, "commit.signoff")) {
+		signoff =3D git_config_bool(k, v);
+		return 0;
+	}
+
 	return git_status_config(k, v, cb);
 }
=20
diff --git a/builtin-revert.c b/builtin-revert.c
index d48313c..395c7a5 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -429,6 +429,8 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 		args[i++] =3D "-n";
 		if (signoff)
 			args[i++] =3D "-s";
+		else
+			args[i++] =3D "--no-signoff";
 		if (!edit) {
 			args[i++] =3D "-F";
 			args[i++] =3D defmsg;
diff --git a/git-rebase.sh b/git-rebase.sh
index ebd4df3..bf520d0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -63,7 +63,7 @@ continue_merge () {
 	cmt=3D`cat "$dotest/current"`
 	if ! git diff-index --quiet --ignore-submodules HEAD --
 	then
-		if ! git commit --no-verify -C "$cmt"
+		if ! git commit --no-verify --no-signoff -C "$cmt"
 		then
 			echo "Commit failed, please do not call \"git commit\""
 			echo "directly, but instead do one of the following: "
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 7b7d072..bd2d08c 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -41,7 +41,8 @@ test_expect_success setup '
 	git branch test-rebase side &&
 	git branch test-rebase-pick side &&
 	git branch test-reference-pick side &&
-	git checkout -b test-merge side
+	git checkout -b test-merge side &&
+	git config commit.signoff true
 '
=20
 test_expect_success 'reference merge' '
@@ -54,6 +55,9 @@ test_expect_success rebase '
 	GIT_TRACE=3D1 git rebase --merge master
 '
=20
+test_expect_success 'rebase uses --no-signoff' '
+	!(git log | grep -q Signed-off-by)'
+
 test_expect_success 'test-rebase@{1} is pre rebase' '
 	test $PRE_REBASE =3D $(git rev-parse test-rebase@{1})
 '
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 6e18a96..c7deb3e 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -147,6 +147,10 @@ zort
 Signed-off-by: C O Mitter <committer@example.com>
 EOF
=20
+cat > expect_no_signoff << EOF
+zort
+EOF
+
 test_expect_success '--signoff' '
 	echo "yet another content *narf*" >> foo &&
 	echo "zort" | (
@@ -157,6 +161,24 @@ test_expect_success '--signoff' '
 	test_cmp expect output
 '
=20
+test_expect_success 'commit.signoff' '
+	echo "and more content" >> foo &&
+	git config commit.signoff true &&
+	echo "zort" | git commit -F - foo &&
+	git config --unset commit.signoff &&
+	git cat-file commit HEAD | sed "1,/^$/d" > output &&
+	test_cmp expect output
+'
+
+test_expect_success '--no-signoff trumps commit.signoff' '
+	echo "and even more" >> foo &&
+	git config commit.signoff true &&
+	echo "zort" | git commit --no-signoff -F - foo &&
+	git config --unset commit.signoff &&
+	git cat-file commit HEAD | sed "1,/^$/d" > output &&
+	test_cmp expect_no_signoff output
+'
+
 test_expect_success 'commit message from file (1)' '
 	mkdir subdir &&
 	echo "Log in top directory" >log &&
--=20
1.6.1.307.g07803
