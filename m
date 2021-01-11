Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77283C433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB1E22ADF
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAKAih (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 19:38:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50500 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbhAKAig (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 19:38:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AAF9B6080E;
        Mon, 11 Jan 2021 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610325475;
        bh=Fv4Gt8h72wYuxAxF7cQhHRiMjfsMQ1PGi3Q32phIhl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=EyYUQXwbSIfO1UU8Z23bOHUJoIInTt/rQw0A98D9OyJBkqXIt1SEvg5vKbJj1BGq/
         f/j++FrL9/MfVMcM9UhU1jXoCiD85+bt4swfctbNyGg9dM5uJq4YO2J6jG+UGY/EvF
         iuMqKdNCtE1BGzMEgKMJzJwqOZOBAgHVvW0sKhFoBGyMVy99bP+C7t+MybewL2pxen
         dlaHWKqTBXGz8RJO5cyCGGvO0iTiyE5rjtyUdrap1wJSWVQa7InpkIvXF7KZcS0zCh
         ICXv7eTUNS741vfdx4lhySTHQiUy4YLK9fVIYcRdbrtY+YYxz8y5u318qS2qCGctlB
         LMzLDw5wNgCHcteR9+HwebUoxWSQAe3XgDHfVzWHHMe4ctfScauB2aQd2Alz3a2hJd
         dayomEtXgKynv7z2Ve2uv8QtBPw9cNBVKds+6W1qnhiRs9b+BQjeA8E6Alwy1pAAl6
         AMYr6UkWWPpbFzHymVPc7za7w38Kwm/lORgVwDCUSpBVG/80mKC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 4/5] ref-filter: hoist signature parsing
Date:   Mon, 11 Jan 2021 00:37:37 +0000
Message-Id: <20210111003740.1319996-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
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
