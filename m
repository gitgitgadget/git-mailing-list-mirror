Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8358FC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 05:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjAIFDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 00:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjAIFDu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 00:03:50 -0500
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2AA9FCE
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 21:03:48 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id d3so8289675plr.10
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 21:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iZbABQlbCmZjqZBMHKx7B8oQPatUGoQKbffVI8FU9Q=;
        b=ehgAFM0TChi9nxa3iIQusBfkV9Kd6pUKVGd24aO2nOYyW+z9qXXW/4vpK9HQ4+f7gh
         q+Qhd6sVucOEFMP8J+Kq3zH8ExmBXCr2/9Jz4va8iwCyLzU/9CGjWJOBYjksccIPfQK1
         iAGx9iKuWmnBiwfg9Zbe+M1FS8F3RE72K7mxFknCLEaQNVIieWqUW5xtCh1iu3vmdYWI
         4+IR3Jxhh3d3H21nTo0oYCd6fmsbBhjD+toxk2W0EHdWdpjXnawqD0flSABtP9QYAzvM
         hkYI89XEoR6oC1XuKdx79+UjQBOLN9gYLfj4ZWIwAslCEZ+Q09bbvA1GZCWD1g7Z2Bwv
         xXeQ==
X-Gm-Message-State: AFqh2koVoZcfjqQ4o7hjgBo6irEGohMJ6DhY5F75fxaU76HbLxmvx9sn
        70Y3Dnnt1Tsqo/fu8MEhB4tK2sUnni7jUXa4Xjc=
X-Google-Smtp-Source: AMrXdXsAh/u7bv8h7rH4715kxE27rXWTMjoF/l+LX6wxtl50QcLjzvjQDg+ZlaWFQ0ZR1TvZ7SwLpYupUsXANbvjKOk=
X-Received: by 2002:a17:90b:48cf:b0:226:164f:522e with SMTP id
 li15-20020a17090b48cf00b00226164f522emr2940945pjb.22.1673240627968; Sun, 08
 Jan 2023 21:03:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com> <xmqqwn5wuwvs.fsf@gitster.g>
In-Reply-To: <xmqqwn5wuwvs.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jan 2023 00:03:37 -0500
Message-ID: <CAPig+cRMdJy9FdL1_rwuMKcA3F3p4g3RF+0mkh12pqN0aUoUiw@mail.gmail.com>
Subject: Re: [PATCH] githooks: discuss Git operations in foreign repositories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Preston Tunnell Wilson <prestontunnellwilson@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2023 at 11:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +If your hook needs to invoke Git commands in a foreign repository or in a
> > +different working tree of the same repository, then it should clear local Git
> > +environment variables, such as `GIT_DIR`, `GIT_WORK_TREE`, etc., which could
> > +interfere with Git operations in the foreign repository since those variables
> > +will be referencing the local repository and working tree. For example:
> > +
> > +------------
> > +local_desc=$(git describe)
> > +foreign_desc=$(unset $(git rev-parse --local-env-vars); git -C ../foreign-repo describe)
> > +------------
>
> It is an excellent idea to add the above, but
>
>  * I think adding it one paragraph earlier may make it fit better.

That was my initial choice, as well, and is where I initially inserted
it, but moved it down a paragraph at the last moment. I'm happy to
move it back up again.

>  * The paragraph, after which the above gets inserted, can use a bit
>    of enhancement.
>
> That is, something like this?
>
>  repository. An exception are hooks triggered during a push ('pre-receive',
>  'update', 'post-receive', 'post-update', 'push-to-checkout') which are always
> -executed in $GIT_DIR.
> +executed in $GIT_DIR.  Environment variables like GIT_DIR and GIT_WORK_TREE
> +are exported so that the hook can easily learn which repository it is
> +working with.

Yes, good idea, although I might phrase it something like:

    Environment variables such as ... are exported so that Git
    commands run by the hook can correctly locate the repository.
