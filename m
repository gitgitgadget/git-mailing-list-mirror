Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE0C433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C897D60F4B
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJ2SsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhJ2Srz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:47:55 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1706CC061766
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:45:26 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635533123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YThjquv3Yec1PDy2Xp0D8f+sRIjrEWH9sfj9grFHTH0=;
        b=RKJ1ymOmSbu5xvridPgXUcx53xyMjUhP7DX/OMh+/5CFFYF/iWTPPYfjsY/IBPSgMHUyW4
        lD8d1qvzF/XBSUD7TAohoE0tMn6GXAtGI4OxDIKdgDCD2L3vdUCAHM+ohUsGoyyqZZSlqa
        wP+k+VAkKqvVqd8MhCTzPhPlp1dyMD+/nU4DD9rjJbj4onVSweoz/5Qq4gU6JQt9vxlX5Q
        TMX2Hv3fbkQhwgLknAhdhKLqgm657ryg50NRTq6qjxQfyNCDVYFef4Lqyml2j5+RHAHQor
        kTYHMdvclgn2nI96MFh4zMXcVUllDaGNcUabk7g1aCxRTdpsUv1lUx1Ejfpr1wYeKCL7ko
        WAI7Vb/dgI8es7nWfy+Cl9LWqZuPcqjYV8/dmWH3cQ/aDtbbimUGV2+jrjXZ+dQd+DEb1n
        GjS/IlbntbtTW9e8j+Of59Mj0HWcV13ozcn5dromEUU3mQkeIhsE+69i69kjWLST1KJ72J
        KelbYefVSqtM+5nZOEoFT0EPdbzde5NlZoSu6310Yko77g/kgg57DNpG6RpZ/VepHtAHC4
        NuwS6Dg3a+Th0YPajB3nNPhI0bgNfNEgfCpp6UzR9eILXIGeEgxAu/+/OxHkVudaHJkE6f
        Y7BAPFAHbHzYBNfrFaOrKfBtVJZ0xw/9t48N7fHQj2Y03dByWvmNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635533123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YThjquv3Yec1PDy2Xp0D8f+sRIjrEWH9sfj9grFHTH0=;
        b=xEF6/N/FiSNINjVngXRE/5CRUHmZ+i7gokxZKcb5eBxSeoDoOl2IkpavB6ZtiFXXWc+RI4
        3e31bMxu+KNe+kBw==
To:     git@vger.kernel.org
Subject: [PATCH v3 1/3] pretty.c: rework describe options parsing for better extensibility
Date:   Fri, 29 Oct 2021 14:45:10 -0400
Message-Id: <20211029184512.1568017-2-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029184512.1568017-1-eschwartz@archlinux.org>
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It contains option arguments only, not options. We would like to add
option support here too, but to do that we need to distinguish between
different types of options.

Lay out the groundwork for distinguishing between bools, strings, etc.
and move the central logic (validating values and pushing new arguments
to *args) into the successful match, because that will be fairly
conditional on what type of argument is being parsed.

Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
---
 pretty.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/pretty.c b/pretty.c
index fe95107ae5..2ec023a0d0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1216,28 +1216,37 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 
 static size_t parse_describe_args(const char *start, struct strvec *args)
 {
-	const char *options[] = { "match", "exclude" };
+	struct {
+		char *name;
+		enum { OPT_STRING } type;
+	}  option[] = {
+		{ "exclude", OPT_STRING },
+		{ "match", OPT_STRING },
+	};
 	const char *arg = start;
 
 	for (;;) {
-		const char *matched = NULL;
+		int found = 0;
 		const char *argval;
 		size_t arglen = 0;
 		int i;
 
-		for (i = 0; i < ARRAY_SIZE(options); i++) {
-			if (match_placeholder_arg_value(arg, options[i], &arg,
-							&argval, &arglen)) {
-				matched = options[i];
+		for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
+			switch (option[i].type) {
+			case OPT_STRING:
+				if (match_placeholder_arg_value(arg, option[i].name, &arg,
+								&argval, &arglen)) {
+					if (!arglen)
+						return 0;
+					strvec_pushf(args, "--%s=%.*s", option[i].name, (int)arglen, argval);
+					found = 1;
+				}
 				break;
 			}
 		}
-		if (!matched)
+		if (!found)
 			break;
 
-		if (!arglen)
-			return 0;
-		strvec_pushf(args, "--%s=%.*s", matched, (int)arglen, argval);
 	}
 	return arg - start;
 }
-- 
2.33.1

