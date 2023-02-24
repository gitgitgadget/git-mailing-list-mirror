Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99D9C61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBXGik (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBXGii (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:38:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF11860D6B
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:38:36 -0800 (PST)
Received: (qmail 3669 invoked by uid 109); 24 Feb 2023 06:38:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:38:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31093 invoked by uid 111); 24 Feb 2023 06:38:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:38:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:38:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/21] http-backend: mark argc/argv unused
Message-ID: <Y/hba4Zq/j4ZhFoM@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can't drop them because it's cmd_main(), which has a set prototype,
but the CGI interface does not do anything with such arguments.

Arguably we could detect them and complain. It's possible this could
detect misconfigurations or other mistakes, but:

  - as far as I can tell common webservers like apache do not have any
    mechanism to pass arguments to a CGI at all, so this isn't a mistake
    one could even make

  - it's possible that some obscure webserver might pass arguments, and
    we'd break that case. I have no idea if such a webserver exists; the
    CGI standard says only "The script is invoked in a system-defined
    manner".

So probably it would not hurt to detect them, but it also is unlikely to
help anyone. Let's just mark them as unused, which retains the current
behavior but silences -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-backend.c b/http-backend.c
index 8ab58e55f8..fc3ab97c0f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -736,7 +736,7 @@ static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
 	return 0;
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
 {
 	char *method = getenv("REQUEST_METHOD");
 	const char *proto_header;
-- 
2.39.2.981.g6157336f25

