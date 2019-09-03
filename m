Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1851F4B7
	for <e@80x24.org>; Tue,  3 Sep 2019 22:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfICWqh (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 18:46:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63163 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICWqh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 18:46:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A4041938B;
        Tue,  3 Sep 2019 18:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q2uFDcU2PA/dB1/0he8knFQR+Is=; b=D4iPWC
        twfASgLa7/St/qtSKCjH4FGEi4cvm0lKqv1KCmYVv8XjV3o9NP0GIPJIl77UMYZd
        yUtNnPgckRSDTGZMasAu5zCICAtspIkGOmp96PZYkcJR0uaNXBTc/R87zNXnWCOy
        eGFH3SbmDVSxxQ5QKm64xhLwh93I7CpYfqolQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ge33qDXtHSg0CwMw4CsJ2EU2XWa3IDKW
        ytjunrGDCjhQfLh1PKet174lpoerZb3k0NmBbZi6FxFmtrs47Fgmz19T7GYz//+z
        d3Z4/wLcYN3MYv4vdy8ZttLCvtL/9Z61kneuSOPQSwvCPhLM+0FnoTglRts5Rm/h
        vMqTf51B/BI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 308621938A;
        Tue,  3 Sep 2019 18:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9103019389;
        Tue,  3 Sep 2019 18:46:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/4] t3427: accelerate this test by using fast-export and fast-import
References: <20190828002210.8862-1-newren@gmail.com>
        <20190903185524.13467-1-newren@gmail.com>
        <20190903185524.13467-3-newren@gmail.com>
        <xmqqsgpdrs01.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 03 Sep 2019 15:46:33 -0700
In-Reply-To: <xmqqsgpdrs01.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 03 Sep 2019 14:26:22 -0700")
Message-ID: <xmqqftldroae.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE4EEEC2-CE9C-11E9-A79D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> +extract_files_subtree () {
>> +	git fast-export --no-data HEAD -- files_subtree/ |
>> +		sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" |
>> +		git fast-import --force --quiet
>> +}

This change has obvious interactions with Dscho's d51b771d ("t3427:
move the `filter-branch` invocation into the `setup` case",
2019-07-31) that is still in flight, but in a good way.  There only
needs a single callsite for the above helper function after that
step.

I think I'll discard this step from the "move us closer to deprecate
filter-branch" topic, and ask you and Dscho to work together to have
it or its moral equivalent included as part of js/rebase-r-strategy
topic.

Thanks.
