From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Thu, 27 Jun 2013 12:48:52 -0700
Message-ID: <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 27 21:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsIBh-0000IL-BP
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 21:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab3F0Ts5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 15:48:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714Ab3F0Ts4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 15:48:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A18329A1F;
	Thu, 27 Jun 2013 19:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v3nRaF7aG6tjZvgYqi1c0Tug9Cg=; b=aFjY28
	Cs6qM9QdElsCcueV0ofgGhR5XW0VkNcjRaYrRzG5oltffvxsCdwKjQse/kpZzzPe
	IEhZUEzjZGiEzgb8iQREnSEPNCQUa52Ae+tk1jN5xzeS4PbeFUXCkpWMAy1+TM/g
	cyfvcIdKD/Uiv4XPvFtltxupqSlqnyK84c6u0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qRK4WB/vyyP8Pd16t64Gl4Q7neBz98Zr
	4xFOST+6Q3vry3JVBS9nlaildKzvkWx9tDGu7bZA2FFVw5kYGLa3I/QubntrgOaQ
	w4qZAhfden3q3NWTYRWPFWj17063Da42baiKeB0Vfe/HcOfrT6pt4u5i8M4IDilk
	Sile5R8kPP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 498E229A1E;
	Thu, 27 Jun 2013 19:48:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE05D29A1B;
	Thu, 27 Jun 2013 19:48:53 +0000 (UTC)
In-Reply-To: <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 23 May 2013 17:03:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98ED2286-DF62-11E2-BDBC-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229149>

Because letting a trivial merge automatically handled by Git is so
easy with "git pull", a person who is new to Git may not realize
that the project s/he is interacting with may prefer "rebase"
workflow.  Add a safety valve to fail "git pull" that is not a
fast-forward until/unless the user expressed her preference between
the two.

Those who want the existing behaviour could just do

    git config --global pull.rebase false

once, and they'd not even notice.

    http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225326

for a full discussion.

The fallout from this change to test suite is not very pretty, though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is not a serious inclusion proposal yet, but to see if
   people are still interested in possibly helping new users.

 git-pull.sh                            | 36 +++++++++++++++++++++++++++++++++-
 t/annotate-tests.sh                    |  2 +-
 t/t4013-diff-various.sh                |  2 ++
 t/t4200-rerere.sh                      |  2 ++
 t/t5500-fetch-pack.sh                  |  6 +++++-
 t/t5521-pull-options.sh                |  2 ++
 t/t5524-pull-msg.sh                    |  2 +-
 t/t5700-clone-reference.sh             |  4 ++--
 t/t6022-merge-rename.sh                |  2 ++
 t/t6026-merge-attr.sh                  |  2 +-
 t/t6029-merge-subtree.sh               |  1 +
 t/t6037-merge-ours-theirs.sh           |  2 ++
 t/t9114-git-svn-dcommit-merge.sh       |  2 +-
 t/t9400-git-cvsserver-server.sh        |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh |  2 +-
 15 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 638aabb..4a6a863 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -41,13 +41,21 @@ test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity= progress= recurse_submodules= verify_signatures=
 merge_args= edit=
+
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
+
+# See if we are configured to rebase by default.
+# The value $rebase is, throughout the main part of the code:
+#    (empty) - the user did not have any preference
+#    true    - the user told us to integrate by rebasing
+#    flase   - the user told us to integrate by merging
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
 if test -z "$rebase"
 then
 	rebase=$(git config --bool pull.rebase)
 fi
+
 dry_run=
 while :
 do
@@ -113,7 +121,8 @@ do
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		rebase=true
 		;;
-	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
+	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase|\
+	-m|--m|--me|--mer|--merg|--merge)
 		rebase=false
 		;;
 	--recurse-submodules)
@@ -219,6 +228,7 @@ test true = "$rebase" && {
 		fi
 	done
 }
+
 orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
@@ -264,6 +274,30 @@ case "$merge_head" in
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
 	;;
+*)
+	# integrating with a single other history
+	merge_head=${merge_head% }
+	if test -z "$rebase$no_ff$ff_only${squash#--no-squash}" &&
+		test -n "$orig_head" &&
+		! $(git merge-base --is-ancestor "$orig_head" "$merge_head")
+	then
+echo >&2 "orig-head was $orig_head"
+echo >&2 "merge-head is $merge_head"
+git show >&2 --oneline -s "$orig_head" "$merge_head"
+
+		die "The pull does not fast-forward; please specify
+if you want to merge or rebase.
+
+Use either
+
+    git pull --rebase
+    git pull --merge
+
+You can also use 'git config pull.rebase true' (if you want --rebase) or
+'git config pull.rebase false' (if you want --merge) to set this once for
+this project and forget about it."
+	fi
+	;;
 esac
 
 if test -z "$orig_head"
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index c56a77d..af02c6d 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -79,7 +79,7 @@ test_expect_success \
 
 test_expect_success \
     'merge-setup part 3' \
