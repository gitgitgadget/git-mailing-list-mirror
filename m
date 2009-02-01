From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Sat, 31 Jan 2009 17:39:56 -0800
Message-ID: <7vk58bylxv.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
 <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRL2-00051b-1d
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbZBABkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbZBABkG
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:40:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbZBABkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:40:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D267958D5;
	Sat, 31 Jan 2009 20:40:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 21373958D2; Sat,
 31 Jan 2009 20:39:57 -0500 (EST)
In-Reply-To: <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 31 Jan 2009 17:27:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F681680-F001-11DD-9E96-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107968>

Junio C Hamano <gitster@pobox.com> writes:

> I haven't manged to convince myself about the "git init" change (I have
> the code and also I've looked at the extent of damage the change causes to
> the existing test suite),...

And here is such a patch.

-- >8 --
Subject: [PATCH] Set receive.denyCurrentBranch to true in a new non-bare repository

This prepares new people to get used to the default planned for 1.7.0;
necessary adjustments are done to many tests, as they all assumed the
traditional "only warn but allow updating" semantics.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-init-db.c           |    2 ++
 t/t5400-send-pack.sh        |    2 ++
 t/t5401-update-hooks.sh     |    1 +
 t/t5405-send-pack-rewind.sh |    1 +
 t/t5516-fetch-push.sh       |    1 +
 t/t5517-push-mirror.sh      |    3 ++-
 t/t5521-pull-symlink.sh     |   20 +++++++++++++-------
 t/t5701-clone-local.sh      |    4 +++-
 8 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..26c10cc 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -250,6 +250,8 @@ static int create_default_files(const char *template_path)
 		    strcmp(git_dir + strlen(work_tree), "/.git")) {
 			git_config_set("core.worktree", work_tree);
 		}
+		if (!reinit)
+			git_config_set("receive.denyCurrentBranch", "refuse");
 	}
 
 	if (!reinit) {
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index b21317d..5c9c277 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -33,6 +33,7 @@ test_expect_success setup '
 	git update-ref HEAD "$commit" &&
 	git clone ./. victim &&
 	cd victim &&
+	git config receive.denyCurrentBranch warn &&
 	git log &&
 	cd .. &&
 	git update-ref HEAD "$zero" &&
@@ -138,6 +139,7 @@ rewound_push_setup() {
 	rm -rf parent child &&
 	mkdir parent && cd parent &&
 	git init && echo one >file && git add file && git commit -m one &&
+	git config receive.denyCurrentBranch warn &&
 	echo two >file && git commit -a -m two &&
 	cd .. &&
 	git clone parent child && cd child && git reset --hard HEAD^
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 64f66c9..325714e 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -18,6 +18,7 @@ test_expect_success setup '
 	git update-ref refs/heads/master $commit0 &&
 	git update-ref refs/heads/tofail $commit1 &&
 	git clone ./. victim &&
+	GIT_DIR=victim/.git git config receive.denyCurrentBranch warn &&
 	GIT_DIR=victim/.git git update-ref refs/heads/tofail $commit1 &&
 	git update-ref refs/heads/master $commit1 &&
 	git update-ref refs/heads/tofail $commit0
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index cb9aacc..4bda18a 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -8,6 +8,7 @@ test_expect_success setup '
 
 	>file1 && git add file1 && test_tick &&
 	git commit -m Initial &&
+	git config receive.denyCurrentBranch warn &&
 
 	mkdir another && (
 		cd another &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 89649e7..a67ebd0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -12,6 +12,7 @@ mk_empty () {
 	(
 		cd testrepo &&
 		git init &&
+		git config receive.denyCurrentBranch warn &&
 		mv .git/hooks .git/hooks-disabled
 	)
 }
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index ea49ded..e2ad260 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -19,7 +19,8 @@ mk_repo_pair () {
 	mkdir mirror &&
 	(
 		cd mirror &&
-		git init
+		git init &&
+		git config receive.denyCurrentBranch warn
 	) &&
 	mkdir master &&
 	(
diff --git a/t/t5521-pull-symlink.sh b/t/t5521-pull-symlink.sh
index 5672b51..66b5ac1 100755
--- a/t/t5521-pull-symlink.sh
+++ b/t/t5521-pull-symlink.sh
@@ -14,13 +14,19 @@ test_description='pulling from symlinked subdir'
 #
 # The working directory is subdir-link.
 
-mkdir subdir
-echo file >subdir/file
-git add subdir/file
-git commit -q -m file
-git clone -q . clone-repo
-ln -s clone-repo/subdir/ subdir-link
-
+test_expect_success setup '
+	mkdir subdir &&
+	echo file >subdir/file &&
+	git add subdir/file &&
+	git commit -q -m file &&
+	git clone -q . clone-repo &&
+	ln -s clone-repo/subdir/ subdir-link &&
+	(
+		cd clone-repo &&
+		git config receive.denyCurrentBranch warn
+	) &&
+	git config receive.denyCurrentBranch warn
+'
 
 # Demonstrate that things work if we just avoid the symlink
 #
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 3559d17..10accc2 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -119,7 +119,9 @@ test_expect_success 'bundle clone with nonexistent HEAD' '
 test_expect_success 'clone empty repository' '
 	cd "$D" &&
 	mkdir empty &&
-	(cd empty && git init) &&
+	(cd empty &&
+	 git init &&
+	 git config receive.denyCurrentBranch warn) &&
 	git clone empty empty-clone &&
 	test_tick &&
 	(cd empty-clone
-- 
1.6.1.2.312.g5be3c
