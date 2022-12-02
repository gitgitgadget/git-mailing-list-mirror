Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21EAC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiLBBqB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 1 Dec 2022 20:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiLBBp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:45:59 -0500
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C876DD3DCE
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:45:58 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id d131so975887ybh.4
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 17:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbig3flsWwuboHl/Aqvf6Z78x1fIRjQzxgl28AFwPYY=;
        b=ZTfwBPyRJWmENnLzltKdqi99HfQIlEKN1SH8n4pf/L52QL+5Le2K1ZQJwC4EMChw6L
         RWgM8xIL7RH1czV38K0FoYacIQREF1vJLp7gV6OkMDaA+cAkum/xCjQo3w5i0MsXBEI3
         UEHjFD+xie3V33U+n8h8IyHNfyaFqpt4n9qpEn9jf8iuopkOR9wH4tmATT1umEoVzPuU
         L7t02PQrhQDAcYZKQNU2oX3iAO40i9XPurg/xNbofpBeYg+4qb6jSsHSvoPDLqxvYJzu
         iYn6B94vXtCoE9ri9tk7qVfpyhu65rIUasRsKSTy5qt3peavimNALoj+KZhqeTfpqXyv
         vpHw==
X-Gm-Message-State: ANoB5pldZfsVyruePKE3DzRbCcRLosz9mRix3O++TVqwb46RoQoQokpI
        KnxROYZc72Q7yaUIM/34NlfdR6ahC7aKfwDSdac=
X-Google-Smtp-Source: AA0mqf4U4wPcS1OEOxuS9y2OmfPMfxVar4tQdgxz8qRDiZnTHHM8aW9gzfs85XPH0Jm/cYzd8cAjq3KVjZ49Iz+uT6I=
X-Received: by 2002:a25:3786:0:b0:6f5:9468:c874 with SMTP id
 e128-20020a253786000000b006f59468c874mr23168120yba.569.1669945557970; Thu, 01
 Dec 2022 17:45:57 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-4.8-c36060934a6-20221202T000227Z-avarab@gmail.com> <CAPig+cTfx4QYBdtSomPRM+BpW+3ELqaQxD7okKhXzykVkyH9NA@mail.gmail.com>
In-Reply-To: <CAPig+cTfx4QYBdtSomPRM+BpW+3ELqaQxD7okKhXzykVkyH9NA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Dec 2022 20:45:42 -0500
Message-ID: <CAPig+cSgnhzFCUVTQCcTKJK+2qVOpdB2R-Vq1DjqspDJudom4w@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] test-lib-functions: add and use test_cmp_cmd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2022 at 8:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Dec 1, 2022 at 7:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > +# test_cmp_cmd is a convenience helper for doing the more verbose:
> > +#
> > +#      echo something >expect &&
> > +#      <some-command-and-args> >actual &&
> > +#      test_cmp expect actual
> > +#
> > +# As:
> > +#
> > +#      test_cmp_cmd something <some-command-and-args>
> > +test_cmp_cmd () {
> > +       local expect="$1" &&
> > +       shift &&
> > +       printf "%s\n" "$expect" >expect &&
> > +       "$@" >actual 2>err &&
> > +       test_must_be_empty err
> > +       test_cmp expect actual
> > +}
>
> I think you also need to document the fact that it expects stderr
> output to be empty.

That said, the behavior of expecting stderr output to be empty seems
like a potentially bad default since it won't play well with commands
which send their "chatty" output to stderr.

Another reason I'm "meh" about this function is that it seems too
narrowly focussed, insisting that the "expect" argument is expressed
as a one-liner. (Yes, I know that that is not a hard limitation; a
caller can pass in a multiline string, but still...) Maybe I'd be less
jaded if it accepted "expect" on its stdin. But, even that doesn't
seem to buy much. The vast majority of cases where you've converted:

    test "$dir" = "$(test-tool path-utils real_path $dir2)" &&

to:

    test_cmp_cmd "$dir" test-tool path-utils real_path $dir2 &&

could just have easily become:

    echo "$dir" >expect &&
    test_cmp test-tool path-utils real_path $dir2 &&

which isn't bad at all, even if it is one line longer, and it is
idiomatic in this test suite.
