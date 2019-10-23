Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5741F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 13:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406125AbfJWNyK (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 09:54:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38410 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404484AbfJWNyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 09:54:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id v9so10940919wrq.5
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 06:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngHsC660Mw5P43jIj5IOTRtCqSh/fsEz8VdllzuITGw=;
        b=K2aQ7xc1pZuQGV6g3axN5PtXf8EsBBpZJTtBXUNHFRm2+Gc01zKR0Wg2D3ZZgf7Ftc
         4MK+Q7ljBpPayRctCeglhho/FtuHk1EMdsgVASTiBwN4e6dMblZi5G8LK9Y8XRmfuS8O
         54GTtw5Kktu4b3MuchN0H5kxNA5A90IMcFnFjpfUIvBBA9S/ZUQswhQb/7TXSIIIh0XX
         5iCOWGs62t+HXOfpnM6dSv4gIokbiEmZp5s8watnOmyXOpwUC5yo5M7Kwc5fXChpT4jD
         oay01QnyLb6XBwfcVq06nu2AIVagPcFLvty3uiHWFf6sV5iZrO+V4+sFuM4Sk0e5Mz0V
         /BJQ==
X-Gm-Message-State: APjAAAWZ9j7kRDsxA6KbErsh+NlE+s6X6PFV6U6DPSR81wKp/7pz0YH/
        D0nUN4g3bVB8qkYa5sR019TSiZLSLHdCuc8U1q4=
X-Google-Smtp-Source: APXvYqxDqFkxZH4gvfdgfdbX3Qn5chbgH/GoQuRcx6B98yQys0eiE11Vmm0w4QyRogojoaFDnvxAPSSg0uE1E764HkE=
X-Received: by 2002:adf:f010:: with SMTP id j16mr8843642wro.317.1571838847990;
 Wed, 23 Oct 2019 06:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571354136.git.liu.denton@gmail.com> <ff05a0a8f7dc91d988e290b7d606e8a64f5daf54.1571354136.git.liu.denton@gmail.com>
 <CAPig+cRF0taNhmZVu0z+P+Oe3em11Jz33GY8eBZRTGkx3z=TOw@mail.gmail.com> <20191018185227.GA74877@generichostname>
In-Reply-To: <20191018185227.GA74877@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 23 Oct 2019 09:53:57 -0400
Message-ID: <CAPig+cQgE=7Ac+NRaxGRjDwFv4PR1sP8FLHNJfKXJC4QmR4Dhg@mail.gmail.com>
Subject: Re: [PATCH 08/12] t5520: use test_cmp_rev where possible
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 2:52 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Thu, Oct 17, 2019 at 07:41:44PM -0400, Eric Sunshine wrote:
> > On Thu, Oct 17, 2019 at 7:17 PM Denton Liu <liu.denton@gmail.com> wrote:
> > > -       test "$COPY" = "$(git rev-parse --verify me/copy)" &&
> > > +       test_cmp_rev "$COPY" me/copy &&
> >
> > This transformation doesn't look correct. COPY already holds the
> > result of a git-rev-parse invocation:
> >
> >     COPY="$(git rev-parse --verify me/copy)" &&
> >
> > so passing it to test_cmp_rev() -- which applies its own git-rev-parse
> > invocation -- doesn't make sense.
>
> So after grokking the test case, it seems like the the transformation is
> indeed correct. Maybe we can replace the last line with
>
>         test_cmp_rev copy me/copy
>
> but I think I'll leave it unless you have any strong opinions.

For some reason, I had it in my mind that test_cmp_rev() was primarily
meant for comparing _named_ revisions, but of course there is nothing
about the function which even suggests that that is its intended
use-case. In retrospect, using it to compare an OID against a named
revision is a sensible use-case too, so I withdraw the objection.
