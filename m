Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E77C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiK2MT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiK2MTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:19:25 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764DF5D699
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669724357; bh=uT5cElCTdv/mAHRqKYgKo0k60whCGn5UMT4DzEBVHZI=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=L3FqzAGuJEfuLhA4z1IgsnpmNnB5mYaHBIWYU6I/4ShrhA0QjxNON6MjanORgUJke
         tNKqAYXs3fj+Q0pL3gscprivaN60ceP12H1NdB4nKndybZ1HNFWksjieqfmaPPZRTS
         ouJXx3VGCAM+XZhUohduLO6xN0zgxBvMYB5/KNTlOkV+ApSe41JZrnKWWjsHs4XcHO
         fPAy/8Q3zx5ZEO0k1CqJ6wjm5teNmKliy0TiyXmNUHMK0SwalhZAEASDm6Db8ewAXl
         +9ZY4uiGqlKP2HYCqt1+NoiN+r6zZsdo9Y2obs4tWa8wPJGK9IocMqHBBrnpn09JzE
         PY8+8zmN8DEag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59iy-1oyteL2TyO-001Cb7; Tue, 29
 Nov 2022 13:19:17 +0100
Message-ID: <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
Date:   Tue, 29 Nov 2022 13:19:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v3 0/5] pack-objects: fix and simplify --filter handling
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
In-Reply-To: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3zT6XiMABJl+7LhYFPMHjWiUKy+aWgov0Iy0l4zM6ImPKmrixys
 p5AY/Kwl3GbjykV3aI+iDN1Ut+6QL3ES2PiqzeFX8OnO+qFAQkkbWg3ZA4OA0Jx1HDwhjhl
 or/7KPCBZY5zwXFxwP80eO5l7rfWRCOuwvv4VyPjzBHN5+G11HPK8aVJDDsKT4Pp/VUIScB
 k+LBWnuepyZV4DiS13MXg==
UI-OutboundReport: notjunk:1;M01:P0:GzidxB8eGeo=;Oo4MJT3XWZpDmjwyLBO/aopLkOL
 vZDAI60kx0pzt7U3hy5BBhJYJ3XHyrY3nwe4CPTlGrMIzE8Gyh5CQM8AO+nFG619VNWWK00cY
 EyvBz6xruH2aTJS2X584ofqdcgjGBL3lVJW1eUPg56gbRwKcd5dd24z77KdBtEVWkTZ+tPy37
 ab9nbF8WjncppNt+FtPH8GAftEGV7f3HJoGsZf5Lbl0zY/qwkM3m5FPptrASAAH6Ev45Wtmu7
 IHDxJnsrW7eOyLBdaEsM1MEz/66DpnFkVvY/hln7sHz5r+0V8HBB82rD8HulgwF+adSeEYp8k
 iHrEa8N92rKEJRADZBDW+r1J3GzZWtgzotBdFMa+SlZm/93HcPzTFi4R2UGgMgCZXyGJUrZ3Z
 +V2Kh+2xoGUwAYqgI9CCQ0cFpayfAYZHFc6BRRkBq3c5nytCVqt368ADVLphNkYwLkH9N2gv4
 RyQnw98ZHWhCwva2lAI81huekYaFTO6bLw6S28AqkC0WwcKZuI2GkRfbshpFawWmDa64ypBsY
 GPXNvA0zmMEm0FU8uvzXuSH4/ngdL6OjgaeF0JVhtGhAh0J5hL/qXT2BhAXlmFXRgALROgTNU
 dOmNh8fPMOVDOC2Dzr6PDVnmGvD/Fww2ia2ifDhsa0XRZ18ObxzyfS53Cr806AweWzhqkc9I0
 UYy11ghanmCAjTHUt4vrKOtRG0s4xxTJ4b0OTNkpHbcmzV4AMmUQr+bgd48V1GX9fHR1CSVYs
 dKWGXljC7UQVro3/mupNMTKu+A8WV5TtgXTPotXOpENcVzXHoPEp9L8mCthYv2EVZ74HfvKeY
 /REguVxfTGZfXe56EitzzjcuBPE2g6KCpSjREAkQ21wnH9KKB7D8UUs09yWoi1Yq82DFA8LLF
 SjucfZOxO5ojCvPqkmtNSn5bdevasE4yP06+dAw470nlc6sT42d+aPcTxTZnvru9nj5Nek97g
 K1daww==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression that prevents using multiple --filter options, simplify
the option parsing code and avoid relying on undefined behavior in it.

Patch 4 conflicts with cc/filtered-repack in seen, but not semantically.

Changes since v2:
- Split the code changes up again like in v1; keep the separate test
  patches.  Reverting 5cb28270a1 wholesale is too cumbersome.
- Bring the dedicated list_objects_filter_options struct back.
- Move the list_objects_filter_release() call to the cleanup section.

Changes since v1:
- Added patch 1 to fix an issue with existing tests.
- Separate patch 2 for new tests.
- Test using blob size filters, only, which is a bit simpler.
- Test both combinations to also catch not just the current
  last-one-wins regression, but also a possible future first-one-wins
  issue.
- Actually revert 5cb28270a1 (pack-objects: lazily set up
  "struct rev_info", don't leak, 2022-03-28) instead of having a
  minimal fix and then adding some kind of middle ground by using a
  separate struct list_objects_filter_options.

  t5317: stop losing return codes of git ls-files
  t5317: demonstrate failure to handle multiple --filter options
  pack-objects: fix handling of multiple --filter options
  pack-objects: simplify --filter handling
  list-objects-filter: remove OPT_PARSE_LIST_OBJECTS_FILTER_INIT()

 builtin/pack-objects.c                 | 27 ++------
 list-objects-filter-options.c          |  4 --
 list-objects-filter-options.h          | 18 +-----
 t/t5317-pack-objects-filter-objects.sh | 90 +++++++++++++++++++-------
 4 files changed, 74 insertions(+), 65 deletions(-)

Range-Diff gegen v2:
1:  955ec33c30 =3D 1:  955ec33c30 t5317: stop losing return codes of git l=
s-files
2:  966094ef98 =3D 2:  966094ef98 t5317: demonstrate failure to handle mul=
tiple --filter options
3:  f5ba2a2f5e < -:  ---------- Revert "pack-objects: lazily set up "struc=
t rev_info", don't leak"
-:  ---------- > 3:  d51424e8d1 pack-objects: fix handling of multiple --f=
ilter options
-:  ---------- > 4:  e1fa0fcb1a pack-objects: simplify --filter handling
-:  ---------- > 5:  5865e24c04 list-objects-filter: remove OPT_PARSE_LIST=
_OBJECTS_FILTER_INIT()
=2D-
2.38.1
