Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4F51F955
	for <e@80x24.org>; Fri, 29 Jul 2016 17:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbcG2RGu (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 13:06:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752657AbcG2RGs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 13:06:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 45CAD2EAFA;
	Fri, 29 Jul 2016 13:06:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DgrFSRVnGqucRXU9pPVfOtYgFG8=; b=Ts//uV
	nuAUMlSJmWrdd0dCpLKFsGbFe1aYkI7uRGWDKD/Cqjbk6hBImuzMM7cdyX5/Evu/
	I+PWb9qRzTwY9+NGudB6oTKlMqN5SXGvkGyV1jvWkuQ/0yLebqhsRZSyxgYPVTjY
	p5dhqjsqgG+F7AfI9UxdBADBMK2g4AmVqDX7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DOJdsgT+cuipPxboScfdgY1raOqIKwp5
	0woyl0XaFDuRnO3juM+pJtd5bTpC7/kF02IaaWElQtTs7YGgt0910A4sKK5h2VBe
	fBJ6982xiP+DQ9WDC4SFHbmCeerukaD6O3++yF1h8fBkP2TkM76Ibe0L+nUPOA7z
	tB/pR3df92k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E7EA2EAF6;
	Fri, 29 Jul 2016 13:06:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE8992EAF3;
	Fri, 29 Jul 2016 13:06:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
	<CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
	<20160729002902.GD9646@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 10:06:44 -0700
In-Reply-To: <20160729002902.GD9646@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 28 Jul 2016 20:29:03 -0400")
Message-ID: <xmqqbn1gpe57.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4FB09EE-55AE-11E6-9C36-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 28, 2016 at 04:47:17PM -0700, Junio C Hamano wrote:
>
>> Also makes me wonder if "git cherry-pick A..B" shares the same
>> breakage.
>
> Probably.

It seems that "cherry-pick A..B" leads to sequencer.c::run_git_commit()
that uses run_command_v_opt() to drive "git commit", so we are safe.

> I guess we want something like:
>
> +void reset_ident_date(void)
> +{
> +	strbuf_reset(&git_default_date);
> +}
> +
>
> and then to sprinkle calls liberally through builtin-ified programs when
> they move from one unit of work to the next.

ident_default_date() is currently the only one that sets this to be
cached, and that is to be used only when there is no user-specified
date.

When I saw the suggestion first time, I was worried if this had
interaction with things like GIT_COMMITTER_DATE environment (because
I didn't have easy access to the source) but it is not the case, so
the change looks very sensible.
