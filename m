Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id C8A9A7D910
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 16:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgCKQZS (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 12:25:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:36386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726314AbgCKQZS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 12:25:18 -0400
Received: (qmail 2096 invoked by uid 109); 11 Mar 2020 16:25:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Mar 2020 16:25:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20277 invoked by uid 111); 11 Mar 2020 16:34:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2020 12:34:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Mar 2020 12:25:17 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Using push.default with push.remote.push
Message-ID: <20200311162517.GA27893@coredump.intra.peff.net>
References: <CAHd499BhLe0xF_k2ASV=ZuM7LVvxui_cxzB9UrJ2MDCyyNUmtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499BhLe0xF_k2ASV=ZuM7LVvxui_cxzB9UrJ2MDCyyNUmtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/20200311162517.GA27893@coredump.intra.peff.net/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

On Wed, Mar 11, 2020 at 10:41:36AM -0500, Robert Dailey wrote:

> With the specified configuration:
> 
> ```
> [push]
>     default = current
> [remote "origin"]
>     url = git@mydomain:myrepo
>     fetch = +refs/heads/dev/john/*:refs/remotes/origin/*
>     fetch = +refs/heads/*:refs/remotes/origin/*
>     push = refs/heads/master:refs/heads/master
>     push = refs/heads/*:refs/heads/dev/john/*
> ```
> 
> Given a currently checked out local branch named `my-feature`, how can
> I make this command:
> 
>     git push -n origin
> 
> Behave semantically identical to this command?
> 
>     git push -n origin my-feature

I don't know of a way. If we had branch.*.pushRef (and not just
pushRemote), it would presumably do what you want.

This came up recently in:

  https://lore.kernel.org/git/20200127231459.GD19360@coredump.intra.peff.net/

as well.

> The current behavior seems to be working as designed, but not as
> desired. The first push command pushes *all* branches under
> `refs/heads/*`, instead of just the current branch as it normally
> would via `push.default` setting. It sort of feels like if a resolved,
> explicitly defined `push.<remote>.push` config is found *and* it
> includes wildcards, the `push.default` setting should still be
> respected.

Then when would remote.*.push with a wildcard ever do anything?

> Note my ultimate goal here is to transparently map local branches to a
> branch with a prefix on the remote. But I do not want to explicitly
> work with or see those prefixes locally. Basically
> `dev/john/my-feature` on the remote should be `refs/heads/my-feature`
> locally, and `refs/remotes/origin/my-feature` for fetches. The
> push-without-explicit-refspec case is the only one I haven't gotten to
> work as desired yet.

I think this is similar to what was desired in the thread I linked
above.

-Peff
