Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4501F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758317AbcHCUTA (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:19:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758124AbcHCUS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:18:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C5C4730A6B;
	Wed,  3 Aug 2016 16:18:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pcqkZnqvgaShvG0NvkudOvdKfOk=; b=BDkoJ2
	13gz6JZ6AVYkQszoZTOW77sPRF8tklMaLSGjA/IWosk9Wq8SsNk9XcYdb+q+pwQ2
	6w0NK/mei9e3JkzVi+rir+Jvb2/s105i8wIPdaUG4BzN28hMpbmY29cLEyVMV88e
	s/H1f0JSBg8hnDkJuJ2ZrtxQ6FFU6gecq973g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gtc1TBHH7TDI4fpZX+Nj/+M7Kaw7bIea
	yvycTqqtq4yS17hf8iXVfucMfq4+KgEIdYdgkirsN/te4WWfeb5nbU8x/2tFB2yZ
	d67q7fRZm4soY3Jg2XQHE/rN9WxUUGVy8++BDrXyWP2XCUyGeSmcNklHqKuypcVQ
	p5aWf++M1w8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BAEB730A6A;
	Wed,  3 Aug 2016 16:18:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 374B330A69;
	Wed,  3 Aug 2016 16:18:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Subject: Re: [PATCH v4 01/12] pkt-line: extract set_packet_header()
References: <20160729233801.82844-1-larsxschneider@gmail.com>
	<20160803164225.46355-1-larsxschneider@gmail.com>
	<20160803164225.46355-2-larsxschneider@gmail.com>
Date:	Wed, 03 Aug 2016 13:18:55 -0700
In-Reply-To: <20160803164225.46355-2-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 3 Aug 2016 18:42:14
	+0200")
Message-ID: <xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81CDE144-59B7-11E6-ADCD-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> set_packet_header() converts an integer to a 4 byte hex string. Make
> this function locally available so that other pkt-line functions can
> use it.

Didn't I say that this is a bad idea already in an earlier review?

The only reason why you want it, together with direct_packet_write()
(which I think is another bad idea), is because you use
packet_buf_write() to create a "<header><payload>" in a buf in the
usercode in step 11/12 like this:

+	packet_buf_write(&nbuf, "command=%s\n", filter_type);
+	ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);

which would be totally unnecessary if you just did strbuf_addf()
into nbuf and used packet_write() like everybody else does.

Puzzled.  Why are steps 01/12 and 02/12 an improvement?

