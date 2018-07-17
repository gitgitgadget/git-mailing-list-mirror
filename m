Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254431F597
	for <e@80x24.org>; Tue, 17 Jul 2018 22:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeGQXYd (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 19:24:33 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:45885 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeGQXYc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 19:24:32 -0400
Received: by mail-vk0-f74.google.com with SMTP id e127-v6so957835vkg.12
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hi58ghG5/qvTSE/nZyW1Td/NYeB0ue5gc66IqSGMBZ8=;
        b=hecRSGFHDtaFT4nFuDxqKk1rxHQiiJaruwaZOC1DVbaoJ/8G8gDQmZxcfXZsMetWqL
         ydlJEcmYz4xfVrW6ZdPpjeQhtkijJDsOMeO5H8g4qXgsfHGMhdmamf3JZo7qKMQ8KX0M
         QONKo4OPcZ8noKMMt9lzbaunqYvTPGW1ZgjePTTUxcooc+YHW6NMDMrTreZ7Qyts7p+q
         r70Ry5Iq7IqdvePhboII3+qqB0IWo5p0F+hX3ZXAQeqxRevdwQalrB8K2fpF58Yhdk4C
         nPBU+oYxevp6IVRV+Wqbqivd/mQWGd9GTB2EIofjMp1uPIqRD+DRLflNwgdAnkJvXobN
         /kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hi58ghG5/qvTSE/nZyW1Td/NYeB0ue5gc66IqSGMBZ8=;
        b=Z6LAQQxKPwnwANaZ0Vy54zhU9jgbBhjmPaiw8Dkzesr2sXhWC1Q6nqcBvsno6TjLgu
         ClNvSF1csHFCiBhLD7/g6kceFG2E79Pjk/UvaVT5ZikBHm7r4I2CHFrB6/L02r3JYAH4
         84YwpTKWKJrwhsaNsZqz9C0KsUloKQXeo2mdjFwHwGpoD2n0OBnlQw2Yqx7BuDhbCq3/
         NVcMqDVPVyDwEUdPaUoLO4fb6Yrig/7//hJzrpw6jPQFCQn+ETG2uAJ9Zm1P+ZIUEcXx
         zt1i1Q7nc6DzTf5CVBeVzOOHYePosAF/iMH73Q8cG7dP+OT8pSZLSrHpwaRGTk2whcXD
         9epQ==
X-Gm-Message-State: AOUpUlHVnxXtK3uHYkrieWrLaYfLqjrEv7Adqlqt/Hjk8ZzABQ5Dd8+r
        gRtuqkxDD/Y6oZgXoDEnIGtD7AwT/YbJ
X-Google-Smtp-Source: AAOMgpfQZovDjLVQK3iH6ELfB8xV9qD7oArH2/SBCa9wbTX1JHLc0QIp1KTckXMY5sC3s7anegE+c1mPFHpp
MIME-Version: 1.0
X-Received: by 2002:ab0:849:: with SMTP id b9-v6mr1803517uaf.44.1531867782041;
 Tue, 17 Jul 2018 15:49:42 -0700 (PDT)
Date:   Tue, 17 Jul 2018 15:49:34 -0700
In-Reply-To: <20180717224935.96397-1-sbeller@google.com>
Message-Id: <20180717224935.96397-2-sbeller@google.com>
References: <20180717224935.96397-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 1/2] refs.c: migrate internal ref iteration to pass thru
 repository argument
From:   Stefan Beller <sbeller@google.com>
To:     dstolee@microsoft.com, stolee@gmail.com
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 60ce76d3581 (refs: add repository argument to for_each_replace_ref,
2018-04-11) and 0d296c57aec (refs: allow for_each_replace_ref to handle
arbitrary repositories, 2018-04-11), for_each_replace_ref learned how
to iterate over refs by a given arbitrary repository.
New attempts in the object store conversion have shown that it is useful
to have the repository handle available that the refs iteration is
currently iterating over.

To achieve this goal we will need to add a repository argument to
each_ref_fn in refs.h. However as many callers rely on the signature
such a patch would be too large.

