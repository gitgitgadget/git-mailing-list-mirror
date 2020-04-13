Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13AEC2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D4020735
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oZFcd93d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgDMWSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:18:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64074 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgDMWSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 18:18:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 335FFB4F44;
        Mon, 13 Apr 2020 18:18:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tF7TVmUaLaMdm9cZvKclhRSS6Ps=; b=oZFcd9
        3dux4jRVCVgdY+9VITLL3yCCZ+QWrKEMPXWZOKRYR5Nm77+Yr48zIBrwORqbQDXa
        w51ThdwNxGeufO+z7yWl/xI4BfEK9HmDa20wVIXQd1rXOGH/kbI7xLU1cGaYp23S
        1F46kOwSmM1q0OBRRHBsC2iFRmx7RT0yGbEdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pnOf6fKah54AM5/19ubVXTenZWFtu+dx
        jg08XbsIkh4zVhdVsw2PvMqO+7O7xb8FOVGD8Ahp4dZeZ5nqlKpoqLsiYWtSG+ir
        ow4214J5pQ+Gns+a3NLCwwHxGkBMqR81wyweqxKlP8ebiKwvBoAahKYKiIsV/lM4
        bRYhjFG0Nlg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B268B4F43;
        Mon, 13 Apr 2020 18:18:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F848B4F40;
        Mon, 13 Apr 2020 18:18:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/4] revision: complicated pathspecs disable filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
        <adc03eee4ac8a0911bfd2a7ae03364ef0e744ef0.1586789126.git.gitgitgadget@gmail.com>
        <20200413160908.GD59601@syl.local>
Date:   Mon, 13 Apr 2020 15:18:15 -0700
In-Reply-To: <20200413160908.GD59601@syl.local> (Taylor Blau's message of
        "Mon, 13 Apr 2020 10:09:08 -0600")
Message-ID: <xmqqlfmzav2w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACDA2420-7DD4-11EA-83A2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> +static int forbid_bloom_filters(struct pathspec *spec)
>> +{
>> +	if (spec->has_wildcard)
>> +		return 1;
>> +	if (spec->nr > 1)
>> +		return 1;
>> +	if (spec->magic & ~PATHSPEC_LITERAL)
>> +		return 1;
>> +	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>>  static void prepare_to_use_bloom_filter(struct rev_info *revs)
>>  {
>>  	struct pathspec_item *pi;
>> @@ -659,7 +673,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>>  	int len;
>>
>>  	if (!revs->commits)
>> -	    return;
>> +		return;
>> +
>> +	if (forbid_bloom_filters(&revs->prune_data))
>> +		return;
>>
>>  	repo_parse_commit(revs->repo, revs->commits->item);
>>
>> --
>> gitgitgadget
>>
>
> Nicely done, this looks good to me. Thanks.

Likewise.  Very exciting.

Will queue.