-    'git pull . branch1'
+    'git pull --merge . branch1'
 
 test_expect_success \
     'Two lines blamed on A, one on B, two on B1, one on B2' \
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e77c09c..1ee2198 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -12,6 +12,8 @@ LF='
 
 test_expect_success setup '
 
+	git config pull.rebase false &&
+
 	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:00:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7f6666f..0563357 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -25,6 +25,8 @@ test_description='git rerere
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	git config pull.rebase false &&
+
 	cat >a1 <<-\EOF &&
 	Some title
 	==========
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index fd2598e..4be8877 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -143,7 +143,11 @@ test_expect_success 'clone shallow depth 1 with fsck' '
 '
 
 test_expect_success 'clone shallow' '
-	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
+	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow &&
+	(
+		cd shallow &&
+		git config pull.rebase false
+	)
 '
 
 test_expect_success 'clone shallow depth count' '
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 453aba5..d821fab 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -91,6 +91,8 @@ test_expect_success 'git pull --force' '
 	[branch "master"]
 		remote = two
 		merge = refs/heads/master
+	[pull]
+		rebase = false
 	EOF
 	git pull two &&
 	test_commit A &&
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 8cccecc..660714b 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 test_expect_success pull '
 (
 	cd cloned &&
-	git pull --log &&
+	git pull --log --merge &&
 	git log -2 &&
 	git cat-file commit HEAD >result &&
 	grep Dollar result
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 6537911..306badf 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -94,7 +94,7 @@ cd "$base_dir"
 
 test_expect_success 'pulling changes from origin' \
 'cd C &&
-git pull origin'
+git pull --merge origin'
 
 cd "$base_dir"
 
@@ -109,7 +109,7 @@ cd "$base_dir"
 
 test_expect_success 'pulling changes from origin' \
 'cd D &&
-git pull origin'
+git pull --merge origin'
 
 cd "$base_dir"
 
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index c680f78..e12d90b 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -10,6 +10,8 @@ modify () {
 
 test_expect_success setup \
 '
+git config pull.rebase false &&
+
 cat >A <<\EOF &&
 a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
 b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 5e43997..5428f19 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -172,7 +172,7 @@ test_expect_success 'up-to-date merge without common ancestor' '
 	test_tick &&
 	(
 		cd repo1 &&
-		git pull ../repo2 master
+		git pull --merge ../repo2 master
 	)
 '
 
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 73fc240..3ca29c4 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -41,6 +41,7 @@ test_expect_success 'setup' '
 	mkdir git &&
 	cd git &&
 	git init &&
+	git config pull.rebase false &&
 	echo git >git.c &&
 	o2=$(git hash-object git.c) &&
 	git add git.c &&
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6037-merge-ours-theirs.sh
index 3889eca..41bf060 100755
--- a/t/t6037-merge-ours-theirs.sh
+++ b/t/t6037-merge-ours-theirs.sh
@@ -66,6 +66,8 @@ test_expect_success 'binary file with -Xours/-Xtheirs' '
 '
 
 test_expect_success 'pull passes -X to underlying merge' '
+	git config pull.rebase false &&
+
 	git reset --hard master && git pull -s recursive -Xours . side &&
 	git reset --hard master && git pull -s recursive -X ours . side &&
 	git reset --hard master && git pull -s recursive -Xtheirs . side &&
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index f524d2f..dfce024 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -62,7 +62,7 @@ test_expect_success 'setup git mirror and merge' '
 	echo friend > README &&
 	cat tmp >> README &&
 	git commit -a -m "friend" &&
-	git pull . merge
+	git pull --merge . merge
 	'
 
 test_debug 'gitk --all & sleep 1'
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 0431386..76b8640 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -46,7 +46,7 @@ test_expect_success 'setup' '
   touch secondrootfile &&
   git add secondrootfile &&
   git commit -m "second root") &&
-  git pull secondroot master &&
+  git pull --merge secondroot master &&
   git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
   GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" &&
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6fca193..787c6cc 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -328,7 +328,7 @@ test_expect_success \
 	 git add b &&
 	 git commit -a -m "On branch" &&
 	 git checkout master &&
-	 git pull . b &&
+	 git pull --merge . b &&
 	 git tag merge_commit'
 
 test_expect_success \
-- 
1.8.3.1-794-ga13ccd6
