Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC46D20A2A
	for <e@80x24.org>; Fri, 22 Sep 2017 21:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbdIVVCN (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 17:02:13 -0400
Received: from siwi.pair.com ([209.68.5.199]:20919 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbdIVVCM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 17:02:12 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EDA5A84577;
        Fri, 22 Sep 2017 17:02:11 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C35F484576;
        Fri, 22 Sep 2017 17:02:11 -0400 (EDT)
Subject: Re: RFC: Design and code of partial clones (now, missing commits and
 trees OK)
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
 <e6259d03-e904-8c57-73b0-2434939fba71@jeffhostetler.com>
 <20170921154214.0d2ac45f@twelve2.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <af084ada-4607-53e8-c6bb-f5bf13bdc153@jeffhostetler.com>
Date:   Fri, 22 Sep 2017 17:02:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170921154214.0d2ac45f@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/21/2017 6:42 PM, Jonathan Tan wrote:
> On Thu, 21 Sep 2017 13:57:30 -0400
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> There's a lot in this patch series.  I'm still studying it, but here
>> are some notes and questions.  I'll start with direct responses to
>> the RFC here and follow up in a second email with specific questions
>> and comments to keep this from being too long).
> 
> OK - thanks for your detailed comments.
> 
>> I like that git-clone saves the partial clone settings in the
>> .git/config.  This should make it easier for subsequent commands to
>> default to the right settings.
>>
>> Do we allow a partial-fetch following a regular clone (such that
>> git-fetch would create these config file settings)?  This seems like
>> a reasonable upgrade path for a user with an existing repo to take
>> advantage of partial fetches going forward.
> 
> A "git-fetch ...options... --save-options" does not sound unreasonable,
> although I would think that (i) partial fetches/clones are useful on
> very large repositories, and (ii) the fact that you had already cloned
> this large repository shows that you can handle the disk and network
> load, so partial fetch after non-partial clone doesn't seem very useful.
> 
> But if there is a use case, I think it could work. Although note that
> the GC in my patch set stops at promisor objects, so if an object
> originally cloned cannot be reached through a walk (with non-promisor
> intermediate objects only), it might end up GC-ed (which might be fine).
> 
>> Or do we require that git-fetch only be allowed to do partial-fetches
>> after a partial-clone (so that only clone creates these settings) and
>> fetch always does partial-fetches thereafter?  It might be useful to
>> allow fetch to do a full fetch on top of a partial-clone, but there
>> are probably thin-pack issues to work out first.
> 
> About the thin-pack issue, I wonder if it is sufficient to turn on
> fetch_if_missing while index-pack is trying to fix the thin pack.
> 
> If the thin-pack issues are worked out, then non-partial fetch after
> partial clone seems doable (all commits from our tip to their tip are
> fetched, as well as all new trees and all new blobs; any trees and blobs
> still missing are already promised).

Agreed.  If we get a thin-pack and there are missing objects from the
commits in the edge set, we wouldn't be able to fix the newly received
objects without demand loading the object they are relative to.  Perhaps
we can use my filter/prefetch concept on the edge set to bulk fetch
them. (this is a bit of a SWAG.)  turning on the dynamic fetch would
be a first step (and may be sufficient).

> 
> Thanks for these questions - I am concentrating on repos in which both
> clone and fetch are partial, but it is good to discuss what happens if
> the user does something else.
> 
>> Also, there is an assumption here that the user will want to keep
>> using the same filtering settings on subsequent fetches.  That's
>> probably fine for now and until we get a chance to try it out for
>> real.
> 
> Yes. Having said that, the fetching of missing objects does not take
> into account the filter at all, so the filter can be easily changed.
> 
>> Do we allow EXACTLY ONE promisor-remote?  That is, can we later add
>> another remote as a promisor-remote?  And then do partial-fetches from
>> either?
> 
> Yes, exactly one (because we need to know which remote to fetch missing
> objects from, and which remote to allow partial fetches from). But the
> promisor remote can be switched to another.
> 
>> Do we need to disallow removing or altering a remote that is
>> listed as a promisor-remote?
> 
> Perhaps, although I think that right now configs are checked when we run
> the command using the config, not when we run "git config".
> 
>> I think for now, one promisor-remote is fine.  Just asking.
>>
>> Changing a remote's URL might be fine, but deleting the
>> promisor-remote would put the user in a weird state.  We don't need
>> to worry about it now though.
> 
> Agreed.
> 
>> I struggled with the terms here a little when looking at the source.
>> () A remote responding to a partial-clone is termed a
>> "promisor-remote". () Packfiles received from a promisor-remote are
>> marked with "<name>.promisor" like "<name>.keep" names.
>> () An object actually contained in such packfiles is called a
>> "promisor-object". () An object not-present but referenced by one of
>> the above promisor-objects is called a "promised-object" (aka a
>> "missing-object").
>>
>> I think the similarity of the words "promisOR" and "promisED" threw
>> me here and as I was looking at the code.  The code in is_promised()
>> [1] looked like it was adding all promisor- and promised-objects to
>> the "promised" OIDSET, but I could be mistaken.
>>
>> [1]
>> https://github.com/jonathantanmy/git/commit/7a9c2d9b6e2fce293817b595dee29a7eede0dddd#diff-5d5d5dc185ef37dc30bb7d9a7ae0c4e8R1960
> 
> I was struggling a bit with the terminology, true.
> 
> Right now I'm thinking of:
>   - promisor remote (as you defined)
>   - promisor packfile (as you defined)
>   - promisor object is an object known to belong to the promisor (whether
>     because we have it in a promisor packfile or because it is referenced
>     by an object in a promisor packfile)
> 
> This might eliminate "promise(d)", and thus eliminate the confusion
> between "promised" and "promisor", but I haven't done an exhaustive
> search.
> 

maybe just call the "promised" ones "missing".

>> The contents of the "<name>.promisor" file are described as arbitrary?
>> Should we write the name of the remote (or some other structured data)
>> into this file so that later fetches can find the server?  This is
>> more a question for when we have multiple promisor-remotes and may
>> need to decide who can supply a missing object.  Not urgent now
>> though.
> 
> Yeah, I don't have a use for it right now. Although it might be a good
> idea to make it future-proof, by say, declaring it to be lines of
> key-value pairs (with comments)...but then again, we might need to
> forbid earlier tools from working on such modern repositories, so we
> would need a repository extension (or something similar), and we can
> upgrade the format then.
> 
>> I assume you mean that a dynamic fetch of a single tree object would
>> be unpacked upon receipt (rather than creating a one object packfile)
>> and that we may need to mark it as promisor-object so that missing
>> objects that *IT* references would still follow the promised-object
>> rules.
> 
> Yes, that's right. (And that it would not participate in GC.)
> 
>> So is the assumption that as soon as you touch a promisOR-object you
>> might as well stop scanning, because anything it references might be
>> missing?
>>
>>
>> The code in rev-list.c and revision.c in [2] looks like it will
>> continue thru PROMISOR-objects and stop at (still-missing)
>> PROMISED-objects.
>>
>> [2]
>> https://github.com/jonathantanmy/git/commit/2d7ae2bc780dd056552643e4f5061a0ca7b5b1e5
> 
> The invocation of for_each_packed_object() in prepare_revision_walk()
> should mark all objects in promisor packs as uninteresting, so the
> traversal should stop there (unless I'm misunderstanding something).
> 
>>> The object walk done by gc also stops at all promisor objects and
>>> promised objects. Only non-promisor packfiles are deleted (if pack
>>> deletion is requested); promisor packfiles are left alone. This
>>> maintains the distinction between promisor packfiles and
>>> non-promisor packfiles. (In the future, we might need to do
>>> something more sophisticated with promisor packfiles.)
>>>
>>
>> Seems like we could combine promisor-packfiles -- so, for example,
>> the net result of a complete repack might be one normal- and one
>> promisor-packfile.
> 
> Yes, that is a good next step. (I'm aiming for a minimum viable product
> here so I didn't include that.)
> 
>> Question: if the initial clone is a partial-clone, we will ONLY have
>> promisor-packfiles, right?  (Unless they later add a second regular
>> remote.) So fsck and GC will basically stop scanning immediately,
>> right? Likewise, repack will basically be disabled until we support
>> repacking promisor-packfiles, right?  So performance of the resulting
>> repo will deteriorate over time as subsequent partial-fetches pull in
>> more and more promisor-packfiles.
> 
> Files locally created are non-promisor objects, and will become
> non-promisor packfiles when GC/repack is run.

i forgot about locally created objects.

> 
> As for performance, you are right. We'll need to make a way to combine
> promisor packfiles after this.
> 
>>> Fetching of promised objects
>>> ----------------------------
>>>
>>> When `sha1_object_info_extended()` (or similar) is invoked, it will
>>> automatically attempt to fetch a missing object from the promisor
>>> remote if that object is not in the local repository. For
>>> efficiency, no check is made as to whether that object is a
>>> promised object or not.
>>>
>>
>> I don't understand this last statement.  A missing-object is assumed
>> to be a promised-object, but we don't check that.  By this do you
>> mean that is_promised() [1] is only used by commands like fsck and
>> not elsewhere?
> 
> Sorry, I meant not checked in sha1_object_info_extended(). Yes, fsck and
> gc will check them.
> 
>> The dynamic object fetching in fetch_object() [3] only fetches 1
>> object from the server.  This will spawn a transport process, network
>> connection (and authentication), a packfile download, and index-pack
>> or unpack for each object.
>>
>> Perhaps this is just preliminary code, but I don't see how you can
>> adapt that model to be efficient.  Even using a long-running
>> background process to fetch individual blobs, it will still be
>> fetching blobs individually.  We do need to have dynamic object
>> fetching, but we should try to minimize its use; that is, to try have
>> higher-level mechanisms in place to predict and bulk prefetch missing
>> objects.
> 
> My plan is to have batch fetching. We would need to extend this command
> by command, for example, my patch for batched checkout here:
> 
> https://github.com/jonathantanmy/git/commit/14f07d3f06bc3a1a2c9bca85adc8c42b230b9143
> 
> (I didn't update this for my newest patch set because I didn't figure
> out a good way to deal with the possibility of missing trees, but
> something like this could probably be done - for example, by only
> batching blobs, and whenever we need to fetch a tree, automatically
> fetch all objects to a certain depth, for example.)
> 
> Server incompatibility is not a problem because the server already
> supports multiple objects per request. (Well, except the fetching trees
> to a certain depth part.)
> 

Here I think we plug in my filter mechanism and hook it to a pre-fetch
command.  Then we have a pre-checkout hook or something that drives
this.  We may need a similar pre-merge hook (to get both tips and the
merge base).

>> I guess it depends on how many missing-objects you expect the client
>> to have. My concern here is that we're limiting the design to the
>> "occasional" big file problem, rather than the more general scale
>> problem.
> 
> Do you have a specific situation in mind?
> 

I have would like to be able do sparse-enlistments in the Windows
source tree. (3.5M files at HEAD.)  Most developers only need a small
feature area (a device driver or file system or whatever) and not the
whole tree.  A typical Windows developer may have only 30-50K files
populated.  If we can synchronize on a sparse-checkout spec and use
that for both the checkout and the clone/fetch, then we can bulk fetch
the blobs that they'll actually need.  GVFS can hydrate the files as
they touch them, but I can use this to pre-fetch the needed blobs in
bulk, rather than faulting and fetching them one-by-one.

So, my usage may have >95% of the ODB be missing blobs.  Contrast that
with the occasional large blob / LFS usage where you may have <5% of
the ODB as large objects (by count of OIDs not disk usage).


>> Also, relying on dynamic object fetching also means that operations,
>> like checkout, may now require a network connection.  Because we
>> don't know we need an object until we actually need it (and are
>> half-way thru some operation that the user thought was safe to do
>> off-line).
> 
> Yes, but I think this is expected when we're dealing with partial
> clones.

Right, but if we could pre-fetch, we could make checkout a little
less unpredictable.

> 
>> Thanks,
>> Jeff
> 
> Thanks.
> 

Thanks
Jeff
