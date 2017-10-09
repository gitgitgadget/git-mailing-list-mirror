Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC2E20404
	for <e@80x24.org>; Mon,  9 Oct 2017 22:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbdJIWoY (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 18:44:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58191 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754172AbdJIWoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 18:44:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BEC9B07D3;
        Mon,  9 Oct 2017 18:44:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dLZqjlM+KdDmPPD1CkcTFWVfqZc=; b=pEiEleS2G3sdpTuXbG/2
        aY24G4//sX8zzP7BI3huqmwAuaoxSR7mRWKiPqsMNwuEVJ5LHy6DChHGkzRbHIq1
        nb1j/jYcjwtBc3lVK4St353b4XBJ+dK5BOQ+3bf6r1IPV76e6DDz8TkttptXO3xs
        4M2THAYRGoS6fLItCDWne0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=r3a12nNgLjcmcjyJyY2Ki9Q5oJvDAQ6CaIPp0Tcav7HPQc
        TodDerjOz355co+VPEMJCAAEVssFAZXJj1huIQjAZOcPaCldyJtUhvyfyE5UCoIm
        Xhibur+iwHH9wPiNOj1YnFap1VpbV2veHjlXrWPgBfEQEQzm13LLv1pPrwRCE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93D99B07D0;
        Mon,  9 Oct 2017 18:44:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B7C4B07CF;
        Mon,  9 Oct 2017 18:44:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 00/24] object_id part 10
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
Date:   Tue, 10 Oct 2017 07:44:18 +0900
Message-ID: <xmqqbmlgrlfh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6377814C-AD43-11E7-99BB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is the tenth in a series of patches to convert from unsigned char
> [20] to struct object_id.  This series mostly involves changes to the
> refs code.  After these changes, there are almost no references to
> unsigned char in the main refs code.
>
> The series has not been rebased on master since the last submission, but
> I can do so if that's more convenient.

Thanks for working on this.

I took a look at the conflicting parts between what happened on
'master' since than and this series.  Two things stood out:

 - many calls to resolve_refdup() started passing NULL when the
   caller does not care the object name (they just want to know what
   ref the symref points at, if any).

 - the implementation of ref peeling has been updated quite a bit.

In addition, builtin/pack-objects.c will lose want_object_in_pack()
and a new function ignore_object() will be introduced to replace its
role in a topic in flight.

Having said all that, I think I managed to come up with a clean
conflict resolutions to all integration branches 'master', 'next',
'jch' and 'pu' (that is, I pretend that the topic is mergeable to
these branches immediately, make a trial merge and test the result
before teaching the resolution to my rerere database, even though
the trial merges to more stable branches than the branch the topic
will start cooking in would be immediately discarded); at least the
results of these all passed the tests, so this round that is based
on a tad older version of 'master' looks alright.

