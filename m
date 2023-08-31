Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71EDC83F2F
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347505AbjHaVRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346710AbjHaVRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:17:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065B4FF
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:17:34 -0700 (PDT)
Received: (qmail 25968 invoked by uid 109); 31 Aug 2023 21:17:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 21:17:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11540 invoked by uid 111); 31 Aug 2023 21:17:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 17:17:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 17:17:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 03/10] format-patch: use OPT_STRING_LIST for to/cc options
Message-ID: <20230831211733.GC949469@coredump.intra.peff.net>
References: <20230831211637.GA949188@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831211637.GA949188@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The to_callback() and cc_callback() functions are identical to the
generic parse_opt_string_list() function (except that they don't handle
optional arguments, but that's OK because their callers do not use the
OPTARG flag).

Let's simplify the code by using OPT_STRING_LIST.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index db3a88bfe9..fb90d43717 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1567,24 +1567,6 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static int to_callback(const struct option *opt, const char *arg, int unset)
-{
-	if (unset)
-		string_list_clear(&extra_to, 0);
-	else
-		string_list_append(&extra_to, arg);
-	return 0;
-}
-
-static int cc_callback(const struct option *opt, const char *arg, int unset)
-{
-	if (unset)
-		string_list_clear(&extra_cc, 0);
-	else
-		string_list_append(&extra_cc, arg);
-	return 0;
-}
-
 static int from_callback(const struct option *opt, const char *arg, int unset)
 {
 	char **from = opt->value;
@@ -1957,8 +1939,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Messaging")),
 		OPT_CALLBACK(0, "add-header", NULL, N_("header"),
 			    N_("add email header"), header_callback),
-		OPT_CALLBACK(0, "to", NULL, N_("email"), N_("add To: header"), to_callback),
-		OPT_CALLBACK(0, "cc", NULL, N_("email"), N_("add Cc: header"), cc_callback),
+		OPT_STRING_LIST(0, "to", &extra_to, N_("email"), N_("add To: header")),
+		OPT_STRING_LIST(0, "cc", &extra_cc, N_("email"), N_("add Cc: header")),
 		OPT_CALLBACK_F(0, "from", &from, N_("ident"),
 			    N_("set From address to <ident> (or committer ident if absent)"),
 			    PARSE_OPT_OPTARG, from_callback),
-- 
2.42.0.561.gaa987ecc69

