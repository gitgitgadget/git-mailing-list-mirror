Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C518EC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 22:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897392072F
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 22:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l8/K/M1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC0WMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:12:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59251 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0WMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 18:12:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36C4E55B16;
        Fri, 27 Mar 2020 18:12:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Wkqa+5WiEgxxkcYcbLd7CFm0EA=; b=l8/K/M
        1ZQwV6s6b5enYmGAOVHGihmK9wi8CE1/zr+Cyrehi1ZBTfgzOJ9lGo6n/XR0+EKK
        kfnP6QLRuJkNTp6tJnlS5J7x+S6u2ZwqKy9cDGx3/S9Q15JNJ+bUW1fVYLlMsAgL
        weakZD8ww5ANmM6f3SQ9wnWJegXy1sQDNOhjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M+lqB5E5Udy6Q2wQD/2tmTojU2FMhYzg
        Np4INwuBTiY8itG9cwma30qojXYoX9sDY0E6VKdu+blrzlf9G3knHytN4DgUP0Xz
        jbEMrx6BusNwwMmPJpxD3i2T6Uv++UZlk+yfIdQqz1oUUN7pNpXuB1zId5mzvCoH
        J1c78GGA56k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E79255B14;
        Fri, 27 Mar 2020 18:12:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6B6E55B10;
        Fri, 27 Mar 2020 18:12:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] use `curl-config --cflags`
References: <20200326080540.GA2200522@coredump.intra.peff.net>
Date:   Fri, 27 Mar 2020 15:12:06 -0700
In-Reply-To: <20200326080540.GA2200522@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 26 Mar 2020 04:05:40 -0400")
Message-ID: <xmqq7dz5e9c9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF6D80FC-7077-11EA-AE1A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I was recently testing Git's behavior with respect to various versions
> of libcurl. So I built a one-off libcurl and installed it in /tmp/foo,
> but was surprised that:
>
>   make CURL_CONFIG=/tmp/foo/bin/curl-config
>
> didn't work, since we do run "$(CURL_CONFIG) --libs". This fixes it,
> along with a minor optimization to the existing "--libs" call.
>
>   [1/2]: Makefile: avoid running curl-config multiple times
>   [2/2]: Makefile: use curl-config --cflags
>
>  Makefile | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> -Peff

Both patches made sense.  Thanks.
