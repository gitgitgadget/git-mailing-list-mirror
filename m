Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E996E1F461
	for <e@80x24.org>; Thu, 16 May 2019 23:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfEPXRI (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 19:17:08 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45723 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXRH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 19:17:07 -0400
Received: by mail-wr1-f45.google.com with SMTP id b18so5065983wrq.12
        for <git@vger.kernel.org>; Thu, 16 May 2019 16:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C//vXymTHDBCR6y6FP1BtG46HtSj9RZmi0pdEZkkwVY=;
        b=U7oa3W4DiVnCzj884Tc5UZsABAkewGvFq01XAxEW6W3vVSh5wBNv5gipJyU1zjCabe
         U1YVY8Nc0ej2OAdPJaRtYzc0Po0/Cp7qJlZUF+hNmq41j7u+1h0SvRqJlGWpBdU89OWr
         1h+faxPaqv58QHx0myQOoFc4JluqaM2Zm7WahZiJdfAdqiS1SpBIX3RL92N8gx2HiEdg
         G0h/uf99LeU0msUMldyhm1N3A4sc5PAFOWzGl0f+6INl7DhtDgm1ut0VUv8OZlpqRqAM
         SSpJPRPITwgNihd427rGBjDXAACAda/u73LG4aflYNBvbU7z3sPknFnLGjdXWLWf9/Us
         le0Q==
X-Gm-Message-State: APjAAAU4PSnt/pqZW8hN+tlTqDJ9uVedwLgjfTDMa1NVbjwarDy1AzTE
        FWVkZ0gYgSVg3qE9rL6S6qwc7X0a788jiLh8gvg=
X-Google-Smtp-Source: APXvYqyxB/lwT0WUwDnDBF9A9UM/Sdc18QoUbgU8b5c6S4NBG6ehRnZJm3QbSrOziq/AGhk6gTMgl2swBpMdI2O0y2I=
X-Received: by 2002:adf:e902:: with SMTP id f2mr32685905wrm.301.1558048626138;
 Thu, 16 May 2019 16:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com> <20190516221702.GA11784@sigill.intra.peff.net>
In-Reply-To: <20190516221702.GA11784@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 May 2019 19:16:54 -0400
Message-ID: <CAPig+cQQ5svrDKRPenL2+bJHGjddUPnAXCFSsQN+WBHqzGpDow@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 6:17 PM Jeff King <peff@peff.net> wrote:
> On Thu, May 16, 2019 at 06:25:24PM +0700, Duy Nguyen wrote:
> > So you probably can still make it work by backing up $GIT_INDEX_FILE
> > (in case you need it), then unset it before you use "git worktree" (or
> > cd to it if you keep a permanent separate worktree for pre-commit
> > activities). [...]
>
> The case of actually _adding_ a new work tree (before we enter it) is
> weirder, though. We definitely want to stay in the same repository, and
> clearing all of that would not make sense. I do wonder if worktree-add
> should be handling GIT_INDEX_FILE (ignoring it when we want to be
> dealing with the index of the new worktree we added, and handling any
> relative fixups if we chdir inside the worktree code).

Ignoring GIT_INDEX_FILE was indeed the conclusion reached earlier in
this thread. Addressing your other point, "git worktree add" does
chdir() into the new worktree if a post-checkout hook exists since
that hook needs to run in the new worktree, not in the worktree in
which the "git worktree add" command itself was invoked. For the hook
invocation, it already sanitizes the environment of GIT_DIR and
GIT_WORK_TREE, and GIT_INDEX_FILE ought to be cleaned too. Is there
any existing code in Git for doing the relative fixups you mention for
other Git environment variables?
