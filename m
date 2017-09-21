Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B97202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 17:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbdIUR5d (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 13:57:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:24865 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751669AbdIUR5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 13:57:32 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 08A02845D1;
        Thu, 21 Sep 2017 13:57:32 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 89EDD845CF;
        Thu, 21 Sep 2017 13:57:31 -0400 (EDT)
Subject: Re: RFC: Design and code of partial clones (now, missing commits and
 trees OK)
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     peartben@gmail.com, Christian Couder <christian.couder@gmail.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e6259d03-e904-8c57-73b0-2434939fba71@jeffhostetler.com>
Date:   Thu, 21 Sep 2017 13:57:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


There's a lot in this patch series.  I'm still studying it, but here
are some notes and questions.  I'll start with direct responses to
the RFC here and follow up in a second email with specific questions
and comments to keep this from being too long).


On 9/15/2017 4:43 PM, Jonathan Tan wrote:
> For those interested in partial clones and/or missing objects in repos,
> I've updated my original partialclone patches to not require an explicit
> list of promises. Fetch/clone still only permits exclusion of blobs, but
> the infrastructure is there for a local repo to support missing trees
> and commits as well.
> 
> They can be found here:
> 
> https://github.com/jonathantanmy/git/tree/partialclone2
> 
> To make the number of patches more manageable, I have omitted support
> for a custom fetching hook (but it can be readded in fetch-object.c),
> and only support promisor packfiles for now (but I don't have any
> objection to supporting promisor loose objects in the future).
> 
> Let me know what you think of the overall approach. In particular, I'm
> still wondering if there is a better approach than to toggle
> "fetch_if_missing" whenever we need lazy fetching (or need to suppress
> it).
> 
> Also, if there any patches that you think might be useful to others, let
> me know and I'll send them to this mailing list for review.
> 
> A demo and an overview of the design (also available from that
> repository's README):
> 
> Demo
> ====
> 
> Obtain a repository.
> 
>      $ make prefix=$HOME/local install
>      $ cd $HOME/tmp
>      $ git clone https://github.com/git/git
> 
> Make it advertise the new feature and allow requests for arbitrary blobs.
> 
>      $ git -C git config uploadpack.advertiseblobmaxbytes 1
>      $ git -C git config uploadpack.allowanysha1inwant 1
> 
> Perform the partial clone and check that it is indeed smaller. Specify
> "file://" in order to test the partial clone mechanism. (If not, Git will
> perform a local clone, which unselectively copies every object.)
> 
>      $ git clone --blob-max-bytes=100000 "file://$(pwd)/git" git2
>      $ git clone "file://$(pwd)/git" git3
>      $ du -sh git2 git3
>      116M	git2
>      129M	git3
> 
> Observe that the new repo is automatically configured to fetch missing objects
> from the original repo. Subsequent fetches will also be partial.
> 
>      $ cat git2/.git/config
>      [core]
>      	repositoryformatversion = 1
>      	filemode = true
>      	bare = false
>      	logallrefupdates = true
>      [remote "origin"]
>      	url = [snip]
>      	fetch = +refs/heads/*:refs/remotes/origin/*
>      	blobmaxbytes = 100000
>      [extensions]
>      	partialclone = origin
>      [branch "master"]
>      	remote = origin
>      	merge = refs/heads/master
> 

I like that git-clone saves the partial clone settings in the
.git/config.  This should make it easier for subsequent commands to
default to the right settings.

Do we allow a partial-fetch following a regular clone (such that git-fetch
would create these config file settings)?  This seems like a reasonable
upgrade path for a user with an existing repo to take advantage of partial
fetches going forward.

Or do we require that git-fetch only be allowed to do partial-fetches
after a partial-clone (so that only clone creates these settings) and
fetch always does partial-fetches thereafter?  It might be useful to
allow fetch to do a full fetch on top of a partial-clone, but there
are probably thin-pack issues to work out first.

Also, there is an assumption here that the user will want to keep
using the same filtering settings on subsequent fetches.  That's
probably fine for now and until we get a chance to try it out for
real.


> Unlike in an older version of this code (see the `partialclone` branch), this
> also works with the HTTP/HTTPS protocols.
> 
> Design
> ======
> 
> Local repository layout
> -----------------------
> 
> A repository declares its dependence on a *promisor remote* (a remote that
> declares that it can serve certain objects when requested) by a repository
> extension "partialclone". `extensions.partialclone` must be set to the name of
> the remote ("origin" in the demo above).
> 

Do we allow EXACTLY ONE promisor-remote?  That is, can we later add
another remote as a promisor-remote?  And then do partial-fetches from
either?  Do we need to disallow removing or altering a remote that is
listed as a promisor-remote?

I think for now, one promisor-remote is fine.  Just asking.

Changing a remote's URL might be fine, but deleting the promisor-remote
would put the user in a weird state.  We don't need to worry about it
now though.


> A packfile can be annotated as originating from the promisor remote by the
> existence of a "(packfile name).promisor" file with arbitrary contents (similar
> to the ".keep" file). Whenever a promisor remote sends an object, it declares
> that it can serve every object directly or indirectly referenced by the sent
> object.
> 
> A promisor packfile is a packfile annotated with the ".promisor" file. A
> promisor object is an object in a promisor packfile. A promised object is an
> object directly referenced by a promisor object.
> 

I struggled with the terms here a little when looking at the source.
() A remote responding to a partial-clone is termed a "promisor-remote".
() Packfiles received from a promisor-remote are marked with "<name>.promisor"
    like "<name>.keep" names.
() An object actually contained in such packfiles is called a "promisor-object".
() An object not-present but referenced by one of the above promisor-objects
    is called a "promised-object" (aka a "missing-object").

I think the similarity of the words "promisOR" and "promisED" threw me here
and as I was looking at the code.  The code in is_promised() [1] looked like
it was adding all promisor- and promised-objects to the "promised" OIDSET,
but I could be mistaken.

[1] https://github.com/jonathantanmy/git/commit/7a9c2d9b6e2fce293817b595dee29a7eede0dddd#diff-5d5d5dc185ef37dc30bb7d9a7ae0c4e8R1960


The contents of the "<name>.promisor" file are described as arbitrary?
Should we write the name of the remote (or some other structured data)
into this file so that later fetches can find the server?  This is more
a question for when we have multiple promisor-remotes and may need to
decide who can supply a missing object.  Not urgent now though.


> (In the future, we might need to add ".promisor" support to loose objects.)
>

I assume you mean that a dynamic fetch of a single tree object would be
unpacked upon receipt (rather than creating a one object packfile) and
that we may need to mark it as promisor-object so that missing objects
that *IT* references would still follow the promised-object rules.


> Connectivity check and gc
> -------------------------
> 
> The object walk done by the connectivity check (as used by fsck and fetch) stops
> at all promisor objects and promised objects.
>

So is the assumption that as soon as you touch a promisOR-object you might
as well stop scanning, because anything it references might be missing?


The code in rev-list.c and revision.c in [2] looks like it will continue
thru PROMISOR-objects and stop at (still-missing) PROMISED-objects.

[2] https://github.com/jonathantanmy/git/commit/2d7ae2bc780dd056552643e4f5061a0ca7b5b1e5


> The object walk done by gc also stops at all promisor objects and promised
> objects. Only non-promisor packfiles are deleted (if pack deletion is
> requested); promisor packfiles are left alone. This maintains the distinction
> between promisor packfiles and non-promisor packfiles. (In the future, we might
> need to do something more sophisticated with promisor packfiles.)
>

Seems like we could combine promisor-packfiles -- so, for example, the net
result of a complete repack might be one normal- and one promisor-packfile.


Question: if the initial clone is a partial-clone, we will ONLY have
promisor-packfiles, right?  (Unless they later add a second regular remote.)
So fsck and GC will basically stop scanning immediately, right?
Likewise, repack will basically be disabled until we support repacking
promisor-packfiles, right?  So performance of the resulting repo will
deteriorate over time as subsequent partial-fetches pull in more and more
promisor-packfiles.


> Fetching of promised objects
> ----------------------------
> 
> When `sha1_object_info_extended()` (or similar) is invoked, it will
> automatically attempt to fetch a missing object from the promisor remote if that
> object is not in the local repository. For efficiency, no check is made as to
> whether that object is a promised object or not.
>

I don't understand this last statement.  A missing-object is assumed to
be a promised-object, but we don't check that.  By this do you mean that
is_promised() [1] is only used by commands like fsck and not elsewhere?


> This automatic fetching can be toggled on and off by the `fetch_if_missing`
> global variable, and it is on by default.
> 
> The actual fetch is done through the fetch-pack/upload-pack protocol. Right now,
> this uses the fact that upload-pack allows blob and tree "want"s, and this
> incurs the overhead of the unnecessary ref advertisement. I hope that protocol
> v2 will allow us to declare that blob and tree "want"s are allowed, and allow
> the client to declare that it does not want the ref advertisement. All packfiles
> downloaded in this way are annotated with ".promisor".
>

The dynamic object fetching in fetch_object() [3] only fetches 1 object from
the server.  This will spawn a transport process, network connection (and
authentication), a packfile download, and index-pack or unpack for each object.

Perhaps this is just preliminary code, but I don't see how you can adapt that
model to be efficient.  Even using a long-running background process to fetch
individual blobs, it will still be fetching blobs individually.  We do need to
have dynamic object fetching, but we should try to minimize its use; that is,
to try have higher-level mechanisms in place to predict and bulk prefetch missing
objects.

I guess it depends on how many missing-objects you expect the client to have.
My concern here is that we're limiting the design to the "occasional" big file
problem, rather than the more general scale problem.

Also, relying on dynamic object fetching also means that operations, like
checkout, may now require a network connection.  Because we don't know we
need an object until we actually need it (and are half-way thru some
operation that the user thought was safe to do off-line).

I'll talk about this more in my next response to this thread.

[3] https://github.com/jonathantanmy/git/commit/d23be53681549d9ac3c2ecb7b2be9f93d355457b#diff-5c4ccaa3282a2113fc8cafa156b30941R7


> Fetching with `git fetch`
> -------------------------
> 
> The fetch-pack/upload-pack protocol has also been extended to support omission
> of blobs above a certain size. The client only allows this when fetching from
> the promisor remote, and will annotate any packs received from the promisor
> remote with ".promisor".
> 

Thanks,
Jeff
