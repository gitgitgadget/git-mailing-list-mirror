Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B531F87F
	for <e@80x24.org>; Thu, 13 Jun 2019 19:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfFMT5a (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 15:57:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61867 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFMT5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 15:57:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F85C15AB43;
        Thu, 13 Jun 2019 15:57:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SDg93N52pCQWs9Em7ifwy6BySes=; b=fTmc/H
        laIuH8W9asJK0/zqeogw4rk1/MTwygcyj+M9AdDcsuH3zhV+do+YGsmetmNNLiFY
        zqInku8iU13vwlNqIpH/S5vcP7F2fk+dSotFfvGkdhH6QBa7AEdsME06rFy2rU2N
        AXWViWt5ayNFH+mn5utZfWFybvSTPeQulKp7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X385C3BSxv8RE2V9oUrPyuRXp+R74gRJ
        vmtbDLy98EkI2e9X67Xgdblk/2tFJDcrcQP/NTV2lK9DTQFYojxFLNIMLA8tpFso
        ESvQ3CO2EdpP4mChYyT59/fSNvf7GW08Ya3OxOzVtDNnAq4PpAL8I/jLCk1zO+Wi
        nt5ryapoHbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8748C15AB42;
        Thu, 13 Jun 2019 15:57:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E3F6615AB41;
        Thu, 13 Jun 2019 15:57:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [GSoC][PATCH v3 2/3] cherry-pick/revert: add --skip option
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
        <20190613040504.32317-1-rohit.ashiwal265@gmail.com>
        <20190613040504.32317-3-rohit.ashiwal265@gmail.com>
        <xmqqa7elwer9.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Jun 2019 12:57:25 -0700
In-Reply-To: <xmqqa7elwer9.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Jun 2019 10:56:26 -0700")
Message-ID: <xmqqtvctuul6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77F4B090-8E15-11E9-BE26-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -static int rollback_single_pick(struct repository *r)
>> +static int rollback_single_pick(struct repository *r, unsigned int is_skip)
>>  {
>> ...
>> +	if (is_null_oid(&head_oid) && !is_skip)
>>  		return error(_("cannot abort from a branch yet to be born"));
>>  	return reset_for_rollback(&head_oid);
>>  }
>
> It is unclear *why* the function (and more importantly, its callers)
> would want to omit two sanity checks when is_skip is in effect.
> ...
>> +	default:
>> +		BUG("the control must not reach here");
>> +	}
>> +
>> +	if (rollback_single_pick(r, 1))
>> +		return error(_("failed to skip the commit"));
>
> And this takes us back to the previous comment.  By passing '1'
> here, this caller is asking the callee to omit certain sanity check
> the original version of the callee used to do.  What makes it an
> appropriate thing to do so here?

I think my earlier comments would lead to a wrong direction, i.e. to
justify the change made to rollback_single_pick(), so let's step
back a bit.  Perhaps the change is unjustifiable and that is why I
had trouble reading it and trying to make sense out of it.

Is it possible that the new callsite that passes is_skip==1 should
not be calling it (while castrating many parts of the callee) in the
first place?  Perhaps it is doing something _different_ from being
called "rollback single pick" (or perhaps the name of the function
is not specific enough to describe what its existing caller, i.e. the
one that passes is_skip==0 after your patch, calls it for)?  IOW,
would it lead to a better code structure if you left the original
rollback_single_pick() helper and its caller alone (perhaps rename
it to make it clearer what it does), and *add* a new helper around
the underlying reset_for_rollback() function and call it from here?

Perhaps it is not rolling back but is skipping, so the new function
needs to be called skip_single_pick() or something, and the existing
one is named correctly and there is no need for even renaming?
