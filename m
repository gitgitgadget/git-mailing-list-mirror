Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E542022F
	for <e@80x24.org>; Fri, 24 Feb 2017 21:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdBXVOE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:14:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:33626 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdBXVOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:14:04 -0500
Received: (qmail 12759 invoked by uid 109); 24 Feb 2017 21:07:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 21:07:22 +0000
Received: (qmail 28779 invoked by uid 111); 24 Feb 2017 21:07:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 16:07:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 16:07:19 -0500
Date:   Fri, 24 Feb 2017 16:07:19 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: [PATCH 1/3] parse_config_key: use skip_prefix instead of starts_with
Message-ID: <20170224210719.zyf5bd6dtwhi5s3f@sigill.intra.peff.net>
References: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This saves us having to repeatedly add in "section_len" (and
also avoids walking over the first part of the string
multiple times for a strlen() and strrchr()).

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index c6b874a7b..1b08a75a7 100644
--- a/config.c
+++ b/config.c
@@ -2536,11 +2536,10 @@ int parse_config_key(const char *var,
 		     const char **subsection, int *subsection_len,
 		     const char **key)
 {
-	int section_len = strlen(section);
 	const char *dot;
 
 	/* Does it start with "section." ? */
-	if (!starts_with(var, section) || var[section_len] != '.')
+	if (!skip_prefix(var, section, &var) || *var != '.')
 		return -1;
 
 	/*
@@ -2552,12 +2551,12 @@ int parse_config_key(const char *var,
 	*key = dot + 1;
 
 	/* Did we have a subsection at all? */
-	if (dot == var + section_len) {
+	if (dot == var) {
 		*subsection = NULL;
 		*subsection_len = 0;
 	}
 	else {
-		*subsection = var + section_len + 1;
+		*subsection = var + 1;
 		*subsection_len = dot - *subsection;
 	}
 
-- 
2.12.0.616.g5f622f3b1

