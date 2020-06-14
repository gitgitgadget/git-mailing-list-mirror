Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE03C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 05:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCEB2068E
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 05:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgFNF4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 01:56:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40926 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgFNF4p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 01:56:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id r15so11673768wmh.5
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 22:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBvwyqgyQssC2QOy2xG6HrZxFix0dzBUzGsuO+70uwE=;
        b=XRZTMccQ20POXjdQkCpJdVw/AYwxtwYqQThzhnGJ0J9FKipSUTS1P5r9ZCjkOOvWTL
         Er+mEazH6NpLQn0tVljc/Qr4VZQfpbFRE5KPFp47wElmjEa/85MnMdfaGyGKlyVL2ah7
         J0PMDkDc3TZ95lqN8sql5yYpJH2hL8gBQmo4M5Yp3pnnS7lDAPIZPzcHqTa9JmzX4Zzo
         yqFmp1XvoPBZFIGpAvohMZdG9zxRX6p6UML4ipfGMlp1drBFFBwww2ogU2qJSzSB0+VR
         wL+HM8uSMru5dg6GJxESJ1aZa/QtaT4VJVjveRMbhWgPp1gjOAaEw8jtjFowqcgy+fVc
         6rnQ==
X-Gm-Message-State: AOAM5300RcSH3vM8VurM/K491eo7cEDOVzVLKuzn3KUAfwABW9QdiZ5A
        65988KJxWrhBlY/gej3gGyM9ogSZuFaylcIQUWFZotXniNE=
X-Google-Smtp-Source: ABdhPJw33X1n0fZpJ9NPo+KAkjYhPnt0zOWGuG9CqgtfRkTFbZtE5joG6Wg2hxRhRKliETH4s/+kz0ZwE6r036QoMt0=
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr6973218wme.107.1592114203605;
 Sat, 13 Jun 2020 22:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <202006130730.05D7UB99010559@dandelion.mymedia.su> <xmqqr1uizzwf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1uizzwf.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Jun 2020 01:56:32 -0400
Message-ID: <CAPig+cRLkv=gd58Qm2MiKz2H74s3O1zoQ4GZ_cBE7QkbBCqN4A@mail.gmail.com>
Subject: Re: [PATCH] worktree: treat "list" as default command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nicholas Guriev <guriev-ns@ya.ru>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 13, 2020 at 12:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> Nicholas Guriev <guriev-ns@ya.ru> writes:
> > Perceive simple "git worktree" without a subcommand as "git worktree list"
> > for consistency with "git submodule" that already can work in such a way.
>
> "git branch" works the same way, and probably "git remote", too?
>
> "git config" doesn't work that way, though. Should it default to
> the list mode (rhetorical/tongue-in-cheek question---but it gives a
> hint for writing the justification to decide where to draw the line).

My knee-jerk reaction to this patch is not to accept such a change,
though I can't fully articulate why I feel this way.

One concrete reason I'm not enthused about this change is, as Junio
notes, there is no consensus even among Git commands, as to what
action should be taken when not specified explicitly. Although bare
"git branch" is interpreted as "git branch list", bare "git stash" is
_not_ interpreted as "git stash list", but instead as "git stash
push". It's possible to imagine someone familiar with "git stash"
coming along and expecting bare "git worktree" to mean "git worktree
add".

I also have a vague recollection from past mailing list discussions
that people eventually consider it flawed UI design for a command to
perform some default action when none is requested explicitly. Bare
"git stash" is one such example which comes to mind as being
considered poor UI design. (It's possible that this recollection is
incorrect; I haven't bothered trying to dig up any past discussions.)

Finally, not having a default action for bare "git worktree" was a
deliberate design decision, probably (at least in part) motivated by
the above considerations. So, I'm hesitant about accepting such a
change without stronger justification.

The patch itself looks reasonable -- based upon a superficial scan --
although I'd probably combine the two new tests (though that's
subjective). To be accepted, however (assuming people are convinced it
is a worthwhile change), it would almost certainly need to include an
update to Documentation/git-worktree.txt.
