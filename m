Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BED4EB64DA
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 03:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjGPDiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 23:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPDiy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 23:38:54 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E010FE
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 20:38:51 -0700 (PDT)
Date:   Sun, 16 Jul 2023 03:38:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689478726; x=1689737926;
        bh=fStHEA2J75ZxI8IZrYPWbEJYbXV6Ix+OqkJnjF2v2sg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZxmmcgfgkcPdjpFwZ1AdOK1lqwsrlXji7XhtjgPTxIIty37BmrwUq/AJkTDeAQWFt
         /NhSG8paT+DLUzUXb683zZokb65A52b4KuZ7jMLZ+9svMlJaj+j946DPMGh2WRvFcf
         aglmSfa5OFsFtOcIoLcAY0XHw+MXfoXwZJsPC7PbXwyobOI1GXfD/t/ZVxtXpgzEJ0
         ZqZ7bJL+4rji5y0y8WNiqFNpnFnIZ65korrhaC4/Rizh/7RPPea4ibZSSQCk6ecKMi
         +vowxWRm2SfUYGCREQrsr5uTwfQLABuJLpPdKTRP5lmxx19TsOO5sAJOXX4Bo6ZeQG
         Z2vzaP9a+S8tA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2] t2400: Fix test failures when using grep 2.5
Message-ID: <20230716033743.18200-1-jacobabel@nullpo.dev>
In-Reply-To: <20230715025512.7574-1-jacobabel@nullpo.dev>
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace all cases of `\s` with `[[:blank:]]` or ` ` as older versions
of GNU grep (and from what it seems most versions of BSD grep) do not
handle `\s`.

For the same reason all cases of `\S` are replaced with `[^ ]`. It's not
an exact replacement (as it does not match tabs) but it is close enough
for this use case.

Replacing `\S` also needs to occur as `\S` is technically PCRE and not
part of ERE even though most modern versions of grep accept it as ERE.

This commit also drops `--sq` from a rev-parse call as it appears to be
a no-op.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
This patch is in response to build failures on GGG's Cirrus CI=20
freebsd_12 build jobs[1] and was prompted by a discussion thread [2].
These failures seem to be caused by the behavior outlined in [3].=20

Changes from v1:
  * Change `[[:space:]]` to ` ` where possible and `[[:blank:]]`=20
    (tabs and spaces) otherwise as it is more accurate than `[[:space:]]` [=
4].
  * Change `[^[:space:]]` to `[^ ]` [4]. Technically `[^[:blank:]]` would b=
e
    more accurate but tabs shouldn't be present where this `[^ ]` is used.
  * Drop `--sq` from rev-parse [4] (after further discussion [5]).
  * Update commit message to match changes.

1. https://github.com/gitgitgadget/git/pull/1550/checks?check_run_id=3D1494=
9695859
2. https://lore.kernel.org/git/CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-=
9zbqXMA@mail.gmail.com/
3. https://stackoverflow.com/questions/4233159/grep-regex-whitespace-behavi=
or
4. https://lore.kernel.org/git/vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462d=
hqjbno@uwghfyfdixtk/
5. https://lore.kernel.org/git/bj27nq5aputhd66rkqer37vuc7qogpmn6nqyusladdy4=
k5it7k@u3yvvivrixsy/

Range-diff against v1:
1:  39f57add45 ! 1:  ef4ebd7350 t2400: Fix test failures when using grep 2.=
5
    @@ Metadata
      ## Commit message ##
         t2400: Fix test failures when using grep 2.5
    =20
    -    Replace all cases of `\s` with `[[:space:]]` as older versions of =
GNU
    -    grep (and from what it seems most versions of BSD grep) do not han=
dle
    -    `\s`.
    +    Replace all cases of `\s` with `[[:blank:]]` or ` ` as older versi=
ons
    +    of GNU grep (and from what it seems most versions of BSD grep) do =
not
    +    handle `\s`.
    +
    +    For the same reason all cases of `\S` are replaced with `[^ ]`. It=
's not
    +    an exact replacement (as it does not match tabs) but it is close e=
nough
    +    for this use case.
    =20
    -    For the same reason all cases of `\S` are replaced with `[^[:space=
:]]`.
         Replacing `\S` also needs to occur as `\S` is technically PCRE and=
 not
         part of ERE even though most modern versions of grep accept it as =
ERE.
    =20
    +    This commit also drops `--sq` from a rev-parse call as it appears =
to be
    +    a no-op.
    +
         Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
    =20
      ## t/t2400-worktree-add.sh ##
    @@ t/t2400-worktree-add.sh: test_wt_add_orphan_hint () {
      =09=09if [ $use_branch -eq 1 ]
      =09=09then
     -=09=09=09grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" =
actual
    -+=09=09=09grep -E "^hint:[[:space:]]+git worktree add --orphan -b [^[:=
space:]]+ [^[:space:]]+[[:space:]]*$" actual
    ++=09=09=09grep -E "^hint:[[:blank:]]+git worktree add --orphan -b [^ ]=
