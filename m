Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 807BA20195
	for <e@80x24.org>; Fri, 15 Jul 2016 18:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbcGOST2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 14:19:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750996AbcGOST1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 14:19:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5F232D124;
	Fri, 15 Jul 2016 14:19:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vIuhUMhPFFlktfy+NKW1xjMO+K0=; b=aoK05h
	7FD5kt/KfmnoXIXC+0GOZD1j5RGZVlU1n7OMhWbYZY0vt9Q4LibHWiXzpJNW7WN5
	qoYLXpF2UNUI2RDi9JX1+R5ZX37dPKnBv+LDg/p+i+MoVW2+f6mMz+cLwBit3udN
	7fZa90VuJErduPqAnpK9JvtlveNegIB8O2wZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ga+1tUqSDapO/r/qqCbnlXS18sBdiwVx
	Kq0mxem59ga4l4CBpiPkat1yRIP9/16Ie1wmxFKEhSS4mpD5+2gCJQDf6HnIsEq1
	6QBGpTiE1XiKbl7ohut+B9AePYDkYQTCaOFkYRto+DEf3C5lATiCVwFPAUE2re4v
	qjVGiMU1B0Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CC6812D122;
	Fri, 15 Jul 2016 14:19:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 545962D120;
	Fri, 15 Jul 2016 14:19:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 05/12] check_connected: relay errors to alternate descriptor
References: <20160715102506.GA23164@sigill.intra.peff.net>
	<20160715103203.GE19271@sigill.intra.peff.net>
Date:	Fri, 15 Jul 2016 11:19:23 -0700
In-Reply-To: <20160715103203.GE19271@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 15 Jul 2016 06:32:03 -0400")
Message-ID: <xmqqbn1yn4r8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A924D7E2-4AB8-11E6-8AF3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +	/*
> +	 * If non-zero, send error messages to this descriptor rather
> +	 * than stderr. The descriptor is closed before check_connected
> +	 * returns.
> +	 */
> +	int err_fd;

Theoretically speaking it may be possible that a caller may want to
write to fd#0 if it closed the standard input before creating the
output channel for multiplexing into a sideband, but I think this
design strikes a good balance between the theoretical correctness
and usability.  Using err_fd == -1 as "no redirect" may allow the
caller to redirect the errors to fd#0, but that forces normal users
to explicitly set this field to -1.
