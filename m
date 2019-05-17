Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987821F461
	for <e@80x24.org>; Fri, 17 May 2019 07:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfEQHqk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 17 May 2019 03:46:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56241 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfEQHqk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 03:46:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so5910735wmb.5
        for <git@vger.kernel.org>; Fri, 17 May 2019 00:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RLRgi5b2/8mwsRl3f1roP5caE214vrmDOeX9iPbOc6k=;
        b=ntYrLHjJn3Uhs+iuW9zST2ELlPSH0niPNuPWI1XUWGjd6ibHNpZt0ji7lO6Tuu1M6F
         ROZ+5lBWNMpI6fRmhoaryTggRYFDSMLuUFnKSmTF4q+KtJuYLOs/l9A/loVZV8ZECJdr
         Ni2aL+UzXGFuXJHEhb6ufTnMYvqKzhW4ff7DGAjKbNy/MVUaj1XVK3zbWriZYJJKan5H
         o9s1kLZdaXGDLon7Uv/xPfx0Wvf12ZCHvgje+nLsa+IQy89f9JSXqzrGPfTRwLeKg48X
         KlV4YxG2KqmHaESenVjALZxKGi1K4/pT+V6+hcqA+V2enn26kCZS1kXpYcXbJHj1f1j+
         N62g==
X-Gm-Message-State: APjAAAWwuyfyKfgI9Imv8JNGWvSoBQeb8uvCBaE0h9dAIl4mIr5l82N5
        hsOVOdsqzQjFVUi5tLUX7lb8wzLB2ykHcex11Dc=
X-Google-Smtp-Source: APXvYqwdgmOwiR7K2k1qv20rGPsq7tx8bFNl+kDmJUsB38n9EdmD8RYU9KjB0JbYMVqw4r28FvjiNiYHJINuEsLwj+8=
X-Received: by 2002:a1c:6586:: with SMTP id z128mr1068253wmb.67.1558079198916;
 Fri, 17 May 2019 00:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
 <20190513104944.20367-1-pclouds@gmail.com>
In-Reply-To: <20190513104944.20367-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 May 2019 03:46:26 -0400
Message-ID: <CAPig+cRNDmHD7JrvJL8yvo0r_3HSNdVuF79uYt7fG4iaBpCeCQ@mail.gmail.com>
Subject: Re: [PATCH] worktree add: be tolerant of corrupt worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     shaheedhaque@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 6:50 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> find_worktree() can die() unexpectedly because it uses real_path()
> instead of the gentler version. When it's used in 'git worktree add' [1]
> and there's a bad worktree, this die() could prevent people from adding
> new worktrees.

This is good to know because, to fix [1], I think we'll want to add a
new function[2] akin to find_worktree(), but without magic suffix
matching (that is, just literal absolute path comparison).

[1]: https://public-inbox.org/git/0308570E-AAA3-43B8-A592-F4DA9760DBED@synopsys.com/
[2]: https://public-inbox.org/git/CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com/

> The "bad" condition to trigger this is when a parent of the worktree's
> location is deleted. Then real_path() will complain.
>
> Use the other version so that bad worktrees won't affect 'worktree
> add'. The bad ones will eventually be pruned, we just have to tolerate
> them for a bit.

The patch itself makes sense, though, as Shaheed noted in his
response, pruning seems to get short-circuited somehow under this
situation; perhaps that needs its own fix, but certainly shouldn't
hold up this fix.

> Reported-by: Shaheed Haque <shaheedhaque@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
