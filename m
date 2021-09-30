Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E61DC433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C2161A40
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbhI3UCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 16:02:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62058 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhI3UCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 16:02:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCD7DEBAF7;
        Thu, 30 Sep 2021 16:00:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8HWhp6y1a3nEeAWXnDit2k7TmwTY0iwZM9vDhk
        w9F58=; b=O89FMb/SH/xD3h0w2kVDQ7RbskMTGEnWNQKkRSUE5hiNMsmzdSh+C6
        f5XyqIIILWAdPJxNrrOaDw4NbXOLBL1He+PKvO3G6HoVWw4QvFpB0LQS/1kHWo/p
        nvQnGmWihoMMZLAAZOmFu0jJ2H9rNFTg4H1spPByGSUiV5jNQpVuU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4B4FEBAF6;
        Thu, 30 Sep 2021 16:00:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16531EBAF5;
        Thu, 30 Sep 2021 16:00:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
        <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
        <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
        <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
Date:   Thu, 30 Sep 2021 13:00:30 -0700
In-Reply-To: <YVVmssXlaFM6yD5W@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 30 Sep 2021 03:26:42 -0400")
Message-ID: <xmqqfstlbzq9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 114FFEB2-2229-11EC-898A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > If not, then I think the solution is probably not to install this as the
>> > "primary", but rather:
>> >
>> >   - do the specific remerge-diff writes we want using a special "write
>> >     to this object dir" variant of write_object_file()
>> >
>> >   - install the tmp_objdir as an alternate, so the reading side (which
>> >     is diff code that doesn't otherwise know about our remerge-diff
>> >     trickery) can find them
>> >
>> > And that lets other writers avoid writing into the temporary area
>> > accidentally.
>> 
>> ...
>
> The key thing here is in the first step, where remerge-diff is
> explicitly saying "I want to write to this temporary object-dir". But
> the textconv-cache code does not; it gets to write to the normal spot.
> So it avoids problem (1).
>
> You're right that it does not avoid problem (3) exactly. But triggering
> that would require some code not just writing other objects or
> references while the tmp-objdir is in place, but specifically
> referencing the objects that remerge-diff did put into the tmp-objdir.
> That seems a lot less likely to me (because the thing we're most worried
> about is unrelated code that just happens to write while the tmp-objdir
> is in place).

I do not offhand remember if a new object creation codepath that
avoids writing an object that we already have considers an object we
find in an alternate as "we have it".  If it does not and we make a
duplicated copy in our primary object store, then it would be OK,
but otherwise, those that know tmp_objdir is an alternate may still
try to write a new object and find that the same object already
exists in an alternate.  Once tmp_objdir is gone, we would end up
with a corrupt repository, right?

freshen_loose_object() seems to go to check_and_freshen() which
consult check_and_freshen_nonlocal() before returning yes/no, so
having the same object in an alternate does seem to count as having
one.

> So hopefully it's clearer now from what I wrote above, but just
> connecting the dots:
>
>   1. Unrelated code calling write_object_file() would still write real,
>      durable objects, as usual.
>
>   2. The write_object_file() "skip this write" optimization already
>      ignores the pretend_object_file() objects while checking "do we
>      have this object".

Yup for (2)---the pretend interface is safer than alternate in that
sense.

But the pretend interface was designed to just hold a handful of
phoney objects in core.  I am not sure if it is a good fit for this
use case.

> But this is all scary and error-prone enough that I'd prefer an approach
> that has the "least surprise". So any solution where random code calling
> write_object_file() _can't_ accidentally write to a throw-away directory
> seems like a safer less surprising thing.
>
> It does mean that the remerge-diff code needs to be explicit in its
> object writes to say "this needs to go to the temporary area" (whether
> it's a flag, or calling into a totally different function or subsystem).

... and also writes by others that happens to write the same object
as what is already in the temporary area should be made to the real
object store.  Then we would be much safer.

> I'm hoping that's not hard to do (because its writes are done explicitly
> by the remerge-diff code), but I worry that it may be (because you are
> relying on more generic tree code to the write under the hood).

Thanks.
