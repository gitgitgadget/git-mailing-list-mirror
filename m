Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED08C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED72761131
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhIIRhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:37:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54981 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbhIIRhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 13:37:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E245EED86;
        Thu,  9 Sep 2021 13:35:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58KV5TkvtQxCI55GMK9b69f4yLYNOHVmW5I3V6
        0sX8E=; b=BGAd7w0HECLjG8i21uqcnboVdPTUMrQSQBjvOns2dnGXyqj8SFLqiO
        YMKtGgRvcEYs9J/elVhlM5HWUnSPg8I2gckyJkAICLPKsQcy3CETFKI6sngzhprK
        LweBd/7GzEN3EWsSMo2fBD9T3IaHi9SrQI84VYeIuVomC0GL0K9/4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 045A0EED84;
        Thu,  9 Sep 2021 13:35:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85829EED83;
        Thu,  9 Sep 2021 13:35:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
        <YTOW352xtsbvJcKy@coredump.intra.peff.net>
        <20210907211128.mauwgxupbredgx7w@meerkat.local>
        <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
        <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
        <xmqqee9x1wvh.fsf@gitster.g>
Date:   Thu, 09 Sep 2021 10:35:51 -0700
In-Reply-To: <xmqqee9x1wvh.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        09 Sep 2021 10:28:50 -0700")
Message-ID: <xmqqa6kl1wjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60A12A7C-1194-11EC-B111-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -789,6 +790,9 @@ int cmd_main(int argc, const char **argv)
>>  	http_config();
>>  	max_request_buffer = git_env_ulong("GIT_HTTP_MAX_REQUEST_BUFFER",
>>  					   max_request_buffer);
>> +	proto_header = getenv("HTTP_GIT_PROTOCOL");
>> +	if (proto_header)
>> +		setenv(GIT_PROTOCOL_ENVIRONMENT, proto_header, 1);

Since this overwrites (I noticed the "1" at the end), the server
operator cannot force a particular protocol with their server
configuration, no?

Would a weaker form to use 0 (set if there isn't any, but keep the
value if somebody else already has set it) work OK?  Would that have
a downside?
