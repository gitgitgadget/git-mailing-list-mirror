Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D2C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 10:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5DD61351
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 10:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhKEKEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 06:04:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49694 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232890AbhKEKEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 06:04:34 -0400
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A5A1eJo012800
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 5 Nov 2021 06:01:41 -0400
Message-ID: <991240f7-2a3e-8ae7-ae25-a1d9d96d55d4@mit.edu>
Date:   Fri, 5 Nov 2021 03:01:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] fetch: Protect branches checked out in all worktrees
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
References: <9dfca5ec-4426-d3d4-988e-b81ebb087584@mit.edu>
 <alpine.DEB.2.21.999.2111041709080.94135@tardis-on-the-dome.mit.edu>
 <YYTtdZblnHYgDgBq@coredump.intra.peff.net>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <YYTtdZblnHYgDgBq@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/5/21 01:38, Jeff King wrote:
> If we get the non-default worktree here, it might be nice to tell the
> user which worktree has it checked out. Otherwise it may lead to
> head-scratching as they peek at their current HEAD.

I’d agree if this case were reachable, but as per below, it seems not to 
be. So I didn’t bother figuring out how to shoehorn such a message into 
the arguments expected by format_display().

> I also notice that find_shared_symref() will catch cases where we're on
> a detached HEAD, but it's because we're rebasing or bisecting on a given
> branch. Arguably that's a sensible thing to do for this check, but it is
> a change from the current behavior (even if you are not using worktrees
> at all).

That’s a good observation. I agree it seems sensible, but should be 
noted in the commit message.

> So if the earlier hunk covered this case, then what is this hunk for? :)

Yeah, that duplication confused me too. The relevant call paths seem to be:

1. do_fetch calls check_not_current_branch (later hunk);
2. do_fetch calls fetch_and_consume_refs → store_updated_refs → 
update_local_ref (earlier hunk);
3. do_fetch calls backfill_tags → fetch_and_consume_refs → 
store_updated_refs → update_local_ref (earlier hunk);

in that order. That suggests there should be no way to trip the earlier 
hunk’s check without first tripping the latter hunk’s check.

>    $ git fetch . main:main
>    fatal: Refusing to fetch into branch 'refs/heads/main' checked out at '/home/peff/tmp'
> 
> It's technically correct, but perhaps it would be nicer to keep the old
> message if the worktree we found is the current one.

I note that this new message is more consistent with

$ git branch -d main
error: Cannot delete branch 'main' checked out at '/home/anders/tmp'


While looking for other related messages, I noticed another bug: 
receive-pack doesn’t stop you from updating or deleting a branch checked 
out in a worktree for a bare repository.

$ git init
$ git commit --allow-empty -qm foo
$ git clone --bare . bare.git
$ git -C bare.git worktree add wt
$ git -C bare.git/wt push .. :wt

To ..

  - [deleted]         wt


This is_bare_repository() check in update() in builtin/receive-pack.c 
seems wrong:

const struct worktree *worktree = is_bare_repository() ? NULL : 
find_shared_symref("HEAD", name);


Anders
