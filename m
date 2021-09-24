Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE0C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDB66103D
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348234AbhIXT4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:56:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57038 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344832AbhIXT4s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 15:56:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81B5816767D;
        Fri, 24 Sep 2021 15:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Bm9Ce+9CKn0XXBXhhrp1zqboQbO8OQvhRN6P0
        ufx34=; b=M5G9VSytQYTHpHYhgOvHiO4yJsPBl7aXflQmZL6HmK6Mb2jLET3uMw
        AeUUulUK4Sx6SMIDcJNJ3LbxRSjcixfDKQESXnKONp85QKb2gsq465TtuhasifRU
        LI8AXyyhTIL3zhWvqrrmsiDxtyEBuC3GH5ieFPV5KmB3Mo4S5dHbc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79C5A16767C;
        Fri, 24 Sep 2021 15:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D735616767B;
        Fri, 24 Sep 2021 15:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/9] refs: make _advance() check struct repo, not flag
References: <xmqq1r5g3y2j.fsf@gitster.g>
        <20210924175651.2918488-1-jonathantanmy@google.com>
Date:   Fri, 24 Sep 2021 12:55:10 -0700
In-Reply-To: <20210924175651.2918488-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 24 Sep 2021 10:56:51 -0700")
Message-ID: <xmqqsfxtsq8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53F8A262-1D71-11EC-81EB-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> It is a bit surprising that ref_iterator does not know which
>> repository it is working in (regardless of "include broken" bit).
>> Do you think it will stay that way?  I have this nagging feeling
>> that it won't, and having "struct repository *repository" pointer
>> that always points at the repository the ref-store belongs to in a
>> ref_iterator instance would become necessary in the longer run.
>
> I think it's better if it stays that way, so that callers that don't
> want to access the ODB (all the callers that currently use
> DO_FOR_EACH_INCLUDE_BROKEN) can be assured that the iterator won't do
> that. If we had a non-NULL "struct repository *repository" parameter, a
> future code change might inadvertently use it, thus causing a bug.

Hmph, I am unlikely to be the one who is doing such a future code
change, but anybody who equates having a pointer to the repository
structure and the need to always validate the tips of refs with the
object store associated to the repository would be poor future
developers we wouldn't want their hands on our codebase.

An in-core repository has a lot more than the object store.

Besides, if we really want to have choice between "do check them"
and "ignore broken" expressed cleanly in the code, it would be much
better to be explicit about it, and a member in the context struct
whose name is ".repo" is not it[*].  A reader would say "ok, I see a
repo.  What is that thing for?  Can I reliably use it to figure out
other things about the repository this reference enumeration is
going on from it?  Ah, no, it sometimes is NULL---what crazy thing
is going on here???".

	Side note.  If it were called
	.check_ref_tips_against_the_object_store_of_this_repository,
	it would be a different story.

>> In which case, this .repo member this patch adds would become a big
>> problem, no?  If we were to validate objects at the tip of the refs
>> against object store, we will always use the object store that
>> belongs to the iterator->repository, so the only valid states for
>> iterator->repo are either NULL or iterator->repository.  That again
>> is the same problem I pointed out already about the parameter the
>> do_for_each_repo_ref() helper that is inviting future bugs, it seems
>> to me.  Wouldn't it make more sense to add
>> 
>>  * iterator->repository that points at the repository in which we
>>    are iterating the refs
>> 
>>  * a bit in iterator that chooses between "do not bother checking"
>>    and "do check the tip of refs against the object store of
>>    iterator->repository
>> 
>> to avoid such a mess?  Perhaps we already have such a bit in the
>> flags word in the ref_iterator but I didn't check.
>
> If we need iterator->repository, then I agree with you. The bit could
> then be DO_FOR_EACH_INCLUDE_BROKEN (which currently exists, and which I
> am removing in this patch, but if we think we should keep it, then we
> should keep it).

I do not care too much about the bit itself.  I have huge trouble
with the idea that representing a single bit with an entire pointer
to a repository, which can cause confusion down the line.  Those who
want to have an access to the repository does not have a reliable
way to get to it, those who do set it can mistakenly set to point at
an unrelated repository.

> Having said all that, it may be better to have a non-NULL repository
> reference in the iterator and retain DO_FOR_EACH_INCLUDE_BROKEN - at the

Yes.

> very least, this is a more gradual change and still leaves open the
> possibility of turning the repository reference into a nullable one.
> Callers that use DO_FOR_EACH_INCLUDE_BROKEN will have to deal with an
> API that is unclear about what is being done with the repository object
> being passed in, but that is the same as the status quo. I'll try it and
> see how it goes (it will probably simplify patch 2 too).

I do not think a structure member of type "struct repository" that
signals anything but "we are not operating in a repository" by being
NULL is a sane interface, so I do not see any positive value in
leaving opent he possibility at all.  The next person who would want
to _optionally_ use a repository for some other purpose (other than
"checking the validity of the object name") may be tempted to add
another member .repo2 next to your .repo---and that would be insane,
given that ref iterator will be iterating over a ref store of a
single repo at any given time.  It is much saner to have a single
"this is the repository the refstore we are iterating over is
attached to" instance, with separate bits "please do validate" and
"do whatever check the second develoepr wanted to signal the need
for with the .repo2 member".

Thanks.
