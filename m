Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE48AC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389307AbiDVJ3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiDVJ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:29:01 -0400
Received: from smtp-out-1.tiscali.co.uk (smtp-out-1.tiscali.co.uk [62.24.135.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0F85FC6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:26:03 -0700 (PDT)
Received: from app-5.app.tt.ham.xion.oxcs.net ([185.74.64.161])
        by smtp.talktalk.net with SMTP
        id hpY7n08S6LVmmhpY8nZWkq; Fri, 22 Apr 2022 10:26:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1650619560;
        bh=nvdD43wZhX92IKooCCDG95zRrj6Hry7dv+CBSd4KkdE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=I2es7cYb3x1tXMA6jiajBfzwmPzWxzYmIIaOBQ5flNdCfyTgwlTSqytBEZeY8avbR
         k4JWkuLVdTeZ8qlPH9YcPei1rWbacGcl9RErd+5UdyZbP716zMitT6Ebw2q69h4RdT
         HbTh+g5sw2ptSn6ozL1KnZHYbTSKQORQzEUBO89o=
Date:   Fri, 22 Apr 2022 10:25:59 +0100 (BST)
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Message-ID: <1654562506.42130.1650619559902@apps.talktalk.co.uk>
In-Reply-To: <patch-v3-1.1-8b3444ecc87-20220422T092015Z-avarab@gmail.com>
References: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
 <patch-v3-1.1-8b3444ecc87-20220422T092015Z-avarab@gmail.com>
Subject: Re: [PATCH v3] CI: select CC based on CC_PACKAGE (again)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev78
X-Originating-IP: 31.185.185.192
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4wfDgiWy0J3eaULiOXphp7V/fub1w/PFaBnZyzvqNlIoQu/SOhjXoSNnRzd/KgjpsY60czSTWyxYmmCYGL6FQtiTeB8bWhv4UoEETO6m9s8srDqyMHfaYa
 Ug06E6yRNzTEmDM/Gspk3Yd+bQrFo4Bp8Ec+hDFaRG1bkWFtU+r12HbK9MvYONhbg9AUHO+T4y9TlVpZOHxGIJdhjKtkD9Uoemb2dzpW+NpDNyJzPzNaTo4u
 IoIBOqaHU03NgSMWHNo9IZSUuDtqVGcDiinQIyEDi1KgGwkXQCSRygW/8ESFYgRwulkdv24uQ3aXIrp6T/UWwg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var

> On 22 April 2022 at 10:20 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com> wrote:
>=20
>=20
> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
> "$jobname" to select packages & config, 2021-11-23).
>=20
> In that commit I changed CC=3Dgcc from CC=3Dgcc-9, but on OSX the "gcc" i=
n
> $PATH points to clang, we need to use gcc-9 instead. Likewise for the
> linux-gcc job CC=3Dgcc-8 was changed to the implicit CC=3Dgcc, which woul=
d
> select GCC 9.4.0 instead of GCC 8.4.0.
>=20
> Furthermore in 25715419bf4 (CI: don't run "make test" twice in one
> job, 2021-11-23) when the "linux-TEST-vars" job was split off from
> "linux-gcc" the "cc_package: gcc-8" line was copied along with
> it, so its "cc_package" line wasn't working as intended either.
>=20
> As a table, this is what's changed by this commit, i.e. it only
> affects the linux-gcc, linux-TEST-vars and osx-gcc jobs:
>=20
> =09|-------------------+-----------+-------------------+-------+-------|
> =09| jobname           | vector.cc | vector.cc_package | old   | new   |
> =09|-------------------+-----------+-------------------+-------+-------|
> =09| linux-clang       | clang     | -                 | clang | clang |
> =09| linux-sha256      | clang     | -                 | clang | clang |
> =09| linux-gcc         | gcc       | gcc-8             | gcc   | gcc-8 |
> =09| osx-clang         | clang     | -                 | clang | clang |
> =09| osx-gcc           | gcc       | gcc-9             | clang | gcc-9 |
> =09| linux-gcc-default | gcc       | -                 | gcc   | gcc   |
> =09| linux-TEST-vars   | gcc       | gcc-8             | gcc   | gcc-8 |
> =09|-------------------+-----------+-------------------+-------+-------|

Having this table is helpful. I do find it confusing that we're still setti=
ng=20
CC in the main.yaml and then overriding it in lib.sh. I think it would make=
=20
things clearer if we got find of the cc settings in the job matrix.

Best Wishes

Phillip

> Reported-by: Carlo Arenas <carenas@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>=20
> I just dropped the linux-TEST-vars change from the v2 in lieu of
> trying to get the wording in the commit message right.
>=20
> Range-diff against v2:
> 1:  92acf9420a9 ! 1:  8b3444ecc87 CI: select CC based on CC_PACKAGE (agai=
n)
>     @@ Commit message
>          Furthermore in 25715419bf4 (CI: don't run "make test" twice in o=
ne
>          job, 2021-11-23) when the "linux-TEST-vars" job was split off fr=
om
>          "linux-gcc" the "cc_package: gcc-8" line was copied along with
>     -    it.
>     -
>     -    That wasn't a bug per-se, as that "make test" would have run und=
er GCC
>     -    8 before the split into two jobs, but the point of selecting dif=
ferent
>     -    compiler for these jobs is to get better coverage, and to narrow=
 down
>     -    any issues with a given compiler to the job that runs it. Since =
the
>     -    "linux-TEST-vars" job is already special in other ways (in runni=
ng
>     -    with various GIT_TEST_* variables), and we've got the "linux-gcc=
" job
>     -    covering gcc-8 let's have it used the default system compiler in=
stead.
>     +    it, so its "cc_package" line wasn't working as intended either.
>     +
>     +    As a table, this is what's changed by this commit, i.e. it only
>     +    affects the linux-gcc, linux-TEST-vars and osx-gcc jobs:
>     +
>     +            |-------------------+-----------+-------------------+---=
----+-------|
>     +            | jobname           | vector.cc | vector.cc_package | ol=
d   | new   |
>     +            |-------------------+-----------+-------------------+---=
----+-------|
>     +            | linux-clang       | clang     | -                 | cl=
ang | clang |
>     +            | linux-sha256      | clang     | -                 | cl=
ang | clang |
>     +            | linux-gcc         | gcc       | gcc-8             | gc=
c   | gcc-8 |
>     +            | osx-clang         | clang     | -                 | cl=
ang | clang |
>     +            | osx-gcc           | gcc       | gcc-9             | cl=
ang | gcc-9 |
>     +            | linux-gcc-default | gcc       | -                 | gc=
c   | gcc   |
>     +            | linux-TEST-vars   | gcc       | gcc-8             | gc=
c   | gcc-8 |
>     +            |-------------------+-----------+-------------------+---=
----+-------|
>     =20
>          Reported-by: Carlo Arenas <carenas@gmail.com>
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>     =20
>     - ## .github/workflows/main.yml ##
>     -@@ .github/workflows/main.yml: jobs:
>     -           - jobname: linux-TEST-vars
>     -             cc: gcc
>     -             os: ubuntu
>     --            cc_package: gcc-8
>     -             pool: ubuntu-latest
>     -           - jobname: osx-clang
>     -             cc: clang
>     -
>       ## ci/lib.sh ##
>      @@ ci/lib.sh: then
>       =09test macos !=3D "$CI_OS_NAME" || CI_OS_NAME=3Dosx
>=20
>  ci/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ci/lib.sh b/ci/lib.sh
> index cbc2f8f1caa..86e37da9bc5 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -122,7 +122,7 @@ then
>  =09test macos !=3D "$CI_OS_NAME" || CI_OS_NAME=3Dosx
>  =09CI_REPO_SLUG=3D"$GITHUB_REPOSITORY"
>  =09CI_JOB_ID=3D"$GITHUB_RUN_ID"
> -=09CC=3D"${CC:-gcc}"
> +=09CC=3D"${CC_PACKAGE:-${CC:-gcc}}"
>  =09DONT_SKIP_TAGS=3Dt
> =20
>  =09cache_dir=3D"$HOME/none"
> --=20
> 2.36.0.879.g56a83971f3f
>
