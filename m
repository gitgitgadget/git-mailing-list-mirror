Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F85C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A391E6108C
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhKHUPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:15:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38753 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238484AbhKHUPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:15:16 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A8KCHSA002094
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 8 Nov 2021 15:12:19 -0500
Message-ID: <2e925989-d435-0355-d26d-e79a0a99929f@mit.edu>
Date:   Mon, 8 Nov 2021 12:12:17 -0800
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
 <991240f7-2a3e-8ae7-ae25-a1d9d96d55d4@mit.edu>
 <YYUbQqyYQDD5QEAz@coredump.intra.peff.net>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <YYUbQqyYQDD5QEAz@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/5/21 04:53, Jeff King wrote:
> +			       wt->is_current ?
> +			       _("can't fetch in current branch") :
> +			       _("branch checked out in worktree"),

Sure, I’ll go ahead and add this.  We can make further improvements here 
if we proceed with removing the other error path, which seems to have 
enough complications that we should consider it after merging this bug fix.

> Hmm. That is the same check that is on the fetch side, isn't it? In a
> bare repository, we will not do any of these current-branch checks. What
> is weird in your example is that you are adding a worktree to a bare
> repository. Is that a supported workflow? Should that make it non-bare?
> 
> I notice that there is a worktree->is_bare flag, and that
> find_shared_symref() would not report such a bare entry to us. But I'm
> really unclear how any of that is supposed to work (how do you have a
> bare worktree, and what does it mean?).

worktree->is_bare is only ever potentially set for the main working tree 
(.git/..).  Although a bare repository doesn’t have a main working tree, 
it can still have other working trees created with git worktree.  Making 
a temporary working tree can be useful to quickly inspect or change a 
bare repository.  It’s also useful for sharing refs, remotes, and object 
storage between several working trees where any of them might be created 
or deleted, and there isn’t one that should be considered primary.

The Zulip installer works this way to save some disk space and 
re-cloning time while allowing for simple rollbacks to a previous 
deployment directory (https://github.com/zulip/zulip/pull/18487), which 
is how my team stumbled on the issue.

> I think that's all orthogonal to the main purpose of your patch here.
> You may want to post about it separately with a different subject to get
> the attention of folks who work on worktrees.

I expect this subject line will have already caught the attention of 
those folks, but I’ll add a patch 2/2 with a more specific subject line 
for this issue.

Anders
