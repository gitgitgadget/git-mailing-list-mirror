Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1591FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 17:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755185AbdBNR2d (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 12:28:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:55139 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755169AbdBNR2c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 12:28:32 -0500
Received: (qmail 6543 invoked by uid 109); 14 Feb 2017 17:28:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 17:28:31 +0000
Received: (qmail 4539 invoked by uid 111); 14 Feb 2017 17:28:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 12:28:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 12:28:29 -0500
Date:   Tue, 14 Feb 2017 12:28:29 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] show-branch: use skip_prefix to drop magic numbers
Message-ID: <20170214172829.6w3cnnqy6ozxl424@sigill.intra.peff.net>
References: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We make several starts_with() calls, only to advance
pointers. This is exactly what skip_prefix() is for, which
lets us avoid manually-counted magic numbers.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/show-branch.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 404c4d09a..c03d3ec7c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -470,17 +470,14 @@ static void snarf_refs(int head, int remotes)
 	}
 }
 
-static int rev_is_head(char *head, char *name,
+static int rev_is_head(const char *head, const char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
 	if (!head || (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
-	if (starts_with(head, "refs/heads/"))
-		head += 11;
-	if (starts_with(name, "refs/heads/"))
-		name += 11;
-	else if (starts_with(name, "heads/"))
-		name += 6;
+	skip_prefix(head, "refs/heads/", &head);
+	if (!skip_prefix(name, "refs/heads/", &name))
+		skip_prefix(name, "heads/", &name);
 	return !strcmp(head, name);
 }
 
@@ -799,8 +796,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				has_head++;
 		}
 		if (!has_head) {
-			int offset = starts_with(head, "refs/heads/") ? 11 : 0;
-			append_one_rev(head + offset);
+			const char *name = head;
+			skip_prefix(name, "refs/heads/", &name);
+			append_one_rev(name);
 		}
 	}
 
-- 
2.12.0.rc1.479.g59880b11e
