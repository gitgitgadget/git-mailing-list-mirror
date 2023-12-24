Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BEC809
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDv8BCB0"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso3237899e87.3
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 19:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703387528; x=1703992328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4jaDoEi5lORp50XaYqZ8hfT2l3EvYRYbGifIStQKP8=;
        b=UDv8BCB0xjw+PxMLUwl3rUXW8GyTjQWAQljbTIrhKJU6LjT5HMiwvSOwE0+7xI0rs4
         EEtW3izPsaKM5V1qqDpZAsRXpTovaUh3iF9fXSxuw/HXkUJo0zUlIEraaq5C7fo4fUvV
         Op/Xvm2HTYCMueY2wUXQaogoCnTKMF62Ef/LPAs2SZ/FjE3LK/ztQIxHHUMEpwoIbJJy
         ruVpxJI5TLl3KKj/2/e34yhUpKuh5nedlB8Bp1iNjIAiGa6oAKNh7fNUPwlHWWygxeLx
         XqBHssC8yFDN2U2D0i/2tpyDuvyO/uRxficFORhPipLLw1y7K0qHVGwbggSqlbZlCvh2
         9m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703387528; x=1703992328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4jaDoEi5lORp50XaYqZ8hfT2l3EvYRYbGifIStQKP8=;
        b=IUd3KNRd5t9rATs2efDaF0EAKIjsCAD3A/c9ORS6JKKpioFD2iyrJvMIthhSWixMV3
         tbNPcyE518rFfdqmzjiolLdroGjbV+1vrRPVdu0aADx/Dr2WqwG4ZmxfyuNTjUvWuEbB
         NsEyoTRkPgZEoDce54wXqG4hkiYFPbq5+Lb6qrv35ly36MBNeRfJljSt6mUR/1ynN7Zf
         A/89TmkhjzFKcfvJU3VbOGWUWNvivhSa718S+SVwwqUrSIU0GleKCRoNe0KYwBokTVAl
         ODNST/+To1jIHc9Ep2myf1RUNkUIe677edy/bLCl8L3g+VToey8zMLv7CEj6F9e3SMY0
         syzQ==
X-Gm-Message-State: AOJu0YzhAYCdAJ87jiZ8YOYFVhwOUwBnlTYOLcJr6DHo852ldpkmGhgr
	5atON2tbsOC/0COHaYWZjpqTD1AKlDZZa039StzeG/Cv
X-Google-Smtp-Source: AGHT+IGUlZ1y7Jz1DfBC/HyvUdzR/Fot9kGYNzMxQfmceEkBRC00z7+nVAhFlCAhtaXHLat8Q1eF/x/3B608jOjqJ0k=
X-Received: by 2002:a19:7616:0:b0:50e:67f6:1ac3 with SMTP id
 c22-20020a197616000000b0050e67f61ac3mr801267lff.68.1703387528113; Sat, 23 Dec
 2023 19:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
In-Reply-To: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 23 Dec 2023 19:11:57 -0800
Message-ID: <CABPp-BFiK9A6426d7CFeMZvaBcvmShaY9O0krtCe7jeV9wW7nQ@mail.gmail.com>
Subject: Re: [PATCH] mem-pool: fix big allocations
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 3:13=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Memory pool allocations that require a new block and would fill at
> least half of it are handled specially.  Before 158dfeff3d (mem-pool:
> add life cycle management functions, 2018-07-02) they used to be
> allocated outside of the pool.  This patch made mem_pool_alloc() create
> a bespoke block instead, to allow releasing it when the pool gets
> discarded.
>
> Unfortunately mem_pool_alloc() returns a pointer to the start of such a
> bespoke block, i.e. to the struct mp_block at its top.  When the caller
> writes to it, the management information gets corrupted.  This affects
> mem_pool_discard() and -- if there are no other blocks in the pool --
> also mem_pool_alloc().
>
> Return the payload pointer of bespoke blocks, just like for smaller
> allocations, to protect the management struct.
>
> Also update next_free to mark the block as full.  This is only strictly
> necessary for the first allocated block, because subsequent ones are
> inserted after the current block and never considered for further
> allocations, but it's easier to just do it in all cases.
>
> Add a basic unit test to demonstate the issue by using mem_pool_calloc()

