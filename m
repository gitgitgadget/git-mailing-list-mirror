Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF631F461
	for <e@80x24.org>; Fri, 12 Jul 2019 16:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfGLQon (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 12:44:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52220 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLQon (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 12:44:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B64670047;
        Fri, 12 Jul 2019 12:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dMO/E/vhHjmKo5Z1+dSdYdWbOQA=; b=catvrc
        j28JPRqBVPL2cSzMP0on9b0N6YRYE1YDnDmw+G59t7GNj8EZofOHEXDcTCLH5iNk
        4iLZHRitLDWm5mabvjesgcf1MUOemCe2orFUP2yzql0Hj+Uno+tguvBfrd7brAaG
        ZofCDNPyLd/cEh3gCXSTJIaPRqvn5iU1KW1JY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K77242i9/uGYxJkcqyEZHhc/Oj8NC8Bv
        GfL7zHJV1s/QURl70Xy0VaQejxDT7TsSDFyoPen34AD3Gr5w6QSjd6CO1dmp96hk
        0qpUmUO4kOb0EA58KxC2/GYICUM3rmk/SaGo2+Q+iBshv0OFUaHAhfcgVSUpzyyi
        aRiPsX7uz2A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 924FE70046;
        Fri, 12 Jul 2019 12:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC5CE70045;
        Fri, 12 Jul 2019 12:44:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
        <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
Date:   Fri, 12 Jul 2019 09:44:36 -0700
In-Reply-To: <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org> (Johannes Sixt's
        message of "Fri, 12 Jul 2019 07:21:08 +0200")
Message-ID: <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56C605AC-A4C4-11E9-A7D8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 12.07.19 um 00:03 schrieb Ramsay Jones:
>> diff --git a/range-diff.c b/range-diff.c
>> index ba1e9a4265..0f24a4ad12 100644
>> --- a/range-diff.c
>> +++ b/range-diff.c
>> @@ -102,7 +102,7 @@ static int read_patches(const char *range, struct string_list *list)
>>  		}
>>  
>>  		if (starts_with(line, "diff --git")) {
>> -			struct patch patch = { 0 };
>> +			struct patch patch = { NULL };
>
> There is nothing wrong with 0 here. IMHO, zero-initialization should
> *always* be written as = { 0 } and nothing else. Changing 0 to NULL to
> pacify sparse encourages a wrong style.
>
> -- Hannes

Hmm, care to elaborate a bit?  Certainly, we have a clear preference
between these two:

	struct patch patch;
	patch.new_name = 0;
	patch.new_name = NULL;

where the "char *new_name" field is the first one in the structure.
We always try to write the latter, even though we know they ought to
be equivalent to the language lawyers.

Is the reason why you say 0 is fine here because we consider

	struct patch patch, *dpatch;
	memset(&patch, 0, sizeof(patch));
	dpatch = xcalloc(1, sizeof(patch));

are perfectly good way to trivially iniitialize an instance of the
struct?

Do we want to talk to sparse folks about this?

