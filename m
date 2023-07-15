Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584F6EB64DA
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 02:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGOCzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 22:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOCzn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 22:55:43 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086835A9
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 19:55:40 -0700 (PDT)
Date:   Sat, 15 Jul 2023 02:55:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689389737; x=1689648937;
        bh=CwNqkG3Ttg2gliMWGS0/X46uy2tT76JxskTALr4Vka0=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=w/ccnpBh4ov575QC9IYJcPknSK62RPQMxB2GdcaW1S2H4LYOqR+cd54p/RyuDkzKx
         K4nS3YOZIW2NDduWskAcQRLF3WvT45BZhx4yW3qjqy/q4TTl6X++UuHGuJCzR35Jwn
         FGmD++5n3RLg3y8xOSB3D9c2+J680+0YJmK5iO3WcJVmK+1RwfOQcSSxNfe3X549ex
         7s11ph6QwKTTnJcHjDrYwGw6litWpNIKQz8n1IswSlN7yWi7XSudFnFHiNHJWu+Xo+
         6E+1yyOVqIB/ePsQW0WcdKjLgqNA4/qDB1zT6nCPWWEZO7/3fEp4WfxNOSHH4oXCP4
         VDpAw1z8GwdYg==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>
Subject: [PATCH] t2400: Fix test failures when using grep 2.5
Message-ID: <20230715025512.7574-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace all cases of `\s` with `[[:space:]]` as older versions of GNU
grep (and from what it seems most versions of BSD grep) do not handle
`\s`.

For the same reason all cases of `\S` are replaced with `[^[:space:]]`.
Replacing `\S` also needs to occur as `\S` is technically PCRE and not
part of ERE even though most modern versions of grep accept it as ERE.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
This patch is in response to build failures on GGG's Cirrus CI=20
freebsd_12 build jobs[1] and was prompted by a discussion thread [2].

These failures seem to be caused by the behavior outlined in [3].=20
Weirdly however they only seem to occur on the FreeBSD CI but not the=20
Mac OS CI for some reason despite Mac OS using FreeBSD grep.

1. https://github.com/gitgitgadget/git/pull/1550/checks?check_run_id=3D1494=
9695859
2. https://lore.kernel.org/git/CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-=
9zbqXMA@mail.gmail.com/
3. https://stackoverflow.com/questions/4233159/grep-regex-whitespace-behavi=
or

 t/t2400-worktree-add.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 0ac468e69e..7f19bdabff 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -417,9 +417,9 @@ test_wt_add_orphan_hint () {
 =09=09grep "hint: If you meant to create a worktree containing a new orpha=
n branch" actual &&
 =09=09if [ $use_branch -eq 1 ]
 =09=09then
-=09=09=09grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" actua=
l
+=09=09=09grep -E "^hint:[[:space:]]+git worktree add --orphan -b [^[:space=
:]]+ [^[:space:]]+[[:space:]]*$" actual
 =09=09else
-=09=09=09grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
+=09=09=09grep -E "^hint:[[:space:]]+git worktree add --orphan [^[:space:]]=
+[[:space:]]*$" actual
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
+=09local invalid_ref_regex=3D"^fatal: invalid reference:[[:space:]]\+.*" &=
&
 =09local bad_combo_regex=3D"^fatal: '[a-z-]\+' and '[a-z-]\+' cannot be us=
ed together" &&
=20
 =09local git_ns=3D"repo" &&
@@ -998,8 +998,8 @@ test_dwim_orphan () {
 =09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-format=
=3Dabsolute --git-path HEAD) &&
 =09=09=09=09=09headcontents=3D$(cat "$headpath") &&
 =09=09=09=09=09grep "HEAD points to an invalid (or orphaned) reference" ac=
tual &&
-=09=09=09=09=09grep "HEAD path:\s*.$headpath." actual &&
-=09=09=09=09=09grep "HEAD contents:\s*.$headcontents." actual &&
+=09=09=09=09=09grep "HEAD path:[[:space:]]*.$headpath." actual &&
+=09=09=09=09=09grep "HEAD contents:[[:space:]]*.$headcontents." actual &&
 =09=09=09=09=09grep "$orphan_hint" actual &&
 =09=09=09=09=09! grep "$info_text" actual
 =09=09=09=09fi &&

base-commit: 830b4a04c45bf0a6db26defe02ed1f490acd18ee
--=20
2.39.3


