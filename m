Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848FE2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 15:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbcF0Pyc (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 11:54:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751745AbcF0Pyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 11:54:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B809F278E1;
	Mon, 27 Jun 2016 11:54:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hc4yhKeKM4P8v7n8yhr1yU2yuY8=; b=anlcB4
	+NSFLgPjH2AlUH1go1wHVRTSrVcr9P0ukL/z1LfMxfEgGfooqxplHtd/xmDwGa0K
	YNLg7fuoV3tleLJnKI4pFXW4AbPKn4KQysz1w9rV+jikd8XzC/LxUGlFl7esK7+Q
	cAxhtK3+zkDgcQNRikGtnfE88mt5w0m00lQdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MgNbpCDXBBSnf/H7WD/VniJmGxnNje6l
	WZ67KlMICiZppjBe+rwdYiyiQRzk2D1Cj5c8xoN1azB3D2LrWGoqykIITrvcRUzS
	mra3BmP19V0WAB5spsa8RMiIRIbZjTEdv4fcL/lPIubvPkQKWsy1ZOeAO42rQEEO
	c3aA5RDhKhA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B044B278E0;
	Mon, 27 Jun 2016 11:54:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37DD5278DF;
	Mon, 27 Jun 2016 11:54:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lukas Fleischer <lfleischer@lfos.de>
Cc:	"Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@fluxnic.net>, "Johannes Sixt" <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160614210038.31465-1-lfleischer@lfos.de>
	<20160624153121.GA2494@sigill.intra.peff.net>
	<alpine.DEB.2.20.1606241942220.12947@virtualbox>
	<20160624181414.GA25768@sigill.intra.peff.net>
	<CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
	<146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de>
Date:	Mon, 27 Jun 2016 08:54:22 -0700
In-Reply-To: <146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de>
	(Lukas Fleischer's message of "Mon, 27 Jun 2016 12:58:04 +0200")
Message-ID: <xmqqr3bibpap.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B79B062-3C7F-11E6-ABD2-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lukas Fleischer <lfleischer@lfos.de> writes:

> On Fri, 24 Jun 2016 at 20:32:28, Junio C Hamano wrote:
>> On Fri, Jun 24, 2016 at 11:14 AM, Jeff King <peff@peff.net> wrote:
>> >
>> > I do wonder about the ANSI_SUFFIX thing, though.
>> 
>> compat/winansi.c seems to have a provision for 'K' (and obviously 'm'
>> for colors).
>
> So we probably want to switch back to using fprintf() or fputs() and
> rely on the assumption that these functions use atomic write()
> operations internally when printing to stderr (on practically relevant
> systems, i.e., libc implementations), right?
>
> Another option is using write() on all systems but Windows and fall back
> on fputs() but that feels a bit like over-engineering at this point.

Wait a bit.

The original used to use one fprintf(stderr) per line it outputs.
That does not necessarily guarantee atomicity (i.e. the payload
string may be large and make stdio decide to do multiple writes).

The issue found in your first round (sent on Jun 13) was that you
did multiple fprintf(stderr) when showing a single line, which is
guaranteed to result in multiple writes because stderr is not
line-buffered.  But that was corrected in your second round.

It's just you used xwrite() there that introduced a different issue.
Wouldn't replacing it with fwrite(stderr) without changing anything
else solve that?
