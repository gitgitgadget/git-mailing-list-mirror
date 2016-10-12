Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2952098A
	for <e@80x24.org>; Wed, 12 Oct 2016 16:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755340AbcJLQUv (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:20:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54326 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754923AbcJLQUt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:20:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E01744F0F;
        Wed, 12 Oct 2016 12:20:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iYFWA0DFcjmR0p6+BCoCHLsRYhE=; b=kDujTJ
        DAYNu3dEZWr7f+9KGvSYd9/z5kGE/i4cam4BPnzqiYnmGlkD4PqwqS4nCILWk+bK
        dS+h2wQmdTLuQcru77rqaCp5HA2qWAOkFbSjX44In/Q2Ns59+EH+In/rU7U1lna9
        Uow41b+w9a37Lt2KEF69C6U6qsfW69WGgIgNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i5wbr0c9kYiL/vNYoQAD8Xb0HdxIE6/g
        Nl//bMwik9qHoD+bdWOH1FrzYZ3qFM2Y/B3uiWxEB8ya40p2cJMVyei0O4jicIS0
        aiyQE2bKFlGUQH9c1U1gE8BqtDjf20YcXsThkbrBAmRWRzfunNO/zvC5SM8fIBjO
        YjQf4qVIjBc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45D5244F0E;
        Wed, 12 Oct 2016 12:20:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD6F944F0D;
        Wed, 12 Oct 2016 12:20:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
References: <20161011235951.8358-1-sbeller@google.com>
        <xmqqvawy5c4i.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZrNSmPAQ6SmBzFDJtSmdCbqKcgQu4KDLfoYVkSXvo-og@mail.gmail.com>
Date:   Wed, 12 Oct 2016 09:20:45 -0700
In-Reply-To: <CAGZ79kZrNSmPAQ6SmBzFDJtSmdCbqKcgQu4KDLfoYVkSXvo-og@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Oct 2016 23:51:56 -0700")
Message-ID: <xmqqfuo15yjm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D581D478-9097-11E6-9FDF-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I am not sure if the updates to the callers fulfill that purpose.
>> For example, look at this hunk.
>>
>>> @@ -111,6 +111,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>>>       struct archiver_args *args = c->args;
>>>       write_archive_entry_fn_t write_entry = c->write_entry;
>>>       static struct git_attr_check *check;
>>> +     static struct git_attr_result result;
>>
>> As we discussed, this caller, even when threaded, will always want
>> to ask for a fixed two attributes, so "check" being static and
>> shared across threads is perfectly fine.  But we do not want to see
>> "result" shared, do we?
> 
> Well all of the hunks in the patch are not threaded, so they
> don't follow a threading pattern, but the static pattern to not be
> more expensive than needed.

Is it too invasive a change to make them as if they are thread-ready
users of API that happen to know their callers are not threading?
It would be ideal if we can prepare them so that the way they
interact with the attr subsystem will not have to change after this
step.

>> In other words, ideally, I think this part of the patch should
>> rather read like this:
>>
>>         static struct git_attr_check *check;
>>         struct git_attr_result result[2];
>>
>>         ...
>>         git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
>>         if (!git_check_attr(path_without_prefix, check, result)) {
>>                 ... use result[0] and result[1] ...
>>
>> For sanity checking, it is OK to add ARRAY_SIZE(result) as the final
>> and extra parameter to git_check_attr() so that the function can
>> make sure it matches (or exceeds) check->nr.
>
> That seems tempting from a callers perspective; I'll look into that.

For callers that prepare "check" and "result" before asking
check-attr about the attributes in "check" for many paths, it is OK
to use your "allocate with attr_result_init()" pattern.  The "result"
still needs to be made non-static, though.

But many callers do not follow that; rather they do

	loop to iterate over paths {
		call a helper func to learn attr X for path
		use the value of attr X
	}

using a callchain that embeds a helper function deep inside, and
"check" is kept in the helper, check-attr function is called from
there, and "result" is not passed from the caller to the helper
(obviously, because it does not exist in the current API).  See the
callchain that leads down to convert.c::convert_attrs() for a
typical example.  When converted to the new API, it needs to have a
new "result" structure every time it is called, and cannot reuse the
one that was used in its previous call.
