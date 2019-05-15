Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C661F461
	for <e@80x24.org>; Wed, 15 May 2019 01:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEOBml (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:42:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56200 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEOBmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:42:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85AB169317;
        Tue, 14 May 2019 21:42:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2t8oJ/QezYLzAc6R98dmxQOEzf4=; b=rfTB1l
        eJiQK1oX0oZzrl6MgfX247Wap38iq0HSf3bF/62AK39XwXg92uO3e5Mz3hxpxDfh
        rJ7bEduOnqDCiZ+8rZLJn/iuuaSFhiKwuwfqUAfF3orceHSVdi0Jqf7P8FFAQJNl
        YMBCNiiPCPX0bPNX90TQQUY0bfQuR+6AJ9kk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EcsWWazkECAjzgAxCedemDcM5CfS3pzr
        wAB1UBGxqUw48hoKplfELUkD3yOva1txT1+E5ZKTKPA8ptodRNBQps3LBgwziYuy
        jgubXFLpsPxSWJbNAcWngJi3U+3uYF3EdGyfEkKlvZppc3gaCAOQRyo2Ep1RYZCS
        qimP+eC0cCw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DA0469316;
        Tue, 14 May 2019 21:42:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEB2F69313;
        Tue, 14 May 2019 21:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
References: <pull.192.git.gitgitgadget@gmail.com>
        <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com>
        <xmqqo9469buw.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905141454510.44@tvgsbejvaqbjf.bet>
        <20190514144305.GA28530@sigill.intra.peff.net>
Date:   Wed, 15 May 2019 10:42:35 +0900
In-Reply-To: <20190514144305.GA28530@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 14 May 2019 10:43:06 -0400")
Message-ID: <xmqqa7fo8pdg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B827069C-76B2-11E9-B428-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do have a slight preference for going the _other_ way. There is no
> need to mark the parameter as const in the definition. It is passed by
> value, so nobody except the function body cares either way. And we have
> many function bodies where value-passed parameters (or local variables!)
> are not marked as const, even though they are only assigned to once.

That would be more like this patch, then?

-- >8 --
Subject: pkt-line: drop 'const'-ness of a param to set_packet_header() 

The fact that the incoming parameter is used as read-only in the
fuction is an implementation detail that the callers should not have
to know, and the prototype defined for the function in pkt-line.h
lacked the "const" for that reason, but apparently some compilers
complain about the parameter type mismatch.

Let's squelch it by removing the "const" that is pointless for a
small function like this, which would not help optimizing compilers
nor reading humans that much.

Noticed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index c9ed780d0b..a0e87b1e81 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -119,7 +119,7 @@ void packet_buf_delim(struct strbuf *buf)
 	strbuf_add(buf, "0001", 4);
 }
 
-void set_packet_header(char *buf, const int size)
+void set_packet_header(char *buf, int size)
 {
 	static char hexchar[] = "0123456789abcdef";
 
