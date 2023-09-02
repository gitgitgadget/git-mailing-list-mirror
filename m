Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A8C83F33
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 22:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjIBWRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 18:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjIBWRF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 18:17:05 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E698CF6
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 15:17:01 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 5B3D03F834;
        Sun,  3 Sep 2023 00:16:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 01D5A3FA93;
        Sun,  3 Sep 2023 00:16:58 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8nUpyM8LxCpa; Sun,  3 Sep 2023 00:16:58 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id D81C23F957;
        Sun,  3 Sep 2023 00:16:56 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 2/3] builtin/rebase.c: Emit warning when rebasing without a forkpoint
Date:   Sat,  2 Sep 2023 18:16:40 -0400
Message-ID: <20230902221641.1399624-3-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.114.g06b8c4a877
In-Reply-To: <20230902221641.1399624-1-wesleys@opperschaap.net>
References: <xmqq1qfiubg5.fsf@gitster.g>
 <20230902221641.1399624-1-wesleys@opperschaap.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=zNV7Rl7Rt7sA:10 a=N3miCFJ7AAAA:8 a=nBIRHicHOAKLuqVCa2UA:9
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds a warning where it will indicate that `rebase.forkpoint'
must be set in the git configuration and/or that you can supply a
`--fork-point' or `--no-fork-point' command line option to your `git
rebase' invocation.

When commit d1e894c6d7 (Document `rebase.forkpoint` in rebase man page,
2021-09-16) was submitted there was a discussion on if the forkpoint
behaviour of `git rebase' was sane. In my experience this wasn't sane.

Git rebase doesn't work if you don't have an upstream branch configured
(or something that says `merge =3D refs/heads/master' in the git config).
You would than need to use `git rebase <upstream>' to rebase. If you
configure an upstream it would seem logical to be able to run `git
rebase' without arguments. However doing so would trigger a different
kind of behavior.  `git rebase <upstream>' behaves as if
`--no-fork-point' was supplied and without it behaves as if
`--fork-point' was supplied. This behavior can result in a loss of
commits and can surprise users. The following reproduction path exposes
this behavior:

    git init reproduction
    cd reproduction
    echo "commit a" > file.txt
    git add file.txt
    git commit -m "First commit" file.txt
    echo "commit b" >> file.txt
    git commit -m "Second commit" file.txt

    git switch -c foo
    echo "commit c" >> file.txt"
    git commit -m "Third commit" file.txt
    git branch --set-upstream-to=3Dmaster

    git status
    On branch foo
    Your branch is ahead of 'master' by 1 commit.

    git switch master
    git merge foo
    git reset --hard HEAD^
    git switch foo
    Switched to branch 'foo'
    Your branch is ahead of 'master' by 1 commit.

    git log --oneline
    5f427e3 Third commit
    03ad791 Second commit
    411e6d4 First commit

    git rebase
    git status
    On branch foo
    Your branch is up to date with 'master'.

    git log --oneline
    03ad791 Second commit
    411e6d4 First commit

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 builtin/rebase.c             | 16 +++++++++-
 t/t3431-rebase-fork-point.sh | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2108001600..ee7db9ba0c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1608,8 +1608,22 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
 								    NULL);
 			if (!options.upstream_name)
 				error_on_missing_default_upstream();
-			if (options.fork_point < 0)
+			if (options.fork_point < 0) {
+				warning(_(
+					"When \"git rebase\" is run without specifying <upstream> on the\n"
+					"command line, the current default is to use the fork-point\n"
+					"heuristics. This is expected to change in a future version\n"
+					"of Git, and you will have to explicitly give \"--fork-point\" from=
\n"
+					"the command line if you keep using the fork-point mode.  You can\n=
"
+					"run \"git config rebase.forkpoint false\" to adopt the new default=
\n"
+					"in advance and that will also squelch the message.\n"
+					"\n"
+					"You can replace \"git config\" with \"git config --global\" to set=
 a default\n"
+					"preference for all repositories. You can also pass --no-fork-point=
, --fork-point\n"
+					"on the command line to override the configured default per invocat=
ion.\n"
+				));
 				options.fork_point =3D 1;
+			}
 		} else {
 			options.upstream_name =3D argv[0];
 			argc--;
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 4bfc779bb8..908867ae0f 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -113,4 +113,66 @@ test_expect_success 'rebase.forkPoint set to true an=
d --root given' '
 	git rebase --root
 '
=20
+# The use of the diff -qw is because there is some kind of whitespace ch=
aracter
+# magic going on which probably has to do with the tabs. It only occurs =
when we
+# check STDERR
+test_expect_success 'rebase without rebase.forkpoint' '
+	git init rebase-forkpoint &&
+	cd rebase-forkpoint &&
+	git status >/tmp/foo &&
+	echo "commit a" > file.txt &&
+	git add file.txt &&
+	git commit -m "First commit" file.txt &&
+	echo "commit b" >> file.txt &&
+	git commit -m "Second commit" file.txt &&
+	git switch -c foo &&
+	echo "commit c" >> file.txt &&
+	git commit -m "Third commit" file.txt &&
+	git branch --set-upstream-to=3Dmain &&
+	git switch main &&
+	git merge foo &&
+	git reset --hard HEAD^ &&
+	git switch foo &&
+	commit=3D$(git log -n1 --format=3D"%h") &&
+	git rebase >out 2>err &&
+	test_must_be_empty out &&
+	cat <<-\OEF > expect &&
+	warning: When "git rebase" is run without specifying <upstream> on the
+	command line, the current default is to use the fork-point
+	heuristics. This is expected to change in a future version
+	of Git, and you will have to explicitly give "--fork-point" from
+	the command line if you keep using the fork-point mode.  You can
+	run "git config rebase.forkpoint false" to adopt the new default
+	in advance and that will also squelch the message.
+
+	You can replace "git config" with "git config --global" to set a defaul=
t
+	preference for all repositories. You can also pass --no-fork-point, --f=
ork-point
+	on the command line to override the configured default per invocation.
+
+	Successfully rebased and updated refs/heads/foo.
+	OEF
+	diff -qw expect err &&
+	git reset --hard $commit &&
+	git rebase --fork-point >out 2>err &&
+	test_must_be_empty out &&
+	echo "Successfully rebased and updated refs/heads/foo." > expect &&
+	diff -qw expect err &&
+	git reset --hard $commit &&
+	git rebase --no-fork-point >out 2>err &&
+	test_must_be_empty err &&
+	echo "Current branch foo is up to date." > expect &&
+	test_cmp out expect &&
+	git config --add rebase.forkpoint true &&
+	git rebase >out 2>err &&
+	test_must_be_empty out &&
+	echo "Successfully rebased and updated refs/heads/foo." > expect &&
+	diff -qw expect err &&
+	git reset --hard $commit &&
+	git config --replace-all rebase.forkpoint false &&
+	git rebase >out 2>err &&
+	test_must_be_empty err &&
+	echo "Current branch foo is up to date." > expect &&
+	test_cmp out expect
+'
+
 test_done
--=20
2.42.0.103.g5622fd1409.dirty

