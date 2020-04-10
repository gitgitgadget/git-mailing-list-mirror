Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D071C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C86220801
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJTqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:46:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:40078 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726142AbgDJTqH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 15:46:07 -0400
Received: (qmail 7650 invoked by uid 109); 10 Apr 2020 19:46:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 19:46:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2245 invoked by uid 111); 10 Apr 2020 19:56:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 15:56:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 15:46:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] git_config_parse_key(): return baselen as size_t
Message-ID: <20200410194607.GD1363756@coredump.intra.peff.net>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410194211.GA1363484@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the recent change to parse_config_key(), the best type to return
a string length is a size_t, as it won't cause integer truncation for a
gigantic key. And as with that change, this is mostly a clarity /
hygiene issue for now, as our config parser would choke on such a large
key anyway.

There are a few ripple effects within the config code, as callers switch
to using size_t. I also adjusted a few related variables that iterate
over strings. The most unexpected change is that a call to strbuf_addf()
had to switch to strbuf_add(). We can't use a size_t with "%.*s",
because printf precisions must have type "int" (we could cast, of
course, but that would miss the point of using size_t in the first
place).

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 17 ++++++++++-------
 config.h |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index 7ea588a7e0..c48bb35dc0 100644
--- a/config.c
+++ b/config.c
@@ -358,12 +358,13 @@ static inline int iskeychar(int c)
  *
  * store_key - pointer to char* which will hold a copy of the key with
  *             lowercase section and variable name
- * baselen - pointer to int which will hold the length of the
+ * baselen - pointer to size_t which will hold the length of the
  *           section + subsection part, can be NULL
  */
-static int git_config_parse_key_1(const char *key, char **store_key, int *baselen_, int quiet)
+static int git_config_parse_key_1(const char *key, char **store_key, size_t *baselen_, int quiet)
 {
-	int i, dot, baselen;
+	size_t i, baselen;
+	int dot;
 	const char *last_dot = strrchr(key, '.');
 
 	/*
@@ -425,7 +426,7 @@ static int git_config_parse_key_1(const char *key, char **store_key, int *basele
 	return -CONFIG_INVALID_KEY;
 }
 
-int git_config_parse_key(const char *key, char **store_key, int *baselen)
+int git_config_parse_key(const char *key, char **store_key, size_t *baselen)
 {
 	return git_config_parse_key_1(key, store_key, baselen, 0);
 }
@@ -2383,7 +2384,7 @@ void git_die_config(const char *key, const char *err, ...)
  */
 
 struct config_store_data {
-	int baselen;
+	size_t baselen;
 	char *key;
 	int do_not_match;
 	regex_t *value_regex;
@@ -2509,7 +2510,7 @@ static struct strbuf store_create_section(const char *key,
 					  const struct config_store_data *store)
 {
 	const char *dot;
-	int i;
+	size_t i;
 	struct strbuf sb = STRBUF_INIT;
 
 	dot = memchr(key, '.', store->baselen);
@@ -2522,7 +2523,9 @@ static struct strbuf store_create_section(const char *key,
 		}
 		strbuf_addstr(&sb, "\"]\n");
 	} else {
-		strbuf_addf(&sb, "[%.*s]\n", store->baselen, key);
+		strbuf_addch(&sb, '[');
+		strbuf_add(&sb, key, store->baselen);
+		strbuf_addstr(&sb, "]\n");
 	}
 
 	return sb;
diff --git a/config.h b/config.h
index d57df283b3..060874488f 100644
--- a/config.h
+++ b/config.h
@@ -254,7 +254,7 @@ int git_config_set_gently(const char *, const char *);
  */
 void git_config_set(const char *, const char *);
 
-int git_config_parse_key(const char *, char **, int *);
+int git_config_parse_key(const char *, char **, size_t *);
 int git_config_key_is_valid(const char *key);
 int git_config_set_multivar_gently(const char *, const char *, const char *, int);
 void git_config_set_multivar(const char *, const char *, const char *, int);
-- 
2.26.0.414.ge3a6455e3d

