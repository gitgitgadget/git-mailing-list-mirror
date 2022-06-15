Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86468C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 19:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbiFOTMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245194AbiFOTMe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 15:12:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907663C6
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 12:12:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g7so17576238eda.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=A/44l5Id/kyx7yvffuO/AmkYWcYBe9dIAvpj2RXygL0=;
        b=QJg3XxG5hKW8FjfBLVxjG/nP52IX6VsCcvE5hD4d4ryYRJZIiMAOcDwD5AZRCpiPa8
         LeTK8eAGTYjbD6SE8rQWzFq+WTY+R8/mpwF0i54mCVyipTVHMN73NJMYW/PfwSyqHALg
         GlvQgQ6/rs7JKZwFCYGAF5KMoSpIS5lpe+Jwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A/44l5Id/kyx7yvffuO/AmkYWcYBe9dIAvpj2RXygL0=;
        b=B8VE8KOCWw8K7xKQwFHlcaUbNEROtEOdg5mdRkfwICYaJbtsGdkfTWvMWPIfp4LH4/
         9tMO44kUOfmgcO5M2X4/2bBN1ZXWyawb7RcRr0AY6WrAi0iD7/0u1woPXElJGumilHXE
         8Dg/R6Zt/AF+oxh25NMyH61k6yt60VLbc/Po6ZY1dEfzdDd9FOKgUX5TShCagSHND+EU
         LCBkW6laA8H6Xp3wmVHhZWPlY1+N+lOIZcjf16yAxf+8BvjtBsBhm1ZwpyRKOaqEL+A5
         qUVYTvuIUtU4qGY0cJfZsVoyVmmdF0N2+Zw0UtTdaA4bSlbuJI4c5piI47yFbi6XvwW6
         HyAg==
X-Gm-Message-State: AJIora/NQBmuY3qn/CNhgGrypRn1xCOm/SaXZw9FVSY59ieMkufE7puD
        xFrAh5lVudyMZtQ5BStCcs5f/JQJbbgRemyDO2ILayyK5qQsIlfWYuk=
X-Google-Smtp-Source: AGRyM1vW+a0SiPXcK5Z3qWxlcALUOMyX5BSpc+32X6ic8j/XTVRTFtdRHnKmqzLQH+BRfBzGKLMA5Hh+Cfzn53EvFv0=
X-Received: by 2002:a05:6402:d0a:b0:425:d455:452 with SMTP id
 eb10-20020a0564020d0a00b00425d4550452mr1544369edb.259.1655320350316; Wed, 15
 Jun 2022 12:12:30 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 15 Jun 2022 21:12:18 +0200
Message-ID: <CAPMMpogUxq59zj+=7UDiURYbydAwvymOqhEWaheT9fkU8HaP4Q@mail.gmail.com>
Subject: Plumbing for mapping from a remote tracking ref to the remote ref?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Given the following configured fetch refspec for a remote:

[remote "origin"]
        url = git@someserver:somerepo.git
        fetch = +refs/heads/*:refs/remotes/somepath/*

And given a ref of the form "refs/remotes/somepath/branch_A",

I'm wondering whether there is any plumbing that would be able to tell
me what to put in a "fetch" command, to get
"refs/remotes/somepath/branch_A" fetched - in other words, is there
any plumbing that can use the configured fetch refspecs to map
"refs/remotes/somepath/branch_A" to "refs/heads/branch_A" for me, so
that I can then do "git fetch origin refs/heads/branch_A".

I understand I can parse the fetch refspecs myself, assuming any
asterisk is only ever on the tail end of the ref pattern... but that
seems very complicated, given that this is *probably* something others
have needed to do in the past?

Fwiw I've noticed that "git rev-parse --symbolic-full-name" knows how
to do almost exactly the *opposite* of that, when presented with the
"@{u}" pattern - it looks up the "branch.XXX.merge" value, which is
written in a remote-relative form ("refs/heads/branch_A" in this
example), and converts that to the "local" fetch destination (eg
"refs/remotes/somepath/branch_A"). But I don't know how to go the
opposite way, given only a local fetch destination and wanting to tell
fetch what to get - it expects a remote-relative ref.

Any help appreciated!

Thanks,
Tao