+ [^ ]+$" actual
      =09=09else
     -=09=09=09grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
    -+=09=09=09grep -E "^hint:[[:space:]]+git worktree add --orphan [^[:spa=
ce:]]+[[:space:]]*$" actual
    ++=09=09=09grep -E "^hint:[[:blank:]]+git worktree add --orphan [^ ]+$"=
 actual
      =09=09fi
     =20
      =09'
    @@ t/t2400-worktree-add.sh: test_dwim_orphan () {
      =09local fetch_error_text=3D"fatal: No local or remote refs exist des=
pite at least one remote" &&
      =09local orphan_hint=3D"hint: If you meant to create a worktree conta=
ining a new orphan branch" &&
     -=09local invalid_ref_regex=3D"^fatal: invalid reference:\s\+.*" &&
    -+=09local invalid_ref_regex=3D"^fatal: invalid reference:[[:space:]]\+=
.*" &&
    ++=09local invalid_ref_regex=3D"^fatal: invalid reference: .*" &&
      =09local bad_combo_regex=3D"^fatal: '[a-z-]\+' and '[a-z-]\+' cannot =
be used together" &&
     =20
      =09local git_ns=3D"repo" &&
     @@ t/t2400-worktree-add.sh: test_dwim_orphan () {
    - =09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-for=
mat=3Dabsolute --git-path HEAD) &&
    + =09=09=09=09=09grep "$invalid_ref_regex" actual &&
    + =09=09=09=09=09! grep "$orphan_hint" actual
    + =09=09=09=09else
    +-=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-for=
mat=3Dabsolute --git-path HEAD) &&
    ++=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --path-format=
=3Dabsolute --git-path HEAD) &&
      =09=09=09=09=09headcontents=3D$(cat "$headpath") &&
      =09=09=09=09=09grep "HEAD points to an invalid (or orphaned) referenc=
e" actual &&
     -=09=09=09=09=09grep "HEAD path:\s*.$headpath." actual &&
     -=09=09=09=09=09grep "HEAD contents:\s*.$headcontents." actual &&
    -+=09=09=09=09=09grep "HEAD path:[[:space:]]*.$headpath." actual &&
    -+=09=09=09=09=09grep "HEAD contents:[[:space:]]*.$headcontents." actua=
l &&
    ++=09=09=09=09=09grep "HEAD path: .$headpath." actual &&
    ++=09=09=09=09=09grep "HEAD contents: .$headcontents." actual &&
      =09=09=09=09=09grep "$orphan_hint" actual &&
      =09=09=09=09=09! grep "$info_text" actual
      =09=09=09=09fi &&

 t/t2400-worktree-add.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 0ac468e69e..1b693dfca9 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -417,9 +417,9 @@ test_wt_add_orphan_hint () {
 =09=09grep "hint: If you meant to create a worktree containing a new orpha=
n branch" actual &&
 =09=09if [ $use_branch -eq 1 ]
 =09=09then
-=09=09=09grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" actua=
l
+=09=09=09grep -E "^hint:[[:blank:]]+git worktree add --orphan -b [^ ]+ [^ =
]+$" actual
 =09=09else
-=09=09=09grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
+=09=09=09grep -E "^hint:[[:blank:]]+git worktree add --orphan [^ ]+$" actu=
al
 =09=09fi
=20
 =09'
@@ -709,7 +709,7 @@ test_dwim_orphan () {
 =09local info_text=3D"No possible source branch, inferring '--orphan'" &&
 =09local fetch_error_text=3D"fatal: No local or remote refs exist despite =
at least one remote" &&
 =09local orphan_hint=3D"hint: If you meant to create a worktree containing=
 a new orphan branch" &&
-=09local invalid_ref_regex=3D"^fatal: invalid reference:\s\+.*" &&
+=09local invalid_ref_regex=3D"^fatal: invalid reference: .*" &&
 =09local bad_combo_regex=3D"^fatal: '[a-z-]\+' and '[a-z-]\+' cannot be us=
ed together" &&
=20
 =09local git_ns=3D"repo" &&
@@ -995,11 +995,11 @@ test_dwim_orphan () {
 =09=09=09=09=09grep "$invalid_ref_regex" actual &&
 =09=09=09=09=09! grep "$orphan_hint" actual
 =09=09=09=09else
-=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-format=
=3Dabsolute --git-path HEAD) &&
+=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --path-format=3Dabso=
lute --git-path HEAD) &&
 =09=09=09=09=09headcontents=3D$(cat "$headpath") &&
 =09=09=09=09=09grep "HEAD points to an invalid (or orphaned) reference" ac=
tual &&
-=09=09=09=09=09grep "HEAD path:\s*.$headpath." actual &&
-=09=09=09=09=09grep "HEAD contents:\s*.$headcontents." actual &&
+=09=09=09=09=09grep "HEAD path: .$headpath." actual &&
+=09=09=09=09=09grep "HEAD contents: .$headcontents." actual &&
 =09=09=09=09=09grep "$orphan_hint" actual &&
 =09=09=09=09=09! grep "$info_text" actual
 =09=09=09=09fi &&
--=20
2.39.3


