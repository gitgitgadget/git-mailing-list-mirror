Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 15448 invoked by uid 111); 23 Dec 2008 10:16:53 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 23 Dec 2008 05:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbYLWKQs (ORCPT <rfc822;peff@peff.net>);
	Tue, 23 Dec 2008 05:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbYLWKQs
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 05:16:48 -0500
Received: from pan.madism.org ([88.191.52.104]:49325 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbYLWKQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 05:16:47 -0500
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Dec 2008 05:16:47 EST
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B8B622C158;
	Tue, 23 Dec 2008 11:05:52 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 1E5922AFDF; Tue, 23 Dec 2008 11:05:50 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	git@vger.kernel.org
Cc:	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] strbuf_readlink semantics update.
Date:	Tue, 23 Dec 2008 11:05:49 +0100
Message-Id: <1230026749-25360-1-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.6.1.rc4.304.g3da087
In-Reply-To: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

strbuf_* operations are meant to append their results to a current buffer
rather than _replace_ its content. Modify strbuf_readlink accordingly.

Current callers only operate on empty buffers at the moment and this
semantic change doesn't break any current code.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 strbuf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index bdf4954..254a7ee 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -299,12 +299,12 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 		int len;
 
 		strbuf_grow(sb, hint);
-		len = readlink(path, sb->buf, hint);
+		len = readlink(path, sb->buf + sb->len, hint);
 		if (len < 0) {
 			if (errno != ERANGE)
 				break;
 		} else if (len < hint) {
-			strbuf_setlen(sb, len);
+			strbuf_setlen(sb, sb->len + len);
 			return 0;
 		}
 
-- 
1.6.1.rc4.304.g3da087

