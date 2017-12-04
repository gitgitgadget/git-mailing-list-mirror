Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71E820954
	for <e@80x24.org>; Mon,  4 Dec 2017 15:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbdLDPgM (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 10:36:12 -0500
Received: from siwi.pair.com ([209.68.5.199]:62120 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751394AbdLDPgL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 10:36:11 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 43714844E0;
        Mon,  4 Dec 2017 10:36:08 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0F0A0844DB;
        Mon,  4 Dec 2017 10:36:08 -0500 (EST)
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Philip Oakley <philipoakley@iee.org>, Vitaly Arbuzov <vit@uber.com>
Cc:     Git List <git@vger.kernel.org>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
 <CANxXvsM-q-MH3y94=tW8GmbWNjvrskPoGEhOkyAzsbZd8RrRbg@mail.gmail.com>
 <CANxXvsNuEmo+uaRY8t44csqzXAk3rS+D9E=LMvaLcZeg-aLvRw@mail.gmail.com>
 <bac032c8-b9c2-4520-58e5-d518f4efd9d6@jeffhostetler.com>
 <A2F606CCDE4542D8AAFC41EB50909FE3@PhilipOakley>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c10b559d-40b3-dd94-daa1-67279e79d533@jeffhostetler.com>
Date:   Mon, 4 Dec 2017 10:36:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <A2F606CCDE4542D8AAFC41EB50909FE3@PhilipOakley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/2/2017 11:30 AM, Philip Oakley wrote:
> From: "Jeff Hostetler" <git@jeffhostetler.com>
> Sent: Friday, December 01, 2017 2:30 PM
>> On 11/30/2017 8:51 PM, Vitaly Arbuzov wrote:
>>> I think it would be great if we high level agree on desired user
>>> experience, so let me put a few possible use cases here.
>>>
>>> 1. Init and fetch into a new repo with a sparse list.
>>> Preconditions: origin blah exists and has a lot of folders inside of
>>> src including "bar".
>>> Actions:
>>> git init foo && cd foo
>>> git config core.sparseAll true # New flag to activate all sparse
>>> operations by default so you don't need to pass options to each
>>> command.
>>> echo "src/bar" > .git/info/sparse-checkout
>>> git remote add origin blah
>>> git pull origin master
>>> Expected results: foo contains src/bar folder and nothing else,
>>> objects that are unrelated to this tree are not fetched.
>>> Notes: This should work same when fetch/merge/checkout operations are
>>> used in the right order.
>>
>> With the current patches (parts 1,2,3) we can pass a blob-ish
>> to the server during a clone that refers to a sparse-checkout
>> specification.
> 
> I hadn't appreciated this capability. I see it as important, and should be available both ways, so that a .gitNarrow spec can be imposed from the server side, as well as by the requester.
> 
> It could also be used to assist in the 'precious/secret' blob problem, so that AWS keys are never pushed, nor available for fetching!

To be honest, I've always considered partial clone/fetch as
a client-side request as a performance feature to minimize
download times and disk space requirements on the client.
I've not thought of it from the "server has secrets" point
of view.

We can talk about it, but I'd like to keep it outside the
scope of the current effort.  My concerns are that that is
not the appropriate mechanism to enforce MAC/DAC like security
mechanisms.  For example:
[a] The client will still receive the containing trees that
     refer to the sensitive blobs, so the user can tell when
     the secret blobs change -- they wouldn't have either blob,
     but can tell when they are changed.  This event by itself
     may or may not leak sensitive information depending on the
     terms of the security policy in place.
[b] The existence of such missing blobs would tell the client
     which blobs are significant and secret and allow them to
     focus their attack.  It would be better if those assets
     were completely hidden and not in the tree at all.
[c] The client could push a fake secret blob to replace the
     valid one on the server.  You would have to audit the
     server to ensure that it never accepts a push containing
     a change to any secret blob.  And the server would need
     an infrastructure to know about all secrets in the tree.
[d] When a secret blob does change, any local merges by the
     user lack information to complete the merge -- they can't
     merge the secrets and they can't be trusted to correctly
     pick-ours or pick-theirs -- so their workflows are broken.
I'm not trying to blindly spread FUD here, but it is arguments
like these that make me suggest that the partial clone mechanism
is not the right vehicle for such "secret" blobs.


> 
>>        There's a bit of a chicken-n-egg problem getting
>> things set up.  So if we assume your team would create a series
>> of "known enlistments" under version control, then you could
> 
> s/enlistments/entitlements/ I presume?

Within my org we speak of "enlistments" as subset of the tree
that you plan to work on.  For example, you might enlist in the
"file system" portion of the tree or in the "device drivers"
portion.  If the Makefiles have good partitioning, you should
only need one of the above portions to do productive work within
a feature area.

I'm not sure what you mean by "entitlements".

> 
>> just reference one by <branch>:<path> during your clone.  The
>> server can lookup that blob and just use it.
>>
>>     git clone --filter=sparse:oid=master:templates/bar URL
>>
>> And then the server will filter-out the unwanted blobs during
>> the clone.  (The current version only filters blobs; you still
>> get full commits and trees.  That will be revisited later.)
> 
> I'm for the idea that only the in-heirachy trees should be sent.
> It should also be possible that the server replies that it is 
> only sending a narrow clone, with the given (accessible?) spec.

I do want to extend this to have unneeded tree filtering too.
It is just not in this version.

> 
>>
>> On the client side, the partial clone installs local config
>> settings into the repo so that subsequent fetches default to
>> the same filter criteria as used in the clone.
>>
>>
>> I don't currently have provision to send a full sparse-checkout
>> specification to the server during a clone or fetch.  That
>> seemed like too much to try to squeeze into the protocols.
>> We can revisit this later if there is interest, but it wasn't
>> critical for the initial phase.
>>
> Agreed. I think it should be somewhere 'visible' to the user, but could be setup by the server admin / repo maintainer if they don't have write access. But there could still be the catch-22 - maybe one starts with a <commit | toptree> : <tree> pair to define an origin point (it's not as refined as a .gitNarrow spec file, but is definative). The toptree option could even allow sub-tree clones.. maybe..

That's why I suggest having the sparse-checkout specifications
be stored under version control in the tree in a known location.
The user could be told out-of-band that "master:enlistments/*"
contains all of the well-defined enlistment specs -- I'm not
proposing such an area, just that a sysadmin could agree to
layout their tree with one.  Perhaps they have an enlistment
that just includes that directory.  Then the user could clone
that and look thru it -- add a new one if they need to and push
it -- and then do a partial fetch using a different enlistment
spec.  Again, I'm not dictating this mechanism, but just saying
that something like the above is possible.

> 
>>
>>>
>>> 2. Add a file and push changes.
>>> Preconditions: all steps above followed.
>>> touch src/bar/baz.txt && git add -A && git commit -m "added a file"
>>> git push origin master
>>> Expected results: changes are pushed to remote.
>>
>> I don't believe partial clone and/or partial fetch will cause
>> any changes for push.
> 
> I suspect that pushes could be rejected if the user 'pretends'
> to modify files or trees outside their area. It does need the
> user to be able to spoof part of a tree they don't have, so an
> upstream / remote would immediatly know it was a spoof but
> locally the narrow clone doesn't have enough detail about the
> 'bad' oid. It would be right to reject such attempts!

There is nothing in the partial clone/fetch to support this.
The server doesn't know which parts of the tree the user has
or doesn't have.  There is nothing to prevent the user from
creating a new file anywhere in the tree -- even if they don't
have blobs for anything else in the surrounding directory --
and including it in a push -- since the local "git commit"
would see it as adding a single file with a new SHA and
use the existing SHAs for the neighboring files.


> 
>>
>>>
>>> 3. Clone a repo with a sparse list as a filter.
>>> Preconditions: same as for #1
>>> Actions:
>>> echo "src/bar" > /tmp/blah-sparse-checkout
>>> git clone --sparse /tmp/blah-sparse-checkout blah # Clone should be
>>> the only command that would requires specific option key being passed.
>>> Expected results: same as for #1 plus /tmp/blah-sparse-checkout is
>>> copied into .git/info/sparse-checkout
> 
> I presume clone and fetch are treated equivalently here.

Yes, for the download and config setup, both clone and fetch are
equivalent.  They can pass a filter-spec to the server and set
the local config variables to indicate that a partial clone/fetch
was used.

> 
>>
>> There are 2 independent concepts here: clone and checkout.
>> Currently, there isn't any automatic linkage of the partial clone to
>> the sparse-checkout settings, so you could do something like this:
>>
> I see an implicit link that clearly one cannot checkout
> (inflate/populate) a file/directory that one does not have
> in the object store. But that does not imply the reverse linkage.
> The regular sparse checkout should be available independently of
> the local clone being a narrow one.

Right, I wasn't talking about changing sparse-checkout.  I was
just pointing out that after you complete a partial-clone, you
need to take a few steps before you can do a checkout that wont'
complain about the missing blobs -- or worse, demand load all
of them.


> 
>>     git clone --no-checkout --filter=sparse:oid=master:templates/bar URL
>>     git cat-file ... templates/bar >.git/info/sparse-checkout
>>     git config core.sparsecheckout true
>>     git checkout ...
>>
>> I've been focused on the clone/fetch issues and have not looked
>> into the automation to couple them.
>>
> 
> I foresee that large files and certain files need to be filterable
> for fetch-clone, and that might not be (backward) compatible
> with the sparse-checkout.

There are several filter-spec criteria: no-blobs, no-large-blobs,
sparse-checkout-compatible and others may be added later.  Each
may require different post-clone or post-fetch handling.

For example, you may want to configure your client to only omit
large blobs and configure a "missing blob helper" (outside of my
scope) that fetches them from S3 rather than from the origin
remote.  This would not need to use sparse-checkout.

I guess what I'm trying to say is that this effort is providing
a mechanism to let the git client request object filtering and
work with missing objects locally.

> 
>>
>>>
>>> 4. Showing log for sparsely cloned repo.
>>> Preconditions: #3 is followed
>>> Actions:
>>> git log
>>> Expected results: recent changes that affect src/bar tree.
>>
>> If I understand your meaning, log would only show changes
>> within the sparse subset of the tree.  This is not on my
>> radar for partial clone/fetch.  It would be a nice feature
>> to have, but I think it would be better to think about it
>> from the point of view of sparse-checkout rather than clone.
>>
> One option maybe by making a marker for the tree/blob to
> be a first class citizen. So the oid (and worktree file)
> has content ".gitNarrowTree <oid>" or ",gitNarrowBlob <oid>"
> as required (*), which is safe, and allows a consistent
> alter-ego view of the tree contents and hence for git-log et.al.
> 
> (*) I keep flip flopping between a single object marker, and
> distinct object markers for the types. It partly depends on
> whether one can know in advance, locally, what the oid type
> should be, and how it should be embedded in the object store
> - need to re-check the specs.
> 
> I'm tending toward distinct types to cope with the D/F conflict
> in the worktrees - the directory must be created (holds the
> name etc), and the alter-ego content then must be placed in a
> _known_ sub-file ".gitNarrowTree" (without the oid in the file
> name, but included in the content). Presence of a ".gitNarrowTree"
> should be standalone in the directory when that part of the
> work-tree is clean.

I'm not sure I follow this, but it is outside of my scope
for partial clone/fetch, so I'd rather not dive too deep on
this here.  If we really want a version of "git log" that
respects sparse-checkout boundaries, we should start a new
thread.  Thanks.

> 
>>
>>>
>>> 5. Showing diff.
>>> Preconditions: #3 is followed
>>> Actions:
>>> git diff HEAD^ HEAD
>>> Expected results: changes from the most recent commit affecting
>>> src/bar folder are shown.
>>> Notes: this can be tricky operation as filtering must be done to
>>> remove results from unrelated subtrees.
>>
>> I don't have any plan for this and I don't think it fits within
>> the scope of clone/fetch.  I think this too would be a sparse-checkout
>> feature.
>>
> 
> See my note about first class citizens for marker OIDs
> 
>>
>>>
>>> *Note that I intentionally didn't mention use cases that are related
>>> to filtering by blob size as I think we should logically consider them
>>> as a separate, although related, feature.
>>
>> I've grouped blob-size and sparse filter together for the
>> purposes of clone/fetch since the basic mechanisms (filtering,
>> transport, and missing object handling) are the same for both.
>> They do lead to different end-uses, but that is above my level
>> here.
>>
>>
>>>
>>> What do you think about these examples above? Is that something that
>>> more-or-less fits into current development? Are there other important
>>> flows that I've missed?
>>
>> These are all good ideas and it is good to have someone else who
>> wants to use partial+sparse thinking about it and looking for gaps
>> as we try to make a complete end-to-end feature.
>>>
>>> -Vitaly
>>
>> Thanks
>> Jeff
>>
> 
> Philip
> 

Thanks!
Jeff

