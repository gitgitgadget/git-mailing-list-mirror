Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0943820281
	for <e@80x24.org>; Thu, 21 Sep 2017 03:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbdIUDCT (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 23:02:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751462AbdIUDCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 23:02:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 990FFA77D7;
        Wed, 20 Sep 2017 23:02:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lbCYMeORTnRxLuigkPy23xgCfdk=; b=YCnZWK
        CfZH6fH1D4+r8xeqfsk+jXuPz1rxUfiBXPPOd5MHeDQcoZSVHqSzcpFoekoGZ6Bu
        rIbjMrizXur/7SOkAVf60KWykbikZQFq7iC/DX+S69RJO65NPPMa8oqh5wO/by2I
        1VpD4R7ooCsBFAnwAht/d59EcR6SHUd2s6A6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fnDipZKyLH92i4/+N2Qis0rhr9rGzsiI
        aVZqfXvSrO5doALtDdpoOkyP2oGwu3wH6/Dq2beH18YZbEwgMnMstOh8G65ZW9GX
        F/YiHdyYdOJ9NovZw+gjEraJckNh2wPYdgN6GwsiOPBxqn/JfB5yoZh5MvqTX/24
        3bx+uquXj4E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F04AA77D6;
        Wed, 20 Sep 2017 23:02:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC75BA77D4;
        Wed, 20 Sep 2017 23:02:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 1.5/8] connect: die when a capability line comes after a ref
References: <20170913215448.84674-1-bmwill@google.com>
        <20170920184832.146564-1-bmwill@google.com>
        <20170920191431.emornzhse6f7s5mg@sigill.intra.peff.net>
        <20170920200627.GA82704@google.com>
Date:   Thu, 21 Sep 2017 12:02:16 +0900
In-Reply-To: <20170920200627.GA82704@google.com> (Brandon Williams's message
        of "Wed, 20 Sep 2017 13:06:27 -0700")
Message-ID: <xmqqmv5olpon.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 471A49F4-9E79-11E7-9AA2-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> Or is this only for v2 clients, and we've changed the protocol but
>> get_remote_heads() just needs to be updated, too?
>
> A client which didn't request protocol v1 (I'm calling the current
> protocol v0, and v1 is just v0 with the initial response from the server
> containing a version string) should not receive a version string in the
> initial response.  The problem is that when introducing the version
> string to protocol version 1, I didn't want to have to do a huge
> refactoring of ALL of the current transport code so I stuck the version
> check in get_remote_heads() since v1 is exactly the same as v0, except
> for the first line from the server.

It is still unclear from your response what other things the server
is now allowed to say before "version".  I have a slight suspicion
that this change makes the input language overly loose.  Before
eb398797 ("connect: advertized capability is not a ref", 2016-09-09)
made the "dummy ref must come before any ref and no refs should be
sent if there is a dummy ref sent", the code before it used to allow
a ".have" or a "shallow" to appear at the beginning, but with the
"anything from the other end whatsoever is not allowed before the
dummy one" check the commit introduced, it made it a protocol error
to send these before dummy ref advertisement.  But with this patch,
you are again allowing them to come before the dummy ref, together
with the "version" line you recently added.  I do not know if it is
a problem in practice or not offhand, though.

