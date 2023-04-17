Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD61C77B77
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjDQJhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjDQJhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:37:02 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863116194
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:36:28 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681724080; x=1681983280;
        bh=HazpFulvYkemTU2flJd+J/W2Z21YBUgTlpnvL6voaIw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=hVa6HOz6osPQ9Ytv8reVchMrOrPHnvkNTJ2uZZSJTwmybml+w1l+kaYccdcEY7Gta
         Xp5e0qidNGpByPgyIsQURjWfiGrMXkcKlgae0xYUvscv5NIXdppmYnnbTXasdj/rDY
         SmfbsQy38AYiH6a/HJ14+UnWK9BIOnAYSkEDGY2IDGdikAXEvo4HTemdP797OzhZ0E
         w4YseNnfqJzsOwiqDD0tJ+Hogxu1Is/tMoAtGDgCBYOFqlUPPZ+AZXCkWVse29FRpw
         LV9gTayAUGKrii1ZPoDQWXSvbKjXxO30v5KQLlOVkqnOzu5h3VnASz424yxJEssg+T
         hAvma6+XFgMBg==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v9 8/8] worktree add: emit warn when there is a bad HEAD
Message-ID: <20230417093255.31079-9-jacobabel@nullpo.dev>
In-Reply-To: <20230417093255.31079-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
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
index 95b5bbb1d2..0fba4cfdf8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -637,6 +637,9 @@ static int first_valid_ref(const char *refname,
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
@@ -644,6 +647,23 @@ static int can_use_local_refs(const struct add_opts *o=
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
@@ -665,16 +685,12 @@ static int can_use_local_refs(const struct add_opts *=
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
@@ -827,8 +843,12 @@ static int add(int ac, const char **av, const char *pr=
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
@@ -853,6 +873,10 @@ static int add(int ac, const char **av, const char *pr=
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
index e5cca1d11b..09bf506155 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -729,6 +729,7 @@ test_dwim_orphan () {
 =09local use_quiet=3D0 &&
 =09local remote=3D0 &&
 =09local remote_ref=3D0 &&
+=09local use_detach=3D0 &&
 =09local use_new_branch=3D0 &&

 =09local outcome=3D"$1" &&
@@ -754,6 +755,10 @@ test_dwim_orphan () {
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
@@ -825,7 +830,7 @@ test_dwim_orphan () {
 =09=09=09context=3D"$context, invalid (or orphan) HEAD"
 =09=09=09;;

-=09=09# Whether the code path is tested with the base add command or -b
+=09=09# Whether the code path is tested with the base add command, -b, or =
--detach
 =09=09"no_-b")
 =09=09=09use_new_branch=3D0 &&
 =09=09=09context=3D"$context, no --branch"
@@ -834,6 +839,10 @@ test_dwim_orphan () {
 =09=09=09use_new_branch=3D1 &&
 =09=09=09context=3D"$context, --branch"
 =09=09=09;;
+=09=09"detach")
+=09=09=09use_detach=3D1 &&
+=09=09=09context=3D"$context, --detach"
+=09=09=09;;

 =09=09# Whether to check that all output is suppressed (except errors)
 =09=09# or that the output is as expected
@@ -894,6 +903,9 @@ test_dwim_orphan () {
 =09if [ $use_new_branch -eq 1 ]
 =09then
 =09=09args=3D"$args -b foo"
+=09elif [ $use_detach -eq 1 ]
+=09then
+=09=09args=3D"$args --detach"
 =09else
 =09=09context=3D"DWIM (no --branch), $context"
 =09fi &&
@@ -1036,6 +1048,10 @@ do
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
2.39.2


