Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CBEC1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 05:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeKPPUB (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 10:20:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63881 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeKPPUA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 10:20:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09FA3109C53;
        Fri, 16 Nov 2018 00:09:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V/Y7JRMeoJuUE4KwD71SQw4w9ss=; b=ipyQIH
        +czuInoPw+AGis04svL8zIIhIX823LLfhSalyseWVoiKWseRA5xV5hem4x47Tb34
        53TNIdNkiSO2xUkuWSOuwPNL50dPmfVi0aOik3wYfiqRhq5sxQT0GSQG5g7Of/Ry
        XzWUwZpATnvHz1fS8BAYSJgo++3VDcSHb989U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PgQu8g/0PR3DH8GkqyjKiYuq/+xIv9cd
        2VZkx21B7dlLZHEw3evuCKgMKezB92RWNfq9h6kD6Rq84fjVcyYb7ZnKbDezpxTg
        SAaoFhc9sUAME8MtB5JSCWkoSc15xSJKhipzergzi7MjOWb+IZkvxJQ8+zxWMMUN
        aGsH3KNMLd4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 017BF109C52;
        Fri, 16 Nov 2018 00:09:09 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F14C109C50;
        Fri, 16 Nov 2018 00:09:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a repository
References: <xmqq5zytpa65.fsf@gitster-ct.c.googlers.com>
        <20181114122725.18659-1-szeder.dev@gmail.com>
        <20181115093844.GA14218@sigill.intra.peff.net>
        <20181115094320.GA18790@sigill.intra.peff.net>
Date:   Fri, 16 Nov 2018 14:09:07 +0900
In-Reply-To: <20181115094320.GA18790@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 15 Nov 2018 04:43:20 -0500")
Message-ID: <xmqq36s1libw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF404598-E95D-11E8-88A6-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 15, 2018 at 04:38:44AM -0500, Jeff King wrote:
>
>> Is SOURCE_NONE a complete match for what we want?
>> 
>> I see problems in both directions:
>> 
>>  - sorting by "objectname" works now, but it's marked with SOURCE_OBJ,
>>    and would be forbidden with your patch.  I'm actually not sure if
>>    SOURCE_OBJ is accurate; we shouldn't need to access the object to
>>    show it (and we are probably wasting effort loading the full contents
>>    for tools like for-each-ref).
>> 
>>    However, that's not the full story. For objectname:short, it _does_ call
>>    find_unique_abbrev(). So we expect to have an object directory.
>
> Oops, I'm apparently bad at reading. It is in fact SOURCE_OTHER, which
> makes sense (outside of this whole "--sort outside a repo thing").
>
> But we'd ideally distinguish between "objectname" (which should be OK
> outside a repo) and "objectname:short" (which currently segfaults).

Arguably, use of ref-filter machinery in ls-remote, whether it is
given from inside or outside a repo, was a mistake in 1fb20dfd
("ls-remote: create '--sort' option", 2018-04-09), as the whole
point of "ls-remote" is to peek the list of refs and it is perfectly
normal that the objects listed are not available.

"ls-remote --sort=authorname" that is run in a repository may not
segfault on a ref that points at a yet-to-be-fetched commit, but it
cannot be doing anything sensible.  Is it still better to silently
produce a nonsense result than refusing to --sort no matter what the
sort keys are, whether we are inside or outside a repository?

