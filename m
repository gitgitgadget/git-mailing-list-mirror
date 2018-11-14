Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B571F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbeKNKOZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:25 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:40629 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKNKOY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:24 -0500
Received: by mail-yw1-f73.google.com with SMTP id k187-v6so11519826ywe.7
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pG0+SlIe+d9rkbh2INm+05H/ACD3hOmzDoWZGqrNL6o=;
        b=sPItMfyhDmdL5EeuShOKhuMEPCTLdxzViIk6ZD68TfCKDVCgJw82tny6Ic9q6WYH2e
         Eh/aKB/p8x4PcRwtre3D6Xz90oeMXIc16OrB8hp9Kp+fNR53LB2Vu7atix3T1O3BSP4D
         3K0lKuRss2EE6GkYBsUdC7iVO8+shYw6UQWU0FME+bGp1yaWyIA6IEWKivO35FatpKM0
         F/CiM+3RavEFs9YPrbTUtoYQnzd79uwzHm0LgkGirN6jZhyVp97ybfCvRbryxIXeOKc2
         cDwgV7pRSo5jjwE3UiVt0CIZyu/B7O3NOjIptn18siWjRVwlZSZ4egJE6mQDTMS32EtP
         jcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pG0+SlIe+d9rkbh2INm+05H/ACD3hOmzDoWZGqrNL6o=;
        b=CBEdRpR2t3I2EdeEdwKOtYI6zx2PCsDQB4jyyLk0AMCE4tdNkRSNkPyj3ijyykUo8m
         nLRVs2YHYeVMLSu8rimF7XsXSpbl0KZ2N6FW5WlbKIUKthal5gJiLSLxoCGuwJ+RCR7s
         m7IIh7JbXhl8vFA0LETOT33t5Wt6UYnRAG8mLVUc+Jhb3M4aP9YzKPXuTH8lvNGMINlZ
         SwPYW5x4b8dpj+WFnMG00OfdLiUvYKCkeSJ1NErG3u+/vIBDX5WPxl5fCrOZPHKmluwT
         IVUdE34gSh0hUDU2y05Zzn5eu1noQ6MzjFrsJQND6YJ3yFl2MHeqN0FE3HgaJr6jQnmw
         CqAg==
X-Gm-Message-State: AGRZ1gJB5e0OnlCdw0CqnmaE+1nBtnmHOt8wh+rjj8W8+uPnKlHHlLGG
        T1qEUcl7zBpN0GDbFp1Re3+5lTKNW27W
X-Google-Smtp-Source: AJdET5fJPQyWQF5JWlllEJhKqSGRopCvUaAbNHR1tWDzMeF7h2XNXFUJgQ5vePC6DIKT6yu7KgQpNWcyqLae
X-Received: by 2002:a25:7d04:: with SMTP id y4-v6mr3380315ybc.16.1542154421475;
 Tue, 13 Nov 2018 16:13:41 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:47 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 04/23] object-store: prepare read_object_file to deal with any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As read_object_file is a widely used function (which is also regularly used
in new code in flight between master..pu), changing its signature is painful
is hard, as other series in flight rely on the original signature. It would
burden the maintainer if we'd just change the signature.

Introduce repo_read_object_file which takes the repository argument, and
hide the original read_object_file as a macro behind
NO_THE_REPOSITORY_COMPATIBILITY_MACROS, similar to
e675765235 (diff.c: remove implicit dependency on the_index, 2018-09-21)

Add a coccinelle patch to convert existing callers, but do not apply
the resulting patch to keep the diff of this patch small.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 12 ++++++++++++
 object-store.h                                  | 10 ++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.pending.cocci

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
new file mode 100644
index 0000000000..a7ac9e0c46
--- /dev/null
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -0,0 +1,12 @@
+// This file is used for the ongoing refactoring of
+// bringing the index or repository struct in all of
+// our code base.
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- read_object_file(
++ repo_read_object_file(the_repository,
+  E, F, G)
diff --git a/object-store.h b/object-store.h
index 3d98a682b2..00a64622e6 100644
--- a/object-store.h
+++ b/object-store.h
@@ -165,10 +165,16 @@ extern void *read_object_file_extended(struct repository *r,
 				       const struct object_id *oid,
 				       enum object_type *type,
 				       unsigned long *size, int lookup_replace);
-static inline void *read_object_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
+static inline void *repo_read_object_file(struct repository *r,
+					  const struct object_id *oid,
+					  enum object_type *type,
+					  unsigned long *size)
 {
-	return read_object_file_extended(the_repository, oid, type, size, 1);
+	return read_object_file_extended(r, oid, type, size, 1);
 }
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define read_object_file(oid, type, size) repo_read_object_file(the_repository, oid, type, size)
+#endif
 
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
-- 
2.19.1.1215.g8438c0b245-goog

