From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Tue, 03 Feb 2009 09:45:54 -0800
Message-ID: <7vd4dzbei5.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
 <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org>
 <20090202124148.GB8325@sigio.peff.net>
 <7vvdrsdtvr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:47:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPN9-0003Ac-Kw
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbZBCRqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbZBCRqJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:46:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbZBCRqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:46:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C0E7F96FC1;
	Tue,  3 Feb 2009 12:46:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0F97696FBC; Tue,
  3 Feb 2009 12:45:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 87848230-F21A-11DD-AC5E-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108226>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, I just realized one thing.
>
> When we flip the default to "refuse" in 1.7.0 for everybody, we will need
> the explanation and instruction on how to get a non-default behaviour and
> how to squelch the message when we "refuse by defaut", just like my first
> patch did when we "warn by default".  It is entirely possible some people
> simply skip 1.6.2 and directly jump to 1.7.0, and while we cannot help
> them avoid the surprise caused by the change in behaviour, we cannot be
> silent in such a situation.

And this is meant for 1.7.0, and is queued at the tip of 'pu' just for the
heck of it.

It will flip the default to "refuse", but explains why the operation that
used to succeed suddenly started failing, how to get the older behaviour
back (but with caveats), and how to squelch this message.

Adjustments to the tests were resurrected from the previous "init-db"
patch.  Since this is meant for 1.7.0 that does flip the default for
everybody, there is no need to touch init-db anymore.

-- >8 --
[PATCH] Refuse updating the current branch in a non-bare repository via push

This makes git-push to refuse pushing-push into a non-bare repository to
update its current branch by default.  To help people who are used to
be able to do this (and later "reset --hard" it in some other way),
a big error message is issued when this refusal is triggered.

Hosting sites that do not give the users direct access to customize their
repositories (e.g. repo.or.cz, gitorious, github etc.) may further want to
explicitly set the configuration variable to "refuse" for their customers'
repositories.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-receive-pack.c      |   40 +++++++++++++++++-----------------------
 t/t5400-send-pack.sh        |    2 ++
 t/t5401-update-hooks.sh     |    1 +
 t/t5405-send-pack-rewind.sh |    1 +
 t/t5516-fetch-push.sh       |    1 +
 t/t5517-push-mirror.sh      |    3 ++-
 t/t5521-pull-symlink.sh     |   20 +++++++++++++-------
 t/t5701-clone-local.sh      |    4 +++-
 8 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 6f61c45..17ab4f5 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -215,33 +215,27 @@ static int is_ref_checked_out(const char *ref)
 	return !strcmp(head, ref);
 }
 
-static char *warn_unconfigured_deny_msg[] = {
-	"Updating the currently checked out branch may cause confusion,",
-	"as the index and work tree do not reflect changes that are in HEAD.",
-	"As a result, you may see the changes you just pushed into it",
-	"reverted when you run 'git diff' over there, and you may want",
-	"to run 'git reset --hard' before starting to work to recover.",
+static char *refuse_unconfigured_deny_msg[] = {
+	"By default, updating the current branch in a non-bare repository",
+	"is denied, because it will make the index and work tree inconsistent",
+	"with what you pushed, and will require 'git reset --hard' to match",
+	"the work tree to HEAD.",
 	"",
 	"You can set 'receive.denyCurrentBranch' configuration variable to",
-	"'refuse' in the remote repository to forbid pushing into its",
-	"current branch."
+	"'ignore' or 'warn' in the remote repository to allow pushing into",
+	"its current branch; however, this is not recommended unless you",
+	"arranged to update its work tree to match what you pushed in some",
+	"other way.",
 	"",
-	"To allow pushing into the current branch, you can set it to 'ignore';",
-	"but this is not recommended unless you arranged to update its work",
-	"tree to match what you pushed in some other way.",
-	"",
-	"To squelch this message, you can set it to 'warn'.",
-	"",
-	"Note that the default will change in a future version of git",
-	"to refuse updating the current branch unless you have the",
-	"configuration variable set to either 'ignore' or 'warn'."
+	"To squelch this message, you can set the configuration variable to",
+	"'refuse'."
 };
 
-static void warn_unconfigured_deny(void)
+static void refuse_unconfigured_deny(void)
 {
 	int i;
-	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_deny_msg); i++)
-		warning(warn_unconfigured_deny_msg[i]);
+	for (i = 0; i < ARRAY_SIZE(refuse_unconfigured_deny_msg); i++)
+		error(refuse_unconfigured_deny_msg[i]);
 }
 
 static const char *update(struct command *cmd)
@@ -261,14 +255,14 @@ static const char *update(struct command *cmd)
 		switch (deny_current_branch) {
 		case DENY_IGNORE:
 			break;
-		case DENY_UNCONFIGURED:
 		case DENY_WARN:
 			warning("updating the current branch");
-			if (deny_current_branch == DENY_UNCONFIGURED)
-				warn_unconfigured_deny();
 			break;
 		case DENY_REFUSE:
+		case DENY_UNCONFIGURED:
 			error("refusing to update checked out branch: %s", name);
+			if (deny_current_branch == DENY_UNCONFIGURED)
+				refuse_unconfigured_deny();
 			return "branch is currently checked out";
 		}
 	}
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
1.6.1.2.346.g115a3
