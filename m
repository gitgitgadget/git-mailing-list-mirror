Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170E3202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 17:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbdJSRrt (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 13:47:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:57826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751750AbdJSRrd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 13:47:33 -0400
Received: (qmail 29016 invoked by uid 109); 19 Oct 2017 17:47:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:47:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10155 invoked by uid 111); 19 Oct 2017 17:47:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 13:47:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 13:47:30 -0400
Date:   Thu, 19 Oct 2017 13:47:30 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        l.s.r@web.de, avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: [PATCH 2/4] remote: handle broken symrefs
Message-ID: <20171019174730.urelfyc2kj37fokg@sigill.intra.peff.net>
References: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible for resolve_ref_unsafe() to return NULL with a
REF_ISSYMREF flag if a symref points to a broken ref.  In
this case, the read_remote_branches() function will segfault
passing the name to xstrdup().

This is hard to trigger in practice, since this function is
used as a callback to for_each_ref(), which will skip broken
refs in the first place (so it would have to be broken
racily, or for us to see a transient filesystem error).

If we see such a racy broken outcome let's treat it as "not
a symref". This is exactly the same thing that would happen
in the non-racy case (our function would not be called at
all, as for_each_ref would skip the broken symref).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 4f5cac96b0..bc89623695 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -565,7 +565,7 @@ static int read_remote_branches(const char *refname,
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
 					    NULL, &flag);
-		if (flag & REF_ISSYMREF)
+		if (symref && (flag & REF_ISSYMREF))
 			item->util = xstrdup(symref);
 		else
 			item->util = NULL;
-- 
2.15.0.rc1.560.g5f0609e481

