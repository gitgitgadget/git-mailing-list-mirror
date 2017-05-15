Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913EB1FAA8
	for <e@80x24.org>; Mon, 15 May 2017 07:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757697AbdEOHsI (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 03:48:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:51722 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757256AbdEOHsH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 03:48:07 -0400
Received: (qmail 11112 invoked by uid 109); 15 May 2017 07:48:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 07:48:07 +0000
Received: (qmail 14440 invoked by uid 111); 15 May 2017 07:48:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 03:48:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 03:48:05 -0400
Date:   Mon, 15 May 2017 03:48:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] clone: factor out refspec parsing
Message-ID: <20170515074805.lev667i37fgnycve@sigill.intra.peff.net>
References: <20170515074617.wsdzogshc4ilnlsb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170515074617.wsdzogshc4ilnlsb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cmd_clone function is rather long and uses many
variables that are only valid or useful for a small part of
the function. Let's pull the refspec parsing into a helper,
which lets us remove some variables from the main function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 54 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0630202c8..645cfa4fd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -841,6 +841,37 @@ static void dissociate_from_references(void)
 	free(alternates);
 }
 
+static struct refspec *get_clone_refspecs(const char *base_refspec,
+					  unsigned int *count)
+{
+	char *key;
+	const struct string_list *config_fetch_patterns;
+	struct refspec *ret;
+
+	key = xstrfmt("remote.%s.fetch", option_origin);
+	config_fetch_patterns = git_config_get_value_multi(key);
+
+	if (!config_fetch_patterns) {
+		*count = 1;
+		ret = parse_fetch_refspec(1, &base_refspec);
+	} else {
+		const char **fetch_patterns;
+		struct string_list_item *fp;
+		unsigned int i = 1;
+
+		*count = 1 + config_fetch_patterns->nr;
+		ALLOC_ARRAY(fetch_patterns, *count);
+		fetch_patterns[0] = base_refspec;
+		for_each_string_list_item(fp, config_fetch_patterns)
+			fetch_patterns[i++] = fp->string;
+		ret = parse_fetch_refspec(*count, fetch_patterns);
+		free(fetch_patterns);
+	}
+
+	free(key);
+	return ret;
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -861,9 +892,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 
 	struct refspec *refspec;
-	unsigned int refspec_count = 1;
-	const char **fetch_patterns;
-	const struct string_list *config_fetch_patterns;
+	unsigned int refspec_count;
 
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
@@ -982,7 +1011,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -990,21 +1018,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_reference.nr)
 		setup_reference();
 
-	strbuf_addf(&key, "remote.%s.fetch", option_origin);
-	config_fetch_patterns = git_config_get_value_multi(key.buf);
-	if (config_fetch_patterns)
-		refspec_count = 1 + config_fetch_patterns->nr;
-	fetch_patterns = xcalloc(refspec_count, sizeof(*fetch_patterns));
-	fetch_patterns[0] = value.buf;
-	if (config_fetch_patterns) {
-		struct string_list_item *fp;
-		unsigned int i = 1;
-		for_each_string_list_item(fp, config_fetch_patterns)
-			fetch_patterns[i++] = fp->string;
-	}
-	refspec = parse_fetch_refspec(refspec_count, fetch_patterns);
-
-	strbuf_reset(&key);
+	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+	refspec = get_clone_refspecs(value.buf, &refspec_count);
 	strbuf_reset(&value);
 
 	remote = remote_get(option_origin);
@@ -1129,7 +1144,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	free(fetch_patterns);
 	free(refspec);
 	return err;
 }
-- 
2.13.0.458.g025404205

