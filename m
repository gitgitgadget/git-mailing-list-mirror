Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8193DC2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D57B22D0A
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgLOVaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:30:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52972 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbgLOV1F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 16:27:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 06933115BEB;
        Tue, 15 Dec 2020 16:26:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kfX+YXsHCXT/05SSK/N8nrfI9eo=; b=k78nV/
        GX02lixae3G0F4nrwPkrUPrl1djPOHy/DA31BzPu6zgN+/IxMTjSYbTkYUP1e7R+
        Ak7pa6RMIMw/6tCfb//L7HHtA3m27DzBq7IFdLp2ghHo434t0EmnurucOtEKmGuf
        Z/kAj+1l85SAK5zS5bLe5KYFoU7J8wtyh/e0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uwBsz0cVtYeWpEYXVf9uccAcjSFkABDk
        ch6jBm9mUCnQbCxPELMaC7oHqFnSHWZEmwZ6t2ACrRTErpscaQaFLtziCL1amsYm
        apKd1EMM7++nC8LN+3Z6JMKOk2AQ31foZld/vXSwlEnUpjHihyeY2MaPomVT7udg
        PhNjJr0QC4w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F23CB115BEA;
        Tue, 15 Dec 2020 16:26:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D110115BE9;
        Tue, 15 Dec 2020 16:26:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] compat-util: pretend that stub setitimer() always succeeds
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>
        <xmqqeejraiw7.fsf@gitster.c.googlers.com>
        <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
        <CABPp-BEnkQahdVJP+rfQho+S_hcS3y-o3cZBUMhU-EQHjJTLOQ@mail.gmail.com>
        <xmqqzh2e7p6l.fsf@gitster.c.googlers.com>
Date:   Tue, 15 Dec 2020 13:26:17 -0800
In-Reply-To: <xmqqzh2e7p6l.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 15 Dec 2020 13:08:18 -0800")
Message-ID: <xmqqpn3a7ocm.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BE9FB1A-3F1C-11EB-AC94-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 15b52a44 (compat-util: type-check parameters of no-op
replacement functions, 2020-08-06) turned a handful of no-op
C-preprocessor macros into static inline functions to give the
callers a better type checking for their parameters, it forgot
to return anything from the stubbed out setitimer() function,
even though the function was defined to return an int just like the
real thing.

Since the original C-preprocessor macro implementation was to just
turn the call to the function an empty statement, we know that the
existing callers do not check the return value from it, and it does
not matter what value we return.  But it is safer to pretend that
the call succeeded by returning 0 than making it fail by returning -1
and clobbering errno with some value.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7a0fb7a045..421c90b5d8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -273,7 +273,7 @@ struct itimerval {
 
 #ifdef NO_SETITIMER
 static inline int setitimer(int which, const struct itimerval *value, struct itimerval *newvalue) {
-	; /* nothing */
+	return 0; /* pretend success */
 }
 #endif
 
-- 
2.30.0-rc0-186-g20447144ec

