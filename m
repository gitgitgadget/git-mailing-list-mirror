Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14C920966
	for <e@80x24.org>; Fri, 24 Mar 2017 17:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966084AbdCXRPi (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:15:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55131 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965669AbdCXRPg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:15:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4767074B03;
        Fri, 24 Mar 2017 13:15:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=edlvgCeLG6ebPsx2cDsZdST89AI=; b=H1CBmm
        RJNHF0Oe8SClsHW2wxaQcdTkwo0ceA0lUHZ7Zf86GSuT55GLK6sWggkGkUGzY0Ul
        ZJ7kqCG3lJbtqkde1YW1j8DQck5XWAJRSk+JhvHtj1/z8i88nX/6759Gbzk3F152
        AAFV8eY00l2E8tdesCFKYtMJEfDcC1SEbbdeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c1zruMewthCuKEe5+0gwhQ2/QIDoEOkq
        iYbEJQxGQp/b/lB7C/ckhAXMp56MDDSEVDGBfAtbywJ+7r1182Ud/lGHriiBPCIS
        HGNyA/T9YUQuWuIXhV5v9hkRvdsTJC3ahHl0d5EvTTWfLdueNxLsCTnVsXfNtzPS
        uHHOgq7ZlXQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F92374B02;
        Fri, 24 Mar 2017 13:15:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C73274B00;
        Fri, 24 Mar 2017 13:15:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Ben Peart <peartben@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder\@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/3] sub-process: refactor the filter process code into a reusable module
References: <20170322165220.5660-1-benpeart@microsoft.com>
        <20170322165220.5660-3-benpeart@microsoft.com>
        <xmqqk27gfrga.fsf@gitster.mtv.corp.google.com>
        <BL2PR03MB32308D0F2BB1C7D6F04141BF43E0@BL2PR03MB323.namprd03.prod.outlook.com>
        <xmqqpoh68xld.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 24 Mar 2017 10:15:32 -0700
In-Reply-To: <xmqqpoh68xld.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Mar 2017 09:10:22 -0700")
Message-ID: <xmqqd1d68ukr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D5346EE-10B5-11E7-8480-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> And for something of sub-process.[ch]'s size, I suspect that it
> would have more than 1 such logical unit to be independently
> refactored, so in total, I would suspect the series would become
>
>     1 (boring mechanical part) +
>     2 or more (refactoring) +
>     1 (final movement)
>
> i.e. 4 or more patches?

To avoid confusion (although readers may not require), even though I
explained "boring mechanical part" first and "refactoring", that was
purely for explanation.  

In practice, I would expect that it would be easier to both do and
review if refactoring is done with the original name.  

A function that will keep its name in the final result (e.g.
start_multi_file_filter()) will call a new and more generic helper
function.  The new helper may start using the new name from the
get-go (e.g. subprocess_start()), but the data types it shares with
the original part of the code (e.g. 'struct cmd2process') may still
be using the original name.

And after completing "2 or more" refactoring would be a good place
to do the remaining "boring mechanical rename".  IOW, the count
above could be

     2 or more (refactoring) +
     1 (boring mechanical part) +
     1 (final movement)

and I didn't mean to say that you need to rename first.  What we
want is "if you need to have a single large patch that cannot be
split, see if you can make it purely mechanical.", as a single large
patch that is _not_ mechanical conversion is the worst kind of patch
for reviewers.
