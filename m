Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE30C001DE
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 04:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjGUElg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 00:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGUElH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 00:41:07 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A410130C1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 21:41:01 -0700 (PDT)
Date:   Fri, 21 Jul 2023 04:40:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689914460; x=1690173660;
        bh=eGz2L0fx2rKREibkbt+UE52ZxLl+jlq2Xv7CWKxzTL8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Bb2SqtzLcJoe/U7Fp3CIf42+V1n3ATIQIF68c8cXYPHpddl72H0TTT8D67tOPa0bx
         V4y7k6RS78mvwKvYSc2nxn4NWzyau1v3DdY3KSaloRoWXkRE6W97c+R7l9tFi/q16X
         U0SKagaJT/Ak0HEC8Hi2hO9DwE9c4KxwvddMuuHbGq6k/mYA404H+J7oWiindnSZXW
         bzA8ztYdOdbFOCQVG7REEcC7nHEu9b8Jx5VZIwKAqW+7iJOOB5EMR7PmepUs5Gu2Bm
         DDuZ+Zap5SMrFWAjK5SJrJfIxjw4Pvm/lui818yOv9AWcoTrq0ZkHGMlaVdJC84k3X
         TrYvxEooWdxXQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 3/3] t2400: rewrite regex to avoid unintentional PCRE
Message-ID: <20230721044012.24360-4-jacobabel@nullpo.dev>
In-Reply-To: <20230721044012.24360-1-jacobabel@nullpo.dev>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <20230716033743.18200-1-jacobabel@nullpo.dev> <20230721044012.24360-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace all cases of `\s` with ` ` as it is not part of POSIX BRE or ERE
and therefore not all versions of grep handle it without PCRE support.

For the same reason all cases of `\S` are replaced with `[^ ]`. It's not
an exact replacement but it is close enough for this use case.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 t/t2400-worktree-add.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index e106540c6d..eafecdf7ce 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -417,9 +417,9 @@ test_wt_add_orphan_hint () {
 =09=09grep "hint: If you meant to create a worktree containing a new orpha=
n branch" actual &&
 =09=09if [ $use_branch -eq 1 ]
 =09=09then
-=09=09=09grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" actua=
l
+=09=09=09grep -E "^hint:[ ]+git worktree add --orphan -b [^ ]+ [^ ]+$" act=
ual
 =09=09else
-=09=09=09grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
+=09=09=09grep -E "^hint:[ ]+git worktree add --orphan [^ ]+$" actual
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
2.39.3


