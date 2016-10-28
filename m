Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407E32035F
	for <e@80x24.org>; Fri, 28 Oct 2016 22:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756635AbcJ1WAb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 18:00:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63895 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754138AbcJ1WAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 18:00:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93A994A765;
        Fri, 28 Oct 2016 18:00:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bZuVRpABoLN3zwObz4D+aDWYVfQ=; b=E2WHXy
        22Jozukwmhm7fklfq/Ye2kkx5rdQ7RTZQhgQjYWHcyRSjCd5ncr1CJKC9isR6gEw
        oMQaXD4sU5L7IhnKbGeEGcGwjX/FuA2AKVD4a+lpRdUbp+x8QRlGMUOXHIbmeBCg
        mO8/5KB21RPQozKwDQxBEgWLC8RjBM0gRFzfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DC3dctoENNhwhzrZuY/BowX946BHUkac
        VaFIVhAMV04KYWNP5glbo40CZyF82EITfXPD6Cj2DLAXbTUq11odLj8TMVXVCU90
        brFofYHsoSmZg1k7gm9vgQJyXJ2GxrJiUQejJ6Tbpw21nvSojZR51dlqPl1hUWa4
        /I2j+oqlomU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B46C4A764;
        Fri, 28 Oct 2016 18:00:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BD684A763;
        Fri, 28 Oct 2016 18:00:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: Fetch/push lets a malicious server steal the targets of "have" lines
References: <1477690790.2904.22.camel@mattmccutchen.net>
Date:   Fri, 28 Oct 2016 15:00:26 -0700
In-Reply-To: <1477690790.2904.22.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Fri, 28 Oct 2016 17:39:50 -0400")
Message-ID: <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFB4CFD4-9D59-11E6-B695-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> I was studying the fetch protocol and I realized that in a scenario in
> which a client regularly fetches a set of refs from a server and pushes
> them back without careful scrutiny, the server can steal the targets of
> unrelated refs from the client repository by fabricating its own refs
> to the "have" objects specified by the client during the fetch.

Let me see if I understood your scenario correctly.

Suppose we start from this history where 'O' are common, your victim
has a 'Y' branch with two commits that are private to it, as well as
a 'X' branch on which it has X1 that it previously obtained from the
server.  On the other hand, the server does not know about Y1 or Y2,
and it added one commit X2 to the branch 'x' the victim is
following:

           victim                server

             Y1---Y2               
            /                      
    ---O---O---X1           ---O---O---X1---X2

Then when victim wants to fetch 'x' from the server, it would say

    have X1, have Y2, have Y1, have O

and gets told to shut up by the server who heard enough.  The
histories on these two parties will then become like this:


           victim                server

             Y1---Y2               
            /                      
    ---O---O---X1---X2      ---O---O---X1---X2

Victim wishes to keep Y1 and Y2 private, but pushes some other
branch (perhaps builds X3 on top of X2 and pushes 'x').  On push
protocol, the server would lie to the victim that it has Y2 without
knowing what they are.

Is that how your attack scenario goes?
