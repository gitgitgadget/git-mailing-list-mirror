From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge: refuse to create too cool a merge by default
Date: Fri, 18 Mar 2016 13:21:09 -0700
Message-ID: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:21:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah0ta-0001KQ-3f
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 21:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621AbcCRUVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 16:21:13 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756188AbcCRUVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 16:21:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AC124D882;
	Fri, 18 Mar 2016 16:21:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	4CpaoLuaRnRdrVuMnwEDI8BhvQ=; b=cEVtTslNNrEmksmlaW6SPCzSaBUW/Hv6Y
	iu6mxEtWp8oaP6i9ssKfkj4u3BZuYCbufrL+EIXZAv3zmvewCGk8mnPtPf+R9jdx
	PY7K1lUlimrXLESxzN1r3n3WONzTB23tZhlwT9IHoLH4rzQ91/DS5vOjYp5+/arZ
	QdVJCEuxmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=KUrC1aTRMRjcLMaAPcMN3ljYLRu0glrY2ohDT7ihnWW3iw7NB8M/87DH
	Y0ILUCXQYjtOJHR6Zj0S5di+VetRRNClJJLM/mVbBqLJtUXbRJhrtJXYVny8INxR
	fqS6dboD+utoXV7OQ132AxJhlBdTmfq41Rgu5HLs4pftWBOzoco=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 215C24D881;
	Fri, 18 Mar 2016 16:21:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7CF1A4D880;
	Fri, 18 Mar 2016 16:21:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F434AEBC-ED46-11E5-8CFB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289248>

While it makes sense to allow merging unrelated histories of two
projects that started independently into one, in the way "gitk" was
merged to "git" itself aka "the coolest merge ever", such a merge is
still an unusual event.  Worse, if somebody creates an independent
history by starting from a tarball of an established project and
sends a pull request to the original project, "git merge" however
happily creates such a merge without any sign of something unusual
is happening.

Teach "git merge" to refuse to create such a merge by default,
unless the user passes a new "--allow-unrelated-histories" option to
tell it that the user is aware that two unrelated projects are
merged.

Because such a "two project merge" is a rare event, a configuration
option to always allow such a merge is not added.

We could add the same option to "git pull" and have it passed
through to underlying "git merge".  I do not have a fundamental
opposition against such a feature, but this commit does not do so
and instead leaves it as low-hanging fruit for others, because such
a "two project merge" would be done after fetching the other project
into some location in the working tree of an existing project and
making sure how well they fit together, it is sufficient to allow a
local merge without such an option pass-through from "git pull" to
"git merge".  Many tests that are updated by this patch does the
pass-through manually by turning:

	git pull something

into its equivalent:

	git fetch something &&
        git merge --allow-unrelated-histories FETCH_HEAD

If somebody is inclined to add such an option, updated tests in this
change need to be adjusted back to:

	git pull --allow-unrelated-histories something

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/merge.c                 | 12 +++++++++---
 t/t3412-rebase-root.sh          |  2 +-
 t/t5500-fetch-pack.sh           |  6 ++++--
 t/t6009-rev-list-parent.sh      |  4 +++-
 t/t6010-merge-base.sh           |  6 ++++--
 t/t6012-rev-list-simplify.sh    |  2 +-
 t/t6026-merge-attr.sh           |  3 ++-
 t/t6029-merge-subtree.sh        |  2 +-
 t/t6101-rev-parse-parents.sh    |  2 +-
 t/t9400-git-cvsserver-server.sh |  3 ++-
 10 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 101ffef..e3db41b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -64,6 +64,7 @@ static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
+static int allow_unrelated_histories;
 static int show_progress = -1;
 static int default_to_upstream = 1;
 static const char *sign_commit;
@@ -221,6 +222,8 @@ static struct option builtin_merge_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
+	OPT_BOOL(0, "allow-unrelated-histories", &allow_unrelated_histories,
+		 N_("allow merging unrelated histories")),
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
@@ -1397,9 +1400,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head_commit->object.oid.hash,
 		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
