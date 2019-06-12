Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E271F462
	for <e@80x24.org>; Wed, 12 Jun 2019 16:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408048AbfFLQVj (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 12:21:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61293 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407889AbfFLQVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 12:21:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7FBC151778;
        Wed, 12 Jun 2019 12:21:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sD3VjOH3vHhx
        PrYUguQ2o415cHA=; b=Br7pJYKdm283GnYLBnGTT0idWWxcI/ix3CY58e2B/0cX
        C2SxmmbG8bERV1eEsCbuthrxD+KrdsV5CMlEasuw2E8+7PZX9eLFIah62x+MbCCw
        iasHdwG7iigskTfXAJ1QH0GeWiYCnuHDyD0KCX23w19zw5s/5qdVrpI9PQvok9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y+igTS
        BOOww/ffU0DIQMI4M7ssHEd1i7HxK/ygiZIzzmQmLveptQVlNw+y4F5iUhbQOXfn
        ebe8deJ+d82lvOTO9o1VgMDxTBv7iTAK2w1BjcTOHK0eqNas45tR4/NV+iTn5FD7
        w7QAzxsR9HKrgiwqci7SDx5VQkvUjuzWG90Xo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE6FB151777;
        Wed, 12 Jun 2019 12:21:35 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AC9D151776;
        Wed, 12 Jun 2019 12:21:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
References: <20190430142556.20921-1-szeder.dev@gmail.com>
        <20190611130320.18499-1-szeder.dev@gmail.com>
        <20190611130320.18499-4-szeder.dev@gmail.com>
        <xmqqy327kfw1.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 12 Jun 2019 09:21:34 -0700
In-Reply-To: <xmqqy327kfw1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Jun 2019 13:48:14 -0700")
Message-ID: <xmqqimtakc4x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25A723F0-8D2E-11E9-8CD7-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> Make sure that the previously displayed "Rebasing (N/M)" line is
>> cleared by using the term_clear_line() helper function added in the
>> previous patch.
>>
>> A couple of other rebase commands print similar messages, e.g.
>> "Stopped at <abbrev-oid>... <subject>" for the 'edit' or 'break'
>> commands, or the "Successfully rebased and updated <full-ref>." at the
>> very end.  These are so long that they practically always overwrite
>> that "Rebasing (n/m)" progress line, but let's be prudent, and clear
>> the last line before printing these, too.
>> ...
>> Note that this patch doesn't completely eliminate the possibility of
>> similar garbled outputs, ...
>> too soon, and it would either flicker or be invisible.
>
> The user of term_clear_line() in this patch always guard themselves
> behind "we do not do this if we are producing verbose output," but
> the proposed log message does not explain why they need to do so.
>
> Is it because it is so obvious to potential readers?

Answering myself, it is due to this part in sequencer.c:

   3721                                 if (!opts->quiet)
   3722                                         fprintf(stderr, "Rebasing=
 (%d/%d)%s",
   3723                                                 todo_list->done_n=
r,
   3724                                                 todo_list->total_=
nr,
   3725                                                 opts->verbose ? "=
\n" : "\r");

That is, under 'verbose' mode, we do not try to reuse a single line
to show different steps of rebase in the progress output, but
consume one line per one step, so it would not be necessary to erase
what is previously written on the line.

I do not think it is so obvious, though.
