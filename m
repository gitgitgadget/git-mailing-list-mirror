Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D668207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 01:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756436AbcI0BWS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 21:22:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56821 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756769AbcI0BWR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 21:22:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AEE440064;
        Mon, 26 Sep 2016 21:22:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=RP7I
        W/B2DKBCyJ5fjts5XCb/PSM=; b=iNmC4f08VXbmJx14vsIh7VnxOZSSDv8CZIfi
        eyMJqo+zOUdznjiHbKTx+s2zGhxnSRUNulrzeQNcB6fcdo0K8BCt+aK9qu4x9+Jo
        Yae2gnTDhob4drITrNa2vwX3rYJZ2fuGmy1+iKySGGu2ERIcwTc3X7H5557tAAP4
        eeVEA5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZhMV1p
        AET10RKOUJjNpKf2qE5XDjA4NXQ8OI1BHL+4gJFsMH2fZ/FBpIis2bEwCsWq/sOp
        qkJnoOpp7Q3H8Y+K5T+rvoZzL2frSRRKOJfWYRvv4VdjuoPJ3Quh0JWJMHE2ZriY
        7ZCatbIKm2GaVNrET7loDW3Vva1gq/S1QxvNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1459D40063;
        Mon, 26 Sep 2016 21:22:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BF6D40062;
        Mon, 26 Sep 2016 21:22:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] utf8: refactor code to decide fallback encoding
Date:   Mon, 26 Sep 2016 18:22:10 -0700
Message-Id: <20160927012211.9378-2-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-556-g5bbc40b
In-Reply-To: <20160927012211.9378-1-gitster@pobox.com>
References: <20160927012211.9378-1-gitster@pobox.com>
X-Pobox-Relay-ID: D3221632-8450-11E6-8E40-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The codepath we use to call iconv_open() has a provision to use a
fallback encoding when it fails, hoping that "UTF-8" being spelled
differently could be the reason why the library function did not
like the encoding names we gave it.  Essentially, we turn what we
have observed to be used as variants of "UTF-8" (e.g. "utf8") into
the most official spelling and use that as a fallback.

We do the same thing for input and output encoding.  Introduce a
helper function to do just one side and call that twice.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 utf8.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/utf8.c b/utf8.c
index 00e10c8..550e785 100644
--- a/utf8.c
+++ b/utf8.c
@@ -489,6 +489,21 @@ char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, int *outs
 	return out;
 }
 
+static const char *fallback_encoding(const char *name)
+{
+	/*
+	 * Some platforms do not have the variously spelled variants of
+	 * UTF-8, so let's fall back to trying the most official
+	 * spelling. We do so only as a fallback in case the platform
+	 * does understand the user's spelling, but not our official
+	 * one.
+	 */
+	if (is_encoding_utf8(name))
+		return "UTF-8";
+
+	return name;
+}
+
 char *reencode_string_len(const char *in, int insz,
 			  const char *out_encoding, const char *in_encoding,
 			  int *outsz)
@@ -501,17 +516,9 @@ char *reencode_string_len(const char *in, int insz,
 
 	conv = iconv_open(out_encoding, in_encoding);
 	if (conv == (iconv_t) -1) {
-		/*
-		 * Some platforms do not have the variously spelled variants of
-		 * UTF-8, so let's fall back to trying the most official
-		 * spelling. We do so only as a fallback in case the platform
-		 * does understand the user's spelling, but not our official
-		 * one.
-		 */
-		if (is_encoding_utf8(in_encoding))
-			in_encoding = "UTF-8";
-		if (is_encoding_utf8(out_encoding))
-			out_encoding = "UTF-8";
+		in_encoding = fallback_encoding(in_encoding);
+		out_encoding = fallback_encoding(out_encoding);
+
 		conv = iconv_open(out_encoding, in_encoding);
 		if (conv == (iconv_t) -1)
 			return NULL;
-- 
2.10.0-556-g5bbc40b

