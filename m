Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF8BC48BE5
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 11:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79111613CD
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 11:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFKLNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 07:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhFKLNV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 07:13:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E7BC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 04:11:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i10so8009278lfj.2
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 04:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluescreen303.nl; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=xk3cVG0ylBYYmA7nRq9crATfF0c5uHCIeU/t2K27cZY=;
        b=aXhyL9a07MayJ0WMm1BF7VJSz86DO1xr5Q9hNxg/S5tC2hpVofJ6FOl7YhVX9S0O5N
         N9Oqj1GAbfCfAE/kK0BVpIXWWcosEgDI9qBBkqRzihHEk5xo5p5hx9Bbm1eA6ATnkx8C
         IL7mmob0x2ynEjww6NLF/Rbzqi2l8vI1WADzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xk3cVG0ylBYYmA7nRq9crATfF0c5uHCIeU/t2K27cZY=;
        b=JcyrvFbsqw2rEuqFSphD30XjqA5elWmCVY8qKKTeIGaVx5oD7KUDETYH/BxQJ6/6RV
         LSRGaQ6bW20b+rvfUX3ClQPyB9DzvXHKAbhfkjDtYFDQJ1CF5BcdEfyxm0pXy/eQWhVN
         K+85RWiP2hP1Rje/qek6rN60cLRoR19WrcOvF1dAevqykStlmB0T54qIO6kH3kn6lpSz
         BQf5WCV3di5wFj7CAbHNGzn+OSk9ll/8PLos7J3ZdepNtxMkcpcH6BfJBav2L901u4NY
         Vu9x6I+3UU39ZQ7SNuqcL8KSAhGkTRsd7Vb7Dm4u/HygIEWojnjknbaqDa0glfb6VHBD
         3iqg==
X-Gm-Message-State: AOAM533WhZdx/nlAWElEZTSp4+0N/RfGY8Tdz6az+qQmnnD9qmJGJp+D
        uftob27VZEDXdbh5GUw7Jex+sYGK+GM9H6fsdCCChEwpMOu6ERv1
X-Google-Smtp-Source: ABdhPJyl5+VZvAA9yuQH55Hty5jR+6OwbnF57NKw1WOGaR8mUXeMEdkCV1ToXa1hNyuQF1tqCiDJ0ez7xhABe2XAFTg=
X-Received: by 2002:a19:86c1:: with SMTP id i184mr2367128lfd.59.1623409870210;
 Fri, 11 Jun 2021 04:11:10 -0700 (PDT)
MIME-Version: 1.0
From:   Mathijs Kwik <mathijs@bluescreen303.nl>
Date:   Fri, 11 Jun 2021 13:10:58 +0200
Message-ID: <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com>
Subject: still using `git pack-redundant` - alternatives?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have some scripts for personal automation where I use git for
backups and file synchronisation between systems.

It uses some form of tiering where large files, older files, and files
no longer present in branch heads, move to slower networked storage
and get linked via the "alternates" mechanism.

Since repacks are too expensive most of the time, I use `git
pack-redundant --all --alt-odb` to clear out "local" packs which
contents have become available in an alternate.

So since pack-redundant is nominated for removal, I would like to know
if there are any alternatives for this type of book-keeping. Of course
I can use `git show-index` and `comm` to implement similar
functionality, but using built-in facilities is less error-prone and
more efficient most of the time.

Cheers,
Mathijs
