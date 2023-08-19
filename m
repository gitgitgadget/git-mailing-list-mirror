Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F5EC88CB2
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 00:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHTALJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Aug 2023 20:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHTAKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:47 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8555F4CC131
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 13:35:48 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 234E33E932
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 22:35:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id EA2B93E661
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 22:35:46 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jBGPqS3m6Q_p for <git@vger.kernel.org>;
        Sat, 19 Aug 2023 22:35:46 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 364613E98F
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 22:35:45 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing without a forkpoint
Date:   Sat, 19 Aug 2023 16:34:49 -0400
Message-ID: <20230819203528.562156-2-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.rc2.7.gf9972720e9.dirty
In-Reply-To: <20230819203528.562156-1-wesleys@opperschaap.net>
References: <20230819203528.562156-1-wesleys@opperschaap.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=UttIx32zK-AA:10 a=N3miCFJ7AAAA:8 a=ndNecGk9zqXrXqs2XWkA:9
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When commit d1e894c6d7 (Document `rebase.forkpoint` in rebase man page,
2021-09-16) was submitted there was a discussion on if the forkpoint
behaviour of `git rebase' was sane. In my experience this wasn't sane.
Git rebase doesn't work if you don't have an upstream branch configured
(or something that says `merge =3D refs/heads/master' in the git config).
The behaviour of `git rebase' was that if you supply an upstream on the
command line that it behaves as if `--no-forkpoint' was supplied and if
you don't supply an upstream, it behaves as if `--forkpoint' was
supplied. This can result in a loss of commits if you don't know that
and if you don't know about `git reflog' or have other copies of your
changes. This can be seen with the following reproduction path:

    mkdir reproduction
    cd reproduction
    git init .
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

    git log --format=3D'%C(yellow)%h%Creset %Cgreen%s%Creset'
    5f427e3 Third commit
    03ad791 Second commit
    411e6d4 First commit

    git rebase
    git status
    On branch foo
    Your branch is up to date with 'master'.

    git log --format=3D'%C(yellow)%h%Creset %Cgreen%s%Creset'
    03ad791 Second commit
    411e6d4 First commit

This patch adds a warning where it will indicate that `rebase.forkpoint'
must be set in the git configuration and/or that you can supply a
`--forkpoint' or `--no-forkpoint' command line option to your `git
rebase' invocation.

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 builtin/rebase.c             | 15 ++++++++++-
 t/t3431-rebase-fork-point.sh | 50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 50cb85751f..41dd9b6256 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1604,8 +1604,21 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
 								    NULL);
 			if (!options.upstream_name)
 				error_on_missing_default_upstream();
-			if (options.fork_point < 0)
+			if (options.fork_point < 0) {
+				warning(_(
+					"Rebasing without specifying a forkpoint is discouraged. You can sq=
uelch\n"
+					"this message by running one of the following commands something be=
fore your\n"
+					"next rebase:\n"
+					"\n"
+					"  git config rebase.forkpoint =3D false # This will become the new=
 default\n"
+					"  git config rebase.forkpoint =3D true  # This is the old default\=
n"
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
index 4bfc779bb8..a583ca6228 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -113,4 +113,54 @@ test_expect_success 'rebase.forkPoint set to true an=
d --root given' '
 	git rebase --root
 '
=20
+# The use of the diff -qw is because there is some kind of whitespace ch=
aracter
+# magic going on which probably has to do with the tabs. It only occurs =
when we
+# check STDERR
+test_expect_success 'rebase without forkpoint' '
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
+	warning: Rebasing without specifying a forkpoint is discouraged. You ca=
n squelch
+	this message by running one of the following commands something before =
your
+	next rebase:
+
+	  git config rebase.forkpoint =3D false # This will become the new defa=
ult
+	  git config rebase.forkpoint =3D true  # This is the old default
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
+	test_cmp out expect
+'
+
 test_done
--=20
2.42.0.rc2.7.gf9972720e9.dirty

