Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28301C432BE
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 05:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE98160FF2
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 05:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhHHFn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 01:43:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54366 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHFn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 01:43:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 135D8E040E;
        Sun,  8 Aug 2021 01:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ND8EyjvrjMh3cBJI+eVb9SGJzlPgP0v/qI4+nA
        9HEiU=; b=O8hnJAZaBmcKUB1upByOkvNVJIf6qK5822rqXNL6PPQe+8abF9lfbo
        yKPoywMKwLVEhpVKC+/N8HmHCXixpg2kvFXp4xCpd6h68wIwhPuhOvqQkjy9FSn0
        e1kZU9UKKwnQdVjlif2qFSUI7Ev7DIyNOwnJ/dJ16Y4m8GEmWtAOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A56FE040D;
        Sun,  8 Aug 2021 01:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 802EDE040C;
        Sun,  8 Aug 2021 01:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Noah Pendleton <noah.pendleton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] blame: Skip missing ignore-revs file
References: <20210807202752.1278672-1-noah.pendleton@gmail.com>
        <xmqqr1f5hszw.fsf@gitster.g>
        <CADm0i3-ToKo1gNTXXLHH6i2d4qpz771VeRjDsfJjgbgMfhx6rA@mail.gmail.com>
Date:   Sat, 07 Aug 2021 22:43:06 -0700
In-Reply-To: <CADm0i3-ToKo1gNTXXLHH6i2d4qpz771VeRjDsfJjgbgMfhx6rA@mail.gmail.com>
        (Noah Pendleton's message of "Sat, 7 Aug 2021 17:34:56 -0400")
Message-ID: <xmqqtuk0h4ph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82116822-F80B-11EB-9E3A-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noah Pendleton <noah.pendleton@gmail.com> writes:

> Very good point about no longer catching misconfiguration. For
> detecting provenance of a setting, I think we'd need to tag the config
> options with it when they're loaded, possibly in 'struct
> config_set_element' or similar. What do you think about instead
> emitting a warning message on stderr in the case of misconfiguration,
> but still continuing? Eg:

Unconditionally continuing with just a warning would not be a good
approach for at least two reasons.  (1) the user may truly have
intended that ignoreRevsFile to be optional, in which case the
warning is a nuisance that does not add any value, and (2) it truly
may be a misconfiguration that the named file did not exist, but the
output from "git blame" will wipe the display and the warning would
very well go unnoticed (or more likely the user may notice that
there was a warning, but it will go away before the user has a
chance to really read it, which is a lot worse and frustrating
experience).

I think an easier way out is to introduce a new configuration
variable blame.ignoreRevsFileIsOptional which takes a boolean value,
and when it is set to true, silently ignore when the named file does
not exist without any warning.  When the variable is set to false
(or the variable does not exist), we can keep the current behaviour
of noticing a misconfigured blame.ignoreRevsFile and error out.

That way, the current users who rely on the typo detection feature
can keep relying on it, and those who want to make it optional can
do so without getting annoyed by a warning.
