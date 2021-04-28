Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F17C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 09:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2998C613F1
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 09:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhD1JRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 05:17:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52229 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1JRN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 05:17:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2030212581E;
        Wed, 28 Apr 2021 05:16:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b3qtwNgyLrmKDH40GGeJTSmJH4aFoET7rwLfF8
        E1REg=; b=QzMxt6WfSNrtPRU/NFDe/5WY0vAsVZ8Cv6tyQnbPXD0+fhbwEvNbbI
        izeQva8GEe3pa7l8DK0V/BFd6HKKwpcMinRAT7i388bDh2urKKJWTvp6KpyWbIwn
        MGbQ/y5ETiUGwmGk3NwpKZTCG6SzwRw2dbpLOwLhgqhLF1AfiphD0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1803E12581C;
        Wed, 28 Apr 2021 05:16:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D20412581B;
        Wed, 28 Apr 2021 05:16:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, ross@skydio.com, abe@skydio.com,
        brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: add --quiet flag
References: <20210427194106.14500-1-jerry@skydio.com>
        <xmqq35vac0vq.fsf@gitster.g>
Date:   Wed, 28 Apr 2021 18:16:24 +0900
In-Reply-To: <xmqq35vac0vq.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        28 Apr 2021 16:40:57 +0900")
Message-ID: <xmqqsg3aahw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 689AD3D2-A802-11EB-9A58-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jerry Zhang <jerry@skydio.com> writes:
>
>> Replace OPT_VERBOSE with OPT_VERBOSITY.
>
> While it is not an incorrect statement, it is odd to have such an
> implementation detail nobody cares as the first thing in the log
> message, though.
>
>> This adds a --quiet flag to "git apply" so
>> the user can turn down the verbosity.
>
> Sure, I think you can do "apply --no-verbose" to do the same thing
> without any change, but we introduced VERBOSITY to replace VERBOSE
> exactly so that --verbose can be countermanded with --quiet, and
> this patch is a good example of the application of that feature.
>
> I wonder if this deserves a test.

Oh, another thing.  "--quiet" with OPT_VERBOSITY is given negative
values, whose magnitude may be used to express "even more quiet".
This is different from "--no-verbose" that is supported by both
OPT_VERBOSITY and OPT_VERBOSE that resets the variable to 0.

So use of OPT_VERBOSITY() to support both --verbose and --quiet is
good, but you'd need to audit the way the verbosity variable is used
by the code.  "if (verbose) perform_verbosely()" would have to be
rewritten as "if (verbose > verbosity_level) perform_verbosely()" 
or something like that, as the "verbose" variable can take a
negative value to mean "less silent than the usual 0".

