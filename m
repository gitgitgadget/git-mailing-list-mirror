Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D0F1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfI3JsU (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:48:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61955 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3JsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:48:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C62F21A54;
        Mon, 30 Sep 2019 05:48:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J0lMCB+Tf3LH5Co7140cSaSQIL0=; b=ycKxxJ
        TaYopQcOMFZeN2nEREmgsdCJ0bnhI8Wsypf8aiPDUDCQ4qfCuBXdZctYxlC0sWBF
        f18o4zRlP7h4wtzgHLD2I7JsnaDGPQWUQwioVkOxS9q11/EHCWiQnHzUtxxagM67
        K1tLOS8wunmK5RyZqfB5y9RiK9U4tdPHs+61w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ge16Pas4nRa73IkrVTCRiiwTbj5DaTuD
        tr65pBltJqRgusp0+148RfQGmdEueygAqa3WWMS+guvH60Q4leB2vQLLAAhlzBa0
        22ty03dkfb8f9P+FOm+JaZ0hfnto5BbDqpBXPLZbRJmck9lw5FYrwxtSqWU0UfPx
        IScQe/vu7vw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3471921A53;
        Mon, 30 Sep 2019 05:48:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9779221A52;
        Mon, 30 Sep 2019 05:48:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        CB Bailey <cb@hashpling.org>, dstolee@microsoft.com
Subject: Re: [PATCH v4] diffcore-break: use a goto instead of a redundant if statement
References: <20190929204322.1244907-1-alexhenrie24@gmail.com>
        <xmqqa7amimzc.fsf@gitster-ct.c.googlers.com>
        <CAMMLpeQLXN=jvD6MSJPdUTr60MiKdQq=zHFQ7aiatFuhqX1aeQ@mail.gmail.com>
Date:   Mon, 30 Sep 2019 18:48:16 +0900
In-Reply-To: <CAMMLpeQLXN=jvD6MSJPdUTr60MiKdQq=zHFQ7aiatFuhqX1aeQ@mail.gmail.com>
        (Alex Henrie's message of "Mon, 30 Sep 2019 01:45:12 -0600")
Message-ID: <xmqq36gei07z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DE549DC-E367-11E9-99B3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Well, I admit that code clarity is somewhat subjective. To me it's not
> obvious that "if (q->nr <= j)" means "if the loop exited normally",

I actually do not have too much problem with this side of the
equation.  I however do see problem with squashing the two diff_q
calls that _happens_ to be textually the same but is made from two
logically separate codepaths (cases B.1 and C, in the message you
are responding to but omitted from quote).  After all, you did not
even realize you introduced a new bug by doing so before CB pointed
it out, no?  A rewrite like that that easily allows a new bug to
slip in hardly qualifies as making code "more clear and readable".

> but a goto does make it obvious. (And it's definitely more clear to
> scan-build, which complains about a possible memory leak when an if
> statement is used but does not complain when the if statement is
> replaced with a goto.)
>
> As far as the diff_q calls, I think that having one call instead of
> two is slightly more readable, but I don't care very much about it.
> I'd be happy to drop that change from the next version of the patch.
>
> -Alex
