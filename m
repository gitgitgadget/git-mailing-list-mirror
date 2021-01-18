Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4686C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C9622E00
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbhARXv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:51:29 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55920 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389310AbhARXvW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Jan 2021 18:51:22 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4A4086080E;
        Mon, 18 Jan 2021 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611013810;
        bh=p2YFF5bzcl9Azh40Ne8B8/U2E5WlWLEohVXeK7uMOPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=rzqaIaQI8iq6n9q23qOl1T8jzj3dvbR7wvngfs0bE/2Fv92t8wOokEJ4IIHs1wJvE
         jXeZ5l0+cNFJEX26amQeoMb7riwjoR68He3UogUBIEDzb4oBYUiREIQMDwZWY9eAgA
         5rqxfp+nhq/Dn6mkHuUca1fxHET8eU2YZIejyScColx8Seqe2kuMLQpf+GHJgMCQP5
         ze7GVLBg4aMwPyHKkw5H3Jp0m+YqLYhKkk9/z1CHoiWmzjt4m7HaCkS/X5zkGORmEr
         jWvwdc05YuLXcuWRXqsvYcopTfxazuChpwdBykDtCH5Y3Q+Dq9W5VGBTaCoYH/hDug
         YRHNZMl+/uSRksr3VFqUp6rJIvXQsczNeXKKrb3zUC5htxIcb9E7xfA9TB0keTT5Od
         OCB4bJjnLwcXuVgbzItGroCkWZ55WipBaxZRxjtRotaVOFiy+VgLn2XF2heMbSgJPr
         xyhg+x2rkXIrieZbaHaAwWZVf0aRqgtE5Z3gV2sB3J5J3YxRU0A
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 4/6] commit: allow parsing arbitrary buffers with headers
Date:   Mon, 18 Jan 2021 23:49:13 +0000
Message-Id: <20210118234915.2036197-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
References: <20210111035840.2437737-1-sandals@crustytoothpaste.net>
 <20210118234915.2036197-1-sandals@crustytoothpaste.net>
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
 commit.c | 20 ++++++++++++++++----
 commit.h |  9 +++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index ccb912b9b5..2c57b6ded9 100644
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
@@ -1035,13 +1035,26 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
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
@@ -1078,7 +1091,6 @@ int parse_signed_commit(const struct commit *commit,
 		}
 		line = next;
 	}
-	unuse_commit_buffer(commit, buffer);
 	return saw_signature;
 }
 
@@ -1532,7 +1544,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
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
