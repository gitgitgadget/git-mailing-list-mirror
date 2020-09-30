Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A45C4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859242076E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgI3M2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:28:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:45294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3M2d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:28:33 -0400
Received: (qmail 23915 invoked by uid 109); 30 Sep 2020 12:28:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:28:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27932 invoked by uid 111); 30 Sep 2020 12:28:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:28:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:28:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/10] env--helper: write to opt->value in parseopt helper
Message-ID: <20200930122832.GC1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use OPT_CALLBACK_F() to call the option_parse_type() callback,
passing it the address of "cmdmode" as the value to write to. But the
callback doesn't look at opt->value at all, and instead writes to a
global variable.

This works out because that's the same global variable we happen to pass
in, but it's rather confusing.  Let's use the passed-in value instead.
We'll also make "cmdmode" a local variable of the main function,
ensuring we can't make the same mistake again.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/env--helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/env--helper.c b/builtin/env--helper.c
index 23c214fff6..3aa4282114 100644
--- a/builtin/env--helper.c
+++ b/builtin/env--helper.c
@@ -7,18 +7,20 @@ static char const * const env__helper_usage[] = {
 	NULL
 };
 
-static enum {
+enum cmdmode {
 	ENV_HELPER_TYPE_BOOL = 1,
 	ENV_HELPER_TYPE_ULONG
-} cmdmode = 0;
+};
 
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
+	enum cmdmode *cmdmode = opt->value;
+
 	if (!strcmp(arg, "bool"))
-		cmdmode = ENV_HELPER_TYPE_BOOL;
+		*cmdmode = ENV_HELPER_TYPE_BOOL;
 	else if (!strcmp(arg, "ulong"))
-		cmdmode = ENV_HELPER_TYPE_ULONG;
+		*cmdmode = ENV_HELPER_TYPE_ULONG;
 	else
 		die(_("unrecognized --type argument, %s"), arg);
 
@@ -33,6 +35,7 @@ int cmd_env__helper(int argc, const char **argv, const char *prefix)
 	int ret;
 	int ret_int, default_int;
 	unsigned long ret_ulong, default_ulong;
+	enum cmdmode cmdmode = 0;
 	struct option opts[] = {
 		OPT_CALLBACK_F(0, "type", &cmdmode, N_("type"),
 			       N_("value is given this type"), PARSE_OPT_NONEG,
-- 
2.28.0.1173.gad90222cf0