-	if (remoteheads && !common)
-		; /* No common ancestors found. We need a real merge. */
-	else if (!remoteheads ||
+	if (remoteheads && !common) {
+		/* No common ancestors found. */
+		if (!allow_unrelated_histories)
+			die(_("refusing to merge unrelated histories"));
+		/* otherwise, we need a real merge. */
+	} else if (!remoteheads ||
 		 (!remoteheads->next && !common->next &&
 		  common->item == remoteheads->item)) {
 		/*
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 0b52105..73a39f2 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -133,7 +133,7 @@ test_expect_success 'set up second root and merge' '
 	rm A B C &&
 	test_commit 6 D &&
 	git checkout other &&
-	git merge third
+	git merge --allow-unrelated-histories third
 '
 
 cat > expect-third <<'EOF'
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e5f83bf..4fca623 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -259,7 +259,8 @@ test_expect_success 'clone shallow object count' '
 test_expect_success 'pull in shallow repo with missing merge base' '
 	(
 		cd shallow &&
-		test_must_fail git pull --depth 4 .. A
+		git fetch --depth 4 .. A
+		test_must_fail git merge --allow-unrelated-histories FETCH_HEAD
 	)
 '
 
@@ -279,9 +280,10 @@ test_expect_success 'clone shallow depth count' '
 test_expect_success 'clone shallow object count' '
 	(
 		cd shallow &&
+		git prune &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^count: 55" count.shallow
+	grep "^count: 54" count.shallow
 '
 
 test_expect_success 'fetch --no-shallow on full repo' '
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 66cda17..20e3e25 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -47,7 +47,9 @@ test_expect_success 'setup roots, merges and octopuses' '
 	git checkout -b yetanotherbranch four &&
 	test_commit eight &&
 	git checkout master &&
-	test_merge normalmerge newroot &&
+	test_tick &&
+	git merge --allow-unrelated-histories -m normalmerge newroot &&
+	git tag normalmerge &&
 	test_tick &&
 	git merge -m tripus sidebranch anotherbranch &&
 	git tag tripus &&
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 39b3238..e0c5f44 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -215,11 +215,13 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
 	git reset --hard E &&
 	test_commit CC2 &&
 	test_tick &&
-	git merge -s ours CC1 &&
+	# E is a root commit unrelated to MMR root on which CC1 is based
+	git merge -s ours --allow-unrelated-histories CC1 &&
 	test_commit CC-o &&
 	test_commit CCB &&
 	git reset --hard CC1 &&
-	git merge -s ours CC2 &&
+	# E is a root commit unrelated to MMR root on which CC1 is based
+	git merge -s ours --allow-unrelated-histories CC2 &&
 	test_commit CCA &&
 
 	git rev-parse CC1 CC2 >expected &&
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b89cd6b..2a0fbb8 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -71,7 +71,7 @@ test_expect_success setup '
 	note J &&
 
 	git checkout master &&
-	test_tick && git merge -m "Coolest" unrelated &&
+	test_tick && git merge --allow-unrelated-histories -m "Coolest" unrelated &&
 	note K &&
 
 	echo "Immaterial" >elif &&
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 04c0509..ef0cbce 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -176,7 +176,8 @@ test_expect_success 'up-to-date merge without common ancestor' '
 	test_tick &&
 	(
 		cd repo1 &&
-		git pull ../repo2 master
+		git fetch ../repo2 master &&
+		git merge --allow-unrelated-histories FETCH_HEAD
 	)
 '
 
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 73fc240..3e69245 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -49,7 +49,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'initial merge' '
 	git remote add -f gui ../git-gui &&
-	git merge -s ours --no-commit gui/master &&
+	git merge -s ours --no-commit --allow-unrelated-histories gui/master &&
 	git read-tree --prefix=git-gui/ -u gui/master &&
 	git commit -m "Merge git-gui as our subdirectory" &&
 	git checkout -b work &&
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 10b1452..1c6952d 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 	git checkout --orphan tmp &&
 	test_commit start2 &&
 	git checkout master &&
-	git merge -m next start2 &&
+	git merge -m next --allow-unrelated-histories start2 &&
 	test_commit final &&
 
 	test_seq 40 |
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index d708cbf..432c61d 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -45,7 +45,8 @@ test_expect_success 'setup' '
   touch secondrootfile &&
   git add secondrootfile &&
   git commit -m "second root") &&
-  git pull secondroot master &&
+  git fetch secondroot master &&
+  git merge --allow-unrelated-histories FETCH_HEAD &&
   git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
   GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" &&
