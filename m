Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53C682018A
	for <e@80x24.org>; Tue, 28 Jun 2016 22:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbcF1WdS (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 18:33:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752209AbcF1WdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 18:33:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DED326D98;
	Tue, 28 Jun 2016 18:33:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/1TsLr09DcC+rFKZygyKLW2AoyQ=; b=Xq7WbP
	XvLIyN65+z2Adqdn0o6oWxFWjT/WkRqy/NNt8l10JjafwD7kXYIorUAT0gdqNRm/
	VCDrENAEjWA3VDqVLJKbvaDFJQU8pIytGi103Ki7emuU9a4bXxWRWyP7JSmUhTi0
	nRB2L3HVjW3hhpAm0tyCBQ6KutncHB838iqIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GUeJS7lg3ib9CNC0ccfjbfAO/cdPMGWY
	sM8t0t2TSg04LX0xXiB+SdmVJ52ZXLbYLGk8qgFrYjRYftNyFsug99eCx7BocKDU
	E5haudehJdCuM+PgPxdmM6KP08E2GbhoMBl+cNpB9oEeHjdxdneA8isM+Ue++JLt
	NY4mhIca+Kc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 153BD26D97;
	Tue, 28 Jun 2016 18:33:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B6F326D95;
	Tue, 28 Jun 2016 18:33:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160628043526.19403-1-lfleischer@lfos.de>
	<xmqqa8i59rph.fsf@gitster.mtv.corp.google.com>
	<xmqq60st9qg5.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
	<xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr>
	<xmqq60st853d.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr>
	<xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr>
Date:	Tue, 28 Jun 2016 15:33:09 -0700
In-Reply-To: <alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr> (Nicolas
	Pitre's message of "Tue, 28 Jun 2016 17:44:30 -0400 (EDT)")
Message-ID: <xmqqfurx6j16.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BA8700A-3D80-11E6-8791-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

>> The basic structure of the code (without the "SQUASH" we discussed)
>> looks like this:
>> 
>> 	strbuf_addf(&outbuf, "%s", PREFIX);
>> 	while (retval == 0) {
>> 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
>> 		...
>> 		band = buf[0] & 0xff;
>> 		switch (band) {
>> 		case 3:
>> 			... /* emergency exit */
>> 		case 2:
>> 			while ((brk = strpbrk(b, "\n\r"))) {
>> 				int linelen = brk - b;
>> 
>> 				if (linelen > 0) {
>> 					strbuf_addf(&outbuf, "%.*s%s%c",
>> 						    linelen, b, suffix, *brk);
>> 				} else {
>> 					strbuf_addf(&outbuf, "%c", *brk);
>> 				}
>> 				fprintf(stderr, "%.*s", (int)outbuf.len,
>> 					outbuf.buf);
>> 				strbuf_reset(&outbuf);
>> 				strbuf_addf(&outbuf, "%s", PREFIX);
>> 				b = brk + 1;
>> 			}
>> 			if (*b)
>> 				strbuf_addf(&outbuf, "%s", b);
>> 			break;
>> 		...
>> 		}
>> 	}
>> 
>> 	if (outbuf.len > 0)
>> 		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
>>  ...
> That won't work. If at this point there is the beginning of a partial 
> line queued in the buffer from the previous round waiting to see its 
> line break, you just deleted the beginning of that line.

Ahh, OK, a single logical line split into two and sent in two
packets--the first one would not result in any output (just does "if
(*b) strbuf_addf(...)" to buffer it) and then the second one finally
finds a LF.  Yeah, that won't work if we cleared.

But then my observation still holds, no?

	while () {
        	read();
                switch () {
                case 2:
                	while ((brk = strpbfk())) {
                        	/* we have LF! we'll say something! */
                                strbuf_splice(&outbuf, 0, 0,
                                	      PREFIX, strlen(PREFIX));
                                strbuf_addf(&outbuf, ...);
                                fwrite(...);
				b = brk + 1;
			}
                        if (*b)
                        	strbuf_addstr(&outbuf, b);
			break;
		}
	}

        if (outbuf.len) {
        	/* we still have something to say */
                strbuf_splice(&outbuf, 0, 0, PREFIX,
        	strlen(PREFIX));
                fwrite(...);
	}
