Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2022E20133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbdCBI2w (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:28:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:37050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932101AbdCBI2v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 03:28:51 -0500
Received: (qmail 22598 invoked by uid 109); 2 Mar 2017 08:21:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 08:21:28 +0000
Received: (qmail 15205 invoked by uid 111); 2 Mar 2017 08:21:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 03:21:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 03:21:27 -0500
Date:   Thu, 2 Mar 2017 03:21:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 2/8] strbuf_branchname: drop return value
Message-ID: <20170302082126.dupi3jcclhj6ejtv@sigill.intra.peff.net>
References: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value from strbuf_branchname() is confusing and
useless: it's 0 if the whole name was consumed by an @-mark,
but otherwise is the length of the original name we fed.

No callers actually look at the return value, so let's just
get rid of it.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 5 +----
 strbuf.h    | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 28865b3a1..4c1e91184 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1279,17 +1279,14 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	return -1;
 }
 
-int strbuf_branchname(struct strbuf *sb, const char *name)
+void strbuf_branchname(struct strbuf *sb, const char *name)
 {
 	int len = strlen(name);
 	int used = interpret_branch_name(name, len, sb);
 
-	if (used == len)
-		return 0;
 	if (used < 0)
 		used = 0;
 	strbuf_add(sb, name + used, len - used);
-	return len;
 }
 
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
diff --git a/strbuf.h b/strbuf.h
index cf1b5409e..47df0500d 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -560,7 +560,7 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 	strbuf_complete(sb, '\n');
 }
 
-extern int strbuf_branchname(struct strbuf *sb, const char *name);
+extern void strbuf_branchname(struct strbuf *sb, const char *name);
 extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
-- 
2.12.0.367.gb23790f66

