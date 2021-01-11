Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E7EC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54C322BEF
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbhAKTry (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 14:47:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51150 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbhAKTrx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 14:47:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D80AA92F73;
        Mon, 11 Jan 2021 14:47:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+gdBsUSy9wIE06xpzOGqRsNnijg=; b=AWF5Rs
        HaRBwR47EMdsnB1zRQLZVDIeRhK5YGrxWpqu/Q7U70IX8mZtp1Ri5R35HN29rynU
        tPwv+z4ehN+h9TQ1/+6eFvC0qxVWmcKGOqdYlezGLqY5KDJy/OhDahaAAlri5GGI
        Nvq7WM986BA3zNev8eZP5P4C3YN8wStR0Kc5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vpVpyeJDuS3HZ4Dh1Ru/67RycqIg39f1
        pQu178u/6dDxMxKUDcrP58kHY/AncV3xRtZ5k8OIaib8j0vniwnnAheYAGC3hZ0P
        w7Ln/F3RFv/0Q+VvRbxNpxKgErcUVZong1C51HzR3TN6A2E+Hl8gJImepEp1xsbP
        bc0ET4XyOHI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF76792F71;
        Mon, 11 Jan 2021 14:47:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 525A792F70;
        Mon, 11 Jan 2021 14:47:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] fetch: implement support for atomic reference
 updates
References: <cover.1610027375.git.ps@pks.im> <cover.1610107599.git.ps@pks.im>
        <53705281b60285837905137f45fc8607012d2f19.1610107599.git.ps@pks.im>
        <xmqq7dongeji.fsf@gitster.c.googlers.com> <X/wrgYYcZfYZj+4/@ncase>
Date:   Mon, 11 Jan 2021 11:47:08 -0800
In-Reply-To: <X/wrgYYcZfYZj+4/@ncase> (Patrick Steinhardt's message of "Mon,
        11 Jan 2021 11:42:09 +0100")
Message-ID: <xmqq5z438ddv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA9ADCFA-5445-11EB-82D9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> It would be much more preferrable to see this series go like so:
>> 
>>     [1/4] create append_fetch_head() that writes out to
>>           fetch_head->fp
>> 
>>     [1.5/4] convert append_fetch_head() to ALWAYS accumulate in
>>             fetch_head->buf, and ALWAYS flushes what is accumulated
>>             at the end.
>
> This is a change I'm hesitant to make. The thing is that FETCH_HEAD is
> quite weird as the current design allows different `git fetch --append`
> processes to write to FETCH_HEAD at the same time.

Hmph, do you mean 

	git fetch --append remote-a & git fetch --append remote-b

or something else [*1*]?

With the current write-out codepath, there is no guarantee that ...

> > +		fprintf(fetch_head->fp, "%s\t%s\t%s",
> > +			old_oid, merge_status_marker, note);
> > +		for (i = 0; i < url_len; ++i)
> > +			if ('\n' == url[i])
> > +				fputs("\\n", fetch_head->fp);
> > +			else
> > +				fputc(url[i], fetch_head->fp);
> > +		fputc('\n', fetch_head->fp);

... these stdio operations for a single record would result in a
single atomic write() that would not compete with writes by other
processes.  So I wouldn't call "the current design allows ... at the
same time."  It has been broken for years and nobody complained.

> If we change to
> always accumulate first and flush once we're done, then we essentially
> have a change in behaviour as FETCH_HEADs aren't written in an
> interleaving fashion anymore, but only at the end.

I view it a good thing, actually, for another reason [*2*], but that
would take a follow-up fix that is much more involved, so let's not
go there (yet).  At least buffering a single line's worth of output
in a buffer and writing it out in a single write() would get us much
closer to solving the "mixed up output" from multiple processes
problem the current code seems to already have.

> Also, if there is any
> unexpected error in between updating references which causes us to die,
> then we wouldn't have written the already updated references to
> FETCH_HEAD now.

That one may be a valid concern.

Thanks.


[Footnote]

*1* "git fetch --all/--multiple" was strictly serial operation to
    avoid such a mixed-up output problem, but perhaps we weren't
    careful enough when we introduced parallel fetch and broke it?

*2* When fetching from a single remote, the code makes sure that a
    record that is not marked as 'not-for-merge' is listed first by
    reordering the records, but it does not work well when fetching
    from multiple remotes.  Queuing all in the buffer before showing
    them would give us an opportunity to sort, but as I said, it
    takes coordination among the processes---instead of each process
    writing to FETCH_HEAD on their own, somebody has to collect the
    records from them, reorder as needed and write them all out.

    cf. https://lore.kernel.org/git/X8oL190Vl03B0cQ%2F@coredump.intra.peff.net/

    
