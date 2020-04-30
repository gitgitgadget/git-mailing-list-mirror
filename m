Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F174C83001
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 05:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460542073E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 05:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgD3Fct (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 01:32:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43052 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgD3Fct (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 01:32:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id i10so5213259wrv.10
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 22:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYDFdcAgWGhT+8Nzm/5yKbLQfo0Kg2f86K26PF8FOnI=;
        b=YCowj0wO+1dPSRJWVGzARMoVTzdtJEYNolp10avXVjLMYr065iWXDpiAF09m8gtyxg
         Kv/RWt1w7B18tHFLpxevmxDaPhROXZXr26lpcDtAUB7QgI+Gy0xnZUYJLLHnpTM+J4pq
         j6kraElOBgp4y8p3qWJ8dQ0e+oBdFkSOFL3WthYYsdla473skK7Bb+DzEb7vCmqoj2kI
         z5HNi/K59Kr4IXQ8wK6XFMNJNCJQ931XEEDGUz6UFyRm4FeQoBhXNODAqdiabcFR03SP
         b1dr6ksAW1Mkt935R9/2A0Yg2525iFHv065vojCQn1yft5hD1TRYg6cX8V02hcEKUWHW
         dWWA==
X-Gm-Message-State: AGi0PuYDvzpkWBmJAiK+udqL96nBkrx48HBoYPCii5qdK+ikWfiQpgaC
        aI12iTva6ijsEpn3yA0ON4Iyd/cj6zGsYWsbKEk=
X-Google-Smtp-Source: APiQypKMn16MJwgY7ndmvb9VvMk9u7lx3eP6Mm4oeTfKaK6XYEN88mOLocezSBl69nq24rJQSk3g+/lIJISmpVBWBJ4=
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr1705999wrs.415.1588224765600;
 Wed, 29 Apr 2020 22:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588199705.git.me@ttaylorr.com> <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
 <20200430031138.GC115238@google.com>
In-Reply-To: <20200430031138.GC115238@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Apr 2020 01:32:34 -0400
Message-ID: <CAPig+cQOMJJQBi2KMqzzZQs-S1KVwzAxdfzEaUvSNskMtYkCrw@mail.gmail.com>
Subject: Re: [PATCH 5/5] shallow: use struct 'shallow_lock' for additional safety
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 11:11 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Taylor Blau wrote:
> > +/*
> > + * shallow_lock is a thin wrapper around 'struct lock_file' in order to restrict
> > + * which locks can be used with '{commit,rollback}_shallow_file()'.
> > + */
>
> I think I disagree with Eric here: it's useful to have a comment here
> to describe the purpose of the struct (i.e., the "why" as opposed to
> the "what").

I'm not, in general, opposed to the structure being documented; it's
just that the comment, as presented, doesn't seem to add value.

> I wonder if we can go further, though --- when using a shallow_lock,
> how should I think of it as a caller? In some sense, the use of
> 'struct lock_file' is an implementation detail, so we could say:
>
>     /*
>     * Lock for updating the $GIT_DIR/shallow file.
>     *
>     * Use `commit_shallow_file()` to commit an update, or
>     * `rollback_shallow_file()` to roll it back. In either case,
>     * any in-memory cached information about which commits are
>     * shallow will be appropriately invalidated so that future
>     * operations reflect the new state.
>     */
>
> What do you think?

This comment makes more sense and wouldn't have led to me questioning
its usefulness. Thanks.
