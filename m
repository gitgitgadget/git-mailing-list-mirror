Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7EF81F454
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeJaHD6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:03:58 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:39274 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeJaHD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:03:58 -0400
Received: by mail-yb1-f201.google.com with SMTP id d196-v6so7114155ybh.6
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pJc2ZwdK7zREJfx7PXoDzDUoawH9Dw3v1oySPEl91f4=;
        b=DO+M4PtSu1NAIvr3bgwOhDsgKfgTSpu+Y6Vblt2jgpg0Cg/KeJeSCrU591WzeumhVo
         mFiDmvegRj4tr6OJjDuChC0MOOTdrBJgRHYo5FHxEgo9fxtCHcIYDtU744+icZjjiXY/
         XrOdi0Ru7Ncc+y7Vx2CZTpNuRzcc53esMZ34iNgnYtT2FMZImwDwDVjlsQlMgvO3s+te
         SbRFAWhdyMWZ2g0Q4jYPZ6xdyrkUypB4j/TGWCkOCtOcivAfxMIoBEQvLZgQS8V1miyI
         /iPfw1N8PE72BV8JxoJXulgpB3HDi1jFJ52cXDOn+NOiFgtdLhAsVhn6OWPV5j5/8Lj4
         rOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pJc2ZwdK7zREJfx7PXoDzDUoawH9Dw3v1oySPEl91f4=;
        b=jlSAjw78YofbKHIG/nsCI103zaSDr5N7yroSygnXH48g6jlvZ7SPI613+fmA1YFybr
         hzUCS1nUvybiNXZTmCAPXQGQNgZhVAVwbsAY9duREW3kOkG1gQAWl8goTiH0f8Xx/OkT
         eofbbXIpV+/aiOwOiCsCvuFsfMJMlyQMxMscQ6va9nMsExuZjKy9UZ8PPmuh63gquWWj
         GoXXjnJsLdyofqfUN9bUkf4NlEoutFrw0Ni4OqjGz7chFkcqDJxLJ1MElWjimhYqssDE
         b5S4WqcFMezKKvnJqvJXvn3IbqyNEtk0JKxL8OniVKSRb/zp86w7b8jtyRRkehSuak15
         2pfw==
X-Gm-Message-State: AGRZ1gI6edKw5FdhzX6g/xYryAgg9hkfW1h92sJ54qd1uOCnwkJ4dygF
        2T6hv7tnyMuymVMLDZ1zvAnsDuS3jF9st4iVWJwywmIUeuKhhG5ZS4RSOID9H90e7wg+2tZId0M
        pMVGs9aiOujEjPIHnJKCGHE5EpTfk8AIf/3fDfip56sI2AMXhEHQ9dymGewib
X-Google-Smtp-Source: AJdET5dJmFtpQNx0r/jJwgpWJUeONiUNzjJ9cRW9E9qz73RhWeKWxCRsLappQdY9K195QuqvQGjbjGTRHUbM
X-Received: by 2002:a25:37cb:: with SMTP id e194-v6mr398747yba.53.1540937323764;
 Tue, 30 Oct 2018 15:08:43 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:07:58 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-6-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 05/24] object-store: prepare read_object_file to deal with
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
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
the resulting patch from 'make coccicheck' to keep the diff of this
patch small.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 13 +++++++++++++
 object-store.h                                  | 10 ++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.pending.cocci

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
new file mode 100644
index 0000000000..3c7fa70502
--- /dev/null
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -0,0 +1,13 @@
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
+
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
2.19.1.930.g4563a0d9d0-goog

