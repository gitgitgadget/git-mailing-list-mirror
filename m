Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B83C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914F76115A
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhIVTVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:21:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60260 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhIVTU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:20:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A21AEE92BA;
        Wed, 22 Sep 2021 15:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jAnIbzvv+QiqI7jJD7pqUirJgII/D9W3M3/sgw
        Mem+E=; b=xcHZ/3IuZ27GkpK+il4w4pftteS5nUk856mlHMJv/GrQzUc8ID+K0M
        fWV5hP9P0z2gLNdvsJvbSjEfJsANXCYG+RItuJX0HQqnKNvM0KAnEabOJmDYRYaI
        2K7vPl6hwLiTHLnD8Dp+/L5yhTCjZk2abKLTyH3xTWiSvtjP3vSxk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A8A2E92B9;
        Wed, 22 Sep 2021 15:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11B05E92B8;
        Wed, 22 Sep 2021 15:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
Date:   Wed, 22 Sep 2021 12:19:26 -0700
In-Reply-To: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 21 Sep 2021 14:41:15 -0400")
Message-ID: <xmqq8rzo770h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00BE0526-1BDA-11EC-B5CF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> 	# Ensure that there is no "Basic" followed by a base64 string, but that
> 	# the auth details are redacted
> 	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
> 	grep "Authorization: Basic <redacted>" trace
>
> gets confused. It sees the "<redacted>" one from the pre-upgrade
> HTTP/1.1 request, but fails to see the unredacted HTTP/2 one, because it
> does not match the lower-case "authorization".

Neither pattern of the above two will not match the HTTP/2 one, so
the first one would report "there is no leakage of Auth with a
caplital letter"; the second one may see only one pre-upgrade Auth
with a capital letter, but as long as it does find one, it should be
happy, no?

I am a bit puzzled how the test gets confused.
