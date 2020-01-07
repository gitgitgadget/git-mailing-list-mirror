Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F7C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5E12081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GQRzwD6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgAGUTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:19:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55333 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgAGUTW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 15:19:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DBC0982AF;
        Tue,  7 Jan 2020 15:19:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z5i7DfT2GQriWJu6PYkrOwWIlAQ=; b=GQRzwD
        6aW/aMm9IcQPXRveHMSGKGbGDSIVB2rElnCcaRT8/dgjJsu5H8encuzpL5EFvWJV
        zZhPO9rqwtjh9S7PqIu5path+GNvTUaYRoIibh2dK7xTenBlQq7fdxhfVUIItYxH
        jOCYF6MxP7R37gZQfNdKKp2BVYw+BRnQinhJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CePgMFiHV7ZrKy0i6QtB1UUVQTadHklQ
        GUTwTFLvVAw/Z2Fi00qt3kdNzbfOlNzXb4iqOWduQ4VqJUYsXh1NFTF/6WOaleek
        gsVJE367/t2IOEDUr8NvgHgBZiilfkhqvERSVyBdKopL6bJ50XbZvxwioL6z9TZ2
        z6nWNKmPvP8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26E90982AD;
        Tue,  7 Jan 2020 15:19:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48047982AB;
        Tue,  7 Jan 2020 15:19:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Liam Huang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Update imap-send.c, fix incompatibilities with OpenSSL 1.1.x
References: <pull.516.git.1578391376.gitgitgadget@gmail.com>
        <8c96c56a1818b066d4570873e00c52d42399e3c2.1578391376.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 12:19:15 -0800
In-Reply-To: <8c96c56a1818b066d4570873e00c52d42399e3c2.1578391376.git.gitgitgadget@gmail.com>
        (Liam Huang via GitGitGadget's message of "Tue, 07 Jan 2020 10:02:56
        +0000")
Message-ID: <xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAE9B234-318A-11EA-B73C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Liam Huang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Liam Huang <Liam0205@users.noreply.github.com>
>
> Some APIs have been changed since OpenSSL 1.1.0, so fix incompatibilities with OpenSSL 1.1.x.

I wonder if the patch can be made a lot less noisy with something
along this line

        #if OPENSSL_VERSION_NUMBER < 0x10100000L
        #define OPENSSL_sk_num(x) sk_GENERAL_NAME_num(x)
        #define OPENSSL_sk_value(x,y) sk_GENERAL_NAME_value((x),(y))
        #define OPENSSL_sk_pop_free(x,y) sk_GENERAL_NAME_pop_free((x),(y))
        #endif

which would allow you to reduce many #if/#else/#endif in the actual
code.

