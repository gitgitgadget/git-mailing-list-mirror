Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EACC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B90220776
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbgFWPZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:25:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:40182 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbgFWPZC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:25:02 -0400
Received: (qmail 11872 invoked by uid 109); 23 Jun 2020 15:25:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 15:25:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16976 invoked by uid 111); 23 Jun 2020 15:25:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 11:25:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 11:25:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 07/10] fast-export: move global "idents" anonymize hashmap
 into function
Message-ID: <20200623152501.GG1435482@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the other anonymization functions keep their static mappings
inside the function to avoid polluting the global namespace. Let's do
the same for "idents", as nobody needs it outside of
anonymize_ident_line().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 99d4a2b404..16a1563e49 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -555,7 +555,6 @@ static char *anonymize_commit_message(const char *old)
 	return xstrfmt("subject %d\n\nbody\n", counter++);
 }
 
-static struct hashmap idents;
 static char *anonymize_ident(const char *old, size_t len)
 {
 	static int counter;
@@ -572,6 +571,7 @@ static char *anonymize_ident(const char *old, size_t len)
  */
 static void anonymize_ident_line(const char **beg, const char **end)
 {
+	static struct hashmap idents;
 	static struct strbuf buffers[] = { STRBUF_INIT, STRBUF_INIT };
 	static unsigned which_buffer;
 
-- 
2.27.0.517.gbc32778fa3

