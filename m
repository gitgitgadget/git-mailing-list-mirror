Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9F9202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 15:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbdJYPjC (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 11:39:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:15432 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751732AbdJYPjC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 11:39:02 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5E09384529;
        Wed, 25 Oct 2017 11:39:01 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E8D36844D1;
        Wed, 25 Oct 2017 11:39:00 -0400 (EDT)
Subject: Re: [PATCH 00/13] WIP Partial clone part 1: object filtering
To:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
 <xmqqmv4fizyn.fsf@gitster.mtv.corp.google.com>
 <CAGf8dg+cK3WpEqosgkbdcrDzrMXJxVYHiBZda6UM7k8Ggq=eBw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4ac6ffd8-60bd-d2bc-6bc1-6c5bb1473416@jeffhostetler.com>
Date:   Wed, 25 Oct 2017 11:39:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGf8dg+cK3WpEqosgkbdcrDzrMXJxVYHiBZda6UM7k8Ggq=eBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 2:46 AM, Jonathan Tan wrote:
> On Tue, Oct 24, 2017 at 10:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> OK, thanks for working well together.  So does this (1) build on
>> Jonathan's fsck-squelching series, or (2) ignores that and builds
>> filtering first, potentially leaving the codebase to a broken state
>> where it can create fsck-unclean repository until Jonathan's series
>> is rebased on top of this, or (3) something else?  [*1*]
> 
> Excluding the partialclone patch (patch 9), I think that the answer is
> (2), but I don't think that it leaves the codebase in a broken state.
> In particular, none of the code modifies the repo, so it can't create
> a fsck-unclean one.

My part 1 series starts with filtering, rev-list, and pack-objects.
So, yes, it add new features that no one will use yet.  But it is useful
by itself.  For example, you can use rev-list to ask for the set of
missing objects that you would need to do a checkout (assuming you had
commits and trees, but no blobs or no large blobs) *before* actually
starting the checkout.

I was then going to lay Jonathan's fsck/gc/dynamic object fetch
on top of that.  I started that here:
	https://github.com/jeffhostetler/git/pull/7

Patch 9 just adds the "extensions.partialclone*" fields and is prep
for my rev-list and his fsck changes.  I included it sooner rather than
later so I can test rev-list on a repo with hand-deleted blobs.
But yes, it can be omitted from this series and included with the fsck
changes.


> 
> Maybe one could say that this leaves the codebase with features that
> no one will ever use in the absence of partial clone, but I don't
> think that's true - rev-list with blob-size/sparse-specification
> filter seems independently useful, at least (for example, when
> desiring to operate on a repo in a sparse way without going through a
> workdir), and if we're planning to allow listing of objects, we
> probably should allow packing as well (especially since this doesn't
> add much code).
> 
> The above is relevant only if we can exclude the partialclone patch,
> but I think that we can and we should, as I wrote in my reply to Jeff
> Hostetler [1].
> 
> As for how this patch set (excluding the partialclone patch) interacts
> with my fsck series, they are relatively independent, as far as I can
> tell. I'll rebase my fsck, gc, and lazy object fetch patches (but not
> the fetch and clone parts, which we plan to instead adapt from Jeff
> Hostetler's patches, as far as I know) on top of these and resend
> those out once discussion on this has settled.

Yes, I want to get Jonathan's fsck/gc/lazy changes built into part 2.
They came over easily and are independent of how/why there are missing
objects.

For part 3, I'd like to take my version of clone, fetch, fetch-pack,
and upload-pack (that talks with the filters from part 1) and incorporate
Jonathan's promisor concepts.  That merge is a little messier, so I'd
like to parts 1 and 2 a chance to get some feedback first.


> [1] https://public-inbox.org/git/CAGf8dg+8AR=XfSV92ODAtKTNjBnD1+oVZp9rs4Y4Otz_eZyTfg@mail.gmail.com/
> 
>> I also saw a patch marked as "this is from Jonathan's earlier work",
>> taking the authorship (which to me implies that the changes were
>> extensive enough), so I am a bit at loss envisioning how this piece
>> fits in the bigger picture together with the other piece.
> 
> The patch you mentioned is the partialclone patch, which I think can
> be considered separately from the rest (as I said above).

A question of mailing-list etiquette: in patch 9, I took Jonathan's
ideas for adding the "extensions.partialclone" setting and extended it
with some helper functions.  His change was part of a larger change
with other code (fsck, IIRC) that I wasn't ready for.  What is the
preferred way to give credit for something like this?


Thanks
Jeff


