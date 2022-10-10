Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A5EC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJJUia (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJJUiN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 16:38:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675EBF51
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 13:38:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 369D6143EB2;
        Mon, 10 Oct 2022 16:38:12 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fDstQLqyQdgA
        lVotFaGrpeqcGBxsYFce8TUwoLPos6k=; b=KcEmqGISPOHdQQgnxdhvo9fo5O88
        p00awL1WlG6Vjk6qyAKi2v93kBfU0smepBt4Lm8AB4NXbLbxQzGTJtVBhBz0s1Lb
        urBwaPIegAXIMcgMLrQmd9FLL39wST91M2/p7iZdm0cjmGe0ZgE4VYIO6fQUZ12R
        IxfUOyRZd3nZkD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F382143EB0;
        Mon, 10 Oct 2022 16:38:12 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9499B143EAF;
        Mon, 10 Oct 2022 16:38:11 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] CodingGuidelines: mention C99 features we can't use
Date:   Mon, 10 Oct 2022 13:37:59 -0700
Message-Id: <20221010203800.2154698-5-gitster@pobox.com>
X-Mailer: git-send-email 2.38.0-140-gc6454a6c7f
In-Reply-To: <20221010203800.2154698-1-gitster@pobox.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
 <20221010203800.2154698-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 74FEB56E-48DB-11ED-A376-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

The C99 section of the CodingGuidelines is a good overview of what we
can use, but is sorely lacking in what we can't use. Something that
comes up occasionally is the portability of %z.

Per [1] we couldn't use it for the longest time due to MSVC not
supporting it, but nowadays by requiring C99 we rely on the MSVC
version that does, but we can't use it yet because a C library that
MinGW uses doesn't support it.

1. https://lore.kernel.org/git/a67e0fd8-4a14-16c9-9b57-3430440ef93c@gmail=
.com/

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index f9affc4050..9598b45f7e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -235,6 +235,13 @@ For C programs:
    . since late 2021 with 44ba10d6, we have had variables declared in
      the for loop "for (int i =3D 0; i < 10; i++)".
=20
+   New C99 features that we cannot use yet:
+
+   . %z and %zu as a printf() argument for a size_t (the %z being for
+     the POSIX-specific ssize_t). Instead you should use
+     printf("%"PRIuMAX, (uintmax_t)v).  These days the MSVC version we
+     rely on supports %z, but the C library used by MinGW does not.
+
  - Variables have to be declared at the beginning of the block, before
    the first statement (i.e. -Wdeclaration-after-statement).
=20
--=20
2.38.0-167-gf9a88ca9e9

