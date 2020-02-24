Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4CAC38BE2
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562CA2084E
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MITxBdml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBXSe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:34:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56861 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBXSe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:34:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36B0EC91FB;
        Mon, 24 Feb 2020 13:34:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fOnuEC3yOaZCoZNemfi8Y5xeRbA=; b=MITxBd
        mlgHgeSQz166OLyOhlpzrXLmYOYuO5oB5TtpwbdjUj/fV8f3iVCBx0G/7CM0sn9f
        EOWYY28mgbHYxfNVP1hIJ3eAplr3YdRB31ddiNU4JEVQr6z3IV4FEZ3AQl28SeDy
        nAhmUxjMcRoAQ3QRj0UVBETaki0htsj8if3oI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FV374rAZtvevFTO/+zwTEa1zXghdT2qr
        Wuic0DhjkWSNYyRg7vE0gI0X2iNTTNgRMuwN26j03dBuYLsqyKQI2tTOJVB4TnPI
        xAHBY/SIZR4qbRhsmX5WlppoRFO8nI4Nzpyzg8Xw+sh2OVr9zSBdcdJQxbpOYTf5
        WwXH5i4e/e0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FAC9C91FA;
        Mon, 24 Feb 2020 13:34:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 59619C91F9;
        Mon, 24 Feb 2020 13:34:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 00/24] SHA-256 stage 4 implementation, part 1/3
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
Date:   Mon, 24 Feb 2020 10:34:20 -0800
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 22 Feb 2020 20:17:25 +0000")
Message-ID: <xmqqy2srq1g3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46AC0270-5734-11EA-ACAF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is a series for part 1 of 3 of a stage 4 SHA-256 implementation.
> It is mostly the same as v1[0], which was RFC.  The interested reader is
> referred there for the in-depth explanations.
>
> A few interesting changes have taken place since v1.  First, I
> discovered a regression in a recent series which introduced a hard-coded
> constant, so patch 1 addresses this.
>
> Second, I discovered a mistaken assumption that we were making about our
> hash implementations: that copying the struct was sufficient to copy the
> context.  This is not true for libgcrypt, where our context is a pointer
> instead, so patch 2 addresses this with a helper function.
>
> Finally, I've added a check to prevent non-developers from creating
> SHA-256 repositories, since this series is not sufficient to implement
> full SHA-256 support.  Even as a developer, creating a SHA-256
> repository immediately leads to a broken state, since we don't recognize
> the extension (yet) and therefore promptly refuse to operate on it in
> any way.  Preventing this experience seemed prudent.

I am very tempted to take 1/24 separately and queue it at the tip of
the jk/packfile-reuse-cleanup topic.

I didn't read the fast-import bits at the end of the series, but
everything before those steps made sense to me.

Thanks.  

