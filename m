Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D275FC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4BD2080D
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gCL7ghoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfLZUSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:18:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63312 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZUSw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 15:18:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 278F81A49D;
        Thu, 26 Dec 2019 15:18:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GEq8lZCRWci0oRecrdJi5xqQDAU=; b=gCL7gh
        oVvggSSaHiNyEqGukCRGLaRJC1M5v9YjqaOSQqj7tOkjA3QG9i0BYykvZFODi6SZ
        5zUTZyPvrGCzjmTR2kJiulT1+tpi0v9IYBpYP2AR1KCZH49dPieUDvft+QND6iXv
        +8v2ZGVt/UtEfYruzB8cXIdxlBlbphJdtBh1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vUNcBUuS5GhhJBd35OJZIw5E+rqw31Us
        JKm/Tii/7yx1jqgAh6PKrzICN0RR80J4qmEBR+W2Hc/4YVSzJPaurl7Nk3SWV/UE
        rfAnZ7UIYo11Z8wi7Bz9fxBWFEvdDuQ9hhqjV40rF4tsK1RTPH1EcK4elCENEUQt
        LpYjIdlXWsI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D8DD1A49B;
        Thu, 26 Dec 2019 15:18:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E2511A49A;
        Thu, 26 Dec 2019 15:18:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] t/check-non-portable-shell: detect "FOO= shell_func", too
References: <20191224005816.GC38316@google.com>
        <20191224010110.GF38316@google.com>
        <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com>
        <20191226195357.GA170890@google.com>
        <20191226195747.GC170890@google.com>
Date:   Thu, 26 Dec 2019 12:18:48 -0800
In-Reply-To: <20191226195747.GC170890@google.com> (Jonathan Nieder's message
        of "Thu, 26 Dec 2019 11:57:47 -0800")
Message-ID: <xmqq7e2ilu1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED671E34-281C-11EA-B37D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Just like assigning a nonempty value, assigning an empty value to a
> shell variable when calling a function produces non-portable behavior:
> in some shells, the assignment lasts for the duration of the function
> invocation, and in others, it persists after the function returns.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> If it would be useful for me to send a copy of the "Enable protocol v2
> by default" series rebased on top of this, let me know.

When rebased, t5552 passes (including the test lint) at the "request
v0 explicitly for some tests" step now.

The tip of "promote proto v2 to default" series fails at 5552.5
with or without these two patches, though.
