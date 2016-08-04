Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C94C20193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758813AbcHDQOM (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:14:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758770AbcHDQOL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:14:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8050A31072;
	Thu,  4 Aug 2016 12:14:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PfB51pbgXR3S0rkqhIDlgOWhe0g=; b=kl0Sm9
	JvgFL1KBcV/u/HxNRE596kb/ircg7EEz/dSVmmLbFXw7K+jgtk19x3UnreFcKsYj
	ZwdnKAXy2FxBk8RYhhOKbPDhJg9uf5Tx/22zWhIQW4uVgI3OqfzWUbsEocEjwBe+
	CIgyeI/2TEkuJB1wrRdRBYK3uv8bGVN9eJPr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iCafI1OBkbpvg6pZ3VpHdk1jlexxpYKB
	TDYYLsFjxzLigswniPbfuYyBl7z9O7/EIdwNRU0h15n3hYUm5HUX4a4fQR3Yk7US
	voLgfvPViesODT5V3tlyLndeJ4V0nPYC9aJsYkm7UMz/rkIv/BQciV3vaX6TfYzD
	e2oYSowNHS8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76ACD31070;
	Thu,  4 Aug 2016 12:14:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF11E3106F;
	Thu,  4 Aug 2016 12:14:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 01/12] pkt-line: extract set_packet_header()
References: <20160729233801.82844-1-larsxschneider@gmail.com>
	<20160803164225.46355-1-larsxschneider@gmail.com>
	<20160803164225.46355-2-larsxschneider@gmail.com>
	<xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com>
	<20160803211221.t2zdhvwjum2baeqs@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 09:14:04 -0700
In-Reply-To: <20160803211221.t2zdhvwjum2baeqs@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 17:12:22 -0400")
Message-ID: <xmqqeg645x6b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 781BE5A4-5A5E-11E6-982A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The cost of write() may vary on other platforms, but the cost of memcpy
> generally shouldn't. So I'm inclined to say that it is not really worth
> micro-optimizing the interface.
>
> I think the other issue is that format_packet() only lets you send
> string data via "%s", so it cannot be used for arbitrary data that may
> contain NULs. So we do need _some_ other interface to let you send a raw
> data packet, and it's going to look similar to the direct_packet_write()
> thing.

OK.  That is a much better argument than "I already stuff the length
bytes in my buffer" (which will invite "How about stop doing that?")
to justify a new "I have N bytes of data, send it out", whose
signature would look more like write(2) and deserve to be called
packet_write() but unfortunately the name is taken by what should
have called packet_fmt() or something, but that squats on a good
name packet_write().  Sigh.




	
