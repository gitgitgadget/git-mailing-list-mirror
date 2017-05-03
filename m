Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76CF1F829
	for <e@80x24.org>; Wed,  3 May 2017 16:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbdECQih (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 12:38:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:28985 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751796AbdECQig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 12:38:36 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A84D4844E0;
        Wed,  3 May 2017 12:38:34 -0400 (EDT)
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
To:     git@vger.kernel.org
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com, jonathantanmy@google.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com>
Date:   Wed, 3 May 2017 12:38:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/8/2017 1:50 PM, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
>
> [RFC] Partial Clone and Fetch
> =============================
> [...]
> E. Unresolved Thoughts
> ======================
>
> *TODO* The server should optionally return (in a side-band?) a list
> of the blobs that it omitted from the packfile (and possibly the sizes
> or sha1_object_info() data for them) during the fetch-pack/upload-pack
> operation.  This would allow the client to distinguish from invalid
> SHAs and missing ones.  Size information would allow the client to
> maybe choose between various servers.

Since I first posted this, Jonathan Tan has started a related
discussion on missing blob support.
https://public-inbox.org/git/CAGf8dgK05+f4uX-8+iMFvQd0n2JP6YxJ18ag8uDaEH6qc6SgVQ@mail.gmail.com/T/

I want to respond to both of these threads here.
-------------------------------------------------

Missing-Blob Support
====================

Let me offer up an alternative idea for representing
missing blobs.  This is differs from both of our previous
proposals.  (I don't have any code for this new proposal,
I just want to think out loud a bit and see if this is a
direction worth pursuing -- or a complete non-starter.)

Both proposals talk about detecting and adapting to a missing
blob and ways to recover -- when we fail to find a blob.
Comments on the thread asked about:
() being able to detect missing blobs vs corrupt repos
() being unable to detect duplicate blobs
() expense of blob search.

Suppose we store "positive" information about missing blobs?
This would let us know that a blob is intentionally missing
and possibly some meta-data about it.


1. Suppose we update the .pack file format slightly.
    () We use the 5 value in "enum object_type" to mean a
       "missing-blob".
    () We update git-pack-object as I did in my RFC, but have it
       create type 5 entries for the blobs that are omitted,
       rather than nothing.
    () Hopefully, the same logic that currently keeps pack-object
       from sending unnecessary blobs on subsequent fetches can
       also be used to keep it from sending unnecessary missing-blob
       entries.
    () The type 5 missing-blob entry would contain the SHA-1 of the
       blob and some meta-data to be explained later.

2. Make a similar change in the .idx format and git-index-pack
    to include them there.  Then blob lookup operations could
    definitively determine that a blob exists and is just not
    present locally.

3. With this, packfile-based blob-lookup operations can get a
    "missing-blob" result.
    () It should be possible to short-cut searching in other
       packfiles (because we don't have to assume that the blob
       was just misplaced in another packfile).
    () Lookup can still look for the corresponding loose blob
       (in case a previous lookup already "faulted it in").

4. We can then think about dynamically fetching it.
    () Several techniques for this are currently being
       discussed on the mailing list in other threads,
       so I won't go into this here.
    () There has also been debate about whether this should
       yield a loose blob or a new packfile.  I think both
       forms have merit and depend on whether we are limited
       to asking for a single blob or can make a batch request.
    () A dynamically-fetched loose blob is placed in the normal
       loose blob directory hierarchy so that subsequent
       lookups can find it as mentioned above.
    () A dynamically-fetched packfile (with one or more blobs)
       is written to the ODB and then the lookup operation
       completes.
       {} I want to isolate these packfiles from the main
          packfiles, so that they behave like a second-stage
          lookup and don't affect the caching/LRU nature of
          the existing first-stage packfile lookup.
       {} I also don't want the ambiguity of having 2 primary
          packfiles with a blob marked as missing in 1 and
          present in the other.

5. git-repack should be updated to "do the right thing" and
    squash missing-blob entries.

6. And etc.


Missing-Blob Entry Data
=======================

A missing-blob entry needs to contain the SHA-1 value of
the blob (obviously).  Other fields are nice to have, but
are not necessary.  Here are a few fields to consider.

A. The SHA-1 (20 bytes)

B. The raw size of the blob (5? bytes).
    () This is the cleaned size of the file as stored.  The
       server does not (and should not) have any knowledge
       of the smudging that may happen.
    () This may be useful if whatever dynamic-fetch-hook
       wants to customize its behavior, such as individually
       fetching large blobs and batch fetching smaller ones
       from the same server.
    () GVFS found it necessary to create a custom server
       end-point to get blob size data so that "ls -l"
       could show file sizes for non-present virtualized
       files.
    () 5 bytes (uint:40) should be more than enough for this.

C. A server "hint" (20 bytes)
    () Instructions to help the client fetch the blob.
    () If I have multiple remotes configured, a missing-blob
       should be fetched from the same server that created
       the missing-blob entry (since it may be the only
       one that has it).
    () If a blob is very large (and was omitted for this
       reason), the server may want to redirect the client
       to a geographically closer CDN.
    () This is the SHA-1 of a file in the repository of a
       hook (or a set of parameters to be used by a hook).
       {} This is a bit of *hand-wave* right now, but the
          idea is that you can use the information here to
          individually fetch a blob or batch fetch a set
          of blobs that have the same hint.
       {} Yes, there are security concerns here, so perhaps
          the hint file should just contain parameters for
          a stock git-fetch-pack or git-fetch-blob-pack or
          curl command (or wrapper script) that "does the
          right thing".
       {} I thought this would be more compact than listing
          detailed fetch data per-blob.  And we don't have
          to define yet another syntax.  For example, we can
          let the SHA-1 point to an administrator configured
          shell script and be done.
    () We assume that the SHA-1 file is present locally
       (not missing).  This might refer to a pinned file
       in a special ".git*" file (that we never omit) in
       HEAD.  Or it might be in a branch that all clients
       are assumed to have.


Concluding Thoughts
===================

Combining the ideas here with the partial clone/fetch
parameters and the various blob back-filling proposals
gives us the ability to create and work with sparse
repos.
() Filtering can be based upon blob size; this could be
    seen as an alternative solution to LFS for repos with
    large objects.
() Filtering could also be based upon pathnames (such as
    a sparse-checkout filter) and greatly help performance
    on very large repos where developers only work with
    small areas of the tree.

Thanks
Jeff







