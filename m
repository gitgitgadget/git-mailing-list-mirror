Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0977FC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3D720775
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgCYGgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:36:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54522 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGgx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:36:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id c81so1073050wmd.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 23:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vk9msG/R4wH1dDFbiRqOK2hziQzDvLXdB4bAP1xwg2k=;
        b=PMwC79ekh6nF1dZqD9p41saboaXUm6Dd0AmfFc0ef7Ge2zpJh8f/z8B2hOFISI6n8E
         zbOoDFy3PpSZwcJvn/bCgo5mMlxBQjpzR4TCdxhhlZy/NhKS+Yk3yBJW1entorieBtpd
         ouOTOsO6q5gbnMGDVUcEvdvish9gaeWZNQNoIsRHjy15pN0lzmRZiXEaklxTr2/eCmC1
         HCBVnQAJKfkLmTjWSXGUS3qppJX5CgSQQONJvzWqEF3cKt5xifknEOTE1aD4hu4rzFGD
         4D5D0QBCqIDLW06Am39KaHzZiSKIfSiikUmM4GbRy5f0pIT0d0BLqkhjMvMHA7ptDziT
         ToQg==
X-Gm-Message-State: ANhLgQ1nTcbA6zG8sP4reQO3w2c+wpPEjZZz6TIXrGYMzMsMenDRpB7l
        nhHko0B2Fg/T+IK6NUPxZjiYFXO8E1zw00U0FA0=
X-Google-Smtp-Source: ADFU+vtRojFZ8DodmWZnS8y6afBRVt528JRX0iOPIK/9Vv6VXw1tD072/885/giM+SG1rDb2F+oAt8hgtPbgUVUoaDA=
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr1862593wme.107.1585118212324;
 Tue, 24 Mar 2020 23:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585115341.git.liu.denton@gmail.com> <b51f97f6ae37e4b69b9651cbd60a480e5db3e72d.1585115341.git.liu.denton@gmail.com>
 <xmqqv9mtx7wv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9mtx7wv.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Mar 2020 02:36:41 -0400
Message-ID: <CAPig+cSJVdFEZ_V_FBtdAhR7KqocqXCgkHm1pFMDjBX_NPE+Jw@mail.gmail.com>
Subject: Re: [PATCH 8/8] t5801: teach compare_refs() to accept !
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 2:31 AM Junio C Hamano <gitster@pobox.com> wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> >  compare_refs() {
> > +     fail= &&
> > +     if test "x$1" = 'x!'
> > +     then
> > +             fail='!' &&
> > +             shift
> > +     fi &&
> >       git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
> >       git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
> > -     test_cmp expect actual
> > +     eval $fail test_cmp expect actual
> >  }
> > -     test_must_fail compare_refs local signed-tag server signed-tag
> > +     compare_refs ! local signed-tag server signed-tag
>
> While this is not wrong per-se, I do not know why we cannot just use
>
>         ! compare_refs local signed-tag server signed-tag
>
> i.e. "we expect these two repositories have different tags"?

As mentioned in the commit message, if one of the git-rev-parse
invocations fails unexpectedly, then compare_refs() would return early
with a failure code, but the "!" would then (undesirably) turn that
failure into a success. We don't want to lose a failure code from
git-rev-parse, so the simple use of "! compare_refs ..." is avoided.
