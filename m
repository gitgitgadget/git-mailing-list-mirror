Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BCF71FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934796AbcHJUiW (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:38:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753132AbcHJSPn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:15:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 15B8D30F21;
	Wed, 10 Aug 2016 13:18:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sm/taaEGV+7rPagpGPrOnnGOy8Y=; b=vj68EF
	ZNW3BFZ633i/hyVMSal9XMH7PJx8KSZ0Zm78R//cRTueXWNAQcTLIZj+tv/8sXBL
	5b7d8rt964t7fwldE9zuAG1udXaTQNKQqNq41/JRC+6G0nbzt+aLKsbZB0zcI2r/
	8AVmz/15h+roOUJyX1h/MOx99WykIBWsVWZkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CSuOQoVqFEqEY9KqfcBs6opyX/3U4pfP
	3CHg1DoTguGBa64TQNJdBBS7H2rOdQUWNSf82bdE1xwFWrYg5E/Q7uvKbmhoVJHt
	CrPnAU+B5bMRPe/vLuCaknzVbNEewPZ/4k5OhMSmzkvZzV0ov8SLZzpe2BeEUqSs
	jlCHzhl6hr4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D99E30F20;
	Wed, 10 Aug 2016 13:18:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85EED30F1C;
	Wed, 10 Aug 2016 13:18:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Subject: Re: [PATCH v5 05/15] pkt-line: add packet_write_gently_fmt()
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
	<20160810130411.12419-1-larsxschneider@gmail.com>
	<20160810130411.12419-6-larsxschneider@gmail.com>
	<20160810134346.6nmf2sudwh56nq76@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 10:18:32 -0700
In-Reply-To: <20160810134346.6nmf2sudwh56nq76@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 10 Aug 2016 09:43:47 -0400")
Message-ID: <xmqqpopg5yqf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77E08792-5F1E-11E6-8459-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 10, 2016 at 03:04:01PM +0200, larsxschneider@gmail.com wrote:
>
>> +int packet_write_gently_fmt(int fd, const char *fmt, ...)
>> +{
>> +	static struct strbuf buf = STRBUF_INIT;
>> +	va_list args;
>> +
>> +	strbuf_reset(&buf);
>> +	va_start(args, fmt);
>> +	format_packet(1, &buf, fmt, args);
>> +	va_end(args);
>> +	packet_trace(buf.buf + 4, buf.len - 4, 1);
>> +	return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
>> +}
>
> Could the end of this function just be:
>
>   return packet_write_gently(fd, buf.buf, buf.len);
>
> ? I guess we'd prefer to avoid that, because it incurs an extra
> memmove() of the data.
>
> Similarly, I'd think this could share code with the non-gentle form
> (which should be able to just call this and die() if returns an error).
> Though sometimes the va_list transformation makes that awkward.

Yes.

Also regarding the naming, please have "_gently" at the end; that is
how all other function families with _gently variant are named, I
think.
