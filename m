Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A9A202DD
	for <e@80x24.org>; Sat, 21 Oct 2017 09:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932066AbdJUJB7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 05:01:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50142 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753028AbdJUJB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 05:01:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 255A0B61F3;
        Sat, 21 Oct 2017 05:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GhB4IBUfIYuDKFKXpj0PNPLe9fU=; b=pdpCdC
        QBiXvC8U7YbPa1W2QhZbQuHaXcMWO+bHK8JPY8Msz51hCpY5WkGK9t861h+nqKgt
        kLubT+9ge+JWeIdC7OwfNf5WF4jhanKMbYlBbYI89PDcN8Fbyqs8jUlt26NQJEm/
        E45MvIS+ePmfceHyddzJIHL6ZG7eWnBuD0n6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QHHoKjiMYC0bNuoP7XGiMlBSg6flSwJt
        XaUM1MAN+UHH/DnKSvdmXtXp1hFWivE4Cy/VgDPuYQvDo0cOAewGfFyPiGrs4FKw
        j4S20e9XC1GogrRaW5OIz4jVhF2vyo72IIfeQOMjSye/BO2kq+nXhfqcfPA8HFK8
        LO+RCXZgLwo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DF89B61F2;
        Sat, 21 Oct 2017 05:01:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FC90B61F1;
        Sat, 21 Oct 2017 05:01:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] branch: split validate_new_branchname() into two
References: <20171013051132.3973-1-gitster@pobox.com>
        <20171013051132.3973-3-gitster@pobox.com>
        <1508561910.2516.22.camel@gmail.com>
Date:   Sat, 21 Oct 2017 18:01:56 +0900
In-Reply-To: <1508561910.2516.22.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sat, 21 Oct 2017 10:28:30 +0530")
Message-ID: <xmqqlgk4g9h7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DFCD856-B63E-11E7-832E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> +/*
>> + * Check if a branch 'name' can be created as a new branch; die otherwise.
>> + * 'force' can be used when it is OK for the named branch already exists.
>> + * Return 1 if the named branch already exists; return 0 otherwise.
>> + * Fill ref with the full refname for the branch.
>> + */
>
> I guess it's better to avoid repeating the comments in both the .h and
> .c file as they might quite easily become stale. I would prefer keeping
> it in the header file alone.

True.  I wrote this while designing the code, so the copy in .c file
came first, and then that was copied to .h file; the one in .c file
can go.

> The change was simple by splitting the function into two and calling
> the right function as required at every call site! As far as I could
> see this doesn't seem to be reducing the confusion that the 'attr_only'
> parameter caused.

The confusion primarily was the way the parameter was named.
"forcing" does not have strong connection to marking "this is only
asking about attributes".  And removing that confusion, by
separating the caller and making it explicit that the caller needs
two separate behaviours depending on the condition, and naming the
functions more appropriately (i.e. is this about creating a new one
that must not exist already?), is the focus of this step.
