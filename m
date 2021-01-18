Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6069C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1EE22E00
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbhARXw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:52:26 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55932 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733215AbhARXwD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Jan 2021 18:52:03 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AC7AA6081F;
        Mon, 18 Jan 2021 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611013810;
        bh=eWe08JyPGPhuNkoBKNMgo54eo3iXKpY520PeCX/aVU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mMNIvvE30bAX6WY+1aXY7fFkwlCH2qpEPePYG9z1NJ4N60/cwdWMGJR5AZ+tdzbla
         ic82IKqhtoqudk6xpC3vgbqUjedvF9BCIcO2/Z9V7UWGmZFkPX5tBYl+HNZrVnnGBi
         QnVN2xvMPE0VRJlVGCv1xp8/2w3r+TxL+5Kkq5otUuNBloqWVZrr2sQ9xdELjGduKo
         M/CJGIMb/QTDyU3IqjUaxxCIjpsGotvsCnMGVd4QiWupHgZkxJ/iNSb7bp7L4sxyYI
         KdNOEVUFzccJfnnugFfIG4wtfmn1l1VxynnMKxcsLcy8SmcTJQIqzqzpW/ylGvjKNR
         9rBtyr3jG0P89nHmYK9Yt/q6ul6JkB1SQVszC0hfBZwllkQyUg2kgMftXxTNJDMhJa
         esYmuIdReyLHlMYhgFNbsLLmbjXVU/Y29Dc/sxXf84Eq26G1SZ6lz1wfV531X6UOLl
         5GDbwmY9rs1VvPUzzrKCVVKCnS0HGEaoz/u+bZbCEbFtmuGihGL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 5/6] ref-filter: hoist signature parsing
Date:   Mon, 18 Jan 2021 23:49:14 +0000
Message-Id: <20210118234915.2036197-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
References: <20210111035840.2437737-1-sandals@crustytoothpaste.net>
 <20210118234915.2036197-1-sandals@crustytoothpaste.net>
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
index bba4877745..e6c8106377 100644
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
