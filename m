Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFDCC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 00:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiBTA1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 19:27:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiBTA1X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 19:27:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C640A04
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 16:27:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m3so16078613eda.10
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CruwDLBgk73SCUxFNmqYlj51unXDnOMBwRbTpE2nLI4=;
        b=e0L0M9YpOjfMo3x6eM+fReezEgSeQ/24UEP1StlrZvE5hNLfWTB54h4wvx2hJyamfe
         rGVymjFcLZzRwIFVnG9eM4ywgYunBv2sGb4wX3Vq74JLMmbBCOV2wt992t8hOsvGnAMg
         GhcFYcW/QKEXB7I556rT5ZC5s7TxIZWX7g4of81uy4HfMXri9L1YbU+yp5g0ajl0jRrW
         2YTbXmIZORGhnuSHvd0zSin4ShVkEhBgpW/YRNssYZIrs5zGagENewLoWqrxRqTxWvmy
         uN90hAmYrfabbcaYXHO6ePbsctf9W38IwWuc9e6GZyxgpycuflMFKi3KMeDrxiasEYiy
         3HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CruwDLBgk73SCUxFNmqYlj51unXDnOMBwRbTpE2nLI4=;
        b=WIVmgeM5zO2a974iQgHSKAWQ7jLP6vgaVu+p4U9Uc/Df8UUlZew8iOPhThH15P1VE4
         zD9swCH6Qm/Do+cnHZUTo7akNReE6PGZ8Tu0aRAWiOKCb+nUQ4UIakbQFYPuY3dW5OvI
         yShXnIsEB+phGYQYDXuNeWp4/gYlY6mRKELV+aVJ5O/aXxnpyT8xZt2MSjFGsz4d+0+e
         YJSSMOcgxw4VunWAehamA2v6YHIPSc/c9l9967mH5632Etdk0Pmj29Y+k03mlyZ9HkKQ
         hDzeF9iE0Ysna24DDWNoJ6SXDgwanC7/tOBOiH9zKnq2LniUZ7tngGv+wJiXI5Z9cl7d
         NQEw==
X-Gm-Message-State: AOAM53169GtVtYXcxfz5goOI6Nhkp3nQvw+8OoC/soVRaQPJ9V8lrrP6
        v0myVt4YqHXae8pEJ3YWLRzSF0thyArnYXH8qGFQtyw9lKM=
X-Google-Smtp-Source: ABdhPJxzMzRBaNu9YVb9l28GkN+ZfMX+BlWyI4/coB0DldyduNcN3g82+bRqdksMe0WqaNb+2pY96uCP8befkaMAEcg=
X-Received: by 2002:aa7:c04e:0:b0:400:4daf:bab1 with SMTP id
 k14-20020aa7c04e000000b004004dafbab1mr14787447edo.101.1645316821446; Sat, 19
 Feb 2022 16:27:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
 <f0308de28e49fb9bb1239fdcbc839097f5afa62a.1645290601.git.gitgitgadget@gmail.com>
 <220219.86sfsecyy6.gmgdl@evledraar.gmail.com>
