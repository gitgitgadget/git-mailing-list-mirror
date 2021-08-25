Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90E3C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 18:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B940F610A0
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 18:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbhHYSi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 14:38:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52969 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhHYSi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 14:38:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8E5A14178F;
        Wed, 25 Aug 2021 14:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=04b96yv1O58ENo5fyPkNJYj0CYoOuFmdO0hihT
        VlU/Q=; b=ySBlj3jsUqiNHFcmoniEjbvmLOui9gEGM+XoMhOEoffwewDYXeKzie
        pFDHQDSKIDnhyUSE1UoG0UNX+qnYj3DAaMSWKQXd3rthcmqvtIbGD1vgrEqTFbtZ
        BS9KJIw83hfNbllLAMvpG5nLvl+PdfDO2sO9Hdg6Ni8xLBjGOIyPY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B17B614178D;
        Wed, 25 Aug 2021 14:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06B5D14178C;
        Wed, 25 Aug 2021 14:37:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] fetch: skip formatting updated refs with `--quiet`
References: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
        <xmqqv93tif9g.fsf@gitster.g> <YSaF2h67u1WTz1b3@tanuki>
Date:   Wed, 25 Aug 2021 11:37:38 -0700
In-Reply-To: <YSaF2h67u1WTz1b3@tanuki> (Patrick Steinhardt's message of "Wed,
        25 Aug 2021 20:03:06 +0200")
Message-ID: <xmqqo89lid59.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86DBDE16-05D3-11EC-9329-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> Interesting.  This line
>> 
>> 	/* uptodate lines are only shown on high verbosity level */
>> 	if (!verbosity && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
>> 		return;
>> 
>> at the beginning of the adjust_refcol_width() function indeed does
>> not skip if verbosity is negative, so the comment is wrong---it is
>> not only computed on high verbosity level.  Why doesn't this patch
>> include a change like this then?
>> 
>> 	if (verbosity <= 0 || oideq(&ref->peer_ref->old_oid, &ref->old_oid))
>> 		return;
>
> This was indeed my first iteration. But if we just fix the condition
> like you do here, then we still iterate over all refs even though we
> know that we're not going to do anything with them. So my version just
> skips over the iteration completely.

I didn't ask "why isn't this patch the above change and nothing else?"

With or without the "don't bother counting columns under --quiet"
fix, the condition used in the above if statement is wrong.  With
the fix, only because the function is never called with negative
verbosity, "if (!verbosity)" means the same thing as "only shown on
high verbosity level", but the reader must have followed the flow of
logic to realize it.  If you fix the condition to exclude all
non-verbose cases (including --quiet), the readers do not have to do
so to realize that the code is doing what the comment claims that it
is doing.

>> Another thing I notice is this part from store_updated_refs():
>> 
>> 			if (note.len) {
>> 				if (verbosity >= 0 && !shown_url) {
>> 					fprintf(stderr, _("From %.*s\n"),
>> 							url_len, url);
>> 					shown_url = 1;
>> 				}
>> 				if (verbosity >= 0)
>> 					fprintf(stderr, " %s\n", note.buf);
>> 			}
>> 
>> We no longer need to check for verbosity, right?
>
> Right. It would be less obvious though that we indeed never print to the
> buffer if `verbosity < 0`, which is why I bailed on that refactoring.

I actually think that the resulting code will still be obvious, even
with the (apparently unrelated) URL display, and actually even be
better, if we drop the condition on verbosity from this code.  

The code that led to this part would have stuffed bytes in the note
strbuf only when we wanted to show something based on the verbosity
setting, and we show what is in note.len only when we have something
to say (the URL thing is to give the header for the message).
Decision to give what contents to show (or not to show at all) is
made elsewhere---it happens to involve verbosity and perhaps in the
future it may use some other input, but this part of the code does
not have to know.

Thanks.
