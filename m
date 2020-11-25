Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B23C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2967C206F9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gIulJIIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgKYVNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 16:13:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64050 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbgKYVNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 16:13:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E1911039BE;
        Wed, 25 Nov 2020 16:13:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+v+X+qMpjw8HV998/JJmIB6tAS4=; b=gIulJI
        ItEhppI8Nrv2QI9TRLNLRqAcy1HQxAv1fGVXtsXrvENvcPPygMdgYzmK9GN78/Iy
        rxqEmUUDAhxkUQnRj0UPvbyWcZAxjzYDHSUUL2uP4Xl1usCekcHUIwItn/D/muVU
        2pAGeJOXKef2kDJBEJKMlvlp5hlJqpa+wCh/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P3TqK81ERUC893YVlbxzKTqQTkmioooT
        FnoCvr7LqznKqJYuT3m+GP8PWP/yFsG8hZuVxaa1VVzBMWZFBl0i0vuw5txOzDkQ
        um/gIX+yq5hTIMNaMtkrGOcoitMCczjUogJaAgLnHISkNSUuyxOI3XpowgOap784
        glI/XpntBqE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 470171039BD;
        Wed, 25 Nov 2020 16:13:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C5081039BA;
        Wed, 25 Nov 2020 16:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 0/2] midx: prevent against racily disappearing packs
References: <cover.1606324509.git.me@ttaylorr.com>
Date:   Wed, 25 Nov 2020 13:13:31 -0800
In-Reply-To: <cover.1606324509.git.me@ttaylorr.com> (Taylor Blau's message of
        "Wed, 25 Nov 2020 12:17:22 -0500")
Message-ID: <xmqqblfldts4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13320E82-2F63-11EB-BEFB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here are a couple of patches that Peff and I wrote after noticing a
> problem where racily disappearing .idx files can cause a segfault. While
> investigating, we fixed a related issue which is described and fixed in
> the second patch.

In the cover letter it won't affect the end result, but when talking
about "race", it always is a good idea to explicitly mention both
sides of the race.  It is clear what one side is in the above
(i.e. somebody who removes .idx file that is still in use), but it
is not so clear who gets hit and segfaults.

I am guessing that the other party is the user of .pack file(s)
bypassing the corresponding .idx file(s) because the necessary data
is mostly in .midx?

Thanks.
