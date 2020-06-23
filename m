Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB03C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A1A2078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VhBcmNKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbgFWWlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:41:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55673 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbgFWWlo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:41:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F9B6D3033;
        Tue, 23 Jun 2020 18:41:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cyUtHuXagbX3
        P+M8MqBr6jvoZnY=; b=VhBcmNKCNvt7RdiWTmYanjMIPOnFuRLF0d968nl2HzUq
        lpy+11e6EMYfzPdeoeNWQZhMTLJdyUlBAMhsHFmJnPVSWD4vEzX6tzTfHgkZuwxW
        TTrcN96HT8dRRymEyqI+LrzI4WoX7tF7slGGEwTpzhwHJ2oWRRthNJ9jxXboGP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wcSKpp
        iPHNxPJoNevY6Nq670XP6dHMj2NqC7wd3C22dRVWDdsXYrwgnfN/EJsIEqvShLbO
        F8aKzb57qdlWP+EpbGHe+I0k8aH9JEfGGBOPOQT440ri8gpQCwWy2wVvoL2T+pDS
        pH9ZUKhI8OY9f4giN7/bRCoq2G+uIocaU9ugQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66F55D3032;
        Tue, 23 Jun 2020 18:41:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3B1BD3031;
        Tue, 23 Jun 2020 18:41:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Michael Ward <mward@smartsoftwareinc.com>
Subject: Re: [PATCH v2] http-push: ensure unforced pushes fail when data would be lost
References: <20200623202129.2616672-1-sandals@crustytoothpaste.net>
        <20200623215220.2620496-1-sandals@crustytoothpaste.net>
Date:   Tue, 23 Jun 2020 15:41:37 -0700
In-Reply-To: <20200623215220.2620496-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 23 Jun 2020 21:52:20 +0000")
Message-ID: <xmqqftalbe1q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B3689B9A-B5A2-11EA-9F26-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> To solve this problem, let's move the two sets of object flags so that
> they don't overlap, since we're clearly using them at the same time.
> The new set should not conflict with other usage because other users ar=
e
> either builtin code (which is not compiled into git http-push) or
> upload-pack (which we similarly do not use here).
>
> Reported-by: Michael Ward <mward@smartsoftwareinc.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Thanks.  Well explained and cleanly fixed.
