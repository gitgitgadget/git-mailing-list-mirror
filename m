Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF0FC4320A
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30AE61051
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhHIPsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 11:48:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51692 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhHIPsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 11:48:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE2CF15E072;
        Mon,  9 Aug 2021 11:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iQXQww8c6SNxxaHf8ShdtojB0SLoWVq/oJALr2
        Sq8LU=; b=LUpizIvvNxkNBMeeIOlN8bPe+Piiine4ZS1Cg5cXttC9V39VnAHCud
        EsPujZ5IC4uyK5WcifYyUHpfwX4WxmK3g7qHOjTfampO4DEx/+zqjqrzC7iKKWFu
        dEED1H/kjInNEa/MwtpMRIQC4qj9mFgfKsUNq4idb8nDj3bNJD2O4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C79CC15E071;
        Mon,  9 Aug 2021 11:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 10D4315E06E;
        Mon,  9 Aug 2021 11:47:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Noah Pendleton <noah.pendleton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] blame: Skip missing ignore-revs file
References: <20210807202752.1278672-1-noah.pendleton@gmail.com>
        <xmqqr1f5hszw.fsf@gitster.g>
        <CADm0i3-ToKo1gNTXXLHH6i2d4qpz771VeRjDsfJjgbgMfhx6rA@mail.gmail.com>
        <xmqqtuk0h4ph.fsf@gitster.g> <xmqqim0fhlm1.fsf@gitster.g>
        <CADm0i39LV91kochHSGVHovaTbDOd0COrQPXHD3x8rEj-1Y+eMA@mail.gmail.com>
Date:   Mon, 09 Aug 2021 08:47:58 -0700
In-Reply-To: <CADm0i39LV91kochHSGVHovaTbDOd0COrQPXHD3x8rEj-1Y+eMA@mail.gmail.com>
        (Noah Pendleton's message of "Sun, 8 Aug 2021 14:21:44 -0400")
Message-ID: <xmqq5ywehb69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C85794C-F929-11EB-95C0-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noah Pendleton <noah.pendleton@gmail.com> writes:

> Very good point- I see about 21 call sites for `git_config_pathname`,
> plus a few others (`git_config_get_pathname`) that bottom out in the
> same function. I could see the utility of optional paths for some of
> them: for example, `commit.template`, `core.excludesfile`. Some of the
> others seem a little more ambiguous, eg `http.sslcert` probably wants
> to always fail in case of missing file.

Thanks for already doing initial surveillance.  Very useful.

> There seems to be a mix of fail-hard on invalid paths, printing a
> warning message and skipping, and silently ignoring.
>
> Hard for me to predict what the least confusing behavior is around
> path configuration values, though, so maybe adding support for the
> `:(optional)` (and maybe additionally a `:(required)`) tag across the
> board to pathname configs is the right move.

I originally hoped only ":(optional)" would be necessary, but to
keep the continuity in behaviour for those currently that do not die
upon seeing a missing file, we probably should treat an unadorned
value as asking for the "traditional" behaviour, at least in the
shorter term, and allow those users who want to detect typos to
tighten the rule using ":(required)".  I dunno.

> That patch might be beyond what I'm capable of, though I'm happy to
> put up a draft that applies it to the original `ignoreRevsFile` case
> as a starting point.

Thanks for an offer.  We are not in a hurry (especially during the
pre-release feature freeze), and hopefully this discussion would
pique other developers' interest to nudge them to help ;-)
