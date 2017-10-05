Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56DA12036C
	for <e@80x24.org>; Thu,  5 Oct 2017 01:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbdJEB0b (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 21:26:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58233 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751219AbdJEB0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 21:26:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D9DBB21FA;
        Wed,  4 Oct 2017 21:26:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=46isykH6A6m2ZKLZ/cLbymxj2vY=; b=DFjxKi
        TQZ4N4L24BRpZQsAJ+TQiY2EDRe57sRDT/xuqOMHBknc/EKaR/ZCml5e4iu++wYC
        x44SJ6THnweERmULxWbXuT8DKODICGRmm+4B0UFU9lihEbQrNzLYO+uPKmI5fpgA
        uPzTw0TxMTaImhuY/2qXZAMZOTPe9v0OOqPGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kPiE78Yq8eDCB22oH/WdaqGziUK+TSPU
        ZvQZH2NX4PoMb5MwnOJbQbyzu376x4jgmiPlhOsB6IS8IfsZhuljpE7KNKgKRfx9
        ECdiL6S7FDd0vtC/sRHZpOD8v31RMdEXYd+xqutVSrS0k45TGCNgPIjlCWosG3tv
        KNMxTZd2NNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 957EAB21F9;
        Wed,  4 Oct 2017 21:26:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07924B21F8;
        Wed,  4 Oct 2017 21:26:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com, sbeller@google.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20171002145651.204984-4-dstolee@microsoft.com>
        <xmqqtvzfcuoy.fsf@gitster.mtv.corp.google.com>
        <a6653525-94f2-fd7d-8c27-9334d473a556@gmail.com>
Date:   Thu, 05 Oct 2017 10:26:27 +0900
In-Reply-To: <a6653525-94f2-fd7d-8c27-9334d473a556@gmail.com> (Derrick
        Stolee's message of "Wed, 4 Oct 2017 09:19:59 -0400")
Message-ID: <xmqqfuay9ygs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36537C46-A96C-11E7-AF32-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 10/4/2017 2:07 AM, Junio C Hamano wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>>> -	exists = has_sha1_file(sha1);
>>> -	while (len < GIT_SHA1_HEXSZ) {
>>> -		struct object_id oid_ret;
>>> -		status = get_short_oid(hex, len, &oid_ret, GET_OID_QUIETLY);
>>> -		if (exists
>>> -		    ? !status
>>> -		    : status == SHORT_NAME_NOT_FOUND) {
>>> -			hex[len] = 0;
>>> -			return len;
>>> -		}
>>> -		len++;
>>> -	}
>>> -	return len;
>> The "always_call_fn" thing is a big sledgehammer that overrides
>> everything else in update_candidates().  It bypasses the careful
>> machinery set up to avoid having to open ambiguous object to learn
>> their types as much as possible.  One narrow exception when it is OK
>> to use is if we never limit our candidates with type.
>
> I do not modify get_short_oid, which uses these advanced options,
> depending on the flags given. find_unique_abbrev_r() does not use
> these advanced options.

It is true that the function no longer even calls get_short_oid().

When it called get_short_oid() before this patch, it not pass "I
want to favor committish" in the old code, as we can see in the
above removed code.  In get_short_oid(), ds.fn would have been set
to default_disambigutate_hint, and that would have been used in the
update_candidates() function.

Now, unless the user has core.disambiguate configuration set, this
"default" thing becomes NULL, so overriding ds.fn like this patch
does and bypass major parts of update_candidates() is probably fine.
After all, update_candidates() wouldn't have inspected the object
types and made the candidate management anyway with ds.fn set to
NULL.

But having the configuration set would mean that the user wants to
set default_disambigutate_hint to some non-default value, e.g.
telling us to find disambiguation only among committishes; the patch
however overrides ds.fn and essentially makes the code ignore it
altogether, no?  That change in behaviour was what I was wondering
about.

