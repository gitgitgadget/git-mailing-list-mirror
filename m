Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8C0C433FE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245FF610A0
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhJZBif (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 21:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhJZBie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 21:38:34 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79408C061767
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 18:36:11 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635212169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRqCGXT694D6/tXnlk/aVyfUkIPx4w5q1p6v/I43Znc=;
        b=XhALJ8Br8y4uPqDYuSh0dOHR64N8aPQ3K2LSToYRnfZX3+HoGAXVE5NKsZcRKwPv9lRIMo
        ljHYdqhGh1XZMtxkWGrjMIbxnV4GDVggEnILuMoPEeoZTPf2/r5nG+pWUI2jVFCuQV5mel
        plt+hroFDsN+d0oh45LibPZ9ThRP4EnnSzT/bv2yYF8jz3FzSI2w2521pOVdd4z3/uHizs
        ZIIGOGVwTTHtpaRIC9RZ7Eh6GDUMITRDM4GEzp5HXhZoXr9Te32Gb7gzd2qE0Q+Qv//L8U
        CscG7okZVl17lMIP5yolQQkWxNzgjrAT76nd5293bUvPVNYa/6MEWvG/0Kf8jObkOIXOkF
        fedOoIRJFZtj54viMHOsHXVaybI/egBQ8pDs5Lxt1WJ4SGbkNWGxwOZzsg9KKHpxOIJAY7
        m7f0Ug1Qyp22Ki4SKZpFhi983f5RxLQ4VvmInigU4c2Xn2nNrzd6zkzjtSWdrAldkShFbw
        O64Q3LLIflbOcJ1kYMbHprrPpRC/GGGInEYuXihFEaVg4NTywPO8u0eEFD3JMF11snI+tJ
        EF9EITvHrez+NRaMlGmXPx2cwfTm2Zwrwv3QB3TIHd0XnEWglbpe203vdrQeF8F1Wa9ylr
        btBbvkqfZQ8odvDPQAV/uEgijlcVqBfYrlSZvkxyqaw85nCh8dadE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635212169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRqCGXT694D6/tXnlk/aVyfUkIPx4w5q1p6v/I43Znc=;
        b=Yaj/U5O6bKHChojBqlB26B3N+r+OMDhWOeSu9heCFNEEktoLHOH0b7P+OwbVIjfeRVEEdW
        RdSGJcNZJzT0wuCA==
To:     git@vger.kernel.org
Subject: [PATCH v2 1/3] pretty.c: rework describe options parsing for better extensibility
Date:   Mon, 25 Oct 2021 21:34:50 -0400
Message-Id: <20211026013452.1372122-2-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211026013452.1372122-1-eschwartz@archlinux.org>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
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
index 73b5ead509..f8b254d2ff 100644
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
+			switch(option[i].type) {
+			case OPT_STRING:
+				if (match_placeholder_arg_value(arg, option[i].name, &arg,
+								&argval, &arglen) && arglen) {
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

