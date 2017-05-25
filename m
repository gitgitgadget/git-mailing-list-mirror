Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4DB2209FD
	for <e@80x24.org>; Thu, 25 May 2017 19:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762529AbdEYTdK (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:33:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:58052 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761548AbdEYTdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:33:09 -0400
Received: (qmail 25394 invoked by uid 109); 25 May 2017 19:33:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 19:33:07 +0000
Received: (qmail 22889 invoked by uid 111); 25 May 2017 19:33:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 15:33:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 May 2017 15:33:05 -0400
Date:   Thu, 25 May 2017 15:33:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] connect.c: fix leak in parse_one_symref_info()
Message-ID: <20170525193304.fhtmywv4xisclhii@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we successfully parse a symref value like
"HEAD:refs/heads/master", we add the result to a string
list. But because the string list is marked
STRING_LIST_INIT_DUP, the string list code will make a copy
of the string and add the copy.

This patch fixes it by adding the entry with
string_list_append_nodup(), which lets the string list take
ownership of our newly allocated string. There are two
alternatives that seem like they would work, but aren't the
right solution.

The first is to initialize the list with the "NODUP"
initializer. That would avoid the copy, but then the string
list would not realize that it owns the strings. When we
eventually call string_list_clear(), it would not free the
strings, causing a leak.

The second option would be to use the normal
string_list_append(), but free the local copy in our
function. We can't do this because the local copy actually
contains _two_ strings; the symref name and its target. We
point to the target pointer via the "util" field, and its
memory must last as long as the string list does.

You may also wonder whether it's safe to ever free the local
copy, since the target points into it. The answer is yes,
because we duplicate it in annotaate_refs_with_symref_info
before clearing the string list.

Signed-off-by: Jeff King <peff@peff.net>
---
Phew. For a one-line leak fix, that sure was complicated.

I doubt it matters much in practice, because servers send only a single
HEAD, so we just leak one string. But I happened to notice it while
looking at the unborn-HEAD thing.

 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index cd21a1b6f..c72b1d115 100644
--- a/connect.c
+++ b/connect.c
@@ -71,7 +71,7 @@ static void parse_one_symref_info(struct string_list *symref, const char *val, i
 	    check_refname_format(target, REFNAME_ALLOW_ONELEVEL))
 		/* "symref=bogus:pair */
 		goto reject;
-	item = string_list_append(symref, sym);
+	item = string_list_append_nodup(symref, sym);
 	item->util = target;
 	return;
 reject:
-- 
2.13.0.496.ge44ba89db
