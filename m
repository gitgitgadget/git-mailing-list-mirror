Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D069FC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA5920767
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hY++NCdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgDVP5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:57:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51141 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDVP5U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 11:57:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FB32C2361;
        Wed, 22 Apr 2020 11:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O457BwZRDtZk
        HvVo2feBmP8T4QQ=; b=hY++NCdFnaFUimmLNoyeXz0iFXgpIvX7lMoeoqsKh4jl
        rcgHIfkOhUj0BPKJ76wgZS2l7+gZSfCmpmjZYrDD+GPHj9y/923R7tO+ZeiJdjX7
        +pe/KDovziqu4rZKoBItWc2KbX36+C2qk9fmyyGv9T0sc7txi2s19Z2aQ6box8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vbxlw3
        CuDN1xzPBY6I2EaTvBOdXhIKZ5Z9SUzNK0mWBhCXXnzPOL8G56sZ1PmDwb5spG8g
        AQzs36hIVaCl9gY4SJVFtduILLLLvokLYcD6VygEttc1piQbYP63DdN1dR0+WA2S
        NnlnU53CrwY8SwFZAEufPkJlzbl4ZvBqqVroM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87BE8C2360;
        Wed, 22 Apr 2020 11:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3FDEC235F;
        Wed, 22 Apr 2020 11:57:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/receive-pack: use constant-time comparison for HMAC value
References: <20200409233730.680612-1-sandals@crustytoothpaste.net>
        <20200422102734.GA3063@szeder.dev>
Date:   Wed, 22 Apr 2020 08:57:13 -0700
In-Reply-To: <20200422102734.GA3063@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Wed, 22 Apr 2020 12:27:34 +0200")
Message-ID: <xmqqo8rjjyxy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF5D8BDC-84B1-11EA-85A6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: receive-pack: compilation fix

We do not use C99 "for loop initial declaration" in our codebase
(yet), but one snuck in.

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 45e2dd2a65..66149777a0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -505,7 +505,9 @@ static char *find_header(const char *msg, size_t len,=
 const char *key,
 static int constant_memequal(const char *a, const char *b, size_t n)
 {
 	int res =3D 0;
-	for (size_t i =3D 0; i < n; i++)
+	size_t i;
+
+	for (i =3D 0; i < n; i++)
 		res |=3D a[i] ^ b[i];
 	return res;
 }
--=20
2.26.2-108-g048abe1751

