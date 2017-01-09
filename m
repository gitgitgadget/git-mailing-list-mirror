Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A771120756
	for <e@80x24.org>; Mon,  9 Jan 2017 10:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758774AbdAIKcM (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 05:32:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52908 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753588AbdAIKcE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 05:32:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08E2D56D96;
        Mon,  9 Jan 2017 05:32:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ObH8GvxsOZqT98380ORtIup26E=; b=igcpkS
        SOtGzQ8Wq8EDOXjBHlNq9ZR9gTcNzerahvOdo+zbLw813yZU4ujqLjWFKWba8VFs
        QpShZQCBATizl+pjscS5Hq+U1eIYIY+TQtqEqRK09c2olHdH0GagMABy7O98SVBD
        7oV5+cC+It6GW7ymCkW1S47x/+vCm5q0SFWm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Asrh4jv+GG2TUMHUnp9cW1VeXmIpfpNP
        eQPdyp7x+d1XGnIqG9abqpIsKvyXc+oyfHbJ6j80fKlJXo9Liv7iD/jOgZjNC2uL
        fERXrNxm4jG7BNochLVvt0s9oCQgQAEyLVnbQUGhgcSrOa0ELnPfTibDpaJo4ST3
        HYYtcDhLiPc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0034C56D94;
        Mon,  9 Jan 2017 05:32:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5108756D91;
        Mon,  9 Jan 2017 05:32:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch_get_push: do not segfault when HEAD is detached
References: <20170106045623.21118-1-kyle@kyleam.com>
        <alpine.DEB.2.20.1701061438300.3469@virtualbox>
        <87inprllpv.fsf@kyleam.com>
        <20170107011138.uuy6ob234kyy3y4e@sigill.intra.peff.net>
        <87bmvjll8m.fsf@kyleam.com>
        <20170107013126.4ub726mf73y36of3@sigill.intra.peff.net>
Date:   Mon, 09 Jan 2017 02:32:00 -0800
In-Reply-To: <20170107013126.4ub726mf73y36of3@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 6 Jan 2017 20:31:26 -0500")
Message-ID: <xmqqy3ykwmlb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBBCF7DC-D656-11E6-9B1E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jan 06, 2017 at 08:19:53PM -0500, Kyle Meyer wrote:
>
>> > The other option is just "git checkout --detach", which is also used in
>> > the test suite. I tend to prefer it because it's a little more obvious
>> > to a reader.
>> 
>> True, that does seem clearer.  Seems I should've waited a bit before
>> sending out v2.
>
> I think it's OK either way. Junio can also mark it up while applying,
> too, if he has a preference.

I prefer <commit>^0 in scripts, simply because it is shorter, works
with any version of Git that knows how to detach, even the ones
before --detach was introduced.  I offhand do not recall which
between <commit>^0 and <commit>^{} came earlier, but in practice I
saw nobody write the latter, so Dscho's suggestion is definitely an
improvement.

I do also care about "git checkout --detach" to keep working
correctly, but as long as we have dedicated tests to ensure that,
we'd be fine.  In the case of the test being discussed, we assume
either should work correctly and the point of the test is not about
ensuring that <commit>^0 or --detach works, so either is OK.

Anyway, thanks for a patch and a review.