So convert the internals of the ref subsystem first to pass through a
repository argument without exposing the change to the user. Assume
the_repository for the passed through repository, although it is not
used anywhere yet.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c               | 39 +++++++++++++++++++++++++++++++++++++--
 refs.h               | 10 ++++++++++
 refs/iterator.c      |  6 +++---
 refs/refs-internal.h |  5 +++--
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index fcfd3171e83..2513f77acb3 100644
--- a/refs.c
+++ b/refs.c
@@ -1390,17 +1390,50 @@ struct ref_iterator *refs_ref_iterator_begin(
  * non-zero value, stop the iteration and return that value;
  * otherwise, return 0.
  */
+static int do_for_each_repo_ref(struct repository *r, const char *prefix,
+				each_repo_ref_fn fn, int trim, int flags,
+				void *cb_data)
+{
+	struct ref_iterator *iter;
+	struct ref_store *refs = get_main_ref_store(r);
+
+	if (!refs)
+		return 0;
+
+	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+
+	return do_for_each_repo_ref_iterator(r, iter, fn, cb_data);
+}
+
+struct do_for_each_ref_help {
+	each_ref_fn *fn;
+	void *cb_data;
+};
+
+static int do_for_each_ref_helper(struct repository *r,
+				  const char *refname,
+				  const struct object_id *oid,
+				  int flags,
+				  void *cb_data)
+{
+	struct do_for_each_ref_help *hp = cb_data;
+
+	return hp->fn(refname, oid, flags, hp->cb_data);
+}
+
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_iterator *iter;
+	struct do_for_each_ref_help hp = { fn, cb_data };
 
 	if (!refs)
 		return 0;
 
 	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
 
-	return do_for_each_ref_iterator(iter, fn, cb_data);
+	return do_for_each_repo_ref_iterator(the_repository, iter,
+					do_for_each_ref_helper, &hp);
 }
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
@@ -2029,10 +2062,12 @@ int refs_verify_refname_available(struct ref_store *refs,
 int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct ref_iterator *iter;
+	struct do_for_each_ref_help hp = { fn, cb_data };
 
 	iter = refs->be->reflog_iterator_begin(refs);
 
-	return do_for_each_ref_iterator(iter, fn, cb_data);
+	return do_for_each_repo_ref_iterator(the_repository, iter,
+					     do_for_each_ref_helper, &hp);
 }
 
 int for_each_reflog(each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index cc2fb4c68c0..80eec8bbc68 100644
--- a/refs.h
+++ b/refs.h
@@ -274,6 +274,16 @@ struct ref_transaction;
 typedef int each_ref_fn(const char *refname,
 			const struct object_id *oid, int flags, void *cb_data);
 
+/*
+ * The same as each_ref_fn, but also with a repository argument that
+ * contains the repository associated with the callback.
+ */
+typedef int each_repo_ref_fn(struct repository *r,
+			     const char *refname,
+			     const struct object_id *oid,
+			     int flags,
+			     void *cb_data);
+
 /*
  * The following functions invoke the specified callback function for
  * each reference indicated.  If the function ever returns a nonzero
diff --git a/refs/iterator.c b/refs/iterator.c
index 2ac91ac3401..629e00a122a 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -407,15 +407,15 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 
 struct ref_iterator *current_ref_iter = NULL;
 
-int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data)
+int do_for_each_repo_ref_iterator(struct repository *r, struct ref_iterator *iter,
+				  each_repo_ref_fn fn, void *cb_data)
 {
 	int retval = 0, ok;
 	struct ref_iterator *old_ref_iter = current_ref_iter;
 
 	current_ref_iter = iter;
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-		retval = fn(iter->refname, iter->oid, iter->flags, cb_data);
+		retval = fn(r, iter->refname, iter->oid, iter->flags, cb_data);
 		if (retval) {
 			/*
 			 * If ref_iterator_abort() returns ITER_ERROR,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dd834314bd8..5c7414bf099 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -473,8 +473,9 @@ extern struct ref_iterator *current_ref_iter;
  * adapter between the callback style of reference iteration and the
  * iterator style.
  */
-int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data);
+int do_for_each_repo_ref_iterator(struct repository *r,
+				  struct ref_iterator *iter,
+				  each_repo_ref_fn fn, void *cb_data);
 
 /*
  * Only include per-worktree refs in a do_for_each_ref*() iteration.
-- 
2.18.0.233.g985f88cf7e-goog

