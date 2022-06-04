Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02F6C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 13:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbiFDNEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 09:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiFDNEu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 09:04:50 -0400
Received: from smtp-out-1.talktalk.net (smtp-out-1.talktalk.net [62.24.135.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E61B517D0
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 06:04:44 -0700 (PDT)
Received: from app-12.app.tt.ham.xion.oxcs.net ([185.74.64.161])
        by smtp.talktalk.net with SMTP
        id xTSLnghrSBJ1LxTSMnsKVT; Sat, 04 Jun 2022 14:04:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1654347883;
        bh=MiYPRzOzMFnykua6HvlLyE6pmCMdunZYH+FBes/1Dz0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=Enq6MFimSOOiLP10DEuPZjyQ4iOD/KnzUVD6dGja8Fj1ShzHHqjWRTLm7RcdzlJ83
         fuGqkjQZeggVHPBmgO0L4ELSsXse8spUeEu0aS3nqRjjpoe/0VRf/reAK9HLnDA4fI
         nRNfbnjor2uQfwfQ0Qu9EAEWvoJ+b71bIzUlnsC8=
Date:   Sat, 4 Jun 2022 14:04:41 +0100 (BST)
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Message-ID: <1848899554.540227.1654347881891@apps.talktalk.co.uk>
In-Reply-To: <RFC-patch-09.15-de0f7722608-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-09.15-de0f7722608-20220603T183608Z-avarab@gmail.com>
Subject: Re: [RFC PATCH 09/15] add-patch: assert parse_diff() expectations
 with BUG()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev79
X-Originating-IP: 31.185.185.192
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4wfMANZRIWB3zgK6utFIoC1Xrea49okfUTxWbPPxqdJ3jlKf1rwzwUC3wIqMccBnS34KlfFijCWQU360Cvf4PcIrOF0l0GJPQ7cPRb4C2heqN1QAhk4h8r
 M4Gw/LC35pKzE4QYAvD+rzSePKxNdWI3mWS2aYwHnMTj8GFsU0ziT1vvSitoPq6mfrFVFe26XDs30V/Cj6WNP8SPRJcgCMIyuUTH/2cwQYz4sI2Bp7f9ysWG
 BbS42Trcb4eBf36rB2tNoeU6v+fhf84SLiSFCkU5d3hbs1HdhRJZ0tVI+YQKvKQhXLXAc2ueP91jWjAwvMTYHn/K+S8M5efBJEhO8+HZlrEo6mkTfsRBOksp
 cZJULCxOcunKiyrXfUnGajq0XTiJiewH8TCMR1acMUb8HvzJwSPa0CH737JGM4PJe2vTDysLFp+cyuo21eGY9Sov6B2xhpdikA70Nv+5IJfTVrc1T4LQe7Ur
 dAXpazKPH0Rkhn2l
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var

> On 03 June 2022 at 19:37 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>=20
>=20
> Assert that this code added in [1], [2] and other related commits
> expects that once we see a "diff " line we should have a non-NULL
> "file_diff" and "hunk".
>=20
> In practice this would have always been the case, as we are parsing
> our own "diff" output, but e.g. GCC v12's -fanalyzer doesn't know
> that, and will alert us that in the "else if" and below in this
> function we could be dereferencing NULL if we were processing anything
> except our expected input.

If we're only doing this to keep -fanalyzer quiet then would it be better t=
o use the macro you introduce at the end of this series instead?

Best Wishes

Phillip

> 1. f6aa7ecc343 (built-in add -i: start implementing the `patch`
>    functionality in C, 2019-12-13)
> 2. 80399aec5ab (built-in add -p: support multi-file diffs, 2019-12-13)
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  add-patch.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/add-patch.c b/add-patch.c
> index 55d719f7845..087bf317b07 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -478,11 +478,16 @@ static int parse_diff(struct add_p_state *s, const =
struct pathspec *ps)
>  =09while (p !=3D pend) {
>  =09=09char *eol =3D memchr(p, '\n', pend - p);
>  =09=09const char *deleted =3D NULL, *mode_change =3D NULL;
> +=09=09const char *const diff_l =3D "diff ";
> +=09=09int is_diff_line =3D starts_with(p, diff_l);
> =20
>  =09=09if (!eol)
>  =09=09=09eol =3D pend;
> =20
> -=09=09if (starts_with(p, "diff ")) {
> +=09=09if (!is_diff_line && (!file_diff || !hunk))
> +=09=09=09BUG("expected '%s' line to follow a '%s' line", p, diff_l);
> +
> +=09=09if (is_diff_line) {
>  =09=09=09complete_file(marker, hunk);
>  =09=09=09ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
>  =09=09=09=09   file_diff_alloc);
> --=20
> 2.36.1.1124.g577fa9c2ebd
>
