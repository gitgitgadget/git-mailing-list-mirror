Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BE2C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7CF22AAF
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbhAKAig (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 19:38:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50492 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbhAKAif (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 19:38:35 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 211A060784;
        Mon, 11 Jan 2021 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610325474;
        bh=N36jOn+qEEAWZgY64U/kylXF+F91wHGrH/6OrSHAf1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OFTAD6WAHBLcfb4nCSKG+eDE6C0eysQcOfRUm5nr2VNw+ZO13BQP6GrfFWweIVJOQ
         kjvm2NKlMlRyKxOf5qKaPihKWgUzUrtRooWx/AQFKhF6pjGJSf4x3eEQj2IPlLzLPP
         OGbjzQAsWVlL3zU1F2i9t5ZqMeS5BIj3H+PUFQQMf2FjJIKUBPsOX4EKlkNw1o8JX4
         Ejf+E84odmeHLWhuQ/OWz/JTdLsXwkdbtKp9pgfsjeHxh+AQfiDVBj16e2OL7DJNb/
         Fm+Fko6phLvw5D6h1lmYpCpsO18pQ6yCA+b1mKSz3jmOFLV9vSeANSzud8FXKe/BFg
         JWdznYB9Q0bI4J5gRaF4OafskQdR/7mT6HVY8E+gHArGjp6aCErEXYi7gK6dvQ96VF
         9YxfmCJ2rbYarbqV9cEX0Yt2+N7QMZ3GTTWdXrNvB/DJsO60xCmJtAh1woHttCEG4h
         UEfwCPDbFfdetq8uwYYX3CElFgvxzgpRs1kXu0TVub5VDhaE7kB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 3/5] commit: allow parsing arbitrary buffers with headers
Date:   Mon, 11 Jan 2021 00:37:36 +0000
Message-Id: <20210111003740.1319996-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently only commits are signed with headers.  However, in the future,
we'll also sign tags with headers as well.  Let's refactor out a
function called parse_buffer_signed_by_header which does exactly that.
In addition, since we'll want to sign things other than commits this
way, let's call the function sign_with_header instead of do_sign_commit.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c | 21 +++++++++++++++++----
 commit.h |  9 +++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 794dc8b593..7bbab5add4 100644
--- a/commit.c
+++ b/commit.c
@@ -995,7 +995,7 @@ static const char *gpg_sig_headers[] = {
 	"gpgsig-sha256",
 };
 
-static int do_sign_commit(struct strbuf *buf, const char *keyid)
+int sign_with_header(struct strbuf *buf, const char *keyid)
 {
 	struct strbuf sig = STRBUF_INIT;
 	int inspos, copypos;
@@ -1035,16 +1035,30 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
 	return 0;
 }
 
+
+
 int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature,
 			const struct git_hash_algo *algop)
 {
-
 	unsigned long size;
 	const char *buffer = get_commit_buffer(commit, &size);
+	int ret = parse_buffer_signed_by_header(buffer, size, payload, signature, algop);
+
+	unuse_commit_buffer(commit, buffer);
+	return ret;
+}
+
+int parse_buffer_signed_by_header(const char *buffer,
+				  unsigned long size,
+				  struct strbuf *payload,
+				  struct strbuf *signature,
+				  const struct git_hash_algo *algop)
+{
 	int in_signature = 0, saw_signature = 0, other_signature = 0;
 	const char *line, *tail, *p;
 	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(algop)];
+	int gpg_sig_header_len = strlen(gpg_sig_header);
 
 	line = buffer;
 	tail = buffer + size;
@@ -1078,7 +1092,6 @@ int parse_signed_commit(const struct commit *commit,
 		}
 		line = next;
 	}
-	unuse_commit_buffer(commit, buffer);
 	return saw_signature;
 }
 
@@ -1530,7 +1543,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	if (encoding_is_utf8 && !verify_utf8(&buffer))
 		fprintf(stderr, _(commit_utf8_warn));
 
-	if (sign_commit && do_sign_commit(&buffer, sign_commit)) {
+	if (sign_commit && sign_with_header(&buffer, sign_commit)) {
 		result = -1;
 		goto out;
 	}
diff --git a/commit.h b/commit.h
index 030aa65ab8..e2856ce8ef 100644
--- a/commit.h
+++ b/commit.h
@@ -360,4 +360,13 @@ int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void
 LAST_ARG_MUST_BE_NULL
 int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
 
+/* Sign a commit or tag buffer, storing the result in a header. */
+int sign_with_header(struct strbuf *buf, const char *keyid);
+/* Parse the signature out of a header. */
+int parse_buffer_signed_by_header(const char *buffer,
+				  unsigned long size,
+				  struct strbuf *payload,
+				  struct strbuf *signature,
+				  const struct git_hash_algo *algop);
+
 #endif /* COMMIT_H */
