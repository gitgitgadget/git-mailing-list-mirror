Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72097C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513C7619E5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 18:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbhI3SlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:41:24 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:35360 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhI3SlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 14:41:23 -0400
Received: by mail-ed1-f50.google.com with SMTP id l8so26005432edw.2
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 11:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcIgSoVefKy/QRAeuZDNHqAp8GYvIhnasarijsS4rMI=;
        b=Iq72JcchEK+jUpdpRaZih8+itMKxWZSDJei8C1hzacyPBaJR0pp98qgSHaPZ0mGfQ+
         ovqvhWHsJ5n6wCzjXZcAycdCB7WJDVDTK7er5dIIzeXcwsVI5c6MM+0yRyvdIeEHbYl/
         uvsVNDItfxyIcx1uPOkCs82n7pufOuJ83Duyda2Ltz2CMvUMZIkkEwTjQmb9QS6FaolK
         5Fb4QIpHcFOWw6pjLEQiOMrVO3zWzCRJJyUDDtwFsNRhcmBdG6vPwmMtd5xJCcTv2YYv
         HptMrOrmAcG3KlrVeZIC9CrkKOP6XSWS6qzHEZMOtUo9H2en94tuTOlTxTlm29VC5+7H
         DRUA==
X-Gm-Message-State: AOAM530/mxuhiy+1M0+SFj7nbH7cKCbw/2ZYLKc/Lsk0qZFwFgyzp/EJ
        /NNCorGfordwIMbdihcx2zo5nEIG7PD5XlWLW/sd4GwsKuU=
X-Google-Smtp-Source: ABdhPJwfXB+x5bE0oClZn6tMqb9yf0SQAJBRAkEVNhy+wL4fW46zU99ztD1yDxLvZKn8PKoY8WLKFW7ajL6xY0ZGlrs=
X-Received: by 2002:a17:907:990d:: with SMTP id ka13mr916046ejc.392.1633027179592;
 Thu, 30 Sep 2021 11:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
 <20210917225459.68086-2-chooglen@google.com> <e1447d0e-091d-c659-b702-c5b33fffdb59@sunshineco.com>
 <kl6lmtnu7xle.fsf@chooglen-macbookpro.roam.corp.google.com> <kl6lk0ix9aju.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lk0ix9aju.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Sep 2021 14:39:28 -0400
Message-ID: <CAPig+cSTEwObVOajvtVA0BQo0vB74BDN4-f6Gi1tYrEt-BzceQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fsck: verify commit graph when implicitly enabled
To:     Glen Choo <chooglen@google.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 2:35 PM Glen Choo <chooglen@google.com> wrote:
> >> test_config() unsets the config variable when the test completes, so I'm
> >> wondering if its use is in fact desirable here. I ask because, from a
> >> quick scan through the file, it appears that many tests in this script
> >> assume that `core.commitGraph` is `true`, so it's not clear that
> >> unsetting it at the end of this test is a good idea in general.
> >
> > This is a good point. I made the original change in response to Taylor's
> > comment, but I think we both didn't consider that this script assumes
> > `core.commitGraph` is `true`. The rest of the tests pass, but only
> > because the default value is true and I'd rather not have tests rely on
> > a happy accident.
>
> I said I would incorporate these suggestions, but I didn't propose what
> changes I would actually make.
>
> Given that each test depends on a global config value in the setup
> phase, it might be simplest to read if we try to avoid anything that
> touches that value. The easiest way to achieve this is to use git -c
> core.commitGraph {true,false} for the {true,false} cases. Since there is
> no -c equivalent for the unset case, I'll continue to use
> test_unconfig() + test_when_finished() to temporarily unset the value.

That was my thought, as well. (I wasn't quite sure why Taylor
recommended test_config() over `-c` which you used originally. It may
just be his personal preference. Perhaps he can chime in?)
