Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1434C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA39A20657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgERS2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:28:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgERRnP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:43:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id i15so12825045wrx.10
        for <git@vger.kernel.org>; Mon, 18 May 2020 10:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulgMFjuz6kRKZtoir59arO63llGvBG/bQKKzMpDsTtQ=;
        b=n8B6wg0WQ7Op98D8aKGLM+glyaC66K3Tx2N8VCWx6X2murJchWyRcmS2A3cJECtcyO
         +xCiNOoSaWW+ZjhNk2ukF6FSRBE5iVrYTe2FuLFBsozLkOxkUkTt0BNE848RGEw4VCUS
         I6S3YAcFlOJfCmatAIov/0MjRY8FWN9h80uGQdyNxVvLFWsHrV5dFpUcsLuOEjms4zY1
         0o2NVz6Oer/dQvC0qkTqEn28hL+PDvKOcdFue5dTyroje+nIV2vfuvJLlObB65Y7CC6f
         aj1jodpq76BIpn5urp8CNLxzw4ooDqh1d4cu6CdUs0DNL966mTcn3CYu5S40S9IyI+H6
         jT2A==
X-Gm-Message-State: AOAM531FPkDwTPejT2wYw5vvRJVeMEr+0AkLSgfLSkiJFNBBBCNgntUE
        hOW620tYzFTQHEJmlDjjN78f7zdCpWDUIH0ngw8=
X-Google-Smtp-Source: ABdhPJwTeLKAFAICV+ySZu0PiteSKNHAXH6ii01b1+4XdwSXA4SjEkLvnmU0KbeCdJKbKYXtjbu3jOZhJMvZJM5+hm8=
X-Received: by 2002:adf:f786:: with SMTP id q6mr20691308wrp.120.1589823793813;
 Mon, 18 May 2020 10:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589393036.git.liu.denton@gmail.com> <c89c1841008dfc2d111369fb682b946a0c33b7be.1589393036.git.liu.denton@gmail.com>
 <CAPig+cQyCSMtSrdk54E6MVYL4prhNyWgBKkkBFHXo5hShqQ+=Q@mail.gmail.com> <20200518091825.GB24557@generichostname>
In-Reply-To: <20200518091825.GB24557@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 May 2020 13:43:02 -0400
Message-ID: <CAPig+cR97uFvxmTBHiV5zi9ZqfZnDKmAi4ZG1rUOngk6QrWEVA@mail.gmail.com>
Subject: Re: [PATCH 3/6] transport: combine common cases with a fallthrough
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 5:18 AM Denton Liu <liu.denton@gmail.com> wrote:
> On Wed, May 13, 2020 at 07:14:35PM -0400, Eric Sunshine wrote:
> > > +       case protocol_v1:
> > >                 die_if_server_options(transport);
> > > +               /* fallthrough */
> > > +       case protocol_v2:
> > >                 refs = fetch_pack(&args, data->fd,
> > >                                   refs_tmp ? refs_tmp : transport->remote_refs,
> > >                                   to_fetch, nr_heads, &data->shallow,
> >
> > I can't say that I'm a fan of this change. While it may make it clear
> > that the two calls are identical, it makes it more difficult to reason
> > about the distinct v0, v1, and v2 cases.
>
> Actually, thinking about it some more, do you think it would make more
> sense to just pull the fetch_pack() call out of the switch statement
> entirely? We could entirely eliminate the fallthrough if we do this.

Yes, I think that works better and is cleaner and easier to understand
than the "fallthrough" in v1.
