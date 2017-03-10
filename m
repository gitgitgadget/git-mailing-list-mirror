Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE331FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 21:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934111AbdCJVpC (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 16:45:02 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36657 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934083AbdCJVow (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 16:44:52 -0500
Received: by mail-qk0-f170.google.com with SMTP id 1so187671614qkl.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WbJbMNgeZGZGE4nF6adV51DwW9+ndml9CkEOVcoIuPU=;
        b=VEF6c6yu3OiUAfGWgrY+Atp9GbkpB32olNjjsFQRHMu08vIFk9p1vo3jwJnkNpObRy
         /d9br6QpJy5AW3ok3RbmWWqU6s37OOCSJ1Mvc40Ookyvkr0lL0EcWvzzP9IOwO0WHJ9V
         zXf/ExtkGHyrm9GRyBbhJnED9eoRmSozkSEVeDvisbvm065X7wSZ3wZufsez//eLr0xO
         8L02ckN7E1HBoWYPgc9obWEyMwvyN+oGWcAp/cQQySrwvItpNER8+kBsKc2ADyCKIVjX
         cNGto/+9wyp8FfABjPmp0fcYHOaBI2XQ+6K1dPcZrro/p54r5ohyLmXrXbLb3mdfd/up
         xR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WbJbMNgeZGZGE4nF6adV51DwW9+ndml9CkEOVcoIuPU=;
        b=DrDlgWcIonpXtBwyeolOr+I1+nMYxWlNuSPcVK6//eWtN/E447Tckc/lZ29AshNkw/
         D9cfraj/jRHEES47gBMMIHtKuOjlUhT/2kzgHdP6Vfy0r8Z9mx80yA7gT1sS1qZVPhUT
         MwOqkjlfYnMNwPqEkyxCM/wrZfuzpzSkPCHgOnVmGy378+FQp4ab73XroZJRW8lOPL/9
         g58nMb9JSKwgwzYKSZ/WBdYXyosBkE1p/rlTwrKHcF02lj2RQSK9hLjt0J0hCsnxU7rq
         uxJnAPXNxOpL1BAoxkjTMWnVxYcjXvU3rpBhDc4zMVmYdGhLL1oSTRIlZZaZvGFtINAY
         hw6A==
X-Gm-Message-State: AMke39kPbaaf4Fxf6s0p0OURE9HZUae8Lk62ARnnlBbITPSaFF1rGVx+Rs2RVeqs3vv7Yl3a77YZlvJYAOLs7Q==
X-Received: by 10.237.41.229 with SMTP id o92mr21299672qtd.223.1489182290753;
 Fri, 10 Mar 2017 13:44:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.177.137 with HTTP; Fri, 10 Mar 2017 13:44:30 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 10 Mar 2017 13:44:30 -0800
Message-ID: <CABURp0pf=4BE=E7qeOmYAcqJb=qDeGJ1EFyfCf+hDtKjjMD=ng@mail.gmail.com>
Subject: git-push branch confusion caused by user mistake
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This week a user accidentally did this:

    $ git push origin origin/master
    Total 0 (delta 0), reused 0 (delta 0)
    To parent.git
     * [new branch]      origin/master -> origin/master

He saw his mistake when the "new branch" message appeared, but he was
confused about how to fix it and worried he broke something.

It seems reasonable that git expanded the original args into this one:

    git push origin refs/remotes/origin/master

However, since the dest ref was not provided, it was assumed to be the
same as the source ref, so it worked as if he typed this:

    git push origin refs/remotes/origin/master:refs/remotes/origin/master

Indeed, git ls-remote origin shows the result:

    $ git ls-remote origin
    d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e HEAD
    d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
    d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/remotes/origin/master

Also, I verified that this (otherwise valid) command has similar
unexpected results:
    $ git remote add other foo.git && git fetch other && git push
origin other/topic
    $ git ls-remote origin
    d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e HEAD
    d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/heads/master
    d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/remotes/origin/master
    d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e refs/remotes/other/topic

I think git should be smarter about deducing the dest ref from the
source ref if the source ref is in refs/remotes, but I'm not sure how
far to take it.  It feels like we should translate refspecs something
like this for push:

    origin/master
        => refs/remotes/origin/master:refs/heads/master

    refs/remotes/origin/master
         => refs/remotes/origin/master:refs/heads/master

    origin/master:origin/master
         => refs/remotes/origin/master:refs/heads/origin/master

    master:refs/remotes/origin/master
         => refs/heads/master:refs/remotes/origin/master

That is, we should not infer a remote refspec of "refs/remotes/*"; we
should only get there if "refs/remotes" was given explicitly by the
user.

Does this seem reasonable?  I can try to work up a patch if so.
