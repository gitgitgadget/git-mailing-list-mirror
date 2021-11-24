Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9991C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 01:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbhKXB51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:57:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51764 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhKXB5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 20:57:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52E7F15AC68;
        Tue, 23 Nov 2021 20:54:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IsjnNiAUEt/tJoVVXR8fiHQ7JUi4gtxNtMiCIe
        S3lTI=; b=WDb1ImNEAsYLJwEWJBAdvo6PEU2zRNc/R3TT9gmQ1tKzPnmabBF5Ly
        dLMkiVsx/KIaMNAFk3u5ZlG5lB6kEXmaqEht6CtVi1B10tRmeJrjeXUEN2WvRl1j
        JrPao577q3IJjp7iROb+BhUq0BNzNZBTvhoQLfC3IfUfOVQVvo0do=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D58615AC67;
        Tue, 23 Nov 2021 20:54:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A98A515AC66;
        Tue, 23 Nov 2021 20:54:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH v2 1/9] worktree: remove redundant NULL-ing of "cp.argv
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
        <patch-v2-1.9-9cc220ce5a3-20211123T115551Z-avarab@gmail.com>
        <CAPig+cStZp=AOPHW8i7AqwDOV6djYzHC6GmcVeb=4PUj5bjvAw@mail.gmail.com>
Date:   Tue, 23 Nov 2021 17:54:10 -0800
In-Reply-To: <CAPig+cStZp=AOPHW8i7AqwDOV6djYzHC6GmcVeb=4PUj5bjvAw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 23 Nov 2021 10:26:56 -0500")
Message-ID: <xmqqy25e48u5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B7C3192-4CC9-11EC-9D93-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> ... At best, following this change,
> git-worktree is only working "by accident" if the underlying
> child_process::args.v doesn't get reallocated between run_command()
> invocations. Relying upon this "by accident" behavior feels rather
> unsafe.

Very true.  Relying on the "if argv is null, point it at args.v"
assignment at the very beginning of the start_command() function is
safe because by that time the reallocations have happened already
if needed.

The pattern with or without NULLing is

	initialize cp
	push to cp.args
	use cp

	/* cp.argv = NULL */
	strvec_clear(&cp.args);
	push to cp.args

and strvec_clear() frees the underying array, and the first push
will reallocates from NULL, so there is no guarantee that cp.argv
in the first use that used to be pointing at cp.args that has
already been freed is still valid.

Thanks for spotting this.  Has this patch ever been tested with
sanitizer?  Do we have gap in test coverage?





