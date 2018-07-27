Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120B31F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbeG0QJw (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 12:09:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42014 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbeG0QJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 12:09:51 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so2407671plo.9
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NSBp6lBGASjn90YWX1IzxlrFnP/omTbE4W/TjYjO5E=;
        b=fh8QdQXpsl4OCtVQ/INdD7nl7Ptfq0qSbM+9q6Iw/cw6kn4esDR7ZrKN/w57jeMWbH
         Ja/mKr9xTkTs8OsBX359s/lrYvKhU46H1m8qrP6Uj/v7Y/NYZmJzDXpqUKIHGO6QngoV
         Xj8ZpBkQqEAIla5pYz6/xKshDNc9pt0sE0FufO579nI7Yc7R/KvPe4trv+eiH5JRJWVe
         cBHcgI7/o29DiJEcB2RA0j9d4G7cpvLKMZKZjl99UGj96XVcgqwD4wtR+3vOzQme6xbS
         9y1J84TR5Ek7eCYt6htuxyABFR6mhFY0CW4ri2Z47AE0BTvv9/Yet+Vq6cEnDOIo5ekY
         qCSA==
X-Gm-Message-State: AOUpUlGAopCc1Q8kA0HtELi6cI8DAzQOIZHZh2s7TS0jl/mRhfmBWYwy
        2uumkN9ErE8+IgIFR+4zZasIKs0RnOJQxZAOTiQ=
X-Google-Smtp-Source: AAOMgpfKVT+8N2Enc6ig81/d7uEuDvQoCYCfOjSy5FHrxbwW/b7GBljRzQj3JLUU4fcyGONLNKJNF12VeCHnv2VKmCU=
X-Received: by 2002:a17:902:b785:: with SMTP id e5-v6mr6305181pls.339.1532702856676;
 Fri, 27 Jul 2018 07:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180726121346.GT1934745@devbig577.frc2.facebook.com>
 <20180726143930.GW1934745@devbig577.frc2.facebook.com> <xmqqa7qerpxu.fsf@gitster-ct.c.googlers.com>
 <20180726153714.GX1934745@devbig577.frc2.facebook.com> <xmqqr2jpq0s1.fsf@gitster-ct.c.googlers.com>
 <20180727084039.GB11932@sigill.intra.peff.net>
In-Reply-To: <20180727084039.GB11932@sigill.intra.peff.net>
From:   Tejun Heo <tj@kernel.org>
Date:   Fri, 27 Jul 2018 10:47:25 -0400
Message-ID: <CAOS58YNjyLLDLpoDDB=oAKn3P_FLLD2WZrygBy6J+TV=E480NQ@mail.gmail.com>
Subject: Re: [PATCH v2] name_rev: add support for --cherry-picks
To:     peff@peff.net
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Jeff.

On Fri, Jul 27, 2018 at 4:47 AM Jeff King <peff@peff.net> wrote:
>  - the set of names might be distinct from the set of commits you'd want
>    to traverse.  For instance, you might want to use "name-rev --tags",
>    but find cherry-picks even on untagged branches (e.g., "--all").

Hmm... maybe but when I'm using --tags, I'm usually asking "when did
this get released?" and --cherry-picks seems to logically extend that
and fits such scenarios pretty well. ie. "Give me the release name and
all the aliases for this commit". We can play with the options to
support combinations of tagged/untagged but I'm not quite sure about
the usefulness. After all, calling the program twice isn't all that
difficult.

>  - instead of naming commits, you might want to see the information as
>    you are viewing git-log output ("by the way, this was cherry-picked
>    elsewhere, too")

name-rev --stdin sort of does this for commit names. I thought about
adding the support for --cherry-picks too but wasn't sure how to weave
in the result, but if we can figure that out this should work, right?

> So I kind of wonder if it would be more useful to have a command which
> incrementally updates a git-notes tree to hold the mapping, and then
> learn to consult it in various places. "git log --notes=reverse-cherry"
> would show it, though it might be worth teaching the notes-display code
> that certain types of notes contain object ids (so it would be
> interesting to recursively show their notes, or format them nicely,
> etc).
>
> I dunno. That is perhaps over-engineering. But it feels like
> "reverse-map the cherry-picks" is orthogonal to the idea of name-rev.

Hmm... to me, it makes logical sense because "name this commit" and
"also include aliases" seem to be a natural combination both in
semantics and use cases, but if there are better ways of tracking down
cherry-picks, I'm all ears.

Thanks.

-- 
tejun
