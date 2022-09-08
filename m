Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E231FC38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 05:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIHFCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 01:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHFCx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 01:02:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FED6CD2B
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 22:02:52 -0700 (PDT)
Received: (qmail 24598 invoked by uid 109); 8 Sep 2022 05:02:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 05:02:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17933 invoked by uid 111); 8 Sep 2022 05:02:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 01:02:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 01:02:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 5/5] prepare_repo_settings(): plug leak of config values
Message-ID: <Yxl3elDV2kpAfAvU@coredump.intra.peff.net>
References: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We call repo_config_get_string() for fetch.negotiationAlgorithm, which
allocates a copy of the string, but we never free it.

We could add a call to free(), but there's an even simpler solution: we
don't need the string to persist beyond a few strcasecmp() calls, so we
can instead use the "_tmp" variant which gives us a const pointer to the
cached value.

We need to switch the type of "strval" to "const char *" for this to
work, which affects a similar call that checks core.untrackedCache. But
it's in the same boat! It doesn't actually need the value to persist
beyond a maybe_bool() check (though it does remember to correctly free
the string afterwards). So we can simplify it at the same time.

Note that this core.untrackedCache check arguably should be using
repo_config_get_maybe_bool(), but there are some subtle behavior
changes. E.g., it doesn't currently allow a value-less "true". Arguably
it should, but let's avoid lumping further changes in what should be a
simple leak cleanup.

Signed-off-by: Jeff King <peff@peff.net>
---
 repo-settings.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index 43bc881bfc..e8b58151bc 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -22,7 +22,7 @@ void prepare_repo_settings(struct repository *r)
 {
 	int experimental;
 	int value;
-	char *strval;
+	const char *strval;
 	int manyfiles;
 
 	if (!r->gitdir)
@@ -77,7 +77,7 @@ void prepare_repo_settings(struct repository *r)
 	if (!repo_config_get_int(r, "index.version", &value))
 		r->settings.index_version = value;
 
-	if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
+	if (!repo_config_get_string_tmp(r, "core.untrackedcache", &strval)) {
 		int v = git_parse_maybe_bool(strval);
 
 		/*
@@ -88,10 +88,9 @@ void prepare_repo_settings(struct repository *r)
 		if (v >= 0)
 			r->settings.core_untracked_cache = v ?
 				UNTRACKED_CACHE_WRITE : UNTRACKED_CACHE_REMOVE;
-		free(strval);
 	}
 
-	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
+	if (!repo_config_get_string_tmp(r, "fetch.negotiationalgorithm", &strval)) {
 		int fetch_default = r->settings.fetch_negotiation_algorithm;
 		if (!strcasecmp(strval, "skipping"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
-- 
2.37.3.1139.g47294c03c7
