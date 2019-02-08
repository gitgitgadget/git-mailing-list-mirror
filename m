Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE0E1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 21:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfBHVWf (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 16:22:35 -0500
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:34073
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbfBHVWf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 16:22:35 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id sDbNgfMy2jKhisDbVgtr4D; Fri, 08 Feb 2019 14:22:34 -0700
From:   Max Kirillov <max@max630.net>
To:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2] pack-refs: fail on falsely sorted packed-refs
Date:   Fri,  8 Feb 2019 23:22:21 +0200
Message-Id: <20190208212221.31670-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
In-Reply-To:  <CAPig+cTn2gURyQgWHZQMNf2cZ+zwFhbH1Q4iPmbwuvYjMrPZPg@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPIFcT04Kp/qZ7M0H99F/7e/pU9G3/Qs05uW4F7YX+tw01lFe3slOT5pvFy1NTbY6WoZeIDZr7Jh6xwRuuCLM3wcx6RFf3H2TSUEL0n4c7ERQnEcg8Dj
 pUCA53WucDBH4HrE0bJPE87Q3nA7EN/+61Ri7g8g3b/UTyRAIZg5ylKGxRVjeDueyIpLTSjWhVfbLVs7dKOA+f4IrlqV22ITwZKGPjFZ+kGkh8HXYI/irhgO
 akjs8lPU3YGkHdPlpALnQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If packed-refs is marked as sorted but not really sorted it causes
very hard to comprehend misbehavior of reference resolving - a reference
is reported as not found, though it is listed by commands which output
the references list.

As the scope of the issue is not clear, make it visible by failing
pack-refs command - the one which would not suffer performance penalty
to verify the sortedness - when it encounters not really sorted existing
data.

Signed-off-by: Max Kirillov <max@max630.net>
---
Fixed the notes
 refs/packed-backend.c               | 18 ++++++++++++++++++
 t/t3212-pack-refs-broken-sorting.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100755 t/t3212-pack-refs-broken-sorting.sh

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c01c7f5901..c89a5eb899 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1088,6 +1088,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 	FILE *out;
 	struct strbuf sb = STRBUF_INIT;
 	char *packed_refs_path;
+	struct strbuf prev_ref = STRBUF_INIT;
 
 	if (!is_lock_file_locked(&refs->lock))
 		BUG("write_with_updates() called while unlocked");
@@ -1137,6 +1138,21 @@ static int write_with_updates(struct packed_ref_store *refs,
 		struct ref_update *update = NULL;
 		int cmp;
 
+		if (iter)
+		{
+			if (prev_ref.len &&  strcmp(prev_ref.buf, iter->refname) > 0)
+			{
+				strbuf_addf(err, "broken sorting in packed-refs: '%s' > '%s'",
+					    prev_ref.buf,
+					    iter->refname);
+				strbuf_release(&prev_ref);
+				goto error;
+			}
+
+			strbuf_init(&prev_ref, 0);
+			strbuf_addstr(&prev_ref, iter->refname);
+		}
+
 		if (i >= updates->nr) {
 			cmp = -1;
 		} else {
@@ -1240,6 +1256,8 @@ static int write_with_updates(struct packed_ref_store *refs,
 		}
 	}
 
+	strbuf_release(&prev_ref);
+
 	if (ok != ITER_DONE) {
 		strbuf_addstr(err, "unable to write packed-refs file: "
 			      "error iterating over old contents");
diff --git a/t/t3212-pack-refs-broken-sorting.sh b/t/t3212-pack-refs-broken-sorting.sh
new file mode 100755
index 0000000000..a44785c8fc
--- /dev/null
+++ b/t/t3212-pack-refs-broken-sorting.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='tests for the falsely sorted refs'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m commit &&
+	for num in $(test_seq 10)
+	do
+		git branch b$(printf "%02d" $num) || return 1
+	done &&
+	git pack-refs --all &&
+	head_object=$(git rev-parse HEAD) &&
+	printf "$head_object refs/heads/b00\\n" >>.git/packed-refs &&
+	git branch b11
+'
+
+test_expect_success 'off-order branch not found' '
+	test_must_fail git show-ref --verify --quiet refs/heads/b00
+'
+
+test_expect_success 'subsequent pack-refs fails' '
+	test_must_fail git pack-refs --all
+'
+
+test_done
-- 
2.19.0.1202.g68e1e8f04e

