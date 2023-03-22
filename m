Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2DAC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjCVRnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCVRmv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:42:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D7169067
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:42:23 -0700 (PDT)
Received: (qmail 10547 invoked by uid 109); 22 Mar 2023 17:42:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:42:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15914 invoked by uid 111); 22 Mar 2023 17:42:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:42:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:42:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] fast-export: de-obfuscate --anonymize-map handling
Message-ID: <20230322174213.GB11424@coredump.intra.peff.net>
References: <20230322173636.GA5643@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322173636.GA5643@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we handle an --anonymize-map option, we parse the orig/anon pair,
and then feed the "orig" string to anonymize_str(), along with a
generator function that duplicates the "anon" string to be cached in the
map.

This works, because anonymize_str() says "ah, there is no mapping yet
for orig; I'll add one from the generator". But there are some
downsides:

  1. It's a bit too clever, as it's not obvious what the code is trying
     to do or why it works.

  2. It requires allowing generator functions to take an extra void
     pointer, which is not something any of the normal callers of
     anonymize_str() want.

  3. It does the wrong thing if the same token is provided twice.
     When there are conflicting options, like:

       git fast-export --anonymize \
         --anonymize-map=foo:one \
	 --anonymize-map=foo:two

     we usually let the second one override the first. But by using
     anonymize_str(), which has first-one-wins logic, we do the
     opposite.

So instead of relying on anonymize_str(), let's directly add the entry
ourselves. We can tweak the tests to show that we handle overridden
options correctly now.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c            | 8 ++------
 t/t9351-fast-export-anonymize.sh | 2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 5a0b63219ad..d1e7b26dc64 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1140,11 +1140,6 @@ static void handle_deletes(void)
 	}
 }
 
-static char *anonymize_seed(void *data)
-{
-	return xstrdup(data);
-}
-
 static int parse_opt_anonymize_map(const struct option *opt,
 				   const char *arg, int unset)
 {
@@ -1166,7 +1161,8 @@ static int parse_opt_anonymize_map(const struct option *opt,
 	if (!keylen || !*value)
 		return error(_("--anonymize-map token cannot be empty"));
 
-	anonymize_str(map, anonymize_seed, arg, keylen, (void *)value);
+	add_anonymized_entry(map, memhash(arg, keylen), arg, keylen,
+			     xstrdup(value));
 
 	return 0;
 }
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 77047e250dc..156a6474847 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -25,6 +25,7 @@ test_expect_success 'setup simple repo' '
 test_expect_success 'export anonymized stream' '
 	git fast-export --anonymize --all \
 		--anonymize-map=retain-me \
+		--anonymize-map=xyzzy:should-not-appear \
 		--anonymize-map=xyzzy:custom-name \
 		--anonymize-map=other \
 		>stream
@@ -41,6 +42,7 @@ test_expect_success 'stream omits path names' '
 
 test_expect_success 'stream contains user-specified names' '
 	grep retain-me stream &&
+	! grep should-not-appear stream &&
 	grep custom-name stream
 '
 
-- 
2.40.0.595.g9b96b494d8c

