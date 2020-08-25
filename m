Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E62C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059C62075F
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BTC3ukLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHYP6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:58:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58567 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHYP6t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 11:58:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EDF1738E0;
        Tue, 25 Aug 2020 11:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PvBitCY1cqOVIo1vUR4mpWKydTk=; b=BTC3uk
        LTPh0mRRP8V5Xlup17F+Bx9wkQG94CgsmgC5Z1s8CHIjIMmtqnB/UVm/dWW6LaG9
        C5O36/XnOgtWtBThr66qiwkCGEOoffTPYjbnJKdp4YLLpXf+Gtxc+0VKqw40HbPl
        ulVYCKc2a1B/sgYVU02UAr+uf+KNTdPYQpxCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=um9z7uLpJ98ZbxHFf4nUXhnWGvpBwgpm
        va3eDlmxDe1F1B/vGYvuWYdpljqrsavA/OTNHGS+X6+cwLdb5Hw31khm29ojenzN
        D/EZ54+1LS+zGUBVQ2x3z4iDcbNl02o9ntjA2GqYcvJK4iyS6zyN+MqBNHAUEPdV
        rGDMP2Y9KLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66A5C738DF;
        Tue, 25 Aug 2020 11:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2A14738DD;
        Tue, 25 Aug 2020 11:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
        <20200825022614.GA1391422@coredump.intra.peff.net>
Date:   Tue, 25 Aug 2020 08:58:46 -0700
In-Reply-To: <20200825022614.GA1391422@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 24 Aug 2020 22:26:14 -0400")
Message-ID: <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBEA9C7E-E6EB-11EA-AB31-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Does "git repack" ever remove just one pack? Obviously "git repack -ad"
> or "git repack -Ad" is going to pack everything and delete the old
> packs. So I think we'd want to remove a midx there.

AFAIK, the pack-redundant subcommand is used by nobody in-tree, so
nobody is doing "there are three packfiles, but all the objects in
one of them are contained in the other two, so let's remove that
redundant one".

> And "git repack -d" I think of as deleting only loose objects that we
> just packed. But I guess it could also remove a pack that has now been
> made redundant? That seems like a rare case in practice, but I suppose
> is possible.

Meaning it can become reality?  Yes.  Or it already can happen?  I
doubt it.

> E.g., imagine we have a midx that points to packs A and B, and
> git-repack deletes B. By your logic above, we need to remove the midx
> because now it points to objects in B which aren't accessible. But by
> deleting it, could we be deleting the only thing that mentions the
> objects in A?
>
> I _think_ the answer is "no", because we never went all-in on midx and
> allowed deleting the matching .idx files for contained packs.

Yeah, it has been my assumption that that part of the design would
never change.

> I'm also a little curious how bad it is to have a midx whose pack has
> gone away. I guess we'd answer queries for "yes, we have this object"
> even if we don't, which is bad. Though in practice we'd only delete
> those packs if we have their objects elsewhere.

Hmph, object O used to be in pack A and pack B, midx points at the
copy in pack B but we deleted it because the pack is redundant.
Now, midx says O exists, but midx cannot be used to retrieve O.  We
need to ask A.idx about O to locate it.

That sounds brittle.  I am not sure our error fallback is all that
patient.


> And the pack code is
> pretty good about retrying other copies of objects that can't be
> accessed. Alternatively, I wonder if the midx-loading code ought to
> check that all of the constituent packs are available.
>
> In that line of thinking, do we even need to delete midx files if one of
> their packs goes away? The reading side probably ought to be able to
> handle that gracefully.

But at that point, is there even a point to have that midx file that
knows about objects (so it can answer has_object()? correctly and
quickly) but does not know the correct location of half of the objects?
Instead of going directly to A.idx to locate O, we need to go to midx
to learn the location of O in B (which no longer exists), and then
fall back to it, that is a pure overhead.

> And the more interesting case is when you repack everything with "-ad"
> or similar, at which point you shouldn't even need to look up what's in
> the midx to see if you deleted its packs. The point of your operation is
> to put it all-into-one, so you know the old midx should be discarded.

Old one, yes.  Do we need to have the new one in that case?

>> Teach 'git repack' to check for this by loading the MIDX, and checking
>> whether the to-be-removed pack is known to the MIDX. This requires a
>> slightly odd alternation to a test in t5319, which is explained with a
>> comment.
>
> My above musings aside, this seems like an obvious improvement.

Yes.

>> diff --git a/builtin/repack.c b/builtin/repack.c
>> index 04c5ceaf7e..98fac03946 100644
>> --- a/builtin/repack.c
>> +++ b/builtin/repack.c
>> @@ -133,7 +133,11 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
>>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
>>  {
>>  	struct strbuf buf = STRBUF_INIT;
>> -	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
>> +	struct multi_pack_index *m = get_multi_pack_index(the_repository);
>> +	strbuf_addf(&buf, "%s.pack", base_name);
>> +	if (m && midx_contains_pack(m, buf.buf))
>> +		clear_midx_file(the_repository);
>> +	strbuf_insertf(&buf, 0, "%s/", dir_name);
>
> Makes sense. midx_contains_pack() is a binary search, so we'll spend
> O(n log n) effort deleting the packs (I wondered if this might be
> accidentally quadratic over the number of packs).
>
> And after we clear, "m" will be NULL, so we'll do it at most once. Which
> is why you can get rid of the manual "midx_cleared" flag from the
> preimage.
>
> So the patch looks good to me.

Thanks.
