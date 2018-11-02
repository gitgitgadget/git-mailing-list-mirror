Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEAFC1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 05:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeKBO3R (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 10:29:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:37658 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727350AbeKBO3R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 10:29:17 -0400
Received: (qmail 26600 invoked by uid 109); 2 Nov 2018 05:23:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 05:23:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 696 invoked by uid 111); 2 Nov 2018 05:22:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 01:22:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 01:23:22 -0400
Date:   Fri, 2 Nov 2018 01:23:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] pathspec: handle non-terminated strings with :(attr)
Message-ID: <20181102052322.GC19234@sigill.intra.peff.net>
References: <20181102052239.GA19162@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102052239.GA19162@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pathspec code always takes names to be matched as a
name/namelen pair, but match_attrs() never looks at namelen,
and just treats "name" like a NUL-terminated string, passing
it to git_check_attr().

This usually works anyway. Every caller passes a
NUL-terminated string, and in all but one the passed-in
length is the same as the length of the string (the
exception is dir_path_match(), which may pass a smaller
length to drop a trailing slash). So we won't currently ever
read random memory, and the one case I found actually
happens to work correctly because the attr code can handle
the trailing slash itself.

But it's still worth addressing, as the function interface
implies that the name does not have to be NUL-terminated,
making this an accident waiting to happen.

Since teaching git_check_attr() to take a ptr/len pair would
be a big refactor, we'll just allocate a new string. We can
do this only when necessary, which avoids paying the cost
for most callers.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/dir.c b/dir.c
index 47c2fca8dc..ab6477d777 100644
--- a/dir.c
+++ b/dir.c
@@ -281,8 +281,15 @@ static int match_attrs(const struct index_state *istate,
 		       const struct pathspec_item *item)
 {
 	int i;
+	char *to_free = NULL;
+
+	if (name[namelen])
+		name = to_free = xmemdupz(name, namelen);
 
 	git_check_attr(istate, name, item->attr_check);
+
+	free(to_free);
+
 	for (i = 0; i < item->attr_match_nr; i++) {
 		const char *value;
 		int matched;
-- 
2.19.1.1336.g081079ac04
