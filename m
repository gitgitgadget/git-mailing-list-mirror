Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70AE20281
	for <e@80x24.org>; Mon,  6 Nov 2017 02:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdKFCYS (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 21:24:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54433 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750910AbdKFCYR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 21:24:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48B7DB48B9;
        Sun,  5 Nov 2017 21:24:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KvwT2FOmd/8vpyqWvNwBUQ/i9Bg=; b=k4v2f/
        JcI8IMbnz/e/1UgSRbeGqPQLLRr7fzI/UX+zeIAbZtsct8nMKBUtCN0N+WK0g2s8
        xzdr5guxqMmgsHP/Th3jFaiwjzx7bo1ipOfPVo/4TUtnZhnBQD3M73Jcmn6NX0I5
        AvPdmDwmx4te42oIbXHSeAui2B5sVQzYVNd9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tRbPgM0omad2MQHnqZURy0FyM1uCCNoL
        1lMpiUkIZ/3eVGKqS0RvTf+i2/u7WmE6z2tOK22vnQ2Gip4rqfT3MQoThsbwtPJz
        EK/zhU/3fwMK+KwkgNIi6LxmqRvbRw2aV61wxkCTmMn4kW2BzhoqGo39hEK3rhSx
        daql2U8y1Lw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40180B48B7;
        Sun,  5 Nov 2017 21:24:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A586FB48B5;
        Sun,  5 Nov 2017 21:24:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [RFC PATCH v3 3/4] branch: introduce dont_fail parameter for branchname validation
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
        <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
        <20171102065407.25404-4-kaartic.sivaraam@gmail.com>
Date:   Mon, 06 Nov 2017 11:24:14 +0900
In-Reply-To: <20171102065407.25404-4-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 2 Nov 2017 12:24:06 +0530")
Message-ID: <xmqq7ev4jga9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95CA62A2-C299-11E7-9CEF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> This parameter allows the branchname validation functions to
> optionally return a flag specifying the reason for failure, when
> requested. This allows the caller to know why it was about to die.
> This allows more useful error messages to be given to the user when
> trying to rename a branch.
>
> The flags are specified in the form of an enum and values for success
> flags have been assigned explicitly to clearly express that certain
> callers rely on those values and they cannot be arbitrary.
>
> Only the logic has been added but no caller has been made to use it, yet.
> So, no functional changes.

This step makes sense, and nicely done.

We usually use the word "gently" to when we enhance an operation
that used to always die on failure.  When there are tons of callsite
to the original operation F(), we introduce F_gently() variant and
do something like

	F(...)
	{
		if (F_gently(...))
			die(...);
	}

so that the callers do not have to change.  If there aren't that
many, it is OK to change the function signature of F() to tell it
not to die without adding a new F_gently() function, which is the
approach more appropriate for this change.  The extra parameter used
for that purpose should be called "gently", perhaps.

> +	if(ref_exists(ref->buf))
> +		return BRANCH_EXISTS;
> +	else
> +		return BRANCH_DOESNT_EXIST;

Always have SP between "if" (and other keyword like "while") and its
condition.

For this one, however, this might be easier to follow:

	return ref_exists(ref->buf) ? BRANCH_EXISTS : BRANCH_DOESNT_EXIST;

The names of the enum values may need further thought.  They must
clearly convey two things, in addition to what kind of status they
represent; the current names only convey the status.  From the names
of these values, it must be clear that they are part of the same
enum (e.g. by sharing a common prefix), and also from the names of
these values, it must be clear which ones are error conditions and
which are not, without knowing their actual values.  A reader cannot
immediately tell from "BRANCH_EXISTS" if that is a good thing or
not.

Other than that, looks fairly cleanly done.  I like what this step
wants to achieve.

Thanks.

