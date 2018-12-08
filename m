Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1AC320A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 06:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLHGCG (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 01:02:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60105 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeLHGCG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 01:02:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50FE426BBE;
        Sat,  8 Dec 2018 01:02:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zMsoT6y2/gq8le6jxuU+aHRBBeQ=; b=L019Q4
        YsTFB/6j19wy1FvirOprRunJmabe7WFJ27Gg2UBo7FdLczeVlX8EZB1yfQKnRr/D
        TvBprvnbb2pAx6cP8zbx3IoODYI5HcNpwPVrfK7HeLrabssHLQir4odrINwOa3Zy
        r4iNwIdjq1HIGnkDD1zlTn392W7SK2RwjiKVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lTv80zWnEv+LB62MY4xCHxj6KYNBJNrk
        YVod5ue7Hod5V/ltMgSxYTIbGRO3W5J2SDa1bAHacf8lYlblHsui/SoDxHARMd+Z
        W7N0rZEVrnJsTxHJTTAGGamGnruQYkD+d4pDmc0o0Hw8bQPDcmYSbBtpRPSKnesw
        l2Sj0DfOO6Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4992F26BBD;
        Sat,  8 Dec 2018 01:02:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F59026BBB;
        Sat,  8 Dec 2018 01:02:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: RFE: git-patch-id should handle patches without leading "diff"
References: <20181207181942.GA6411@pure.paranoia.local>
        <20181207220116.GB73340@google.com>
        <87tvjpx9fy.fsf@evledraar.gmail.com>
        <20181207223406.GD73340@google.com>
Date:   Sat, 08 Dec 2018 15:01:59 +0900
In-Reply-To: <20181207223406.GD73340@google.com> (Jonathan Nieder's message of
        "Fri, 7 Dec 2018 14:34:06 -0800")
Message-ID: <xmqqa7lg8sko.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C78DE680-FAAE-11E8-8B3C-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> So it seems most sensible to me if this is going to be supported that we
>> go a bit beyond the call of duty and fake up the start of it, namely:
>>
>>     --- a/arch/x86/kernel/process.c
>>     +++ b/arch/x86/kernel/process.c
>>
>> To be:
>>
>>     diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>>     --- a/arch/x86/kernel/process.c
>>     +++ b/arch/x86/kernel/process.c
>
> Right.  We may want to handle diff.mnemonicPrefix as well.

I definitely think under the --stable option, we should pretend as
if the canonical a/ vs b/ prefixes were given with the "diff --git"
header, just like we try to reverse the effect of diff-orderfile,
etc.

I am unsure what the right behaviour under --unstable is, though.


