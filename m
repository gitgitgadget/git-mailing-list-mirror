Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304201F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbcIGSbo (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:31:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63815 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751147AbcIGSbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:31:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B25A23C26C;
        Wed,  7 Sep 2016 14:31:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VIhEk5RmYqy69ICRQzQi5RyrH7E=; b=WqpITN
        6Oa6eKuFWugSuqjIG1Bw1wTb2EUcR2uR2po7NLyMUUmYFu62V3K+/IU1BLeV8FSP
        gMfXhVrx5vbTcvJkMz+C1xYNPLc752LYVvk7DzxwD+O85fDQfaGEhLfi87zB4HVz
        a1qmaGNcePXQeKWbMvk/EqMJrWng3CgzrvEN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rb2Ci/+/mSgoDtk1y7oA0RnapRyCDHr9
        yD9KndUY28ZEMrKcMUp53AsUwwxpwQhxrymXs4bJsz0Rc6fMup+DEzy3rzarUywm
        nNJi+zQ81psUd7oa4917ror/rzoAQh0pmLo5DuNj965L6Rj0ewgdlkPLvWnOaunU
        ODsjQNZ23GY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB1F03C26B;
        Wed,  7 Sep 2016 14:31:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 325EA3C26A;
        Wed,  7 Sep 2016 14:31:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
        <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de>
        <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net>
        <alpine.DEB.2.20.1609061613270.129229@virtualbox>
        <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net>
Date:   Wed, 07 Sep 2016 11:31:39 -0700
In-Reply-To: <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 6 Sep 2016 14:41:43 -0400")
Message-ID: <xmqqinu7muic.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 520F4A00-7529-11E6-B28C-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> What happens to those poor souls on systems without REG_STARTEND? Do
> they get to keep segfaulting?
>
> I think the solution is to push them into setting NO_REGEX. So looking
> at this versus a "regexecn", it seems:
>
>   - this lets people keep using their native regexec if it supports
>     STARTEND
>
>   - this is a bit more clunky to use at the callsites (though we could
>     _create_ a portable regexecn wrapper that uses this technique on top
>     of the native regex library)
>
> But I much prefer this approach to copying the data just to add a NUL.

I first thought "push them to NO_REGEX" to mean "they live with
crippled Git that does not do regexp" and went "Huh?", but it merely
means "let's avoid platform regex library and use on from the
compat/ hierarchy", which would solve the STARTEND portability issue
for everybody.

Which is very good.

The idea to create a thin regexecn() wrapper also sounds like a good
idea, too.  The changes to the callsites in the demonstration patch
does look a bit clunky to me, too.