In-Reply-To: <220219.86sfsecyy6.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 19 Feb 2022 16:26:49 -0800
Message-ID: <CABPp-BEfMVFYaN=17Hp5GgSLbhDnS5YOx2PBtme39xioQgBXTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] merge-ort: fix small memory leak in detect_and_process_renames()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 19, 2022 at 1:45 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Feb 19 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > detect_and_process_renames() detects renames on both sides of history
> > and then combines these into a single diff_queue_struct.  The combined
> > diff_queue_struct needs to be able to hold the renames found on either
> > side, and since it knows the (maximum) size it needs, it pre-emptively
> > grows the array to the appropriate size:
> >
> >       ALLOC_GROW(combined.queue,
> >                  renames->pairs[1].nr + renames->pairs[2].nr,
> >                  combined.alloc);
> >
> > It then collects the items from each side:
> >
> >       collect_renames(opt, &combined, MERGE_SIDE1, ...)
> >       collect_renames(opt, &combined, MERGE_SIDE2, ...)
> >
> > Note, though, that collect_renames() sometimes determines that some
> > pairs are unnecessary and does not include them in the combined array.
> > When it is done, detect_and_process_renames() frees this memory:
> >
> >       if (combined.nr) {
> >                 ...
> >               free(combined.queue);
> >         }
> >
> > The problem is that sometimes even when there are pairs, none of them a=
re
> > necessary.  Instead of checking combined.nr, we should check
> > combined.alloc.  Doing so fixes the following memory leak, as reported
> > by valgrind:
> >
> > =3D=3DPID=3D=3D 192 bytes in 1 blocks are definitely lost in loss recor=
d 107 of 134
> > =3D=3DPID=3D=3D    at 0xADDRESS: malloc
> > =3D=3DPID=3D=3D    by 0xADDRESS: realloc
> > =3D=3DPID=3D=3D    by 0xADDRESS: xrealloc (wrapper.c:126)
> > =3D=3DPID=3D=3D    by 0xADDRESS: detect_and_process_renames (merge-ort.=
c:3134)
> > =3D=3DPID=3D=3D    by 0xADDRESS: merge_ort_nonrecursive_internal (merge=
-ort.c:4610)
> > =3D=3DPID=3D=3D    by 0xADDRESS: merge_ort_internal (merge-ort.c:4709)
> > =3D=3DPID=3D=3D    by 0xADDRESS: merge_incore_recursive (merge-ort.c:47=
60)
> > =3D=3DPID=3D=3D    by 0xADDRESS: merge_ort_recursive (merge-ort-wrapper=
s.c:57)
> > =3D=3DPID=3D=3D    by 0xADDRESS: try_merge_strategy (merge.c:753)
> > =3D=3DPID=3D=3D    by 0xADDRESS: cmd_merge (merge.c:1676)
> > =3D=3DPID=3D=3D    by 0xADDRESS: run_builtin (git.c:461)
> > =3D=3DPID=3D=3D    by 0xADDRESS: handle_builtin (git.c:713)
> > =3D=3DPID=3D=3D    by 0xADDRESS: run_argv (git.c:780)
> > =3D=3DPID=3D=3D    by 0xADDRESS: cmd_main (git.c:911)
> > =3D=3DPID=3D=3D    by 0xADDRESS: main (common-main.c:52)
> >
> > Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index d85b1cd99e9..4f5abc558c5 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -3175,7 +3175,7 @@ simple_cleanup:
> >               free(renames->pairs[s].queue);
> >               DIFF_QUEUE_CLEAR(&renames->pairs[s]);
> >       }
> > -     if (combined.nr) {
> > +     if (combined.alloc) {
> >               int i;
> >               for (i =3D 0; i < combined.nr; i++)
> >                       pool_diff_free_filepair(&opt->priv->pool,
>
> This looks correct in that it'll work, but I still don't get why the
> pre-image or post-image is going through this indirection of checking
> "alloc" at all. Wouldn't this be correct & more straightforward (the
> memset part is optional, just did it for good measure)?:
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 40ae4dc4e92..a01f28586a1 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3092,12 +3092,12 @@ static int detect_and_process_renames(struct merg=
e_options *opt,
>                                       struct tree *side1,
>                                       struct tree *side2)
>  {
> -       struct diff_queue_struct combined;
> +       struct diff_queue_struct combined =3D { 0 };
>         struct rename_info *renames =3D &opt->priv->renames;
>         int need_dir_renames, s, clean =3D 1;
>         unsigned detection_run =3D 0;
> +       int i;
>
> -       memset(&combined, 0, sizeof(combined));
>         if (!possible_renames(renames))
>                 goto cleanup;
>
> @@ -3181,13 +3181,10 @@ static int detect_and_process_renames(struct merg=
e_options *opt,
>                 free(renames->pairs[s].queue);
>                 DIFF_QUEUE_CLEAR(&renames->pairs[s]);
>         }
> -       if (combined.alloc) {
> -               int i;
> -               for (i =3D 0; i < combined.nr; i++)
> -                       pool_diff_free_filepair(&opt->priv->pool,
> -                                               combined.queue[i]);
> -               free(combined.queue);
> -       }
> +
> +       for (i =3D 0; i < combined.nr; i++)
> +               pool_diff_free_filepair(&opt->priv->pool, combined.queue[=
i]);
> +       free(combined.queue);
>
>         return clean;
>  }

Hmm, good point; I like your version better.  I'll change it, thanks.
