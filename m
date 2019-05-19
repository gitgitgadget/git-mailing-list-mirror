Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D771F461
	for <e@80x24.org>; Sun, 19 May 2019 18:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfESShP (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 14:37:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:33546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726946AbfESShP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 14:37:15 -0400
Received: (qmail 20817 invoked by uid 109); 19 May 2019 05:10:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 19 May 2019 05:10:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28070 invoked by uid 111); 19 May 2019 05:11:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 19 May 2019 01:11:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 May 2019 01:10:32 -0400
Date:   Sun, 19 May 2019 01:10:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] transport_anonymize_url(): support retaining username
Message-ID: <20190519051031.GA19434@sigill.intra.peff.net>
References: <20190519050724.GA26179@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190519050724.GA26179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we anonymize URLs to show in messages, we strip out both the
username and password (if any). But there are also contexts where we
should strip out the password (to avoid leaking it) but retain the
username.

Let's generalize transport_anonymize_url() to support both cases. We'll
give it a new name since the password-only mode isn't really
"anonymizing", but keep the old name as a synonym to avoid disrupting
existing callers.

Note that there are actually three places we parse URLs, and this
functionality _could_ go into any of them:

  - transport_anonymize_url(), which we modify here

  - the urlmatch.c code parses a URL into its constituent parts, from
    which we could easily remove the elements we want to drop and
    re-format it as a single URL. But its parsing also normalizes
    elements (e.g., downcasing hostnames).  This isn't wrong, but it's
    more friendly if we can leave the rest of the URL untouched.

  - credential_form_url() parses a URL and decodes the specific
    elements, but it's hard to convert it back into a regular URL. It
    treats "host:port" as a single unit, meaning it needs to be
    re-encoded specially (since a colon would otherwise end
    percent-encoded).

Since transport_anonymize_url() seemed closest to what we want here, I
used that as the base.

Signed-off-by: Jeff King <peff@peff.net>
---
I think it would be beneficial to unify these three cases under a single
parser, but it seemed like too big a rabbit hole for this topic. Of the
three, the urlmatch one seems the most mature. I think if we could
simply separate the normalization from the parsing/decoding, the others
could build on top of it. It might also require some careful thinking
about how pseudo-urls like ssh "host:path" interact.

I won't call that a #leftoverbits, because it's more of a feast. :)

 transport.c | 21 ++++++++++++++-------
 transport.h | 11 ++++++++++-
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/transport.c b/transport.c
index f1fcd2c4b0..ba61e57295 100644
--- a/transport.c
+++ b/transport.c
@@ -1335,11 +1335,7 @@ int transport_disconnect(struct transport *transport)
 	return ret;
 }
 
-/*
- * Strip username (and password) from a URL and return
- * it in a newly allocated string.
- */
-char *transport_anonymize_url(const char *url)
+char *transport_strip_url(const char *url, int strip_user)
 {
 	char *scheme_prefix, *anon_part;
 	size_t anon_len, prefix_len = 0;
@@ -1348,7 +1344,10 @@ char *transport_anonymize_url(const char *url)
 	if (url_is_local_not_ssh(url) || !anon_part)
 		goto literal_copy;
 
-	anon_len = strlen(++anon_part);
+	anon_len = strlen(anon_part);
+	if (strip_user)
+		anon_part++;
+
 	scheme_prefix = strstr(url, "://");
 	if (!scheme_prefix) {
 		if (!strchr(anon_part, ':'))
@@ -1373,7 +1372,15 @@ char *transport_anonymize_url(const char *url)
 		cp = strchr(scheme_prefix + 3, '/');
 		if (cp && cp < anon_part)
 			goto literal_copy;
-		prefix_len = scheme_prefix - url + 3;
+
+		if (strip_user)
+			prefix_len = scheme_prefix - url + 3;
+		else {
+			cp = strchr(scheme_prefix + 3, ':');
+			if (cp && cp > anon_part)
+				goto literal_copy; /* username only */
+			prefix_len = cp - url;
+		}
 	}
 	return xstrfmt("%.*s%.*s", (int)prefix_len, url,
 		       (int)anon_len, anon_part);
diff --git a/transport.h b/transport.h
index 06e06d3d89..6d8c99ac91 100644
--- a/transport.h
+++ b/transport.h
@@ -243,10 +243,19 @@ const struct ref *transport_get_remote_refs(struct transport *transport,
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
-char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport,
 			 struct child_process *child);
 
+/*
+ * Strip password and optionally username from a URL and return
+ * it in a newly allocated string (even if nothing was stripped).
+ */
+char *transport_strip_url(const char *url, int strip_username);
+static inline char *transport_anonymize_url(const char *url)
+{
+	return transport_strip_url(url, 1);
+}
+
 int transport_connect(struct transport *transport, const char *name,
 		      const char *exec, int fd[2]);
 
-- 
2.22.0.rc0.583.g23d90da2b3

