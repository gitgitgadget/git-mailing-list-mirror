Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9EAC433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 03:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A80F22475
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 03:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbhAKD7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 22:59:33 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50706 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbhAKD7c (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 22:59:32 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9B62E6080E;
        Mon, 11 Jan 2021 03:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610337531;
        bh=Fv4Gt8h72wYuxAxF7cQhHRiMjfsMQ1PGi3Q32phIhl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XkEje9Dm0pnSfR0A12LnmAqc0eKD56+sH5QKET6TNFVpPdEY0j+aO2Kzv7tkLVeao
         t9lLB5J6HpTJs+ZJZYXVuQfROal+d9RG+tOmyxpH6VKLJZ+MWnRqBNUJOnUipHEjRH
         m4vnhNV42jOUTEyJXjkfg8gZxJcnimjEPuj8Xd27MpbZMk06iyTfpUIxW8cs0Qc58O
         lXu8+b7oxLcdbWyf3o4InfPr7f2tTMQ6EzGIhN6gmofEjwyzpsdV4iv0QZHle/yhYV
         vSdBoQ5VrKeZa0LjvmXkCyxGxKVdZI1d/R377FTSQCyqGQt/mw19CYBmS9CSByShUq
         H0wSMZOF3KQ2mgSMVnPSh4Iy/y73+yDAtcb9k0LSlGgLsNDd4QCA32f9zzFGySsDLn
         iZ+RtLOn4ViEtPjfVAteoSh95uC4oN1JHjw52MU7hUQC4oJ0shbtqvCB/PlUvFuEh1
         AB+Qh7rt4nanKz+AGNceYBgnkWuzdg+RWY0r2AGnn6Reqsy7wLI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 4/5] ref-filter: hoist signature parsing
Date:   Mon, 11 Jan 2021 03:58:39 +0000
Message-Id: <20210111035840.2437737-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210111035840.2437737-1-sandals@crustytoothpaste.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
 <20210111035840.2437737-1-sandals@crustytoothpaste.net>
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
index 8d8baec1b5..32ed4d5111 100644
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
