Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE53C43460
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1ECB611C2
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhDJPWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:22:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58486 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234680AbhDJPWq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:22:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ADF636078B;
        Sat, 10 Apr 2021 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068151;
        bh=1TKM1w4qZs9O6ZZj89x3SfPK9ZzDPA44jRP0uq267nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=i23kfIHsQwbz9OkqprsBgwkQS+TG6WZfSYCTXQaNjUzs6cfInWWvdG8GjMSi0REle
         Ve9gFZ4R/uRuONpCVAah+lBPu7kVU5qIMCd3YDqVomJVkeD9oRJc0QGxmzf393ZPmb
         9bvxc6/QdzszRAtvV4QUogRlifcZH3SALphsnKZoJybF4YKSR19EavGo2S3tqvNXKL
         FvvfLNR5kWFeV3Q+js/+S3/IM5In7cDS3CrXUhOXXc2uD6hcvKS//cZQvApI/Qw9ec
         15tbfqPJrX9mZD4MkNNNOcTRdIrVTIqmFk38SBEsr/08I4LrqNSQYMqirNi8rLVlXj
         4HFdosl9veFMkFSl4qpMF6fIyYpKLZnCQ7IidAkss+2n+eOxUD3eECwWHA5LJi4AF1
         OTU6bQEhdAcz+f6mX/Q8KCUJVV0S76B/uIdPf0GDNez/GvH/z2HsfVxmYdFuUqwtol
         c69V+1URwe4Nwx8L6bgjm5n91WF59HDkRfFM36cZfrLLyGmljRT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 01/15] sha1-file: allow hashing objects literally with any algorithm
Date:   Sat, 10 Apr 2021 15:21:26 +0000
Message-Id: <20210410152140.3525040-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to perform suitable testing with multiple algorithms and
interoperability, we'll need the ability to hash an object with a given
algorithm. Introduce this capability for now only for objects which are
hashed literally by adding a function which does this and changing a
static function to accept an algorithm pointer.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-file.c  | 16 ++++++++++++++--
 object-store.h |  3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 624af408cd..f5847ee20f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1957,6 +1957,15 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags)
+{
+	return hash_object_file_literally_algop(buf, len, type, oid, flags,
+						the_hash_algo);
+}
+
+int hash_object_file_literally_algop(const void *buf, unsigned long len,
+				     const char *type, struct object_id *oid,
+				     unsigned flags,
+				     const struct git_hash_algo *algo)
 {
 	char *header;
 	int hdrlen, status = 0;
@@ -1964,11 +1973,14 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + MAX_HEADER_LEN;
 	header = xmalloc(hdrlen);
-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, header,
-				  &hdrlen);
+	write_object_file_prepare(algo, buf, len, type, oid, header, &hdrlen);
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
+	if (algo->format_id != the_hash_algo->format_id) {
+		status = -1;
+		goto cleanup;
+	}
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
 	status = write_loose_object(oid, header, hdrlen, buf, len, 0);
diff --git a/object-store.h b/object-store.h
index ec32c23dcb..f95d03a7f5 100644
--- a/object-store.h
+++ b/object-store.h
@@ -221,6 +221,9 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags);
 
+int hash_object_file_literally_algop(const void *buf, unsigned long len,
+				     const char *type, struct object_id *oid,
+				     unsigned flags, const struct git_hash_algo *algo);
 /*
  * Add an object file to the in-memory object store, without writing it
  * to disk.
