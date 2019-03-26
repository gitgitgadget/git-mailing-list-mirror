Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB963202BB
	for <e@80x24.org>; Tue, 26 Mar 2019 22:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfCZWJM (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 18:09:12 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:53138 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfCZWJL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 18:09:11 -0400
Received: by mail-vs1-f74.google.com with SMTP id b16so1359698vsp.19
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IGentZ7iC563cUZwxdrZNt9p721D+J9lZjiomaAJVsU=;
        b=ugJgnvKTwmaxWlY2elWKrNi5+b4HxersdSK8AoqZiFlClu6hbyUSY6KD1isjLHQjBA
         6C38Q1DUdn7bHYos9II813kxLeVHEWZ4BFQCN9PCj6sZn4cSFOO4E+FAW71c0DZqEo/d
         sPESWeYdHZszGe1bHvRGB142Hz7zZzDSXV6HNPTLYTMcmTBciWbSSiUBsSGX1mrS7Zox
         DgCRS/VZmNCffEP2jw5nVi/bLsmP0wBtBuQebe1O1ocyH/sjJ1T+sYHmY4fCHuQnyMP1
         HfNy2OMvc6f/jYNkcMONmGZuANQYE9lz/E9ViUTmpIbqu9Bah1CL2psTKlE5DHnHPstY
         Q6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IGentZ7iC563cUZwxdrZNt9p721D+J9lZjiomaAJVsU=;
        b=WSvf8iyjmxmTu7BAScn1lKXUyNJNGZOJ2pTcod9x7bLiIKM7FdlQlEnkRzhf/lm+C8
         9s9AG429jUb74NjKpIXkiIMc3kZIzRCAYpup2BTk9du84B/gKL/j9+jHEXxIB6a1HSD4
         SPxlSRR/Qn/fU8cx7nWE3sUKdpKS9gOkalD2LDxQFQa/TicX4IdgZvo/B7agCustJS9M
         8DElpdJvlkbP+Ongt3+YsOuyE3ot9PtMcP2RsiTCfN8oYuTMB4jbQoDnAqUJLW7qBU9j
         vEifT/IxBqr1McU43BxE5s3azecPfI/yJ08e7/fRmMSsW13q6v+gJooAiw5hc3O5cfLS
         +m6w==
X-Gm-Message-State: APjAAAX11TehTfgPqTjim9AekiKhW5sUD/hVVddgAZSvVXrSc/xkX44N
        XbYTc5Lh+MrF+laXjI+46543NMSBopBJf7QqRlJLIpAXKK7NWdb+OTrVRpviEIPLNHl0191I28M
        8LKguheL4E+nB3pbAcy/KrgT2PAcdCOwmHczMbaFgVdx9U1tHZvfSyl0Q3v9ZadTTRViRI6ZzRv
        Mp
X-Google-Smtp-Source: APXvYqyFKTHYiE4+uPphWe+ysiE/ODSfo2BzzZbLhpC+TLPQjqkVExaaaoxAX3SJ6OgUjCwblsO5+eamkMKemog+as28
X-Received: by 2002:a1f:8ec6:: with SMTP id q189mr20004910vkd.54.1553638150377;
 Tue, 26 Mar 2019 15:09:10 -0700 (PDT)
Date:   Tue, 26 Mar 2019 15:09:06 -0700
Message-Id: <20190326220906.111879-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH] diff: batch fetching of missing blobs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running a command like "git show" or "git diff" in a partial clone,
batch all missing blobs to be fetched as one request.

This is similar to c0c578b33c ("unpack-trees: batch fetching of missing
blobs", 2017-12-08), but for another command.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Here's an improvement for those having partial clones.

I couldn't find a good place to place the test (a place that checks how
diff interfaces with the object store would be ideal), so I created a
new one. Let me know if there's a better place to put it.
---
 diff.c                        | 27 +++++++++++++
 t/t4067-diff-partial-clone.sh | 76 +++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100755 t/t4067-diff-partial-clone.sh

diff --git a/diff.c b/diff.c
index ec5c095199..0e08d05b14 100644
--- a/diff.c
+++ b/diff.c
@@ -25,6 +25,7 @@
 #include "packfile.h"
 #include "parse-options.h"
 #include "help.h"
+#include "fetch-object.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -6067,6 +6068,32 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	if (o->color_moved)
 		o->emitted_symbols = &esm;
 
+	if (repository_format_partial_clone) {
+		/*
+		 * Prefetch the diff pairs that are about to be flushed.
+		 */
+		struct oid_array to_fetch = OID_ARRAY_INIT;
+		int fetch_if_missing_store = fetch_if_missing;
+
+		fetch_if_missing = 0;
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (!check_pair_status(p))
+				continue;
+			if (p->one && p->one->oid_valid &&
+			    !has_object_file(&p->one->oid))
+				oid_array_append(&to_fetch, &p->one->oid);
+			if (p->two && p->two->oid_valid &&
+			    !has_object_file(&p->two->oid))
+				oid_array_append(&to_fetch, &p->two->oid);
+		}
+		if (to_fetch.nr)
+			fetch_objects(repository_format_partial_clone,
+				      to_fetch.oid, to_fetch.nr);
+		fetch_if_missing = fetch_if_missing_store;
+		oid_array_clear(&to_fetch);
+	}
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
new file mode 100755
index 0000000000..38f03be114
--- /dev/null
+++ b/t/t4067-diff-partial-clone.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='behavior of diff when reading objects in a partial clone'
+
+. ./test-lib.sh
+
+test_expect_success 'git show batches blobs' '
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure that there is exactly 1 negotiation by checking that there is
+	# only 1 "done" line sent. ("done" marks the end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client show HEAD &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
+test_expect_success 'diff batches blobs' '
+	rm -rf server client trace &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	echo c >server/c &&
+	echo d >server/d &&
+	git -C server add c d &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure that there is exactly 1 negotiation by checking that there is
+	# only 1 "done" line sent. ("done" marks the end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
+test_expect_success 'diff skips same-OID blobs' '
+	rm -rf server client trace &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	echo another-a >server/a &&
+	git -C server add a &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	echo a | git hash-object --stdin >hash-old-a &&
+	echo another-a | git hash-object --stdin >hash-new-a &&
+	echo b | git hash-object --stdin >hash-b &&
+
+	# Ensure that only a and another-a are fetched.
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
+	grep "want $(cat hash-old-a)" trace &&
+	grep "want $(cat hash-new-a)" trace &&
+	! grep "want $(cat hash-b)" trace
+'
+
+test_done
-- 
2.21.0.155.ge902e9bcae.dirty

