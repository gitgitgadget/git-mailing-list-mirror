Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4D1211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 05:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeK2Q7R (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 11:59:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60275 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeK2Q7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 11:59:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 634A83C3EC;
        Thu, 29 Nov 2018 00:55:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4gWipjfAkAv4+afYAmtxOUhZIb8=; b=rD5qGh
        4YJTj5i3fbYbhtqYYgWqhTl0i+REUjyp7SJ85dLlzcPm95wlBmnK5vrYxFTuqTd7
        WaBD0JNRrsHcELbicQBdd1ThC1dSETEmqQ73Lp83/aDV6jadXwCwQNa8sO0CeTHx
        6kzMDdrRnPbQNj7YqwEvc7VW7Ofrcy1uDu1FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PIlJd+aHh/MeSXTotWu4dUKndnJhEi47
        0u5LyfUQpcD56IbPE+x7h1y6SEOi4Dbyy6Y4ezy02AZrXaAY5rKgsOAT131uy9TE
        Zza1qWXb9vr9ZGHsNuLP8R7rHc51unXcok6fDtutbhRvu1haxQzAec+Kw7ZM0adi
        MM4RmKPTHHM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57A2C3C3EB;
        Thu, 29 Nov 2018 00:55:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65A8E3C3C5;
        Thu, 29 Nov 2018 00:55:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
References: <20181120174554.GA29910@duynguyen.home>
        <20181127165211.24763-1-pclouds@gmail.com>
        <20181127165211.24763-7-pclouds@gmail.com>
        <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
        <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
        <CAGZ79kbWqfMHZeYFXNh00N5xSSkW0_Mzja1EtuzxQxrhESoZxQ@mail.gmail.com>
Date:   Thu, 29 Nov 2018 14:55:00 +0900
In-Reply-To: <CAGZ79kbWqfMHZeYFXNh00N5xSSkW0_Mzja1EtuzxQxrhESoZxQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 28 Nov 2018 11:08:04 -0800")
Message-ID: <xmqqh8g0pgwb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 501C0722-F39B-11E8-A0D0-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I dislike the checkout-* names, as we already have checkout-index
> as plumbing, so it would be confusing as to which checkout-* command
> should be used when and why as it seems the co-index moves
> content *from index* to the working tree, but the co-files moves content
> *to files*, whereas checkout-branch is neither 'moving' to or from a branch
> but rather 'switching' to that branch.

To me, "switching to work on the branch", is like "checking the book
out from the library to read".  IOW, "check the branch out to work
on" does not have to involve *any* moving of contents.
