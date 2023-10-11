Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C479DCDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjJKTot convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Oct 2023 15:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjJKTor (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:44:47 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B194
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:44:45 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-991c786369cso31233566b.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697053484; x=1697658284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bv6x3RV0yfoephPSiJVI26w5kCC4Iul6B5wyG0dc33A=;
        b=igZj5F7tt7C4D7PHSKeWeZg9gCLS78Yf1q96uw3eCGnvxlSEr+wlO/W4/f40swxekg
         fJQ9Y4Z6ze4t5mZ6ZuKWyXcipFCrYmxlvNWmHfr/cDgdrxWtCixWErdBN3OoCj6PTI9i
         uuLGnVjDDWdzPSOlSRYd7g6k6xneTHq3rDQLVUC4jKVtUCFram55uAGf/zBX2SLSMjLP
         n8ZDbE8EuaORW1gIrMZvbBdwut7A9S92I/+hjqxWnwQMn89/YosLeUhnQIH6X5aqKs7K
         4NRrXgZjXoE6mTVmSzwYb9p0oglxqzjuvevEL5ZK2vXAv5BScGqw5/nPOxqTD4zSNMU3
         4JKQ==
X-Gm-Message-State: AOJu0YyOdKSFFOmXj89fsYfDFi1XIK7KtELot0sr7XG1HjJLd2aa8a/r
        J137Fw69g+PiDraxquLycVaWqnp8wN5q+M5NjzDc+Qac5dE=
X-Google-Smtp-Source: AGHT+IF4BSR9NJcRf2aSZnm3AmCqhNV6ghr6DZDnwDol/Lu5Nod0grQHXQh0HSUp6Da0Zsljr7OoL/hedNjI5eVeV1k=
X-Received: by 2002:a17:906:209:b0:9a9:e5bb:eddc with SMTP id
 9-20020a170906020900b009a9e5bbeddcmr21264989ejd.16.1697053484137; Wed, 11 Oct
 2023 12:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+JQ7M_effxh9BSOhF67N+rsvBVTULe0dWZzp-kq1yOiDq3+hQ@mail.gmail.com>
 <xmqqzg0pnmv5.fsf@gitster.g>
In-Reply-To: <xmqqzg0pnmv5.fsf@gitster.g>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 11 Oct 2023 21:44:07 +0200
Message-ID: <CA+JQ7M9j5_1kJ2+E70+EXF6wFyPPovHnz=T26sQ2hOr0cyaO8g@mail.gmail.com>
Subject: Re: Bug: git stash store can create stash entries that can't be dropped
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 6:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> I am of two minds.  As "stash store" and "stash create" were
> invented as, and have always been ever since, pretty much
> implementation details of scripted "stash save", the user deserves
> what they get when they abuse them: garbage-in, garbage-out.

Fair. I knew what I was doing was probably not kosher. Still, the
documentation says

           git stash store [(-m | --message) <message>] [-q | --quiet] <commit>

and then later clarifying

           Store a given stash created via git stash create (which is
a dangling merge commit) in the stash ref, updating the stash reflog.
This is intended to be useful for scripts.
           It is probably not the command you want to use; see "push" above.

I knew git stash store is meant to be used with git stash create. But
I didn't expect to be able to create a stash entry that I wouldn't be
able to drop.

> Yes, this is exactly what the user deserves.
>
> Having said that, I agree that this shows an uneven UI.  The "drop"
> command cares about what it is dropping and refuses if it is not a
> stash-like thing, so it is understandable to wish "store" to also
> care to the same degree.

I can see why I deserve the mess I made for myself. But I'm also
inclined to think that if I've been allowed to make said mess, I
should similarly be allowed to clean it up, without having to manually
delete the entry from the stash reflog. (In case someone else finds
themselves in a similar mess, I just went into the
.git/logs/refs/stash and deleted line of the offending stash entry)

I think a more user-friendly behavior is to either prevent the user
from making the mess, or not prevent the user from cleaning it up.
Doing both seems a tad overzealous. Hard for me to say which is
better. For example, it's not immediately clear, to me, why git stash
drop cares about the validity of stash entries to be dropped. But
maybe there are edge cases where it's good to be defensive here.
