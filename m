Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779AEC64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060E020705
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cVbk2rAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgLAVM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 16:12:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55325 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgLAVMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 16:12:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11BEA8F383;
        Tue,  1 Dec 2020 16:11:43 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ngTnNkJLgQ8crtFdM45LTwX5w
        MY=; b=cVbk2rAU7A+2u6z3qArl4DMUxlTt85rKsxklQ3NbUkteS1J7mgN/s3R7k
        SbCH6pIzB7YG4g2GKP8Irs4+GMNZGciRZkqZF3LYeaOSBLzYsN8KxhlZtAduS/qd
        QhqAidBKZi0pQ8LDJCI4Iy1XfERrPKOV72WhONbivqdlrp4W44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=lm/j0BSxIQ8MRS2KuXW
        6Ay1HTH4AjhjmgNb1yRq6UrlpwC4HMlkZH/wwFjUd1xN7jT77DBPEzRZ1Uh4z8qH
        O17Fp6dG3xa5NCBt+XZPygEGT6tTczZp/X35JTI3Ea7GcFh1e6nPS/C0bn3mK7RE
        Y9Ls2bdxbSKP/KxdClWUj+FA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A4328F381;
        Tue,  1 Dec 2020 16:11:43 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 863398F380;
        Tue,  1 Dec 2020 16:11:42 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] banned.h: mark ctime_r() and asctime_r() as banned.
Date:   Tue,  1 Dec 2020 13:11:38 -0800
Message-Id: <20201201211138.33850-2-gitster@pobox.com>
X-Mailer: git-send-email 2.29.2-561-g49e167ef76
In-Reply-To: <20201201211138.33850-1-gitster@pobox.com>
References: <X8aMt2LEiCLkdV9/@nand.local>
 <20201201211138.33850-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: CF89653E-3419-11EB-8E2D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The ctime_r() and asctime_r() functions are reentrant, but have
no check that the buffer we pass in is long enough (the manpage says it
"should have room for at least 26 bytes"). Since this is such an
easy-to-get-wrong interface, and since we have the much safer stftime()
as well as its more conveinent strbuf_addftime() wrapper, let's ban both
of those.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 banned.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/banned.h b/banned.h
index ed11300bb2..7ab4f2e492 100644
--- a/banned.h
+++ b/banned.h
@@ -35,7 +35,11 @@
 #define localtime(t) BANNED(localtime)
 #undef ctime
 #define ctime(t) BANNED(ctime)
+#undef ctime_r
+#define ctime_r(t, buf) BANNED(ctime_r)
 #undef asctime
 #define asctime(t) BANNED(asctime)
+#undef asctime_r
+#define asctime_r(t, buf) BANNED(asctime_r)
=20
 #endif /* BANNED_H */
--=20
2.29.2-561-g49e167ef76

