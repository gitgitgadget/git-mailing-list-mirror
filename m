Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60791C0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 21:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGZVnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjGZVmt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 17:42:49 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD402703
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 14:42:44 -0700 (PDT)
Date:   Wed, 26 Jul 2023 21:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1690407762; x=1690666962;
        bh=kAkTkSLnpV/ITODJmqTF4UGq+oGHmGpFbMDJDcqn73I=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=iLDBosDiilRzqoPI/UODih4WTHcT/7pB3u4WJ3RR4Q3YqVJyEgGlwwENdaJp15V4m
         y7d7deXiq0sCFNZnPLghQEhkci67fjPAUCwrnebLdVZkcEZ+kyfICOdAb3zm3BME3M
         KmopCuld73a2ZXv0If/YwPscLFtnztZJEL1z7+iox6N5iEwO7zYjIPTd/82TZUmxiE
         TXhNYaU6B436hOA/d1dElpv2fkhSIswtB2pa9dWzlwPnh0G/AOsbzzcMffrsAAq57A
         GA5TYwNAaVIyb56G7IunUmTSuNGsepLT5MHRgvzcv1epER7fsy2s2FOAV3KIH3/cED
         OVaWK/+eyPyTA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 3/3] t2400: rewrite regex to avoid unintentional PCRE
Message-ID: <20230726214202.15775-4-jacobabel@nullpo.dev>
In-Reply-To: <20230726214202.15775-1-jacobabel@nullpo.dev>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <20230716033743.18200-1-jacobabel@nullpo.dev> <20230721044012.24360-1-jacobabel@nullpo.dev> <20230726214202.15775-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace all cases of `\s` with ` ` as it is not part of POSIX BRE or ERE
and therefore not all versions of grep handle it.

For the same reason all cases of `\S` are replaced with `[^ ]`. It is
not an exact replacement but it is close enough for this use case.

Also, do not write `\+` in BRE and expect it to mean 1 or more;
it is a GNU extension that may not work everywhere.

Remove `.*` from the end of a pattern that is not right-anchored.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2400-worktree-add.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index e106540c6d..051363acbb 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -417,9 +417,9 @@ test_wt_add_orphan_hint () {
 =09=09grep "hint: If you meant to create a worktree containing a new orpha=
n branch" actual &&
 =09=09if [ $use_branch -eq 1 ]
 =09=09then
-=09=09=09grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" actua=
l
+=09=09=09grep -E "^hint: +git worktree add --orphan -b [^ ]+ [^ ]+$" actua=
l
 =09=09else
-=09=09=09grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
+=09=09=09grep -E "^hint: +git worktree add --orphan [^ ]+$" actual
 =09=09fi
=20
 =09'
@@ -709,8 +709,8 @@ test_dwim_orphan () {
 =09local info_text=3D"No possible source branch, inferring '--orphan'" &&
 =09local fetch_error_text=3D"fatal: No local or remote refs exist despite =
at least one remote" &&
 =09local orphan_hint=3D"hint: If you meant to create a worktree containing=
 a new orphan branch" &&
-=09local invalid_ref_regex=3D"^fatal: invalid reference:\s\+.*" &&
-=09local bad_combo_regex=3D"^fatal: '[a-z-]\+' and '[a-z-]\+' cannot be us=
ed together" &&
+=09local invalid_ref_regex=3D"^fatal: invalid reference: " &&
+=09local bad_combo_regex=3D"^fatal: '[-a-z]*' and '[-a-z]*' cannot be used=
 together" &&
=20
 =09local git_ns=3D"repo" &&
 =09local dashc_args=3D"-C $git_ns" &&
@@ -998,8 +998,8 @@ test_dwim_orphan () {
 =09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --path-format=3Dabso=
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
2.41.0


