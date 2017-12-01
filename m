Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0131A20954
	for <e@80x24.org>; Fri,  1 Dec 2017 14:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbdLAOad (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 09:30:33 -0500
Received: from siwi.pair.com ([209.68.5.199]:49925 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752880AbdLAOad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 09:30:33 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3AB2984551;
        Fri,  1 Dec 2017 09:30:32 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 15BC3844C7;
        Fri,  1 Dec 2017 09:30:32 -0500 (EST)
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Vitaly Arbuzov <vit@uber.com>, Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
 <CANxXvsM-q-MH3y94=tW8GmbWNjvrskPoGEhOkyAzsbZd8RrRbg@mail.gmail.com>
 <CANxXvsNuEmo+uaRY8t44csqzXAk3rS+D9E=LMvaLcZeg-aLvRw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bac032c8-b9c2-4520-58e5-d518f4efd9d6@jeffhostetler.com>
Date:   Fri, 1 Dec 2017 09:30:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CANxXvsNuEmo+uaRY8t44csqzXAk3rS+D9E=LMvaLcZeg-aLvRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/30/2017 8:51 PM, Vitaly Arbuzov wrote:
> I think it would be great if we high level agree on desired user
> experience, so let me put a few possible use cases here.
> 
> 1. Init and fetch into a new repo with a sparse list.
> Preconditions: origin blah exists and has a lot of folders inside of
> src including "bar".
> Actions:
> git init foo && cd foo
> git config core.sparseAll true # New flag to activate all sparse
> operations by default so you don't need to pass options to each
> command.
> echo "src/bar" > .git/info/sparse-checkout
> git remote add origin blah
> git pull origin master
> Expected results: foo contains src/bar folder and nothing else,
> objects that are unrelated to this tree are not fetched.
> Notes: This should work same when fetch/merge/checkout operations are
> used in the right order.

With the current patches (parts 1,2,3) we can pass a blob-ish
to the server during a clone that refers to a sparse-checkout
specification.  There's a bit of a chicken-n-egg problem getting
things set up.  So if we assume your team would create a series
of "known enlistments" under version control, then you could
just reference one by <branch>:<path> during your clone.  The
server can lookup that blob and just use it.

     git clone --filter=sparse:oid=master:templates/bar URL

And then the server will filter-out the unwanted blobs during
the clone.  (The current version only filters blobs; you still
get full commits and trees.  That will be revisited later.)

On the client side, the partial clone installs local config
settings into the repo so that subsequent fetches default to
the same filter criteria as used in the clone.


I don't currently have provision to send a full sparse-checkout
specification to the server during a clone or fetch.  That
seemed like too much to try to squeeze into the protocols.
We can revisit this later if there is interest, but it wasn't
critical for the initial phase.


> 
> 2. Add a file and push changes.
> Preconditions: all steps above followed.
> touch src/bar/baz.txt && git add -A && git commit -m "added a file"
> git push origin master
> Expected results: changes are pushed to remote.

I don't believe partial clone and/or partial fetch will cause
any changes for push.


> 
> 3. Clone a repo with a sparse list as a filter.
> Preconditions: same as for #1
> Actions:
> echo "src/bar" > /tmp/blah-sparse-checkout
> git clone --sparse /tmp/blah-sparse-checkout blah # Clone should be
> the only command that would requires specific option key being passed.
> Expected results: same as for #1 plus /tmp/blah-sparse-checkout is
> copied into .git/info/sparse-checkout

There are 2 independent concepts here: clone and checkout.
Currently, there isn't any automatic linkage of the partial clone to
the sparse-checkout settings, so you could do something like this:

     git clone --no-checkout --filter=sparse:oid=master:templates/bar URL
     git cat-file ... templates/bar >.git/info/sparse-checkout
     git config core.sparsecheckout true
     git checkout ...

I've been focused on the clone/fetch issues and have not looked
into the automation to couple them.


> 
> 4. Showing log for sparsely cloned repo.
> Preconditions: #3 is followed
> Actions:
> git log
> Expected results: recent changes that affect src/bar tree.

If I understand your meaning, log would only show changes
within the sparse subset of the tree.  This is not on my
radar for partial clone/fetch.  It would be a nice feature
to have, but I think it would be better to think about it
from the point of view of sparse-checkout rather than clone.


> 
> 5. Showing diff.
> Preconditions: #3 is followed
> Actions:
> git diff HEAD^ HEAD
> Expected results: changes from the most recent commit affecting
> src/bar folder are shown.
> Notes: this can be tricky operation as filtering must be done to
> remove results from unrelated subtrees.

I don't have any plan for this and I don't think it fits within
the scope of clone/fetch.  I think this too would be a sparse-checkout
feature.


> 
> *Note that I intentionally didn't mention use cases that are related
> to filtering by blob size as I think we should logically consider them
> as a separate, although related, feature.

I've grouped blob-size and sparse filter together for the
purposes of clone/fetch since the basic mechanisms (filtering,
transport, and missing object handling) are the same for both.
They do lead to different end-uses, but that is above my level
here.


> 
> What do you think about these examples above? Is that something that
> more-or-less fits into current development? Are there other important
> flows that I've missed?

These are all good ideas and it is good to have someone else who
wants to use partial+sparse thinking about it and looking for gaps
as we try to make a complete end-to-end feature.
> 
> -Vitaly

Thanks
Jeff

