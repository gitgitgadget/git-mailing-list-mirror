Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B45209AB
	for <e@80x24.org>; Mon, 26 Sep 2016 17:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161503AbcIZReC (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:34:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63625 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030261AbcIZReB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:34:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C30234121D;
        Mon, 26 Sep 2016 13:33:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vLJ+ggJe9dpOOimF4R+inAJatkM=; b=gaBs8F
        IJDrUHuWqAo1mzrXiLHx+cV+wocZNbXFqmpInv2FQ/mADVX7mR1Z4axy4nT2f7tx
        B3N/NVlzeOEEF6pX7kj95gVi3gxAQKcdMHrsUAZKgGqcifONGIQ3pNBBCZZNSqd1
        SkdiZJH85PE8mIcsbU103fu4H39/ExA/MuEEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LlnWz4m0r/+6sMyntXeLuphXn6LPlBVi
        3fKNQUlRaWx0EvAknYN46BYQuuhQ/zetemOeS1uqQbwB5AU8FhtKOTlAPRYPFScz
        H13QATc2cbcQvnXPzpjDWJnA2E3gOk+5OrjEiO3BkItS/v+BNHm0ZR6K+OUo6iPj
        6/YpqLj9po0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA9224121B;
        Mon, 26 Sep 2016 13:33:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C7A44121A;
        Mon, 26 Sep 2016 13:33:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
        Gustavo Grieco <gustavo.grieco@imag.fr>
Subject: Re: [PATCH] unpack_sha1_header(): detect malformed object header
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
        <xmqqshsnuvvz.fsf_-_@gitster.mtv.corp.google.com>
        <20160926140309.l2h4b65gpqyutepn@sigill.intra.peff.net>
        <xmqqfuomvdqe.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Sep 2016 10:33:57 -0700
In-Reply-To: <xmqqfuomvdqe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 26 Sep 2016 09:15:53 -0700")
Message-ID: <xmqqshsmtvju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 686B1E10-840F-11E6-B529-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Good that your attempt to signature-changing change caught it.  I'll
> take a further look.

So here are two patch series.  The first one makes sure all callers
of parse_sha1_header() check the returned status.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 26 Sep 2016 09:23:41 -0700
Subject: [PATCH 1/2] streaming: make sure to notice corrupt object

The streaming read interface from a loose object called
parse_sha1_header() but discarded its return value, without noticing
a potential error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 streaming.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/streaming.c b/streaming.c
index 811fcc2..884a8f1 100644
--- a/streaming.c
+++ b/streaming.c
@@ -347,7 +347,8 @@ static open_method_decl(loose)
 		return -1;
 	}
 
-	parse_sha1_header(st->u.loose.hdr, &st->size);
+	if (parse_sha1_header(st->u.loose.hdr, &st->size) < 0)
+		return -1;
 	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
 	st->u.loose.hdr_avail = st->z.total_out;
 	st->z_state = z_used;
-- 
2.10.0-533-ga18d90d

