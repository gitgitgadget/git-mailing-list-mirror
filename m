Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1706120286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdIMRSB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:18:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:37256 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751542AbdIMRR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:17:59 -0400
Received: (qmail 23110 invoked by uid 109); 13 Sep 2017 17:17:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 17:17:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17626 invoked by uid 111); 13 Sep 2017 17:18:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 13:18:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 13:17:57 -0400
Date:   Wed, 13 Sep 2017 13:17:57 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 7/7] config: flip return value of store_write_*()
Message-ID: <20170913171756.v7vzu3a77g2khq7x@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The store_write_section() and store_write_pairs() functions
are basically high-level wrappers around write(). But their
return values are flipped from our usual convention, using
"1" for success and "0" for failure.

Let's flip them to follow the usual write() conventions and
update all callers. As these are local to config.c, it's
unlikely that we'd have new callers in any topics in flight
(which would be silently broken by our change). But just to
be on the safe side, let's rename them to just
write_section() and write_pairs().  That also accentuates
their relationship with write().

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index daf093db45..f8b7b81445 100644
--- a/config.c
+++ b/config.c
@@ -2297,10 +2297,11 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static int store_write_section(int fd, const char *key)
+static ssize_t write_section(int fd, const char *key)
 {
 	const char *dot;
-	int i, success;
+	int i;
+	ssize_t ret;
 	struct strbuf sb = STRBUF_INIT;
 
 	dot = memchr(key, '.', store.baselen);
@@ -2316,15 +2317,16 @@ static int store_write_section(int fd, const char *key)
 		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
 	}
 
-	success = write_in_full(fd, sb.buf, sb.len) == sb.len;
+	ret = write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
 
-	return success;
+	return ret;
 }
 
-static int store_write_pair(int fd, const char *key, const char *value)
+static ssize_t write_pair(int fd, const char *key, const char *value)
 {
-	int i, success;
+	int i;
+	ssize_t ret;
 	int length = strlen(key + store.baselen + 1);
 	const char *quote = "";
 	struct strbuf sb = STRBUF_INIT;
@@ -2364,10 +2366,10 @@ static int store_write_pair(int fd, const char *key, const char *value)
 		}
 	strbuf_addf(&sb, "%s\n", quote);
 
-	success = write_in_full(fd, sb.buf, sb.len) == sb.len;
+	ret = write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
 
-	return success;
+	return ret;
 }
 
 static ssize_t find_beginning_of_line(const char *contents, size_t size,
@@ -2497,8 +2499,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		}
 
 		store.key = (char *)key;
-		if (!store_write_section(fd, key) ||
-		    !store_write_pair(fd, key, value))
+		if (write_section(fd, key) < 0 ||
+		    write_pair(fd, key, value) < 0)
 			goto write_err_out;
 	} else {
 		struct stat st;
@@ -2620,10 +2622,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		/* write the pair (value == NULL means unset) */
 		if (value != NULL) {
 			if (store.state == START) {
-				if (!store_write_section(fd, key))
+				if (write_section(fd, key) < 0)
 					goto write_err_out;
 			}
-			if (!store_write_pair(fd, key, value))
+			if (write_pair(fd, key, value) < 0)
 				goto write_err_out;
 		}
 
@@ -2816,7 +2818,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 					continue;
 				}
 				store.baselen = strlen(new_name);
-				if (!store_write_section(out_fd, new_name)) {
+				if (write_section(out_fd, new_name) < 0) {
 					ret = write_error(get_lock_file_path(lock));
 					goto out;
 				}
-- 
2.14.1.874.ge7b2e05270
