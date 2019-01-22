Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238461F453
	for <e@80x24.org>; Tue, 22 Jan 2019 23:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfAVXzG (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 18:55:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35202 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVXzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 18:55:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so284513edx.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 15:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoeL3srhyel/BmRToz7WIEL1qHqtJPpCLdZnMRd5qtY=;
        b=KOKs83B7xkDZMDeuCpTT45ijhqH1YmwMYoVMTzg+iYDUfGjUMh0V/9jx4lReUbY+Xk
         j7Q9xJBiJQMt3i+TodzH+9e/IuGuXyLl6My/+F77zywYdEoxKHjJWJ0qQyGFaqvljGeI
         sZY5cdvZ2Y+QpHvtuvxU1xi6lpv2hVzqk5kXAXG5rsS3Ji8Sni9tVBrc497xb5neKszc
         w7BwYxWM81cTf/rVqbX6EAkF10L+tgaGsGQmaZswHsEBCkdg5FSARzk46KmCKKzpnbBw
         UpIvAk5rWlmJXl7WBRQnMkZI7l2cURsBz+WoZZD4wwVIHP3Z0s5O7z8FN7t9NDi0Wc6r
         pMMw==
X-Gm-Message-State: AJcUukfqk/ovFPHwOO/Kvm/UX+4qAi9275GIGAbGwskmSVeRtW9hK+c2
        OMW+3g+xmCSimSOM6J9OJhDm+Xkhpg==
X-Google-Smtp-Source: ALg8bN7fAaObP8YHv0Z8J6DTGiq38L4NNIMTte+B2KHbvW9BordL2Gb+KweB34aOjrKyH+yRMlk3tg==
X-Received: by 2002:a17:906:11ce:: with SMTP id o14-v6mr441647eja.136.1548201303824;
        Tue, 22 Jan 2019 15:55:03 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id l18sm9619424edq.87.2019.01.22.15.55.02
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:55:03 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id p6so294671eds.0
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 15:55:02 -0800 (PST)
X-Received: by 2002:a50:bf02:: with SMTP id f2mr449005edk.157.1548201302507;
 Tue, 22 Jan 2019 15:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20190119154337.6556-1-phogg@novamoon.net> <xmqq1s54e2ju.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s54e2ju.fsf@gitster-ct.c.googlers.com>
From:   Patrick Hogg <phogg@novamoon.net>
Date:   Tue, 22 Jan 2019 18:54:24 -0500
X-Gmail-Original-Message-ID: <CAFOcBz==BunV48U94ZSnc2gmBTOcOpY4XO-dPugKMUVNZGjzZA@mail.gmail.com>
Message-ID: <CAFOcBz==BunV48U94ZSnc2gmBTOcOpY4XO-dPugKMUVNZGjzZA@mail.gmail.com>
Subject: Re: [PATCH v2] pack-objects: Use packing_data lock instead of read_mutex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 5:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Patrick Hogg <phogg@novamoon.net> writes:
>
> > As I mentioned in the prior thread I think that it will be simpler
> > to simply use the existing lock in packing_data instead of moving
> > read_mutex. I can go back to simply moving read_mutex to the
> > packing_data struct if that that is preferable, though.
>
> I'll let others comment on this to show preference between the two
> approaches.
>
> > I also removed the #ifndef NO_PTHREADS in prepare_packing_data around
> > the initialization of &pdata->lock since I had to upgrade the lock to
> > a recursive mutex. As far as I can tell init_recursive_mutex (and
> > pthread_mutex_init for that matter) have that protection already so it
> > appears to be redundant.
>
> If you can defer "I also" to a separate patch, please do so.
> Keeping the fix alone as small as possible and not tangled with
> other changes would make it easier for people to cherry-pick the fix
> to older maintenance tracks if they choose to.

That's a fair point.  To confirm (as I'm rather new to submitting git
patches), do you mean to submit a two-patch series or to just leave
out the #ifndef removal altogether for now?

If this does become a two patch series I could simply move the
read_mutex to packing_data in the first patch and merge the two
mutexes (and remove the #ifndef) in the second.  That would keep the
fix alone even smaller (just the first patch) to simplify
cherry-picking.

(There is also the option of going back to the v1 change and
correcting the cleanup in the early return.)

I just want to confirm preferences first before submitting a v3 to
avoid spamming patches; I'll go whichever way the experts think is
best.

Thanks,
-Patrick
