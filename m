Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6869D211B5
	for <e@80x24.org>; Tue, 12 Feb 2019 22:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfBLWoz (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:44:55 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:33743 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfBLWoy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:44:54 -0500
Received: by mail-qk1-f181.google.com with SMTP id x9so252982qkf.0
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pncE8dXXADpGm/+Bzh6Kyj2PF/pzFMXoDTzw4SOLlL8=;
        b=T+/ZfC3FwMlQpn2whowHLmobt5b/yfLwjiDuLvNh06YRiMeOK4BmkRPO+wqkJWtOt5
         SZPBv5pGBH0b3Lj449PPkVMD+kvnuC/aulCnHTCna1ht4Ufxk0DLVI6b+KGyxJ92mTTD
         40tjB6+KIMe0qOF/0u+u3UQeRJYKR4V5O3e8DreN7O0s6oO3hiktrCdWx1z/2+Z9ogm9
         h0M36fWqx5y7V0KDwYIyVOG85g2mLdYcbJxOzQZAtWCcIy3TAHUIYWSGEE51ebAd10wM
         0bpJhRYbJbJkfYS9rzivQ2KAFqEGMdTKbIuZ4FyA+/ODe/p4Cah/3YDIG78aM6dLUBLU
         gm4g==
X-Gm-Message-State: AHQUAuZqvCUy4f9Wsk5lMBwpD9TiiPV77CvAxeTrD8NZA0d6c0RShGtT
        awNVyqeTA4iYEVBFy+treXeZ1xsXw01vkHUCGdoDPERi
X-Google-Smtp-Source: AHgI3IbQyI8nA+XGkR03QbBTnxBq7SXiXuP4PFwH0Hqs09mn+ZS6e43sRAwWfLvWI0WW31ulQ6AI1PAN6X0WYKDTuHs=
X-Received: by 2002:a37:c313:: with SMTP id a19mr4254832qkj.220.1550011493557;
 Tue, 12 Feb 2019 14:44:53 -0800 (PST)
MIME-Version: 1.0
References: <0308570E-AAA3-43B8-A592-F4DA9760DBED@synopsys.com>
In-Reply-To: <0308570E-AAA3-43B8-A592-F4DA9760DBED@synopsys.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Feb 2019 17:44:41 -0500
Message-ID: <CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com>
Subject: Re: BUG: git worktree add directory-path fails due to over-aggressive
 disallowing of worktrees with same suffix
To:     Cameron Gunnin <cameron.gunnin@synopsys.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 6:50 PM Cameron Gunnin
<cameron.gunnin@synopsys.com> wrote:
> The bug:
>   cd unique-path-1
>   git --git-dir=../worktree-test-repo/.git worktree add subdir branch1
>   cd ../unique-path-2
>   git --git-dir=../worktree-test-repo/.git worktree add subdir branch2
>   # FAILS WITH: fatal: 'subdir' is a missing but already registered worktree; use 'add -f' to override, or 'prune' or 'remove' to clear
>
> This appears to have been introduced by the following commit:
>       worktree: disallow adding same path multiple times
>
> The fix, I think, should be applied to builtin/worktree.c to the
> validate_worktree_add method. After finding a worktree that matches
> the suffix (via find_worktree), it should check that the absolute
> path of the found worktree is the same as the absolute path of the
> worktree being added, and allow the add when they are different. Or,
> perhaps there should be a way to invoke 'find_worktree' such that it
> only finds absolute path matches.

When crafting cb56f55c16 (worktree: disallow adding same path multiple
times, 2018-08-28), I flip-flopped between two implementations: (1)
using find_worktree(), and (2) manually scanning the worktree list
with absolute path comparison. The latter approach, would not have
suffered from this problem. The one ugly bit of the manual scan was
that it was a bit too cozy with the underlying worktree
implementation, so I eventually went with the find_worktree() approach
despite its obvious drawback of doing suffix matching (though, I
didn't feel particularly comfortable with the decision).

A likely reasonable approach to fixing it would probably be to
introduce new worktree API to find a worktree without magic suffix
matching (i.e. literal absolute path matching) which would avoid
having to imbue the higher-level "git worktree" command with that
low-level knowledge, and then take advantage of that new API.
