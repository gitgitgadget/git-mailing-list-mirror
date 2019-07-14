Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4CFA1F461
	for <e@80x24.org>; Sun, 14 Jul 2019 21:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfGNVzZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 17:55:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62698 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfGNVzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 17:55:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CCFD7F8A0;
        Sun, 14 Jul 2019 17:55:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oNwybt12WNcsE+Xniy0KSbuz/CU=; b=I+xFqr
        qHZd6Yki7bsx4hilAXHA4YmwEJ0aKfp/B3F/0NIKkYmYPd5f2RMIYRNjvFrbfG2C
        dNAlvAgGZduUhJxptFg0bwJ8yUnSmbb5hmkAwfCigwtQCDPyMrBzkdjwmeqR5gz3
        gQegAxCe6l0Vl2XCFO++ZMRfLOzNi9se3UyLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qaVU6yJBGNWDDeG5Kpb9yP0VR0hRomqz
        CouJbgiedudJ2Vzr847WazyNoGom6h4NduIdsZBwihnwKE0hdFWPZLYxDazcETHh
        6JrlGS71mjotzH+v+Zhp43xZ8XgTVo+aQTbjnDyWSIez3CUPjkB4R70Q/BoMJcnC
        p5tYgf/zeMo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 655847F89F;
        Sun, 14 Jul 2019 17:55:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 96D717F89E;
        Sun, 14 Jul 2019 17:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] log: add warning for unspecified log.mailmap setting
References: <20190712230204.16749-1-ariadne@dereferenced.org>
        <20190712230204.16749-2-ariadne@dereferenced.org>
Date:   Sun, 14 Jul 2019 14:55:19 -0700
In-Reply-To: <20190712230204.16749-2-ariadne@dereferenced.org> (Ariadne
        Conill's message of "Fri, 12 Jul 2019 18:02:02 -0500")
Message-ID: <xmqqzhlg46yg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 139A58FE-A682-11E9-AC86-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ariadne Conill <ariadne@dereferenced.org> writes:

> +	if (mailmap < 0) {
> +		/*
> +		 * Only display the warning if the session is interactive
> +		 * and pretty_given is false. We determine that the session
> +		 * is interactive by checking if auto_decoration_style()
> +		 * returns non-zero.
> +		 */
> +		if (auto_decoration_style() && !rev->pretty_given)
> +			warning("%s\n", _(warn_unspecified_mailmap_msg));

The huge comment can go if you refactored the helper function a
little bit and will give us a much better better organization.

static int auto_decoration_style(void)
{
	return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
}

The existing helper is meant to help those who are interested in the
decoration feature, and the fact that it kicks in by default when
the condition (isatty(1) || pager_in_use()) is true is a mere
"decoration feature happens to be designed that way right now".
There is no logical reason to expect that the decoration feature and
mailmap feature's advicse messages will be triggered by the same
condition forever.

Think a bit and what the condition "means".  You wrote a good one
yourself above: "the session is interactive".  Introduce a helper
that checks exatly that, by reusing what auto_decoration_style()
already uses. i.e.

	static int session_is_interactive(void)
	{
		return isatty(1) || pager_in_use();
	}

	static int auto_decoration_style(void)
	{
		return session_is_interactive() ? DECORATE_SHORT_REFS : 0;
	}

and then the above hunk becomes

	if (session_is_interactive() && !rev->pretty_given)
		warning(...);

It is clear enough and there is no need for your 2 sentence comment,
as (1) the first sentence is exactly what the implementation is, and
(2) we no longer abuse auto_decoration_style() outside its intended
purpose.




