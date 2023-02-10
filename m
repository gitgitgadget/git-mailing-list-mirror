Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD039C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 20:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjBJUVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 15:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjBJUV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 15:21:27 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE47290
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 12:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676060430; bh=VXghr297Iv6rReBLa/HGo/BmBvBUU8OUBubZdySPKjU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=NwKYEi4HyUMxfbo93vmRiTMvS05U58LZ7DfTa+aAdZRaFbhVhQve4PneJjZxsDKgl
         w1Iv++KnGaGw7tYhMuY+Pdrg5oOFZt2BOiRKX7k1wpaEHaoqb8VXlCVbEivWmSWVl4
         NSbP4fTQqKJYt5nxgcmqnCGEfZzufg4OKcJMHfRhQ7/kagtrncViWOn6shmJzqcypI
         AGe7QP6CFgwsl+bCC4Xm/ueB9NGR1dIkj4yEmVYmBTxIohk8X3UkWsRkxCrQ0lyaRX
         ELKujPAXXXxASrHYoZgWR5fxDiZIDqkki5RJ7sDPvEec6zxBh954eHL08d4q8TA+K2
         SJj9LikEZjRSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MvKbd-1oZzGJ3RlB-00rKyo; Fri, 10
 Feb 2023 21:20:30 +0100
Message-ID: <a37623c8-d2fb-aec6-3423-2d402d717959@web.de>
Date:   Fri, 10 Feb 2023 21:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH v2] cache-tree: fix strbuf growth in prime_cache_tree_rec()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
In-Reply-To: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pAsgtzBb46vP62yHLPg3jd6sI7C5uCv7YLp1LnTQ0cot8MH07rM
 QuXaoeqJax4SC6cQhiZ/fJ9hCpIlOKh2So0Pfi7Ge/CbfYtFrJEuSDZmeGoFG6WylyeDmwj
 WSFUvlrNw6hYRRbaIEElJF/q0kIkPqx7f2dSPywEl11ISkoeMrILh+axKu4osUWNMGf9Ogc
 RKnpOfsGFd57e33sle6Jg==
UI-OutboundReport: notjunk:1;M01:P0:V1CJUH+dx4g=;IwlwqKztTwzm0GKdhORciqg9FoM
 i/7zJMhKAylxnGWLW5cMxME7dGkShvVyb0TM8jI4+jA/5PEgFHZxH23SBBe4YmDdGsQqWtWEO
 foUntxWE8psDkrORtraofUlPNILNPKXtA3nuY6Vco3tUVF96Ea1FV+/HFZhl7z760TSNivL9u
 OLAjNeZ6H50yOcQWvxvc6Uj7aTS14Nw235TPZtTw03lApSMYsRHyh9XtPus3tAszOuWBam44+
 /vlY1ujzcEU2CA1QA8VqYJQcRrVhOJp9NUqoCqYDcfIz9bsN0g133KPY3LnSXpcwQ4qDLJn+u
 T4sIjk08W/mOe6JSBhOctiHVt6M3VhU2tlTy6GmjRw/aG44HWQGQEPKLNgh2VvApV3JqRojWW
 f6Wufe8plslCgx3bXsmyYPWk32+xvQh2DvOxc8pGHg5tcDszNQGg29CWw/ZlBhtRrhNwAqwXd
 nFIgr+SPbz+AyIg1Ow4Xlw0iBF6VF2j40OBos/JlIjCmQ7lg55Op16ztngLgHupQBjqlXg71v
 +fpal2rMr8aeP6uPh2NV+CS1MgxyM7QQOJDWUZmKYbAF3Hjejz2pWPfMnuHrBd+0MStlbiJF9
 0xPD6ibmp5THUaxVf9xf3KkKi9cC6wkKph/Zj0vgkQJK/c8Qb0fvitCgkz0Yt2ZR/m6pnisDl
 R9mMYD/IRVR6ur2qbcI/WZr9BD5/VwK9pb8vabtP59CdVUtbG6k7+gPqqVYjRQU+S+GVvi4ON
 St+tMCDzBPV3ZnLfbAmriGN1nwLyMqSfwdllOrkQP1OP49/YoqGR+hXboaa3S9yAB27+EouS6
 T7D4gWYfXZbvn3EpOLRU+Gw125dmkZISgmUj5FPjuoofT6xs1LNplowwKQFPn+rPZFQgzJXbx
 sITceXFzLbOQl/k/LRd3dJadqshqwXOgzVIlaNvyHfhGZbyvv5z0tMfoagbHDrVQLIZmN2gAb
 0FDJ2A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use size_t to store the original length of the strbuf tree_len, as
that's the correct type.

Don't double the allocated size of the strbuf when adding a subdirectory
name.  And the chance of the trailing slash fitting in the slack left by
strbuf_add() is very high, so stop pre-growing the strbuf at all.

Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1: Remove strbuf_grow() call

 cache-tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 9af457f47c..88c2c04f87 100644
=2D-- a/cache-tree.c
+++ b/cache-tree.c
@@ -760,7 +760,7 @@ static void prime_cache_tree_rec(struct repository *r,
 	struct tree_desc desc;
 	struct name_entry entry;
 	int cnt;
-	int base_path_len =3D tree_path->len;
+	size_t base_path_len =3D tree_path->len;

 	oidcpy(&it->oid, &tree->object.oid);

@@ -785,7 +785,6 @@ static void prime_cache_tree_rec(struct repository *r,
 			 */
 			if (r->index->sparse_index) {
 				strbuf_setlen(tree_path, base_path_len);
-				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
 				strbuf_add(tree_path, entry.path, entry.pathlen);
 				strbuf_addch(tree_path, '/');
 			}
=2D-
2.39.1
