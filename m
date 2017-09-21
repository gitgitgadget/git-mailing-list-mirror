Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F308020281
	for <e@80x24.org>; Thu, 21 Sep 2017 04:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdIUELp (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 00:11:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53518 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751283AbdIUELo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 00:11:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB0CBA8355;
        Thu, 21 Sep 2017 00:11:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NtpBOFDNtyl3
        fxUx08nxqT75Qgs=; b=Hz1UyWmDTrQia2Z9Gt6qr4WounUU7sg3Mx9WxtlbRfh+
        bCovp3DrFAelv4rzkTmXZkob02QFFMJUpOuQG8sdYyjl44D/1WaifY6icg8J2jfJ
        9vQfiMTwDfTtE0lWulRTyK+qEg0A2NKoSBY6XzXkFjBQS9Clz3BPlmNtq/vLWDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jBqopf
        0584Zj3HMChhyaAIoVC/dGCVYZ8yIejaHIL2+1O2zHDt8SiJpNYKzBOprnh+jxTO
        2fyMMGc6psJmshXsLx6rLeovnCNhm8TrElfoVbKPwEUKCNgTgfly9HXmQLnzpHge
        5syeQ7PpJqea6mrNIl/AYD5RCsvPYqoSzqDz8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1AC2A8354;
        Thu, 21 Sep 2017 00:11:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B25CA8353;
        Thu, 21 Sep 2017 00:11:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] revision: replace "struct cmdline_pathspec" with argv_array
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
        <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
        <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
Date:   Thu, 21 Sep 2017 13:11:36 +0900
In-Reply-To: <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 20 Sep 2017 16:36:59 -0400")
Message-ID: <xmqqingclmh3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F6DB7C7E-9E82-11E7-8344-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] revision: replace "struct cmdline_pathspec" with argv_=
array
>
> We assemble an array of strings in a custom struct,
> NULL-terminate the result, and then pass it to
> parse_pathspec().
>
> But then we never free the array or the individual strings
> (nor can we do the latter, as they are heap-allocated when
> they come from stdin but not when they come from the
> passed-in argv).
>
> Let's swap this out for an argv_array. It does the same
> thing with fewer lines of code, and it's safe to call
> argv_array_clear() at the end to avoid a memory leak.
>
> Reported-by: Martin =C3=85gren <martin.agren@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  revision.c | 39 +++++++++++----------------------------
>  1 file changed, 11 insertions(+), 28 deletions(-)

Makes sense.  Thanks for cleaning up the mess I made.
