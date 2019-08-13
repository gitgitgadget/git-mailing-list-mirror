Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDBC1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 17:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHMRG5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 13:06:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53888 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfHMRG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 13:06:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5CEC17008F;
        Tue, 13 Aug 2019 13:06:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LOcVisGD40dqLB4+4f3W2ZfuQo4=; b=OaxpOC
        oIxrPXXRKU4QQjFRNmB2jSXtNLD7qhVkJE99bkCXDD4UoLByVcFFciW3gksT2DSR
        5xxAFaRdMf1un1qjzqTrdqUik/IXlWFVkvrFOuQrDTzkZOBVexGVjb6aJIfbED+n
        ceIoP+tmFX0bIN3TrA6e6KWigyAXCDJE5CXQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H4xuCnHP1WTMN35Z/3KP03cEWZMj+L8C
        gWWo02CVAsEedcOY/gnd8I6PMIB0sDkz6S4Ji8NySt19AulY/ZKZdS8/sWbSt28v
        +UdT8KgiK825yWT7YcErBzLMog9AsDp8KyHrR6noL3xncYNKkib4XbPbG8efM2vL
        wjpyKuwu89w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE01417008D;
        Tue, 13 Aug 2019 13:06:54 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AC1F17008C;
        Tue, 13 Aug 2019 13:06:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 3/6] rebase -i: support --committer-date-is-author-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-4-rohit.ashiwal265@gmail.com>
        <7274e753-f75c-ad9a-9c2c-7ba8abc32971@gmail.com>
Date:   Tue, 13 Aug 2019 10:06:53 -0700
In-Reply-To: <7274e753-f75c-ad9a-9c2c-7ba8abc32971@gmail.com> (Phillip Wood's
        message of "Tue, 13 Aug 2019 11:38:57 +0100")
Message-ID: <xmqqsgq5805u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFEA7446-BDEC-11E9-99AF-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   +	if (opts->committer_date_is_author_date) {
>> +		size_t len;
>> +		int res = -1;
>> +		struct strbuf datebuf = STRBUF_INIT;
>> +		char *date = read_author_date_or_null();
>
> You must always check the return value of functions that might return
> NULL. In this case we should return an error as you do in try_to
> _commit() later
>
>> +
>> +		strbuf_addf(&datebuf, "@%s", date);
>
> GNU printf() will add something like '(null)' to the buffer if you
> pass a NULL pointer so I don't think we can be sure that this will not
> increase the length of the buffer if date is NULL.

And an implementation that is not as lenient may outright segfault.

>>   +	if (opts->committer_date_is_author_date) {
>> +		int len = strlen(author);
>> +		struct ident_split ident;
>> +		struct strbuf date = STRBUF_INIT;
>> +
>> +		split_ident_line(&ident, author, len);
>> +
>> +		if (!ident.date_begin)
>> +			return error(_("corrupted author without date information"));
>
> We return an error if we cannot get the date - this is exactly what we
> should be doing above. It is also great to see a single version of
> this being used whether or not we are amending.
>
>> +
>> +		strbuf_addf(&date, "@%s",ident.date_begin);
>
> I think we should use %s.* and ident.date_end to be sure we getting
> what we want. Your version is OK if the author is formatted correctly
> but I'm uneasy about relying on that when we can get the verified end
> from ident.

If the author line is not formatted correctly, split_ident_line()
would notice and return NULL in these fields, I think (in other
words, my take on the call to split_ident_line() above is not
necessarily done in order to "split", but primarily to validate that
the line is formatted correctly---and find the beginning of the
timestamp field).

But your "pay attention to date_end" raises an interesting point.

The string that follows ident.date_begin would be a large integer
(i.e. number of seconds since epoch), a SP, a positive or negative
sign (i.e. east or west of GMT), 4 digits (i.e. timezone offset), so
if you want to leave something like "@1544328981" in the buffer, you
need to stop at .date_end to omit the timezone information.

On the other hand, if you do want the timezone information as well
(which I think is the case for this codepath), you should not stop
at there and have something like "@1544328981 +0900", the code as
written would give better result.
