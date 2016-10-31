Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6924B2021E
	for <e@80x24.org>; Mon, 31 Oct 2016 21:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S946994AbcJaVQM (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 17:16:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60706 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S946962AbcJaVQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 17:16:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA9004B1C3;
        Mon, 31 Oct 2016 17:16:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=UDeoIyJP+R1JTe1QCVTQ75P7TPg=; b=QxHt8A1z0V+6TjsQxsP1
        sX6+oJB+CXNZmHaj+MS3PmZivFNw3WFSTU8ZNs1z4HkXl8R+syuwJwqyryK4xxka
        bVjc/tECVeBk28AgucY65hps/Ih9AYzg+bzPAv3Eq9ivJNW3wOSqulNHG8RCOjC9
        8vjiI+TPmdZHl5yC93iv++k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=B+0EC3iTDTt+9+JKWZK22UZu0SGSw1wbXUZtAA4uQ9jOaa
        lXpdXpUxRh4dIqeNGqupy8r5nWXWWwf8ctxxp214mN8rT1Lp1JlZTXTTTF9IUnTq
        dTuCAiYlZMRzyKK+uzBDtHMbb+/oz6VkfnCGT+DeyFckQLvgd4qQP8QA9SXZQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2B284B1C2;
        Mon, 31 Oct 2016 17:16:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41A1E4B1BF;
        Mon, 31 Oct 2016 17:16:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] trailer: avoid unnecessary splitting on lines
References: <cover.1477698917.git.jonathantanmy@google.com>
        <db609e13740415ac4e5e357493661347b0f681f7.1477698917.git.jonathantanmy@google.com>
        <CAP8UFD3o89EzQLLsMtLWxBhKCG4RmbG6u+UrLwzyAAEyezv1cA@mail.gmail.com>
Date:   Mon, 31 Oct 2016 14:16:08 -0700
Message-ID: <xmqqd1igrzhj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EC91B8C-9FAF-11E6-889E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Oct 29, 2016 at 2:05 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>> trailer.c currently splits lines while processing a buffer (and also
>> rejoins lines when needing to invoke ignore_non_trailer).
>>
>> Avoid such line splitting, except when generating the strings
>> corresponding to trailers (for ease of use by clients - a subsequent
>> patch will allow other components to obtain the layout of a trailer
>> block in a buffer, including the trailers themselves). The main purpose
>> of this is to make it easy to return pointers into the original buffer
>> (for a subsequent patch), but this also significantly reduces the number
>> of memory allocations required.
>>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>>  trailer.c | 215 +++++++++++++++++++++++++++++++++-----------------------------
>>  1 file changed, 116 insertions(+), 99 deletions(-)
>
> IMHO it is telling that this needs 17 more lines.

Given that among which 13 are additional comments to explain what is
going on, I think this is a surprisingly good outcome, relative to
what the patch achieves (reducing a lot of split/rejoin operations
and need for allocation associated with them that are all made
unnecessary).

I agree with you that it is telling to see that this needs only 17
more lines (or 4, if you only count the true code additions) and
clearly shows that strbuf_split() helper function was a not good
match for the codepath touched by this patch.  The helper function
is very tempting in that with a simple single call it will give us
tons of strbufs in an array, each of which are _MUCH_ more flexible
than simple strings if we ever need to manipulate them by trimming,
splicing and inserting etc.  This patch shows us that if we do not
need the flexibility, doing strbuf_split() as the first thing on the
input and having to deal with an array of strbuf is an overall loss,
I would think.

Although I admit that I carefully read only up to [2/4] I am fairly
happy with this series.  It finally fixes the second of the two
issues I pointed out in the review of the original series (the other
one was fixed in the series that this topic depends on), paying down
technical debt.

>> @@ -954,7 +971,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
>>  {
>>         LIST_HEAD(head);
>>         LIST_HEAD(arg_head);
>> -       struct strbuf **lines;
>> +       struct strbuf sb = STRBUF_INIT;
>
> We often use "sb" as the name of strbuf variables, but I think at
> least here (and maybe in other places above) we could use something a
> bit more telling, like "input_buf" perhaps.

That sounds sensible.

>
>>         int trailer_end;
>>         FILE *outfile = stdout;
>>
