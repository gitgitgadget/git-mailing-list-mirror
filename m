Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C0DC77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 12:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjEGMHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 08:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEGMHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 08:07:37 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E114E48
        for <git@vger.kernel.org>; Sun,  7 May 2023 05:07:31 -0700 (PDT)
Date:   Sun, 07 May 2023 12:07:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1683461249; x=1683720449;
        bh=FMoAr+pgHWkKt3yYSft2rtS/oPhEwMshg9YNbWQomGM=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=HdGmK4N07/V5nF/zXeinRFCuPoI2lU7oMd197v+NZqWjpRjY5F+U3mWTrTAc1jjVs
         vT6R3g4gd1XAlApQkjHuFSi32O0MKQdzhaLwz/2GkrAbpdia8AEHLnwZH2qB5XC311
         1sCvXkz3uhO1LaJxjINYUd0TYS+slt6U3sParrJPqRMaTSJXLktnO6Ajn+o+aEveMl
         hJE4Tm0NhRLuYnbSEfX3sQ1gctjkr0wZuflt7oY7spcFnJmaVC8x6R92fLW4o5ZAjb
         Om/r/CQAjrhP0Xv5mGjC9tGuPWZ7l+t/hgMJnK7/5M6+I8AZVVH8Flch/Z2vlL7CwC
         fuz2iYhH/s5jw==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v10 8/8] worktree add: emit warn when there is a bad HEAD
Message-ID: <20230507120530.14669-9-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a warning to `worktree add` when the command tries to reference
HEAD, there exist valid local branches, and the HEAD points to a
non-existent reference.

Current Behavior:
% git -C foo worktree list
/path/to/repo/foo     dadc8e6dac [main]
/path/to/repo/foo_wt  0000000000 [badref]
% git -C foo worktree add ../wt1
Preparing worktree (new branch 'wt1')
HEAD is now at dadc8e6dac dummy commit
% git -C foo_wt worktree add ../wt2
hint: If you meant to create a worktree containing a new orphan branch
[...]
hint: Disable this message with "git config advice.worktreeAddOrphan false"
fatal: invalid reference: HEAD
%

