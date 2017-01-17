Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DD120756
	for <e@80x24.org>; Tue, 17 Jan 2017 22:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbdAQWVt (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 17:21:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54448 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751177AbdAQWVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 17:21:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58A6761C2A;
        Tue, 17 Jan 2017 17:19:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RJBWuSx+vNJd3xZsVaCge7fW/xE=; b=KpWTGy
        YL8MkR9Lr5tXWu3iSmaf/fwrnpFPYvmjDmQWcAq/K/E9HzAZCyllbw4xENRoVhNS
        ETfl4mgtPPejRP5FFKyOjRtwlNR8sVXtBVnifSAeO0C+CKj0x+dSug03e5lYyh2g
        WBFkkSfKA0WOjBfn8pxSqpnw/GXpHZ/xEAs8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gMlo+JO/UVgTac3rySyKsxqDZ8nnfUnH
        r92ZjO0gOdwFvqT6ZHe1yJUIfS+Cx5+4pYz4HXFD+xnBVWHLOuOH5K7A4BUnFK5m
        LCA+KiYd4qAyovQrQG8kl0tK1ZQWoUPJ9SAt9BwXUoZfvu2rzbpQ6KyD7aCsy1IO
        VijY258+bhM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4ECEE61C28;
        Tue, 17 Jan 2017 17:19:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1D3661C27;
        Tue, 17 Jan 2017 17:19:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote was configured
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
        <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de>
        <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 14:19:28 -0800
In-Reply-To: <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 17 Jan 2017 16:47:23 -0500")
Message-ID: <xmqqd1flcosv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03A92628-DD03-11E6-B38A-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Let's fix this by telling Git that a remote is not configured unless any
>> fetch/push URL or refspec is configured explicitly.
>
> I notice here that setting a refspec _does_ define a remote. Is there a
> reason you drew the line there, and not at, say, whether it has a URL?

"Not configured unless any URL or refspec is configured" means that
if URL is there, even if there is no refspec, then it is a remote
definition, right?  

But I think "what does it mean to define a remote" is a question
that you are asking, and that is not necessary to answer within the
scope of this topic.

I do agree that honoring .prune is nonsense unless refspecs are
defined, but the question "does it make sense to allow prune?"  is
different from "is it configured?".  Your "you can set .proxy and
other useful things, it is just .prune does not make sense" is a
quite appropriate statement to illustrate the difference.

Perhaps instead of adding "is it configured?" flag that is too
broadly named and has too narrow meaning, would it make more sense
to introduce "int can_prune(struct remote *remote)" that looks at
the remote refspecs?
