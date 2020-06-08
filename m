Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9719EC433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699282076A
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgFHGmU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 8 Jun 2020 02:42:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39663 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgFHGmT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:42:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id t18so16077003wru.6
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n6sGHbArcdtvkqnag4jnC8w6L2gcyjbcuWf8BRE9ikU=;
        b=E97Pwosjd8wqaT9dixEW7pijpHPDJRJNJSLM0qInUBV5rr+d9z4TUnJbUh0q/+nsot
         H/tXR7cCRxZmt+dObj1P4fWs5m3TW9tpBJYcpdMHD5Vbwee8U/h1JKPZiShWpC2Jkudd
         biEa4fX6oYBdbUBi+ZLb+wcD+uzFA8pqvUfuoWIF/uUfyRGZenAACKnvzPY+eJg2rdFJ
         aQ/2etk0bwvu3ZxCFDJ68kz6zgNJsHMUhC9H6mGeSZ6hRlewoc/V5TUXLz3iqqAcBfmI
         /g0i7ZfZxGtsRohJbyypubRq2YXRs8L0tT+kBtyRDkwBV8LI/on5tUX9VKtr6oOsC8/J
         NQ2A==
X-Gm-Message-State: AOAM533/dd53czb51n8Y8elu33+BS7WmWnqMz+aP2Pkx7l7J0zDcoQve
        OHIiRHt73eQocZXU900+RYhZHbUT4MkTsK4NnoqdEBNKylY=
X-Google-Smtp-Source: ABdhPJxudK2SYHwWIpWXADQegcDIJqNwZcgIHWTFxsbYoioUCiqMbecL2kaC2S0vU2mWCqbRtHy1rk4YIxRpT3eP8vU=
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr23237915wrw.277.1591598536764;
 Sun, 07 Jun 2020 23:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <89526b3a-297d-591d-6e12-48580d697ed5@gmail.com>
 <CAPig+cTU8+N6Chimpoa2_T-TcXxw-3B9-9pjCLz7WeOh472P_A@mail.gmail.com> <dd7c3a11-6537-74ec-053c-0c9c946c5f19@gmail.com>
In-Reply-To: <dd7c3a11-6537-74ec-053c-0c9c946c5f19@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 Jun 2020 02:42:05 -0400
Message-ID: <CAPig+cTpcgunPNKrzfqKYRb3gVhYff7UiBza-xaTH9GqH_Y+gA@mail.gmail.com>
Subject: Re: Bug: git worktree remove and overwritten directory
To:     =?UTF-8?Q?Jonathan_M=C3=BCller?= <jonathanmueller.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 10:28 AM Jonathan Müller
<jonathanmueller.dev@gmail.com> wrote:
> On 20.05.20 16:22, Eric Sunshine wrote:
> > Git tries hard to prevent the same directory from being registered to
> > multiple worktrees, however, there is not much it can do to prevent a
> > person from shooting himself in the foot by making changes like this
> > outside of Git's control. Thus, this seems like a case of "if it
> > hurts, don't do it".
>
> I agree and didn't expect git to "work".

I just posted a patch series[1] which enhances "git worktree prune" to
detect and deal with multiple worktree entries referencing the same
path.

> > However, "git worktree" could possibly do a better job of helping you
> > recover from such a situation. In particular, I think it should be
> > reasonably easy to enhance "git worktree prune" to detect this
> > situation and automatically prune the non-main now-bogus worktree
> > entry.
>
> At the very least, the somewhat confusing error message could be
> replaced by a "you messed up the worktrees, please delete the
> corresponding entry in .git/worktree" or something like that. But
> enhancing `git worktree prune` would be better. It was, in fact, the
> first command I ran to try and fix the problem.
>
> As said above, I think git worktree remove could issue a better error if
> it detects multiple worktrees with an identical path.

Hmm, the message it printed complaining that you tried removing the
main worktree seems pretty accurate since that extra worktree entry
was indeed pointing at the main worktree. I suppose it would be
possible to have "git worktree remove" also perform "corruption
detection" so as to present additional information which might clarify
the complaint. Of course, if that is done, then it would make sense to
make all "git worktree" commands likewise report corruption. However,
I haven't convinced myself that we need to go that far. Anyhow, the
posted patch series[1] addresses the immediate problem.

[1]: https://lore.kernel.org/git/20200608062356.40264-1-sunshine@sunshineco.com/T/