New Behavior:
% git -C foo worktree list
/path/to/repo/foo     dadc8e6dac [main]
/path/to/repo/foo_wt  0000000000 [badref]
% git -C foo worktree add ../wt1
Preparing worktree (new branch 'wt1')
HEAD is now at dadc8e6dac dummy commit
% git -C foo_wt worktree add ../wt2
warning: HEAD points to an invalid (or orphaned) reference.
HEAD path: '/path/to/repo/foo/.git/worktrees/foo_wt/HEAD'
HEAD contents: 'ref: refs/heads/badref'
hint: If you meant to create a worktree containing a new orphan branch
[...]
hint: Disable this message with "git config advice.worktreeAddOrphan false"
fatal: invalid reference: HEAD
%

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 builtin/worktree.c      | 34 +++++++++++++++++++++++++++++-----
 t/t2400-worktree-add.sh | 18 +++++++++++++++++-
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 093b2cb032..5f62084334 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -638,6 +638,9 @@ static int first_valid_ref(const char *refname,
  *
  * - Checks whether any valid local branches exist.
  *
+ * - Emits a warning if there exist any valid branches but HEAD does not p=
oint
+ *   to a valid reference.
+ *
  * Returns 1 if any of the previous checks are true, otherwise returns 0.
  */
 static int can_use_local_refs(const struct add_opts *opts)
@@ -645,6 +648,23 @@ static int can_use_local_refs(const struct add_opts *o=
pts)
 =09if (head_ref(first_valid_ref, NULL)) {
 =09=09return 1;
 =09} else if (for_each_branch_ref(first_valid_ref, NULL)) {
+=09=09if (!opts->quiet) {
+=09=09=09struct strbuf path =3D STRBUF_INIT;
+=09=09=09struct strbuf contents =3D STRBUF_INIT;
+
+=09=09=09strbuf_add_real_path(&path, get_worktree_git_dir(NULL));
+=09=09=09strbuf_addstr(&path, "/HEAD");
+=09=09=09strbuf_read_file(&contents, path.buf, 64);
+=09=09=09strbuf_stripspace(&contents, 0);
+=09=09=09strbuf_strip_suffix(&contents, "\n");
+
+=09=09=09warning(_("HEAD points to an invalid (or orphaned) reference.\n"
+=09=09=09=09  "HEAD path: '%s'\n"
+=09=09=09=09  "HEAD contents: '%s'"),
+=09=09=09=09  path.buf, contents.buf);
+=09=09=09strbuf_release(&path);
+=09=09=09strbuf_release(&contents);
+=09=09}
 =09=09return 1;
 =09}
 =09return 0;
@@ -666,16 +686,12 @@ static int can_use_local_refs(const struct add_opts *=
opts)
 static int can_use_remote_refs(const struct add_opts *opts)
 {
 =09if (!guess_remote) {
-=09=09if (!opts->quiet)
-=09=09=09fprintf_ln(stderr, WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT);
 =09=09return 0;
 =09} else if (for_each_remote_ref(first_valid_ref, NULL)) {
 =09=09return 1;
 =09} else if (!opts->force && remote_get(NULL)) {
 =09=09die(_("No local or remote refs exist despite at least one remote\n"
 =09=09      "present, stopping; use 'add -f' to overide or fetch a remote =
first"));
-=09} else if (!opts->quiet) {
-=09=09fprintf_ln(stderr, WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT);
 =09}
 =09return 0;
 }
@@ -828,8 +844,12 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09=09int n;
 =09=09const char *s =3D worktree_basename(path, &n);
 =09=09new_branch =3D xstrndup(s, n);
-=09} else if (opts.orphan || opts.detach) {
+=09} else if (opts.orphan) {
 =09=09// No-op
+=09} else if (opts.detach) {
+=09=09// Check HEAD
+=09=09if (!strcmp(branch, "HEAD"))
+=09=09=09can_use_local_refs(&opts);
 =09} else if (ac < 2 && new_branch) {
 =09=09// DWIM: Infer --orphan when repo has no refs.
 =09=09opts.orphan =3D dwim_orphan(&opts, !!opt_track, 0);
@@ -854,6 +874,10 @@ static int add(int ac, const char **av, const char *pr=
efix)
 =09=09=09=09branch =3D remote;
 =09=09=09}
 =09=09}
+
+=09=09if (!strcmp(branch, "HEAD"))
+=09=09=09can_use_local_refs(&opts);
+
 =09}

 =09if (!opts.orphan && !lookup_commit_reference_by_name(branch)) {
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index c7ca8df586..0ac468e69e 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -722,6 +722,7 @@ test_dwim_orphan () {
 =09local use_quiet=3D0 &&
 =09local remote=3D0 &&
 =09local remote_ref=3D0 &&
+=09local use_detach=3D0 &&
 =09local use_new_branch=3D0 &&

 =09local outcome=3D"$1" &&
@@ -747,6 +748,10 @@ test_dwim_orphan () {
 =09=09success=3D0 &&
 =09=09outcome_text=3D'"add" error inferred "--orphan" gives illegal opts c=
ombo'
 =09=09;;
+=09"warn_bad_head")
+=09=09success=3D0 &&
+=09=09outcome_text=3D'"add" error, warn on bad HEAD, hint use orphan'
+=09=09;;
 =09*)
 =09=09echo "test_dwim_orphan(): invalid outcome: '$outcome'" >&2 &&
 =09=09return 1
@@ -818,7 +823,7 @@ test_dwim_orphan () {
 =09=09=09context=3D"$context, invalid (or orphan) HEAD"
 =09=09=09;;

-=09=09# Whether the code path is tested with the base add command or -b
+=09=09# Whether the code path is tested with the base add command, -b, or =
--detach
 =09=09"no_-b")
 =09=09=09use_new_branch=3D0 &&
 =09=09=09context=3D"$context, no --branch"
@@ -827,6 +832,10 @@ test_dwim_orphan () {
 =09=09=09use_new_branch=3D1 &&
 =09=09=09context=3D"$context, --branch"
 =09=09=09;;
+=09=09"detach")
+=09=09=09use_detach=3D1 &&
+=09=09=09context=3D"$context, --detach"
+=09=09=09;;

 =09=09# Whether to check that all output is suppressed (except errors)
 =09=09# or that the output is as expected
@@ -887,6 +896,9 @@ test_dwim_orphan () {
 =09if [ $use_new_branch -eq 1 ]
 =09then
 =09=09args=3D"$args -b foo"
+=09elif [ $use_detach -eq 1 ]
+=09then
+=09=09args=3D"$args --detach"
 =09else
 =09=09context=3D"DWIM (no --branch), $context"
 =09fi &&
@@ -1023,6 +1035,10 @@ do
 =09=09test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref remote no_r=
emote_ref no_guess_remote
 =09=09test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref remote no_r=
emote_ref guess_remote
 =09=09test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref remote remo=
te_ref guess_remote
+
+=09=09test_dwim_orphan 'warn_bad_head' $dwim_test_args no_-b local_ref bad=
_head
+=09=09test_dwim_orphan 'warn_bad_head' $dwim_test_args -b local_ref bad_he=
ad
+=09=09test_dwim_orphan 'warn_bad_head' $dwim_test_args detach local_ref ba=
d_head
 =09done

 =09test_dwim_orphan 'fatal_orphan_bad_combo' $quiet_mode no_-b no_checkout
--
2.39.3


