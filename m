Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA251C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C1D23107
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406264AbhALTUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:20:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57237 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404314AbhALTUd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 14:20:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAAD79C95B;
        Tue, 12 Jan 2021 14:19:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x4qfjbDq/CaIhBNGZhrOR7KDv5Y=; b=Js0Nku
        W7mfkFrCyedZQXnMP63babWybWIXw7W1DJv1GqBTXOEab4bqvdSVqVg0JO77fsHT
        bY+doUF/uDS6ZPIu+uGXBO96RdojhtIuf+3ELY6QNTYcBSf8rWNHe9IiA72PuY/N
        8ghUnbOZB9K8sj9QTWksFUHDSFqtHYyMUnG6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dW8OTof3nJS2g+S6UCOK/U8exKgVJFcV
        HvOJEiBHd4n1+BZDJQconwYQAFTsZxvlZF1bipUTcOIvM3opd9HbpQPc7HMWZJOc
        NMA8S06RwP4mX4cq/VeOkpbQYXAm0D35t0t/eZyvpLqKsO+6NyWwBxNODK9EJj1R
        aDarAjSzbFQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B20E39C95A;
        Tue, 12 Jan 2021 14:19:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36C379C959;
        Tue, 12 Jan 2021 14:19:50 -0500 (EST)
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
        <xmqq5z438ddv.fsf@gitster.c.googlers.com> <X/2UkKS0AhT6jLXj@ncase>
Date:   Tue, 12 Jan 2021 11:19:49 -0800
In-Reply-To: <X/2UkKS0AhT6jLXj@ncase> (Patrick Steinhardt's message of "Tue,
        12 Jan 2021 13:22:40 +0100")
Message-ID: <xmqqturm3qui.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2407CFE4-550B-11EB-AFD3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> 
>> > > +		fprintf(fetch_head->fp, "%s\t%s\t%s",
>> > > +			old_oid, merge_status_marker, note);
>> > > +		for (i = 0; i < url_len; ++i)
>> > > +			if ('\n' == url[i])
>> > > +				fputs("\\n", fetch_head->fp);
>> > > +			else
>> > > +				fputc(url[i], fetch_head->fp);
>> > > +		fputc('\n', fetch_head->fp);
>> 
>> ... these stdio operations for a single record would result in a
>> single atomic write() that would not compete with writes by other
>> processes.  So I wouldn't call "the current design allows ... at the
>> same time."  It has been broken for years and nobody complained.
>
> Fair enough. I somehow blindly assumed that `git fetch --all`, which
> does invoke `git fetch --append`, did perform the fetch in parallel. If
> that's not the case: all the better.

The "--all" option started as "one after another, one at a time",
but these days goes thru fetch_multiple() where we started to use
run_processes_parallel() API without giving it much thought what it
would do to the writing of FETCH_HEAD; since around d54dea77 (fetch:
let --jobs=<n> parallelize --multiple, too, 2019-10-05), this
codepath wrt FETCH_HEAD is utterly broken, I would have to say.

> The buffering of a single line is exactly what we're doing now in the
> non-atomic case. Previously there had been multiple writes, now we only
> call `strbuf_write()` once on the buffer for each reference.

Exactly.
