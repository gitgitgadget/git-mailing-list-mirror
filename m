Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B135C433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 17:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49AA460F4F
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 17:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJaRSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhJaRSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 13:18:10 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA5C061714
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 10:15:37 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635700535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yansnfxaCmZi7VQJU6+3RuIe2AWssx9e9LGKZRy9vbU=;
        b=HeCXR0gtjmNMBCu+4tMj868TYrprlX6d2uRliGO88JPIlTnInFd7uWfD1AKponX89lLz+H
        AaBvNkWf0OlF1uC0l8zB9wNTu65GYc3Lan/uT4+tWuN0VcMmFDIK0TE49Up+4w6NYAqA2I
        v1/phyrTWng4mWDgOtw/Ou/ke+Dub2vuTdN4GyIAVebfgyuVPJGCKSxk10x77QoiOuWzZv
        risMJhl+eg99Ateh777s+sBxSrtZoHJBKoBpT7Rx9MyUUGLJ6/3AMpLiU409W/Xs9G+xiA
        UTtgcDGQz8bj5jAk3KBgHgD1+jEQHiBcE4Cr0QW/iNm4PA0k6Jqpht+3oE/VJzdav5dltT
        ks7i/GxZnS/XqdANN144xnmxGUh+Bh72UYyoDZQI7vJF2rSGQkLZQz1MK8DKbt1h54rv5I
        IzLqmxFHfiBcABw3RLdch11n8uBek0jzfnRG/a2U5/yCZnsCMZBvUfREya2ldXA7Mo0Kjn
        x0EWg1poTxTOYdrGH+XWUo6y9uvJrap4NtqOXaP0Pimae3e3Ox/UNEEDUMn/T2z1jj3ZbS
        p7mMRrQTuPtDm0fZKrNFMsBHfZxGoB0S4sylYGTw5sc++W/ct5A5qqWrAYIZCewWBOrwGF
        cfq83polcTfz/xSz5SuBJStR2Ne8vkS2DUOqXZHsJQkLXNAnFBoMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635700535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yansnfxaCmZi7VQJU6+3RuIe2AWssx9e9LGKZRy9vbU=;
        b=b7eZYIVqrP6KO3nj33hOaPTfOHcrsTZLm1Utbg4tANwDz3wTsxqBlickE75xsPZsZjwme6
        2k6T5m0KyUmgfBDw==
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 1/3] pretty.c: rework describe options parsing for better extensibility
Date:   Sun, 31 Oct 2021 13:15:08 -0400
Message-Id: <20211031171510.1646396-2-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211031171510.1646396-1-eschwartz@archlinux.org>
References: <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211031171510.1646396-1-eschwartz@archlinux.org>
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
 pretty.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/pretty.c b/pretty.c
index be477bd51f..c38acda8cb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1212,28 +1212,39 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 
 static size_t parse_describe_args(const char *start, struct strvec *args)
 {
-	const char *options[] = { "match", "exclude" };
+	struct {
+		char *name;
+		enum {
+			DESCRIBE_ARG_STRING,
+		} type;
+	}  option[] = {
+		{ "exclude", DESCRIBE_ARG_STRING },
+		{ "match", DESCRIBE_ARG_STRING },
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
+			case DESCRIBE_ARG_STRING:
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

