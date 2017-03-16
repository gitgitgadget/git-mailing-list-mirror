Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF5D20323
	for <e@80x24.org>; Thu, 16 Mar 2017 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbdCPVoB (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 17:44:01 -0400
Received: from siwi.pair.com ([209.68.5.199]:18305 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752582AbdCPVoA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 17:44:00 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C574184683;
        Thu, 16 Mar 2017 17:43:36 -0400 (EDT)
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
 <9ef37430-17be-dfc2-bca5-e4e33bc68df8@google.com>
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7ce6e14f-b2b1-19f3-916a-9ed1307a3403@jeffhostetler.com>
Date:   Thu, 16 Mar 2017 17:43:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <9ef37430-17be-dfc2-bca5-e4e33bc68df8@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/9/2017 3:18 PM, Jonathan Tan wrote:
> Overall, this fetch/clone approach seems reasonable to me, except
> perhaps some unanswered questions (some of which are also being
> discussed elsewhere):
>  - does the server need to tell us of missing blobs?
>  - if yes, does the server need to tell us their file sizes?

File sizes are a nice addition.  For example, with a virtual
file system, a "ls -l" can lie and tell you the sizes of the
yet-to-be-populated files.  Or if the client wants to distinguish
between going back to the original remote or going to S3 for the
blob, it could use the size to choose.  (I'm not saying we actually
build that yet, but others on the mailing list have spoken about
parking large blobs in S3.)

So, not necessary, but might be nice to have.

>  - do we need to store the list of missing blobs somewhere (whether the
>    server told it to us or whether we inferred it from the fetched
>    trees)

We should be able to infer the list of missing blobs; I hadn't
considered that.  However, by doing so we will need to disable
some of the integrity checking (as I had to do with the
"--allow-partial" option) and some concerns about that were
discussed earlier in the thread.  But if we do that inference
during clone/fetch and record it somewhere, we could get back
the integrity checking.

>
> The answers to this probably depend on the answers in "B. Issues
> Backfilling Omitted Blobs" (especially the additional concepts I listed
> below).
>
> Also, do you have any plans to implement other functionality, e.g. "git
> checkout" (which will allow fetches and clones to repositories with a
> working directory)? (I don't know what the mailing list consensus would
> be for the "acceptance criteria" for this patch set, but I would at
> least include "checkout".)

Yes, supporting "checkout" is essential. Commands like "merge", "diff",
and etc. will come later.  In Ben's RFC, he has been investigating
demand-loading blobs in read_object().  I've been focusing on
pre-fetching the missing blobs for a particular command.  I need
to make more progress on this topic.

>
> On 03/08/2017 10:50 AM, git@jeffhostetler.com wrote:
>> B. Issues Backfilling Omitted Blobs
>> ===================================
>>
>> Ideally, if the client only does "--partial-by-profile" fetches, it
>> should not need to fetch individual missing blobs, but we have to allow
>> for it to handle the other commands and other unexpected issues.
>>
>> There are 3 orthogonal concepts here:  when, how and where?
>
> Another concept is "how to determine if a blob is really omitted" - do
> we store a list somewhere or do we assume that all missing blobs are
> purposely omitted (like in this patch set)?
>
> Yet another concept is "whether to fetch" - for example, a checkout
> should almost certainly fetch, but a rev-list used by a connectivity
> check (like in patch 6 of this set) should not.
>
> For example, for historical-blob-searching commands like "git log -S",
> should we:
>  a) fetch everything missing (so users should use date-limiting
>     arguments)
>  b) fetch nothing missing
>  c) use the file size to automatically exclude big files, but fetch
>     everything else
>
> For a) and b), we wouldn't need file size information for missing blobs,
> but for c), we do. This might determine if we need file size information
> in the fetch-pack/upload-pack protocol.

good points.

>
>> C. New Blob-Fetch Protocol (2a)
>> ===============================
>>
>> *TODO* A new pair of commands, such as fetch-blob-pack and
>> upload-blob-pack,
>> will be created to let the client request a batch of blobs and receive a
>> packfile.  A protocol similar to the fetch-pack/upload-pack will be
>> spoken
>> between them.  (This avoids complicating the existing protocol and the
>> work
>> of enumerating the refs.)  Upload-blob-pack will use pack-objects to
>> build
>> the packfile.
>>
>> It is also more efficient than requesting a single blob at a time using
>> the existing fetch-pack/upload-pack mechanism (with the various allow
>> unreachable options).
>>
>> *TODO* The new request protocol will be defined in the patch series.
>> It will include: a list of the desired blob SHAs.  Possibly also the
>> commit
>> SHA, branch name, and pathname of each blob (or whatever is necessary
>> to let
>> the server address the reachability concerns).  Possibly also the last
>> known SHA for each blob to allow for deltafication in the packfile.
>
> Context (like the commit SHA-1) would help in reachability checks, but
> I'm not sure if we can rely on that. It is true that I can't think of a
> way that the client would dissociate a blob that is missing from its
> tree or commit (because it would first need to "fault-in" that blob to
> do its operation). But clients operating on non-contextual SHA-1s (e.g.
> "git cat-file") and servers manipulating commits (so that the commit
> SHA-1 that the client had in its context is no longer reachable) are not
> uncommon, I think.
>
> Having said that, it might be useful to include the context in the
> protocol anyway as an optional "hint".

That is what I was thinking. A hint of the branch or commit the
client is referencing (wants to checkout, for example).  Frankly,
I'm not sure how secure some of the proposed/existing reachability
constraints are, so I'm hedging here a bit.

>
> I'm not sure what you mean by "last known SHA for each blob".

What I meant was. If I'm missing the blob for a particular file
in the commit I want to checkout, but I have the blob for the
same file in a recent ancestor commit, I could send the SHA-1 of
the file in the parent commit. The server would be free to deltafy
the missing blob relative to it, rather than sending the entire
blob.

>
> (If we do store the file size of a blob somewhere, we could also store
> some context there. I'm not sure how useful this is, though.)
>
>> E. Unresolved Thoughts
>> ======================
>
> <snip>
>
>> *TODO* The partial clone arguments should be recorded in ".git/info/"
>> so that subsequent fetch commands can inherit them and
>> rev-list/index-pack
>> know to not complain by default.
>>
>> *TODO* Update GC like rev-list to not complain when there are missing
>> blobs.
>
> These 2 points would be part of "whether to fetch" above.

Thanks for all of the comments.
Jeff
