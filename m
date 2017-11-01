Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D3620450
	for <e@80x24.org>; Wed,  1 Nov 2017 01:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754022AbdKAB0w (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 21:26:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61251 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752319AbdKAB0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 21:26:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8EFEBB797;
        Tue, 31 Oct 2017 21:26:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P9wSW6H9olI1GRElazInBX08Hgg=; b=aTtEq4
        dyiLi7ZAf6jT616nRbeb047fw4SDH32v78pfLc3wUGSvkUnyq4jf+vYIfnGFkmuB
        igvQhwXJ9tG1LfzDzl8lHbjO3AWlUYqoICGIxftIltUWPAUK11IfVWgot5sYYT4v
        dHIfiLEnMj76Fcz4d66g7yeh+SjmmvP2gX13I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s5mXRdbaMkuXH5uoukobD4PsZ43K4m4i
        yxpC+OOW5vVz7iNNkLtuZTyrQcT/PpGrihv5leRQd/J3KWgZuPYIkh4CP6/KnSiN
        PayejrSrySshPlUBPv3yJfOp94yRbkFCrEAQFpKLdo3xscvXu0rTqhnPVM1Yyp2a
        +vcq94Ohop8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF09CBB796;
        Tue, 31 Oct 2017 21:26:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42414BB795;
        Tue, 31 Oct 2017 21:26:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] diff: convert flags to be stored in bitfields
References: <20171030194646.27473-1-bmwill@google.com>
        <20171031181911.42687-1-bmwill@google.com>
        <20171031181911.42687-3-bmwill@google.com>
        <CAGZ79kajX=FmGacDSv_dDzppE6WBHGqgyCpaG1zDyENcsDbwZg@mail.gmail.com>
Date:   Wed, 01 Nov 2017 10:26:49 +0900
In-Reply-To: <CAGZ79kajX=FmGacDSv_dDzppE6WBHGqgyCpaG1zDyENcsDbwZg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 31 Oct 2017 14:32:20 -0700")
Message-ID: <xmqq8tfqyejq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC1A8292-BEA3-11E7-ACDD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> After some quick research our coding style on bit fields is twofold:
> Most older code is this way and more recent code seems to prefer
>
>     unsigned <FLAGNAME> SP : SP ;

Yes, we are very inconsistent.  What does the clang format rules
Brandon came up with have to say on this?  FWIW, checkpatch.pl is
unhappy without spaces on both side.

>> +static inline void diff_flags_or(struct diff_flags *a,
>> +                                const struct diff_flags *b)
>> +{
>> +       char *tmp_a = (char *)a;
>> +       const char *tmp_b = (const char *)b;
>> +       int i;
>> +
>> +       for (i = 0; i < sizeof(struct diff_flags); i++)
>
> I think most of the code prefers to put the variable into the sizeof
> argument i.e. 'sizeof(*a)', as that is presumably more maintainable.
> (If the type of 'a' changes, then we don't forget to adapt this place,
> but the compiler can take care of it.

Yup, but in this case we won't change the type, no?
