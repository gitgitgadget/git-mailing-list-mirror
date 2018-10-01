Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1555E1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 14:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeJAVb5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 17:31:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:37368 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729439AbeJAVb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 17:31:57 -0400
Received: (qmail 8618 invoked by uid 109); 1 Oct 2018 14:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Oct 2018 14:53:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18714 invoked by uid 111); 1 Oct 2018 14:53:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Oct 2018 10:53:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Oct 2018 10:53:44 -0400
Date:   Mon, 1 Oct 2018 10:53:44 -0400
From:   Jeff King <peff@peff.net>
To:     Jose Gisbert <jose.gisbert@live.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Message-ID: <20181001145344.GA26349@sigill.intra.peff.net>
References: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 08:12:49AM +0000, Jose Gisbert wrote:

> My proposal consists to import the svn repository to git using git svn and set
> receive.denyCurrentBranch to updateInstead. Then install pre-receive and
> post-receive hooks and set that repository as the central repository for git
> users.
> 
> The pre-receive hook does git svn rebase and, if there is an update at the svn
> repository, rejects the push and instructs the user to do git pull. The
> post-receive hook does git svn dcommit to update the state of the svn
> repository, then instructs the user to do git pull too.
> [...]
> However I'm stuck at this point because the pre-receive hook it's not allowed
> to do git svn rebase because update refs are not allowed at the quarantine
> environment. I was sure that I tried this solution with a past version of git
> and it worked, but now I doubt this because the restriction to update refs at
> quarantine environment was delivered at version 2.13, that dates from April
> 2017, if I'm not wrong.

As you noticed, this used to be allowed. But it's dangerous, because if
the movement of the objects out of quarantine fails, then you're left
with a corrupted ref (ditto, anybody looking at the ref after update but
before quarantine ends will see what appears to be a corrupted
repository).

There are two solutions I can think of:

  1. The unsafe thing is to just unset $GIT_QUARANTINE_PATH before
     running "git svn rebase". That will skip the safety check
     completely, enabling the pre-v2.13 behavior. I don't really
     recommend this, but modulo the race and unlikely file-moving
     errors, it would probably generally work.

  2. Store intermediate results from pre-receive not as actual refs, and
     then install the refs as part of the post-receive. I don't think
     there's out of the box support for this, since "git svn rebase" is
     always going to call "git rebase", which is going to try to write
     refs.

     The smoothest thing would be for the refs code to see that
     $GIT_QUARANTINE_PATH is set, write a journal of ref updates into a
     file in that path, and then have the quarantine code try to apply
     those ref updates immediately after moving the objects out of
     quarantine (with the usual lease-locking mechanism).

     That's likely to be pretty tricky to implement, so I'm not even
     going to try to sketch out a patch in this email.

     You might be able to do something similar by hand by using a
     temporary sub-repository. E.g., "clone -s" to a temp repo, do the
     rebase there, and then in the post-receive fetch the refs back.
     That's less efficient, but the boundaries of the operation are very
     easy to understand.

> I come here asking for help because I think this is the appropriate place to
> do so. I apologise if this is not the case. Any help is welcome. If anything
> needs to be clarified, please, ask me to do so. I can share with you the
> source code of the hook scripts, if necessary.

This is definitely the right place. Sorry I don't have a better answer!

-Peff
