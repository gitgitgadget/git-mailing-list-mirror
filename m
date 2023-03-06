Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69879C678D4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 08:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCFII7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 03:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCFII6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 03:08:58 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772609EC9
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 00:08:52 -0800 (PST)
Received: (qmail 4997 invoked by uid 109); 6 Mar 2023 08:08:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Mar 2023 08:08:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27477 invoked by uid 111); 6 Mar 2023 08:08:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Mar 2023 03:08:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Mar 2023 03:08:50 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Tennant <sdt@sebyte.me>
Cc:     git@vger.kernel.org
Subject: Re: How to mirror and augment a git repository
Message-ID: <ZAWfkkmrPUqNmrtu@coredump.intra.peff.net>
References: <87ilfgemkb.fsf@sebyte.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ilfgemkb.fsf@sebyte.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2023 at 12:19:16PM +0000, Sebastian Tennant wrote:

>  Augmented mirror:
> 
>    $ git clone --mirror <upstream> upstream
>    $ cd upstream
>    $ git remote update  # regular cron job

The problem here is that your refspec for "origin" in the mirror will be
"+refs/*:refs/*". So it claims to have responsibility for the whole refs
namespace. And because of the "+", it will happily overwrite local refs
when fetching, including branches pushed up by the client. You noticed
it most with "prune", because that deletes local branches not present in
upstream repo. But a similar problem would happen if both a client and
the upstream had a branch named "foo".

> I've tried running the augmented mirror as a plain bare repo, i.e.
> 
>    $ git config --unset remote.origin.fetch
>    $ git config --unset remote.origin.mirror
> 
> but then the cron job (git remote update) is no longer sufficient in
> making all upstream activity available downstream.

Right. If you drop the fetch refspec entirely, then it will only fetch
HEAD during your cron jobs, which is not what you want. You want a
refspec that tells Git to fetch everything, but you need to divide up
the "refs/" namespace into local stuff and mirrored stuff.

You could use the normal "+refs/heads/*:refs/remotes/origin/*" refspec,
but it's awkward for the clients to access "refs/remotes/" on the
mirror.

So you probably want to keep the upstream branches in "refs/heads/", but
mark a special part of the namespace. Like:

  cd augmented-mirror
  git config remote.origin.fetch '+refs/heads/*:refs/heads/upstream/*'

And then "git fetch" will pull all of the remote branches into the
"upstream/" namespace. And it's safe to prune, because it will only
delete branches in refs/heads/upstream/ (and you may want to just "git
fetch --prune" as you fetch via cron, which is a little more efficient
than a separate "git remote prune").

Clients can name their branches whatever they like, as long as they
don't start with "upstream/", and that won't interfere with the mirror.

-Peff
