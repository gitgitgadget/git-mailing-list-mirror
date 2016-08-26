Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F70F2018E
	for <e@80x24.org>; Fri, 26 Aug 2016 21:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754209AbcHZVOw (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 17:14:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62610 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754196AbcHZVOv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 17:14:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A7313982C;
        Fri, 26 Aug 2016 17:09:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lVYcrfHOtFo01+S7+bUIPotnvVE=; b=MVDS16
        KxEmWh8H3M4nxjWXMMH6AU79lfv9BZYUKwLWboW0qpjtQZo+s68Mo6VJeUueF0W/
        fL4iicZpfWFLOVW7XaYtYSIxZUoCQW4ibJ64QJi/ztEmeqf/HuQzV+oT0r1ALRri
        Se8HGTfwuykrUfIgwdEX3E+0d++s/KUfN1UEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ph/nUNgUyJJxpPdEOZ9xgqLrtlyJB075
        gcdnXahab+0JgLepSbCeivI24jmcwds1VRD8Rnc9bMuhNCbgN4/UaT5AFSNZYkgo
        N3nai/A63kUlDbtqV32W1jo/QWfzhXrbN+ZxQEOAOoayI/lXfS4zYW8Q+k+CEApJ
        wQYHY1brf1E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 834E53982B;
        Fri, 26 Aug 2016 17:09:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0699F3982A;
        Fri, 26 Aug 2016 17:09:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 17/27] bisect--helper: `bisect_autostart` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6d7-8b80c663-7c77-469e-811f-40200ec6dbb1-000000@eu-west-1.amazonses.com>
Date:   Fri, 26 Aug 2016 14:09:55 -0700
In-Reply-To: <01020156b73fe6d7-8b80c663-7c77-469e-811f-40200ec6dbb1-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqqy43jdyos.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 710CFCB0-6BD1-11E6-A5C1-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> @@ -410,6 +413,7 @@ static int bisect_next(struct bisect_terms *terms, const char *prefix)
>  {
>  	int res, no_checkout;
>  
> +	bisect_autostart(terms);
>  	/* In case of mistaken revs or checkout error, or signals received,
>  	 * "bisect_auto_next" below may exit or misbehave.
>  	 * We have to trap this to be able to clean up using

This change is extremely hard to reason about.

Why wasn't auto-start done at the very beginning of this function
before?  Why does this start calling it all of a sudden?  Before
autostart was rewritten in C in this step, who made sure the shell
version of autostart was called before bisect_next is called (which
must have become unnecessary with this step, and I fully expected a
removal of such a call in the shell version, but I didn't find such
a change in this patch)?

Or is this series simply broken by lossage of autostart feature in
"bisect next" between the step where bisect_next is rewritten in C
and this step?

