Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB6C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A53661078
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhHFUxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:53:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58670 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbhHFUxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 16:53:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F51CEF577;
        Fri,  6 Aug 2021 16:52:47 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=9XjKMr+wvb4JncvE5sY8BY37I
        NzqQ2Aa6ZPtLVLiLqo=; b=K+pwBuKqRk5/Theim2+e5P+Ksa9wv4idTp2cFrOsd
        C91cTk4jGdYsONPvzWN9KRwrODH0sqSsWC5vE4NTcJU3N8gm6wJP4XclLP+AA97l
        lP4EJfe+DE/tF1Q98QEYqnNoIX3fSNKQ0Ged/HuasMoCDUsOcFD1+eijJehjGjCY
        j8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C19CEF576;
        Fri,  6 Aug 2021 16:52:47 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D65DDEF575;
        Fri,  6 Aug 2021 16:52:46 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/3] build: catch clang that identifies itself as "$VENDOR clang"
Date:   Fri,  6 Aug 2021 13:52:35 -0700
Message-Id: <20210806205235.988761-4-gitster@pobox.com>
X-Mailer: git-send-email 2.33.0-rc1-159-gdd7297d7fa
In-Reply-To: <20210806205235.988761-1-gitster@pobox.com>
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 411176DC-F6F8-11EB-AFBF-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The case statement in detect-compiler notices 'clang', 'FreeBSD
clang' and 'Apple clang', but there are other platforms that follow
the '$VENDOR clang' pattern (e.g. Debian).

Generalize the pattern to catch them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 detect-compiler | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/detect-compiler b/detect-compiler
index 955be1c906..11d60da5b7 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -38,13 +38,10 @@ case "$(get_family)" in
 gcc)
 	print_flags gcc
 	;;
-clang)
+clang | *" clang")
 	print_flags clang
 	;;
-"FreeBSD clang")
-	print_flags clang
-	;;
-"Apple LLVM"|"Apple clang")
+"Apple LLVM")
 	print_flags clang
 	;;
 *)
--=20
2.33.0-rc1-159-gdd7297d7fa

