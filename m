Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E47420986
	for <e@80x24.org>; Tue, 27 Sep 2016 01:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932639AbcI0BWW (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 21:22:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51789 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756508AbcI0BWU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 21:22:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64005423AD;
        Mon, 26 Sep 2016 21:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Jzu/
        wBvCpJ1IMAGa81uG7QF2diQ=; b=Kowar5EH1jdMsDttyqP2Q2XsiJ24HenQlVqe
        pggUjeHoS548YgxpU5izwQ5ACNNYQDre1JsiPKQlDdFs3U2dbGb7X+93n/6Os9U5
        M5/ODXi+8mrMnHb6VyzW040tspRSo/ahs8AuRoiwPM5khz3hrbX/Xc1/oEYSAgiT
        xB/1Bn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=pLEGLR
        ngPiVpGJ8h13jqXs52FtjhuMZgFoY1/bPs4RF78QDCXWgJ57VHYVrurSflm3i/8K
        yM4Ttk0q/G0BdFUVUNGGtSyXGeGrdrYhoc5foAFN0AId23W42wRgzAIUFUwhadNL
        uCI+aFJfcScaafFCC5o6I2Gui+FbThf1JW7iw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B0F1423AB;
        Mon, 26 Sep 2016 21:22:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5194423AA;
        Mon, 26 Sep 2016 21:22:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] utf8: accept "latin-1" as ISO-8859-1
Date:   Mon, 26 Sep 2016 18:22:11 -0700
Message-Id: <20160927012211.9378-3-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-556-g5bbc40b
In-Reply-To: <20160927012211.9378-1-gitster@pobox.com>
References: <20160927012211.9378-1-gitster@pobox.com>
X-Pobox-Relay-ID: D480C8CA-8450-11E6-B6B4-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though latin-1 is still seen in e-mail headers, some platforms
only install ISO-8859-1.  "iconv -f ISO-8859-1" succeeds, while
"iconv -f latin-1" fails on such a system.

Using the same fallback_encoding() mechanism factored out in the
previous step, teach ourselves that "ISO-8859-1" has a better chance
of being accepted than "latin-1".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 utf8.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/utf8.c b/utf8.c
index 550e785..0c8e011 100644
--- a/utf8.c
+++ b/utf8.c
@@ -501,6 +501,13 @@ static const char *fallback_encoding(const char *name)
 	if (is_encoding_utf8(name))
 		return "UTF-8";
 
+	/*
+	 * Even though latin-1 is still seen in e-mail
+	 * headers, some platforms only install ISO-8859-1.
+	 */
+	if (!strcasecmp(name, "latin-1"))
+		return "ISO-8859-1";
+
 	return name;
 }
 
-- 
2.10.0-556-g5bbc40b

