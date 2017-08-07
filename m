Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C692047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbdHGRtc (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:49:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63072 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751799AbdHGRtb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:49:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 891A5A1223;
        Mon,  7 Aug 2017 13:49:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FE+7LnnHH0oyzxWFw5j4VZUaXbQ=; b=v2r5R3
        eeGFJ4Sn/g/DSPBp9CxVioivHvIaV2Uhfq0gB1e+e2SgqkgU4NJchJcD0zt3sFep
        SQqKf4u19fCpVCjYnAQvlI5ABJD1KyxxD+KSHUyt+PmkcKbI0GkvgBR+6WXKgUf9
        JK4rB+RxTbNmLtJCGp0dbV4eP/bRVco2d1O0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=THckHQkl2oYOGgag750J1OobLcQKYuOR
        EwMgn17XL3O9wqh6h0TLtJH9IwSzitmx7zNZqUkbR/5OyhIsXIobIMgU46vrcNy3
        pEnwp4olH5Vts8bvxfT5PRABHaR2Oy7ssgKxIhYJ3pLI1MFY3P49Jbjm45E0cfCA
        C2sIaEsNkXM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80BB2A1221;
        Mon,  7 Aug 2017 13:49:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD4F9A121F;
        Mon,  7 Aug 2017 13:49:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1] am: fix signoff when other trailers are present
References: <20170807102929.25151-1-phillip.wood@talktalk.net>
Date:   Mon, 07 Aug 2017 10:49:28 -0700
In-Reply-To: <20170807102929.25151-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 7 Aug 2017 11:29:29 +0100")
Message-ID: <xmqqfud3qndj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C337899C-7B98-11E7-BC0F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If there was no 'Signed-off-by:' trailer but another trailer such as
> 'Reported-by:' then 'git am --signoff' would add a blank line between
> the existing trailers and the added 'Signed-off-by:' line. e.g.
>
>     Rebase accepts '--rerere-autoupdate' as an option but only honors
>     it if '-m' is also given. Fix it for a non-interactive rebase by
>     passing on the option to 'git am' and 'git cherry-pick'.
>
>     Reported-by: Junio C Hamano <gitster@pobox.com>
>
>     Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Fix by using the code provided for this purpose in sequencer.c.
> Change the tests so that they check the formatting of the
> 'Signed-off-by:' lines rather than just grepping for them.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> I'm not sure if this should be calling ignore_non_trailer() or not -
> git commit does but git cherry-pick does not. This follows commit and
> cherry-pick in ignoring the value of trailer.ifExists for the signoff.
> I'm a bit surprised they do that - is it correct?

These built-in "sign-off" machinery long predates the "trailer"
thing, so I am not surprised if they do not behave the same.  I
vaguely recall having discussions on this earlier this year, but
details escape me.  

Asking Jonathan, who did a series that ends at 44dc738a ("sequencer:
add newline before adding footers", 2017-04-26), and Christian, who
is the original contirbutor to the "trailer" machinery, for input.

