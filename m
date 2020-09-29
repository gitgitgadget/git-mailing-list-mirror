Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D5CC4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF41207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NxM2fX9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgI2QCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:02:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53724 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgI2QCI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 12:02:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 701457C56E;
        Tue, 29 Sep 2020 12:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=grnWd+HyfPfQZbv0Uf03X0Llihg=; b=NxM2fX
        9HVY+UhdBNDRi18lyUBqVjYiR68EpzN2PQcNIpNDtntUqcExT07UYPBlEDQlUZ7H
        wlVoRJo48CiUiuhqo/4a+lkpEPbIyKgH67izUHaTRIuLkZSwYn8BW7jY4lm9i6GS
        Bvc36JBeY8hOKVFzhUpZelJ6rQDe5gkE9O/1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O6cuN5oFieVWSm53pISGOZrwKzFR3Bgb
        p5DZSt9OUQfJHprwoJCPdF+X7J/PlwoxMwU5dP8qOuepB5edSSGuyOz2OhYnA2qa
        CLChA7zWqIpMqjpw5nC/w1c7017uWQ2yFTvdLnl9cPY19Ui3Gc2AYOLpi/Uju+Yl
        9fUZuCoBWaU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FD4D7C56D;
        Tue, 29 Sep 2020 12:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65CC97C56C;
        Tue, 29 Sep 2020 12:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git checkout -p HEAD...
References: <20200929061830.GA40759@generichostname>
Date:   Tue, 29 Sep 2020 09:02:04 -0700
In-Reply-To: <20200929061830.GA40759@generichostname> (Denton Liu's message of
        "Mon, 28 Sep 2020 23:18:30 -0700")
Message-ID: <xmqqlfgsinb7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EADE9C0-026D-11EB-AF57-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> So I lean on the side of fully supporting the `...` form for `git
> restore/checkout`. However, I understand if someone wishes to suggest
> "that was never valid to begin with; we should prohibit `...` from
> being used with restore-modes`.
>
> Any opposition to fully supporting the `...` form?

Not from me.  The "-p" feature of various commands were bolted on as
a mere afterthought and in a rather hacky way. I am not surprised if
quality of their implementation differs from that of the primary
codepaths.  It did not help that they are implemented by diverting
the control early to the "add--interactive" machinery from the
primary control flow, and it may be a large, if not primary, source
of differences in how command line options are handled by the "-p"
codepath and the primary codepath in these commands.

Making "-p" behave more like the primary modes of operation in these
commands would be a welcome move, I would think.  I hope that it got
much easier to access the "add--interactive" machinery from C these
days; probably it is a good time to make that move.

Thanks.
