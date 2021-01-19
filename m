Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29139C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 01:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF555230FA
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 01:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391975AbhASBZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 20:25:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58243 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391901AbhASBZk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 20:25:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C035411EF56;
        Mon, 18 Jan 2021 20:24:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bfru4bglKFSYR2t3w+uW8PmGDks=; b=x083rp
        iGBNlXQES6P237aGhOfvUMNqDLrj69dYvhS9G68ki98I6aTFaYdiU4E9qZSxUPXj
        GeS8YYIciu4bUwRFNVaReI1XyiqOqRmRTWna2z4FHoZxXk2PdbyFjaXRcUSz2Ey2
        WlTXLDTTZ5k4jaOrZoAigQhJkgzYPjJYx/5zU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dFBbzCsA3EFcviRMHjOLoT4xd5yLpzNG
        BV5daiamQMpP8L+tGlzeizWPOgICRR+ApMh5oDFOR2z/qqPJcUxKyTrJaLN7gx7P
        BW9Nr4o5OzPewaVN+Y/iTYr7ymvT4QNLHIL2/kQSjjvvQyHfon95zToctSTBO55K
        a2GizDM1PNE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B99D511EF55;
        Mon, 18 Jan 2021 20:24:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0FC7611EF54;
        Mon, 18 Jan 2021 20:24:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Russo <aerusso@aerusso.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Aiyee Bee <shane.880088.supw@gmail.com>, git@vger.kernel.org
Subject: Re: DEVEL: Help with feature implementation
References: <C8MJ83LNOZ1Q.OCQKHOTGHKWF@localhost>
        <38ed4389-ba9f-743a-3fa3-5ffab12ef0a9@gmail.com>
        <992cd021-d6f6-dfe4-1918-45643aa85a61@aerusso.net>
Date:   Mon, 18 Jan 2021 17:24:52 -0800
In-Reply-To: <992cd021-d6f6-dfe4-1918-45643aa85a61@aerusso.net> (Antonio
        Russo's message of "Mon, 18 Jan 2021 17:54:06 -0700")
Message-ID: <xmqq7do9iuqj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2236BBDC-59F5-11EB-B40E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Russo <aerusso@aerusso.net> writes:

> As a side note, would this list be willing to look at patches that remove
> the need to use revs->limited?  Adding new features would be much easier if
> we could restrict git to use streaming algorithms for these simplifications.

Do you mean you will write new implementations of operations like
"--simplify-merges", "--ancestory-path" and all its friends without
the need for the "limited" bit?

Willing to look at?  I do not know about others, but sure, it would
make be extremely excited.

You may be able to rewrite some other operations that implicitly
require the limited bit into an incremental implementation, but I am
skeptical that you can do "simplify-merges" in a streaming fashion
in such a way that we'd dig a bit but not all the way down before
making decisions on which commits should be included in the output
and how their parenthood relationship should appear etc.  I and
Linus tried independently and we did not get that far in our
attempts (note: there wasn't commit-graph back then).

If you are talking about precomputed stuff like commit-graph, that
may change the equation, but we'd prefer to have the system work
without requiring these auxiliary data (in other words, it would be
fine to use them as optimization).

