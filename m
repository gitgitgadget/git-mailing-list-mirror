Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2E2C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAD520705
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j+PF0la7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgLAVMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 16:12:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57439 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgLAVMY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 16:12:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8AC310E70F;
        Tue,  1 Dec 2020 16:11:42 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=PyTAgSMXZZe/ZhsrER3IQc+hp
        Ns=; b=j+PF0la7xNHieB3JS0GUpo5XDJkGbD100p+uBOno65i7oe/52CdYuWG4O
        UHdFHtkX86ViqpS3eTSFVwuxzqbvgGlbj9oyngmAXnbOLftmVVsSVu0++wyvfbdr
        Ll+fiRrD7S/5luB7dS6omuym0Xmr0NQ3d/bNSkwHxSSHYibrY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=aKNvYrxpUIhqpGdtY/H
        Cmxg0wHs1HpkHHRjE98AynFl2frzmeAarePAUGUrKSi+fuuo1eekEQY6hajAmlMP
        oCL8TeDhy4Q8lViwxE9qqRQdNq25nkMFiNHYLtgDEGeE96vhcql7usEJYIKuEJUI
        TP56ToDOaVjihl8QeK3VVSc0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2EEF10E70E;
        Tue,  1 Dec 2020 16:11:42 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 092B410E70C;
        Tue,  1 Dec 2020 16:11:39 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] banned.h: mark non-reentrant gmtime, etc as banned
Date:   Tue,  1 Dec 2020 13:11:37 -0800
Message-Id: <20201201211138.33850-1-gitster@pobox.com>
X-Mailer: git-send-email 2.29.2-561-g49e167ef76
In-Reply-To: <X8aMt2LEiCLkdV9/@nand.local>
References: <X8aMt2LEiCLkdV9/@nand.local>
MIME-Version: 1.0
X-Pobox-Relay-ID: CE0A3D50-3419-11EB-9A11-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The traditional gmtime(), localtime(), ctime(), and asctime() functions
return pointers to shared storage. This means they're not thread-safe,
and they also run the risk of somebody holding onto the result across
multiple calls (where each call invalidates the previous result).

All callers should be using their reentrant counterparts.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 banned.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/banned.h b/banned.h
index 60a18d4403..ed11300bb2 100644
--- a/banned.h
+++ b/banned.h
@@ -29,4 +29,13 @@
 #define vsprintf(buf,fmt,arg) BANNED(vsprintf)
 #endif
=20
+#undef gmtime
+#define gmtime(t) BANNED(gmtime)
+#undef localtime
+#define localtime(t) BANNED(localtime)
+#undef ctime
+#define ctime(t) BANNED(ctime)
+#undef asctime
+#define asctime(t) BANNED(asctime)
+
 #endif /* BANNED_H */
--=20
2.29.2-561-g49e167ef76

