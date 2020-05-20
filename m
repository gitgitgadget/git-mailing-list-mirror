Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7175C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7705207D4
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETOqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:46:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55178 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETOqH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:46:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id h4so2768648wmb.4
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1Y6xeModiH3BlTdB61seYkfWK9sq2iVhtjHJ4PNhFc=;
        b=b02jlj+PAOu05DwU8jOWmAaj8gcg9rr4DBzlOVWxB1+AUQ9ysBXsgWwy93XlqIoUk1
         eIe+lQwkUOlKE2brusZpxbQanwHt2AtOte+e8MWwJG33j7cFhjUi7BUZWQOyXtzOqqsm
         FE7b/A3tAKMPDYcN6zTmBBKmVSkxu6ds4L8WjeHuyj3if16aQ6sodHPM/SzAqF7IqMzv
         nl1a6rMQCTsso42ixJYToYy0j2HBwmU3dU83vpDZZBhCf3/RAvcCYXUJ9h3ByUA8G2Cg
         HmWsxIZbhOlLc2a88/21Zt2xD4MBkLXchm/qL33KFPONG5ldPhbVSASJBMoNVPVzd/n/
         GE6Q==
X-Gm-Message-State: AOAM533ypfW/K9pE/HXpGabssEbIr46NHil0tlpcNde2u06ACO8zOON3
        RBe9uPl6ZxmI3L9NljRdlHJGmtXxF3kBgs0tSp/mMXJY
X-Google-Smtp-Source: ABdhPJyutAov8bY6WOwLkyf1iSUZHNpoB8O9FFlr3BQT22QHFpnzW97uBPVt77pIJCNJq4+t298bPg/KlxABXbJ/Ds8=
X-Received: by 2002:a1c:bad6:: with SMTP id k205mr4794013wmf.53.1589985965263;
 Wed, 20 May 2020 07:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200519182654.33318-1-shouryashukla.oo@gmail.com>
 <CAPig+cSKFBFdNXA52f5f0q3SetA2btmkXeqyHNw-qwJ5ECq5mQ@mail.gmail.com> <20200520121530.GA7992@konoha>
In-Reply-To: <20200520121530.GA7992@konoha>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 May 2020 10:45:53 -0400
Message-ID: <CAPig+cSr0_eOOi6xiOLY0bzJ33ewpib+MiMjmtay_bi4J9D_=w@mail.gmail.com>
Subject: Re: [PATCH v2] submodule: port subcommand 'set-branch' from shell to C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git List <git@vger.kernel.org>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 8:23 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> On 19/05 02:57, Eric Sunshine wrote:
> > On Tue, May 19, 2020 at 2:27 PM Shourya Shukla
> > <shouryashukla.oo@gmail.com> wrote:
> > > +        OPT__QUIET(&quiet,
> >
> > However, the bigger question is: Why is the --quiet option even here?
> > None of the code in this function ever consults the 'quiet' variable,
> > so its presence seems pointless.
>
> I actually wanted to have *some* use of the `quiet` option and delivered
> it in the v1, but after some feedback had to scrap it. You may have a
> look here:
> https://lore.kernel.org/git/20200513201737.55778-2-shouryashukla.oo@gmail.com/

I agree with Denton's conclusion about not introducing needless noise
merely to give the --quiet option something to squelch. And, to answer
your question about when and when not to print something, a good "Unix
way" guideline is that "silence is golden"[1].

[1]: http://www.catb.org/esr/writings/taoup/html/ch01s06.html#id2878450

> > Looking at the git-submodule documentation, I see that it is already
> > documented as accepted --quiet, so it may make some sense for you to
> > accept the option here. However, it might be a good idea either to
> > have an in-code comment or a blurb in the commit message explaining
> > that this C rewrite accepts the option for backward-compatibility (and
> > for future extension), not because it is actually used presently.
>
> That seems like a better idea; should I add this comment just above the
> `options` array? BTW, the shell version has a comment about this,
> see:
> https://github.com/git/git/blob/v2.26.2/git-submodule.sh#L727

It would be a good idea to attach a comment like that to the
declaration of 'quiet' in the C code (rather than placing it above the
'options' array). For instance:

    /* for backward compatibility but not presently used */
    int quiet = 0;

> > > +        die(_("--branch and --default do not make sense together"));
> >
> > A more precise way to say this is:
> >
> >   die(_("--branch and --default are mutually exclusive"));
>
> Will that be clear to everyone? What I mean is maybe a person from a
> non-mathematical background (someone doing programming as a hobby maybe)
> will not grasp at this at one go and will have to search it's meaning
> online. Isn't it fine as-is?

Others have already responded to this up-thread...
