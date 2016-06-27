Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C072018A
	for <e@80x24.org>; Mon, 27 Jun 2016 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbcF0RuS (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 13:50:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751638AbcF0RuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 13:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1F3B28332;
	Mon, 27 Jun 2016 13:50:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AbP61eaNbspURO6UpcBZc5Zgd3w=; b=Ga5KwN
	9F0wc4hhSfLFhJxX32pCUuvUvaCq8dy/pdfld0j5wL2/NxkU/1Gls/nIXeCBSmb2
	/YKbTI7Fwjuyq4auWRO2yUusw5MZPDXYJUCgwjHSQIaL+nnVcwp2bJ+yQnnbuGsT
	qcTkZMEadsAbQuBW+rNlfCDrjgVO/wWzsHbww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sYDSQUpbw/X77VJGIPegAeRMpGcxxKY5
	oVMQWYiXWc07oUk0K9g2jz7xPIQ8nyJ1SWqp/z1NNB2EScz1uyKRRLkAWhiYYyY2
	3iUu0h6pAzBOMW9Gj0S+gVXsZMpMLQCxWFRlT4ovgVJivFGfKA42CO2TQfElWCil
	cug6LUnEP8c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9FD728330;
	Mon, 27 Jun 2016 13:50:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F92C2832F;
	Mon, 27 Jun 2016 13:50:15 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Lukas Fleischer <lfleischer@lfos.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160614210038.31465-1-lfleischer@lfos.de>
	<20160624153121.GA2494@sigill.intra.peff.net>
	<alpine.DEB.2.20.1606241942220.12947@virtualbox>
	<20160624181414.GA25768@sigill.intra.peff.net>
	<CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
	<146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de>
	<xmqqr3bibpap.fsf@gitster.mtv.corp.google.com>
	<20160627161616.GA4430@sigill.intra.peff.net>
Date:	Mon, 27 Jun 2016 10:50:13 -0700
In-Reply-To: <20160627161616.GA4430@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 27 Jun 2016 12:16:17 -0400")
Message-ID: <xmqqbn2mbjxm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AA6FA10-3C8F-11E6-939B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 27, 2016 at 08:54:22AM -0700, Junio C Hamano wrote:
>
>> It's just you used xwrite() there that introduced a different issue.
>> Wouldn't replacing it with fwrite(stderr) without changing anything
>> else solve that?
>
> I am having trouble actually seeing how the ANSI-emulation code gets
> triggered, but the comment in color.h implies that it is only printf,
> fprintf, and fputs that have the desired effect. So fwrite() may not be
> sufficient, and we may need fprintf("%.*s", len, buf) or something.

I have no idea how, either X-<.  But you're probably right about the
magic being limited to the printf family of functions---I do recall
hearing something like that in the past.
