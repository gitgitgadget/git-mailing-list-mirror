Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD8620229
	for <e@80x24.org>; Fri, 21 Oct 2016 16:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754915AbcJUQuy (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 12:50:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64308 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754781AbcJUQux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 12:50:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B22D44AD1;
        Fri, 21 Oct 2016 12:50:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z8uwJTObneEpgV55W6yoNxcGvuc=; b=H1E2Qt
        y5a5ftLeLTCAikL4qJejnlZ2tRFXqRuoq01eCsx1WwNCtFXUp6RWSEXz3r6mSmnK
        3AehkET+W61O+2b3mJhnzabogTvZLcC1N4FVmpFaBx20z5Oy7AZngL5b0T4vLg10
        CwnsdZca6ArwyaI5XDmIOFv0iF2AdLo+SNk10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NfLyui9gzQbNBUFAKyxgwRcpCLH6doHe
        DN5hzsIhiHLOlQrtZ/PjUE1uytAV0MEMZO3eZZjFgxo28+5HQ3AgzhJtQeXI8D8R
        f9ajDuNUv73zd/dtvdiUwvHuwRE+WPAmVmfx2iWNIJ2JMYXufsPUhTvazeoUK570
        SuCes4J6Xtc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3DB244AD0;
        Fri, 21 Oct 2016 12:50:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D21944ACD;
        Fri, 21 Oct 2016 12:50:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] fetch output is ugly in 'next'
References: <20161021002654.qo6kcya4gocp73rs@sigill.intra.peff.net>
        <CACsJy8Bxn1qV+xXNnCpuOQ7qWNsz3oLt5-VG=VXZvV9dvJVvTQ@mail.gmail.com>
        <CACsJy8CkK8K0ty3fv9qyD7wwB+81VPB-P1UUCbDJTJ4iM0Y+Cw@mail.gmail.com>
Date:   Fri, 21 Oct 2016 09:50:49 -0700
In-Reply-To: <CACsJy8CkK8K0ty3fv9qyD7wwB+81VPB-P1UUCbDJTJ4iM0Y+Cw@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 21 Oct 2016 20:07:22 +0700")
Message-ID: <xmqqd1itd4t2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 864BDFCA-97AE-11E6-9095-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Oct 21, 2016 at 7:11 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Yeah.. replacing the 4 DEFAULT_ABBREV in fetch.c with something
>> sensible should do it.
>
> Correction (if somebody will pick this up), it's
> TRANSPORT_SUMMARY_WIDTH that needs to be adjusted, not those four.

Yes, it used to be and it still is (2 * DEFAULT_ABBREV + 3) but in
the new world order where default-abbrev is often -1 the expression
does not make much sense.

Perhaps something along this line?

 transport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.h b/transport.h
index 18d2cf8275..5339fabbad 100644
--- a/transport.h
+++ b/transport.h
@@ -127,7 +127,7 @@ struct transport {
 #define TRANSPORT_PUSH_CERT 2048
 #define TRANSPORT_PUSH_ATOMIC 4096
 
-#define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+#define TRANSPORT_SUMMARY_WIDTH (2 * (DEFAULT_ABBREV < 0 ? 7 : DEFAULT_ABBREV) + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
 
 /* Returns a transport suitable for the url */
