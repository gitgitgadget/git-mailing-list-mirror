Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6870202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 17:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbdGLR3O (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 13:29:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:15919 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753913AbdGLR3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 13:29:13 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 26A3F8457E;
        Wed, 12 Jul 2017 13:29:12 -0400 (EDT)
Received: from [10.160.98.76] (unknown [167.220.148.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E2C3084579;
        Wed, 12 Jul 2017 13:29:11 -0400 (EDT)
Subject: Re: [RFC PATCH 1/3] promised-blob, fsck: introduce promised blobs
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1499800530.git.jonathantanmy@google.com>
 <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <890a36fc-be16-83bc-fec6-94e21d0f7d0a@jeffhostetler.com>
Date:   Wed, 12 Jul 2017 13:29:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/11/2017 3:48 PM, Jonathan Tan wrote:
> Currently, Git does not support repos with very large numbers of blobs
> or repos that wish to minimize manipulation of certain blobs (for
> example, because they are very large) very well, even if the user
> operates mostly on part of the repo, because Git is designed on the
> assumption that every blob referenced by a tree object is available
> somewhere in the repo storage.
> 
> As a first step to reducing this problem, introduce the concept of
> promised blobs. Each Git repo can contain a list of promised blobs and
> their sizes at $GIT_DIR/objects/promisedblob. This patch contains
> functions to query them; functions for creating and modifying that file
> will be introduced in later patches.


As part of my on-going effort on partial/narrow clone/fetch I've also
looked at how to represent the set of omitted objects and whether or
not we should even try.

My primary concern is scale and managing the list of objects over time.

My fear is that this list will be quite large.  If we only want to omit
the very large blobs, then maybe not.  But if we want to expand that
scope to also omit other objects (such as a clone synchronized with a
sparse checkout), then that list will get large on large repos.  For
example, on the Windows repo we have (conservatively) 100M+ blobs (and
growing).  Assuming 28 bytes per, gives a 2.8GB list to be manipulated.

If I understand your proposal, newly-omitted blobs would need to be
merged into the promised-blob list after each fetch.  The fetch itself
may not have that many new entries, but inserting them into the existing
list will be slow.  Also, mmap'ing and bsearch'ing will likely have
issues.  And there's likely to be a very expensive step to remove
entries from the list as new blobs are received (or locally created).

In such a "sparse clone", it would be nice to omit unneeded tree objects
in addition to just blobs.   I say that because we are finding with GVFS
on the Windows repo, that even with commits-and-trees-only filtering,
the number of tree objects is overwhelming.  So I'm also concerned about
limiting the list to just blobs.  If we need to have this list, it
should be able to contain any object.  (Suggesting having an object type
in the entry.)

I assume that we'll also need a promised-blob.lock file to control
access during list manipulation.  This is already a sore spot with the
index; I'd hate to create another one.

I also have to wonder about the need to have a complete list of omitted
blobs up front.  It may be better to just relax the consistency checks
and assume a missing blob is "intentionally missing" rather than
indicating a corruption somewhere.  And then let the client do a later
round-trip to either demand-load the object -or- demand-load the
existence/size info if/when it really matters.

Maybe we should add a verb to your new fetch-blob endpoint to just get
the size of one or more objects to help with this.

Thanks,
Jeff

