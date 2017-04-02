Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38D72096C
	for <e@80x24.org>; Sun,  2 Apr 2017 17:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdDBRPB (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 13:15:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57643 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751190AbdDBRPA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 13:15:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE78675855;
        Sun,  2 Apr 2017 13:14:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jsl8Y9iVTTx1pZZTKZV6+0rRF6A=; b=ApHI8C
        hHEVAc0QQ6WgXmXP7I7pSky5XfDA80Fo+LM6M8oCrSedq+OMV1k74L8WER9JiU0d
        fjcftnTgvWtISZaV5YZ6kDwMMO8pLCa2bmOO26W1dahzyOsJm1V0r6VdFp3DWG7t
        zVnGD3u4S7003Eri8Sv1EZVJHTVHL1Td19iQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sTjKBUgUAYSUZyx+i/sUaq0rQLJj4y5M
        BjsHGJnshqPnCT7r2mhE3VH4mh5TUkIjs9VNO2CHS9hZ9rx9pognjBtQ3JUqvCDP
        0rMFdSAiDJX49Afor0odnsG5yG3isvV7ull6LxwZipR2VbI+HaQljYOREdcLxGL+
        BsGyhXfz4p0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E719375854;
        Sun,  2 Apr 2017 13:14:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A78775853;
        Sun,  2 Apr 2017 13:14:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Stanca <robert.stanca7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] [GSOC] show_bisect_vars(): Use unsigned int instead of signed int for flags
References: <20170401153049.21400-1-robert.stanca7@gmail.com>
        <20170401153049.21400-2-robert.stanca7@gmail.com>
        <xmqqtw68szz1.fsf@gitster.mtv.corp.google.com>
        <CAJYcaSNAB+1gth2NkTjrcBV9TXT9bRsBQhwOsQCmnudYz5bTmg@mail.gmail.com>
        <xmqqlgrjtrjl.fsf@gitster.mtv.corp.google.com>
        <CAJYcaSNJ0un1RgM3DNX=EOez5zP=Rko+BUt5SMeyBTb20K21oQ@mail.gmail.com>
Date:   Sun, 02 Apr 2017 10:14:46 -0700
In-Reply-To: <CAJYcaSNJ0un1RgM3DNX=EOez5zP=Rko+BUt5SMeyBTb20K21oQ@mail.gmail.com>
        (Robert Stanca's message of "Sun, 2 Apr 2017 16:18:56 +0300")
Message-ID: <xmqqmvbyspdl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFF1FEA8-17C7-11E7-98FE-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Stanca <robert.stanca7@gmail.com> writes:

> The question is : If the flags field of the structure is used in
> function calls should i update flags that deep?(there are other
> cases where the field is used in nested calls )

[administrivia: please don't top-post around here].

There won't be any fast and clear rule and you'd need to grow and
use common sense and good taste, but it probably is helpful to go
back and think from the first principle, i.e. why you are doing this
conversion.

For example, in your PATCH 2/2 that we are discussing, you updated
the local variable "flags" to unsigned in show_bisect_vars(),
because it receives the value from "info->flags", which is becoming
an "unsigned" because it is a collection of independent bits.

The function uses this "flags" (now unsigned) twice, and one is to
pass it to filter_skipped() as its 3rd parameter.  This helper
function takes "int", but you didn't update it to "unsigned".  And
you made the right decision to stop there.

The reason why it is the right place to stop is because the function
does not use its 3rd parameter as a collection of bits; it wants its
callers to give Yes/No there--anything non-zero is yes.  Because you
know "flags & BISECT_SHOW_ALL", which is unsigned, would be passed
as a non-zero "int" to filter_skipped(), iff flags has that bit set,
you know you do not have to touch that function and you stop there.

There will be similar places in the callchain that stop propagating
the "collection-of-independent-bits"-ness.  And that is where you
would stop--because beyond that point there is no "arrgh, we use
signed int to represent a collection of bits?" problem, which is
what you are cleaning up.


