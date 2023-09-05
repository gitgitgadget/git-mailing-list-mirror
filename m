Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A49CA0FFE
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjIEQAh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 5 Sep 2023 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbjIEAjH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 20:39:07 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA035BF
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 17:39:03 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6556d05a55fso8797406d6.3
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 17:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693874343; x=1694479143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVkPl5NE2W7NVhfW7YB/ku5ImMx7lrWoBZQeQc3gi3E=;
        b=HEzA5ofLYGNfjYrWGWybIrH2paptDDUvU743VhUvg/3UM5ZsWabU/bdHphgx5qvxn+
         AEwpi1GvJdEGdo/Fs7L7vGKJ6Zr1uBJRzC9rzmvrF6C6/P8cptXAnDkumD8U8+Frsb+4
         wECp8Z6v+nHMfsEoPIw1ae04BEaSGJNI3Z/Z8DB4RZntcNYgIvmBseU3Hh4y0zVhY+FZ
         xQjWbv10So+SZqFywGxvYl8TnlNQlLOrfKTQLLb//oG0WD5pmSJNlULLdf9z/pucQp83
         Se51/PB8Zq1AXP/CocdxAZOaK3a0DKqL5TSEuNF146Tk0orZ5w20nj3lS5g/UmZ8R+6t
         Envg==
X-Gm-Message-State: AOJu0YysbM0H02chj7ebwWg0ee0fcEGwyKxIyyOomRDv+Xhr9i/wJIMk
        K+mgz3ATIBTP7EQCK7scJxXFqIM10968HQ2z4Wc=
X-Google-Smtp-Source: AGHT+IH/L56n91WHKm0qIDBUdtHWmwSeYH1mwLcIm4QWJU/FSIOrHUwZJFUc0HORs5EuXesedQyI2qIiKpueg0h8IJ4=
X-Received: by 2002:ad4:4088:0:b0:64f:452e:a78d with SMTP id
 l8-20020ad44088000000b0064f452ea78dmr10285065qvp.44.1693874342956; Mon, 04
 Sep 2023 17:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
In-Reply-To: <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Sep 2023 20:38:52 -0400
Message-ID: <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Tao Klerks <tao@klerks.biz>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 4, 2023 at 1:57 PM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
> On Mon, Sep 4, 2023, at 16:41, Tao Klerks wrote:
> > Because worktree use was so useful/widespread/critical on this project,
> > and we already had a custom cloning process that introduced selective
> > refspecs etc, we introduced a special clone topology: the initial clone
> > is a bare repo, and that folder gets a specific clear name (ending in
> > .git). Then we create worktrees attached to that bare repo.
>
> This is interesting as a Git user. I've been encountering questions on
> StackOverflow where the questioner is using a bare repository which they
> make (or try to make) worktrees from. I've been telling them that making
> worktrees from a bare repository is a contradiction:[1]

Not at all. The combination of bare repository and multiple-worktrees
is legitimate and supported intentionally. (There are tests in the Git
test suite validating support of this feature.) For people who
regularly work with multiple worktrees, it is quite natural to have
all the worktrees hanging off a bare repository, each with equal
importance, rather than having a single "blessed" worktree which has
priority over all others.

> > Bare repositories don’t have worktrees per definition. Or at least
> > that’s what `man gitglossary says`. Of course what `git worktree` allows
> > you to do trumps that. But it might be ill-defined.
>
> The glossary says under “worktree” (on Git 2.42):
>
> > A repository can have zero (i.e. bare repository) or one or more
> > worktrees attached to it.

Speaking as a person involved in the implementation of worktrees,
including support for them in combination with bare repositories, my
reading of this is perhaps biased so that I understand its intent.
However, if I squint hard, I suppose I can see how you could read it
as meaning that a bare repository can't have any worktrees associated
with it. So, perhaps, the documentation could use a bit of touch up.
