Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D52C07548
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B551208E4
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t9U8fltr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIJRDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:03:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54718 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgIJRCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:02:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6056E0E12;
        Thu, 10 Sep 2020 13:02:13 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=5JRU/h3y3iEwQbydRN4YuflRC
        BU=; b=t9U8fltr0Ar7+kgxErtkIuguhkXBN6iW1zvhQbem9DUv1+Ut2R/80pOUV
        vO2ISLDMsyCbJL1mkVNUhgheGzSlR5UjwVeFrxUlibHUXePUAVPmL7e0cMvSiZfL
        LxKBpYlwa2MNEbuI8P8j7u0NB1FoViqabBJLA9XZPp2+XyeULE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=Je/yLbRzEx/jM7adZjK
        5mCDONqM6uQnuRmxv9///ftUSvOIYydBsSXZEyvXLo/aY0A2gaAme62EOEeOGTHM
        UoP1ypbRU8sjBPogIEhXMM3lM0qQlKrv42XIC1Ix0Qes0kGwfS7ANt5NgSerI1gx
        09dRJpi2R8FtpaLhnh0SAeR4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FB8DE0E11;
        Thu, 10 Sep 2020 13:02:13 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD697E0E10;
        Thu, 10 Sep 2020 13:02:10 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 4/7] quote_path: code clarification
Date:   Thu, 10 Sep 2020 10:01:56 -0700
Message-Id: <20200910170159.1278781-5-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-603-ga98dad7d4d
In-Reply-To: <20200910170159.1278781-1-gitster@pobox.com>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 5DDE9CCE-F387-11EA-AC70-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The implementation we moved from wt-status to enclose a pathname
that has a SP in it inside a dq-pair is a bit convoluted.  It lets
quote_c_style_counted() do its escaping and then

 (1) if the input string got escaped, which is checked by seeing if
     the result begins with a double-quote, declare that we are
     done.  If there wasn't any SP in the input, that is OK, and if
     there was, the result is quoted already so it is OK, too.

 (2) if the input string did not get escaped, and the result has SP
     in it, enclose the whole thing in a dq-pair ourselves.

Instead we can scan the path upfront to see if the input has SP in
it.  If so, we tell quote_c_style_counted() not to enclose its
output in a dq-pair, and we add a dq-pair ourselves.  Whether the
input had bytes that quote_c_style_counted() uses backslash quoting,
this would give us a desired quoted string.  If the input does not
have SP in it, we just let quote_c_style_counted() do its thing as
usual, which would enclose the result in a dq-pair only when needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 quote.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/quote.c b/quote.c
index aa9a37b1b1..b8107cd403 100644
--- a/quote.c
+++ b/quote.c
@@ -356,16 +356,21 @@ char *quote_path(const char *in, const char *prefix=
, struct strbuf *out, unsigne
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *rel =3D relative_path(in, prefix, &sb);
+	int force_dq =3D ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' '));
+
 	strbuf_reset(out);
-	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
-	strbuf_release(&sb);
=20
-	if ((flags & QUOTE_PATH_QUOTE_SP) &&
-	    (out->buf[0] !=3D '"' && strchr(out->buf, ' '))) {
-		/* Ensure the whole thing is quoted if the path has SP in it */
-		strbuf_insertstr(out, 0, "\"");
+	/*
+	 * If the caller wants us to enclose the output in a dq-pair
+	 * whether quote_c_style_counted() needs to, we do it ourselves
+	 * and tell quote_c_style_counted() not to.
+	 */
+	if (force_dq)
 		strbuf_addch(out, '"');
-	}
+	quote_c_style_counted(rel, strlen(rel), out, NULL, !!force_dq);
+	if (force_dq)
+		strbuf_addch(out, '"');
+	strbuf_release(&sb);
=20
 	return out->buf;
 }
--=20
2.28.0-603-ga98dad7d4d

