Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B223CC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B72464EDF
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhBKCJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:09:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45914 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhBKCJo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Feb 2021 21:09:44 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 91B8A60DE2;
        Thu, 11 Feb 2021 02:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613009301;
        bh=H/INRfllYyg7i2IOB9IKquFFT1GDJB+PNBw+QTHWitc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Q4ygP2mgRGTGmAagA9EJwffGQ1sJnWrFr6SyLyFFjz+nNdsp/GdEiaBerpPJ56Jml
         T4O3wDNghp1OnRK9J3KC1yAOqtmdU8N5I8CBrosKpPGo6O0Y5Tfwys9tbulV7df99m
         jbAxOgIRdzMNUl0HQLRFCeZ8bVfoZogIvPybDedN+iMhph5qfKYl1FUQgUqzoBGQ5Z
         iofkgGgU167fqQyUCNeHhJIt99PiOG8FASsD9tUzA/828CCz0YmPRBYCIY4wvrwbfi
         2QexHQNYlYdhRZ5hxo4hwvC+vmtWIzRDURFzoDBX5tAiKaWuvSmk2POXMiJl0o2aRy
         DgsAG9SyMdb4Xsx2iBV5hAYqO9zHwj/kuyF+4hZWYSXJvlSpzSbpxC7SSXvHYJsKgG
         Clob93Ys1e3uREEfqO/FATXMYlYYYts+/T9WyWFUjbqygN9iNO9HLlIPgFomdFp9vY
         ydDj93FXReEj/+Ddk7vM/hpZWXHXAii26KGc9xLw5KEfgq6i6iS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 5/6] ref-filter: hoist signature parsing
Date:   Thu, 11 Feb 2021 02:08:05 +0000
Message-Id: <20210211020806.288523-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210211020806.288523-1-sandals@crustytoothpaste.net>
References: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
 <20210211020806.288523-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we parse a signature in the ref-filter code, we continually
increment the buffer pointer.  Hoist the signature parsing above the
blank line delimiting headers and body so we can find the signature when
using a header to sign the buffer.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ref-filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 040a24402e..bade6528ee 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1221,6 +1221,8 @@ static void find_subpos(const char *buf,
 	const char *end = buf + strlen(buf);
 	const char *sigstart;
 
+	/* parse signature first; we might not even have a subject line */
+	parse_signature(buf, end - buf, &payload, &signature);
 
 	/* skip past header until we hit empty line */
 	while (*buf && *buf != '\n') {
@@ -1232,9 +1234,6 @@ static void find_subpos(const char *buf,
 	/* skip any empty lines */
 	while (*buf == '\n')
 		buf++;
-
-	/* parse signature first; we might not even have a subject line */
-	parse_signature(buf, end - buf, &payload, &signature);
 	*sig = strbuf_detach(&signature, siglen);
 	sigstart = buf + parse_signed_buffer(buf, strlen(buf));
 
@@ -1330,7 +1329,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			v->s = xmemdupz(sigpos, siglen);
 		else if (atom->u.contents.option == C_LINES) {
 			struct strbuf s = STRBUF_INIT;
-			const char *contents_end = bodylen + bodypos - siglen;
+			const char *contents_end = bodypos + nonsiglen;
 
 			/*  Size is the length of the message after removing the signature */
 			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