demonstrate (missing 'r')?

> with a tiny block size, which forces the creation of a bespoke block.
> Without the mem_pool_alloc() fix it reports zeroed pointers:
>
>    ok 1 - mem_pool_calloc returns 100 zeroed bytes with big block
>    # check "((pool->mp_block->next_free) !=3D (((void*)0))) =3D=3D 1" fai=
led at t/unit-tests/t-mem-pool.c:22
>    #    left: 0
>    #   right: 1
>    # check "((pool->mp_block->end) !=3D (((void*)0))) =3D=3D 1" failed at=
 t/unit-tests/t-mem-pool.c:23
>    #    left: 0
>    #   right: 1
>    not ok 2 - mem_pool_calloc returns 100 zeroed bytes with tiny block
>    1..2
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  Makefile                  |  1 +
>  mem-pool.c                |  6 +++---
>  t/unit-tests/t-mem-pool.c | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 3 deletions(-)
>  create mode 100644 t/unit-tests/t-mem-pool.c
>
> diff --git a/Makefile b/Makefile
> index 88ba7a3c51..15990ff312 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1340,6 +1340,7 @@ THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
>  THIRD_PARTY_SOURCES +=3D sha1dc/%
>
>  UNIT_TEST_PROGRAMS +=3D t-basic
> +UNIT_TEST_PROGRAMS +=3D t-mem-pool
>  UNIT_TEST_PROGRAMS +=3D t-strbuf
>  UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRA=
MS))
>  UNIT_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAM=
S))
> diff --git a/mem-pool.c b/mem-pool.c
> index c34846d176..e8d976c3ee 100644
> --- a/mem-pool.c
> +++ b/mem-pool.c
> @@ -99,9 +99,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
>
>         if (!p) {
>                 if (len >=3D (pool->block_alloc / 2))
> -                       return mem_pool_alloc_block(pool, len, pool->mp_b=
lock);
> -
> -               p =3D mem_pool_alloc_block(pool, pool->block_alloc, NULL)=
;
> +                       p =3D mem_pool_alloc_block(pool, len, pool->mp_bl=
ock);
> +               else
> +                       p =3D mem_pool_alloc_block(pool, pool->block_allo=
c, NULL);
>         }
>
>         r =3D p->next_free;
> diff --git a/t/unit-tests/t-mem-pool.c b/t/unit-tests/t-mem-pool.c
> new file mode 100644
> index 0000000000..2295779b0b
> --- /dev/null
> +++ b/t/unit-tests/t-mem-pool.c
> @@ -0,0 +1,34 @@
> +#include "test-lib.h"
> +#include "mem-pool.h"
> +
> +#define check_ptr(a, op, b) check_int(((a) op (b)), =3D=3D, 1)
> +
> +static void setup_static(void (*f)(struct mem_pool *), size_t block_allo=
c)
> +{
> +       struct mem_pool pool =3D { .block_alloc =3D block_alloc };
> +       f(&pool);
> +       mem_pool_discard(&pool, 0);
> +}
> +
> +static void t_calloc_100(struct mem_pool *pool)
> +{
> +       size_t size =3D 100;
> +       char *buffer =3D mem_pool_calloc(pool, 1, size);
> +       for (size_t i =3D 0; i < size; i++)
> +               check_int(buffer[i], =3D=3D, 0);
> +       if (!check_ptr(pool->mp_block, !=3D, NULL))
> +               return;
> +       check_ptr(pool->mp_block->next_free, <=3D, pool->mp_block->end);
> +       check_ptr(pool->mp_block->next_free, !=3D, NULL);
> +       check_ptr(pool->mp_block->end, !=3D, NULL);
> +}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +       TEST(setup_static(t_calloc_100, 1024 * 1024),
> +            "mem_pool_calloc returns 100 zeroed bytes with big block");
> +       TEST(setup_static(t_calloc_100, 1),
> +            "mem_pool_calloc returns 100 zeroed bytes with tiny block");
> +
> +       return test_done();
> +}
> --
> 2.43.0

Nice catch; looks good to me.  Out of curiosity, how'd you find the issue?
