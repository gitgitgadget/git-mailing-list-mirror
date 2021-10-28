Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A1CC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 00:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5E760EBD
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 00:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJ1AFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:05:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59077 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ1AFm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 20:05:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7754915BA9F;
        Wed, 27 Oct 2021 20:03:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xYHPr0IVUpkZP+ji9DUgXztbvMo4QjsgTM44tz
        ndxfo=; b=wxJJU9/ggLv7gWYeGj96vm8U2M2HjVSm4TH3TxCmruRAp6zbHavoLE
        Cj/mJcCNUqACQWbFgLyLUOxUruKbECZu0J/I3FFICT83QmDTMD2d8DLguakMuE1y
        1aw60uuzta6B4FQZYjdhA0haDymxLtbkuoxLyxxtAoKyVMBlz27I0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C39915BA9E;
        Wed, 27 Oct 2021 20:03:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A97E115BA9D;
        Wed, 27 Oct 2021 20:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] Documentation/Makefile: fix lint-docs mkdir dependency
References: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
Date:   Wed, 27 Oct 2021 17:03:12 -0700
In-Reply-To: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Oct 2021 03:31:44 -0400")
Message-ID: <xmqqlf2et3r3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71DAA908-3782-11EC-A4C4-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since 8650c6298c (doc lint: make "lint-docs" non-.PHONY, 2021-10-15), we
> put the output for gitlink linter into .build/lint-docs/gitlink. There
> are order-only dependencies to create the sequence of subdirs like:
>
>   .build/lint-docs: | .build
>           $(QUIET)mkdir $@
>   .build/lint-docs/gitlink: | .build/lint-docs
>           $(QUIET)mkdir $@
>
> where each level has to depend on the prior one (since the parent
> directory must exist for us to create something inside it). But the
> "howto" and "config" subdirectories of gitlink have the wrong
> dependency; they depend on "lint-docs", not "lint-docs/gitlink".

Thanks.

I wonder if we can somehow avoid this unwieldy chain of commands,
perhaps with using "mkdir -p" somewhere, or make the lint scripts
create the necessary leading paths.  From the looks of the tail end
of Documentation/Makefile, the latter may be the cleaner solution.

