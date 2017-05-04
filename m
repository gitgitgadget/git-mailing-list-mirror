Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515B0207FF
	for <e@80x24.org>; Thu,  4 May 2017 16:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755788AbdEDQvH (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 12:51:07 -0400
Received: from siwi.pair.com ([209.68.5.199]:37751 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755726AbdEDQvD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 12:51:03 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9BFF184471;
        Thu,  4 May 2017 12:51:00 -0400 (EDT)
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
To:     Jonathan Nieder <jrnieder@gmail.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
 <777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com>
 <20170503182725.GC28740@aiede.svl.corp.google.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        gitster@pobox.com, markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9b58bec9-dafb-aebc-d421-5327f2f607eb@jeffhostetler.com>
Date:   Thu, 4 May 2017 12:51:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170503182725.GC28740@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/3/2017 2:27 PM, Jonathan Nieder wrote:
> Hi,
>
> Jeff Hostetler wrote:
>> Missing-Blob Support
>> ====================
>>
>> Let me offer up an alternative idea for representing
>> missing blobs.  This is differs from both of our previous
>> proposals.  (I don't have any code for this new proposal,
>> I just want to think out loud a bit and see if this is a
>> direction worth pursuing -- or a complete non-starter.)
>>
>> Both proposals talk about detecting and adapting to a missing
>> blob and ways to recover -- when we fail to find a blob.
>> Comments on the thread asked about:
>> () being able to detect missing blobs vs corrupt repos
>> () being unable to detect duplicate blobs
>> () expense of blob search.
>>
>> Suppose we store "positive" information about missing blobs?
>> This would let us know that a blob is intentionally missing
>> and possibly some meta-data about it.
>
> We've discussed this a little informally but didn't go more into
> it, so I'm glad you brought it up.
>
> There are two use cases I care about.  I'll want names to refer to
> them later, so describing them now:
>
>  A. A p4 or svn style "monorepo" containing all code within a company.
>     We want to make git scale well when working with such a
>     repository.  Disk usage, network usage, index size, and object
>     lookup time are all issues for such a repository.
>
>     A repository can creep up in size so it starts falling into this
>     category even though git coped well with it before.  Another way
>     to end up in this category is a conversion from a version control
>     system like p4 or svn.
>
>  B. A more modestly sized repository with some large blobs in it.  At
>     clone time we want to omit unneeded large blobs to speed up the
>     clone, save disk space, and save bandwidth.
>
>     For this kind of repository, the idx file already contained all
>     those blobs and that was not causing problems --- the only problem
>     was the actual blob size.

Yes, I've been primarily concerned with "case A" repos.
I work with the team converting the Windows source repo
to git.  This was discussed in Brussels as part of the
GVFS presentation.

The Windows tree has 3.5M files in the worktree for a simple checkout
of HEAD.  The index is 450MB.  There are 500K trees/folders in
the commit.  Multiply that by scale factor considering the number
of trunk/release branches, number of developers, typical number of
commits per day per developer, and n years(decades) of history and
we get to a very large number....

FWIW, there's also a "case C" which has both, but that
just hurts to think about.

>
>> 1. Suppose we update the .pack file format slightly.
> [...]
>> 2. Make a similar change in the .idx format and git-index-pack
>>    to include them there.  Then blob lookup operations could
>>    definitively determine that a blob exists and is just not
>>    present locally.
>
> Some nits:
>
> - there shouldn't be any need for the blobs to even be mentioned in
>   the .pack stored locally.  The .idx file maps from sha1 to offset
>   within the packfile --- a special offset could mean "this is a
>   missing blob".
>
> - Git protocol works by sending pack files over the wire.  The idx
>   file is not transmitted to the client --- the client instead
>   reconstructs it from the pack file.  I assume this is why you
>   stored the SHA-1 of the object in the pack file, but it could
>   equally well be sent through another stream (since this proposal
>   involves a change to git protocol anyway).
>
> - However, the list of missing blobs can be inferred from the existing
>   pack format, without a change to the pack format used in git
>   protocol.  As part of constructing the idx, "git index-pack"
>   inflates every object in the pack file sent by the server.  This
>   means we know what blobs they reference, so we can easily produce a
>   list for the idx file without changing the pack file format.

In my original RFC there were comments/complaints that with
missing blobs we lose the ability to detect corruptions.  My
proposed changes to index-pack and rev-list (and suggestions
for other commands like fsck) just disabled those errors.
Personally, I'm OK with that, but I understand that others
would like to save the ability to distinguish between missing
and corrupted.

Right, only the .pack is sent over the wire.  And that's why I
suggest listing the missing SHAs in it.  I think we need the server
to send a list of them -- whether in individual per-file type-5
records as I suggested, or a single record containing a list of
SHAs+data (which I think I prefer in hindsight).

WRT being able to discover the missing blobs, is that true in
all cases?  I don't think it is for thin-packs -- where the server
only sends stuff you don't (supposedly) already have, right ?

If instead, we have pack-object indicate that it *would have*
sent this blob normally, we don't change any of the semantics
of how pack files are assembled.  This gives the client a
definitive list of what's missing.


> If this is done by only changing the idx file format and not the pack
> file, then it does not affect the protocol.  That is good for
> experimentation --- it lets us try out different formats client-side
> without having to coordinate with server authors.
>
> In case (A), this proposal means we get back some of the per-object
> overhead that we were trying to avoid.  I would like to avoid that
> if possible.

If thin-packs are used, the fetch only receives information about
blobs that are new relative to the heads the client already has,
right?

>
> In case (B), this proposal doesn't hurt.
>
> One problem with proposals so far has been how to handle repositories
> with multiple remotes.  Having a local list of missing blobs is
> convenient because it can be associated to the remote --- when a blob
> is referenced later, we know which remote to ask for for it.  This is
> a niche feature, but it's a nice bonus.

The more I think about it, I'd like to NOT put the list in the .idx
file.  If we put it in a separate peer file next to the *.{pack,idx}
we could decorate it with the name of the remote used in the fetch
or clone.

>
> [...]
>> 3. With this, packfile-based blob-lookup operations can get a
>>    "missing-blob" result.
>>    () It should be possible to short-cut searching in other
>>       packfiles (because we don't have to assume that the blob
>>       was just misplaced in another packfile).
>>    () Lookup can still look for the corresponding loose blob
>>       (in case a previous lookup already "faulted it in").
>
> The number of packfiles to search is always a problem for object
> lookups --- we need to be able to keep the number of packfiles low.
> If we solve that for missing blobs but not for the ones that are
> present, then git's object access performance is still slow.
>
> I have some ideas for improving git's gc behavior to bound the number
> of packfiles better.  I think that's mostly orthogonal to this
> proposal.  The main point of overlap is the number of packfiles
> produced if someone uses one packfile per large blob, but that is bad
> for the performance in successful lookups, not just negative lookups,
> so it needs to be solved directly anyway.
>

I've always wondered if repack, fetch, and friends should build
a meta-idx that merges all of the current .idx files, but that
is a different conversation....


>> 4. We can then think about dynamically fetching it.
>
> This also seems orthogonal to whether the missing blobs list exists.
>
> [...]
>> A missing-blob entry needs to contain the SHA-1 value of
>> the blob (obviously).  Other fields are nice to have, but
>> are not necessary.  Here are a few fields to consider.
> [...]
>> B. The raw size of the blob (5? bytes).
>
> This would be a very nice thing.
>
> If we were starting over, would this belong in the tree object?
> (Part of the reason I ask is that we have an opportunity to sort
> of start over as part of the transition away from SHA-1.)

Yes, putting the size in the tree would be nice.  That does
add 5-8 bytes to every entry in every tree (on top of the
larger hash), but it would be useful.

If we're going there, we might just define the new hash
as the concatenation of the SHA* and the length of the data
hashed.  So instead of a 32-byte SHA256, we'd have a (32 + 8)
byte value.  (Or maybe a (32 + 5) if we want to squeeze it.)


>
> [...]
>> C. A server "hint" (20 bytes)
>>    () Instructions to help the client fetch the blob.
>>    () If I have multiple remotes configured, a missing-blob
>>       should be fetched from the same server that created
>>       the missing-blob entry (since it may be the only
>>       one that has it).
>
> I am worried about the implications of storing this kind of policy
> information in the pack file.  There may be useful information along
> these lines for a server to advertise, but I don't think it belongs in
> the pack file.  Git protocol relies on it being cheap to stream pack
> files as is.

Perhaps.  I'm not sure it would be that expensive -- I'm thinking
about it being a server constant rather than a per-user/per-fetch
field.  But maybe we don't need it.  Assuming we can correctly
associate a missing blob with the server/remote that omitted it.

>
> [...]
>
> Thanks and hope that helps,
> Jonathan
>

thanks!
Jeff
