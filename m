Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2A2C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 17:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjFARiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjFARiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 13:38:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD955138
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 10:38:15 -0700 (PDT)
Received: (qmail 5848 invoked by uid 109); 1 Jun 2023 17:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 17:38:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25279 invoked by uid 111); 1 Jun 2023 17:38:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 13:38:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 13:38:14 -0400
From:   Jeff King <peff@peff.net>
To:     Jim Pryor <dubiousjim@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 1/3] pathspec: factor out magic-to-name function
Message-ID: <20230601173814.GA4165297@coredump.intra.peff.net>
References: <20230601173724.GA4158369@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601173724.GA4158369@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we have unsupported magic in a pathspec (because a command or code
path does not support particular items), we list the unsupported ones in
an error message.

Let's factor out the code here that converts the bits back into their
human-readable names, so that it can be used from other callers, which
may want to provide more flexible error messages.

Signed-off-by: Jeff King <peff@peff.net>
---
 pathspec.c | 19 ++++++++++++-------
 pathspec.h |  8 ++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 6966b265d3..5049dbb528 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -531,24 +531,29 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 	return strcmp(a->match, b->match);
 }
 
-static void NORETURN unsupported_magic(const char *pattern,
-				       unsigned magic)
+void pathspec_magic_names(unsigned magic, struct strbuf *out)
 {
-	struct strbuf sb = STRBUF_INIT;
 	int i;
 	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 		const struct pathspec_magic *m = pathspec_magic + i;
 		if (!(magic & m->bit))
 			continue;
-		if (sb.len)
-			strbuf_addstr(&sb, ", ");
+		if (out->len)
+			strbuf_addstr(out, ", ");
 
 		if (m->mnemonic)
-			strbuf_addf(&sb, _("'%s' (mnemonic: '%c')"),
+			strbuf_addf(out, _("'%s' (mnemonic: '%c')"),
 				    m->name, m->mnemonic);
 		else
-			strbuf_addf(&sb, "'%s'", m->name);
+			strbuf_addf(out, "'%s'", m->name);
 	}
+}
+
+static void NORETURN unsupported_magic(const char *pattern,
+				       unsigned magic)
+{
+	struct strbuf sb = STRBUF_INIT;
+	pathspec_magic_names(magic, &sb);
 	/*
 	 * We may want to substitute "this command" with a command
 	 * name. E.g. when "git add -p" or "git add -i" dies when running
diff --git a/pathspec.h b/pathspec.h
index a5b38e0907..fec4399bbc 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -130,6 +130,14 @@ void parse_pathspec_file(struct pathspec *pathspec,
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
 void clear_pathspec(struct pathspec *);
 
+/*
+ * Add a human-readable string to "out" representing the PATHSPEC_* flags set
+ * in "magic". The result is suitable for error messages, but not for
+ * parsing as pathspec magic itself (you get 'icase' with quotes, not
+ * :(icase)).
+ */
+void pathspec_magic_names(unsigned magic, struct strbuf *out);
+
 static inline int ps_strncmp(const struct pathspec_item *item,
 			     const char *s1, const char *s2, size_t n)
 {
-- 
2.41.0.346.g8d12207a4f

