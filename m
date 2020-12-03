Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5353C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 08:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5108321741
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 08:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbgLCIKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:10:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:49796 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387625AbgLCIKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 03:10:24 -0500
Received: (qmail 8322 invoked by uid 109); 3 Dec 2020 08:09:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Dec 2020 08:09:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29308 invoked by uid 111); 3 Dec 2020 08:09:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Dec 2020 03:09:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Dec 2020 03:09:42 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] upload-pack: propagate return value from object filter
 config callback
Message-ID: <X8idRpUCgV8rNeA6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we encounter an error in parse_filter_object_config(), we'll complain
to stderr but won't actually propagate the return value up the stack.
This is unlike most of our config callbacks, which return the error to
git_config() so it can die (this includes the call just below us to
parse_hide_refs_config(), which can also produce errors).

Signed-off-by: Jeff King <peff@peff.net>
---
The changed code is from 6dd3456a8c (upload-pack.c: allow banning
certain object filter(s), 2020-08-03), but it was not until 5b01a4e8ff
(upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth', 2020-08-03)
that the function could actually return an error (and so the test
doesn't work until then). Applying on top of tb/upload-pack-filters is
reasonable.

 t/t5616-partial-clone.sh | 8 ++++++++
 upload-pack.c            | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index f4d49d8335..2ea66205cf 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -251,6 +251,14 @@ test_expect_success 'implicitly construct combine: filter with repeated flags' '
 	test_cmp unique_types.expected unique_types.actual
 '
 
+test_expect_success 'upload-pack complains of bogus filter config' '
+	printf 0000 |
+	test_must_fail git \
+		-c uploadpackfilter.tree.maxdepth \
+		upload-pack . >/dev/null 2>err &&
+	test_i18ngrep "unable to parse.*tree.maxdepth" err
+'
+
 test_expect_success 'upload-pack fails banned object filters' '
 	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
 	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
diff --git a/upload-pack.c b/upload-pack.c
index 5dc8e1f844..57a22d14f2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1307,7 +1307,8 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 			return git_config_string(&data->pack_objects_hook, var, value);
 	}
 
-	parse_object_filter_config(var, value, data);
+	if (parse_object_filter_config(var, value, data) < 0)
+		return -1;
 
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
-- 
2.29.2.896.g080220a959
