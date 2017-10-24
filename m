Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0893202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 02:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbdJXCBZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 22:01:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751226AbdJXCBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 22:01:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 897D496137;
        Mon, 23 Oct 2017 22:01:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bVFOc0Q6WSlvSPSiefa6wgfXG6o=; b=D0Fk7t
        v54cfklG8AqSfX1whv/4csTeo974frUq9c17xmX4Imlo4OfJf9srI+gnqP0y2Xzm
        xRdc7CW+RVeSfJ8krBWQwtwI4a7mgVDve4gq2ARK00BqaCyWa0DE03mTJNfwx3kN
        nb4XiwgCqwBCwbu8dMJO+dRyiZJkOMgUUywow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XtxEKdWGVecOIIFFkn+28zPysvkcZBGN
        azp0kFFxMb0lpFINt5rmgXVgYiQ5xp5z/ggFylYwPHWXvasmUvG1VMRQinm/Mmt/
        d4ByF2s+lm9/1rxUc27qf7UV0PuwEutf22Ck4cxFegE/LEgw2KL9dTCzrh+BXMxE
        Oo5bbtCJBGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 816D796136;
        Mon, 23 Oct 2017 22:01:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E760296135;
        Mon, 23 Oct 2017 22:01:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH 2/5] connect: split ssh command line options into separate function
References: <20171003201507.3589-11-bmwill@google.com>
        <20171003214206.GY19555@aiede.mtv.corp.google.com>
        <20171016171812.GA4487@google.com>
        <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
        <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
        <20171023151929.67165aea67353e5c24a15229@google.com>
        <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
        <20171023225106.GA73667@google.com>
        <20171023155713.5055125d7467d8daaee42e32@google.com>
        <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
        <20171023231733.tattcu2aws7kgous@aiede.mtv.corp.google.com>
Date:   Tue, 24 Oct 2017 11:01:22 +0900
In-Reply-To: <20171023231733.tattcu2aws7kgous@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 23 Oct 2017 16:17:33 -0700")
Message-ID: <xmqqh8up9udp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CD83F82-B85F-11E7-AA18-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The git_connect function is growing long.  Split the portion that
> discovers an ssh command and options it accepts before the service
> name and path to a separate function to make it easier to read.
>
> No functional change intended.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
> As before, except for the Reviewed-by.
>
>  connect.c | 116 +++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 61 insertions(+), 55 deletions(-)

Looks like a straight-forwrd split.  Makes sense.

Thanks.
