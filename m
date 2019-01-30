Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF28211B5
	for <e@80x24.org>; Wed, 30 Jan 2019 23:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfA3XV1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 18:21:27 -0500
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:56324
        "EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbfA3XV1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 18:21:27 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 18:21:27 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id oz3TgzEqkMKAIoz3YgRXHk; Wed, 30 Jan 2019 16:14:09 -0700
From:   Max Kirillov <max@max630.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org
Subject: [RFC PATCH] pack-refs: fail on falsely sorted packed-refs
Date:   Thu, 31 Jan 2019 01:13:59 +0200
Message-Id: <20190130231359.23978-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPyRE62HJFQTqcqo8n+0OFWqCkOLE/JDSxXdnCGG+3McIlxDIn9fyS3TofPhZFJ01A2nC3TF/O9AtJNau+CuB8keIH3c6/SB2EBHgsNzIiw+r4th/uTm
 MHUKtiOi9pilnZl3l7L6u2pvTp48EgZEbQuyK9Kbux2TQaMQTyjqb3cwkab6zEa2Xrsfr8L24eqvsKxX3XcA2X7S774WhpPVg8436zsP4jSr7wOFfaELxxYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If packed-refs is marked as sorted but not really sorted it causes
very hard to comprehend misbehavior of reference resolving - a reference
is reported as not found.

As the scope of the issue is not clear, make it visible by failing
pack-refs command - the one which would not suffer performance penalty
to verify the sortedness - when it encounters not really sorted existing
data.

Signed-off-by: Max Kirillov <max@max630.net>
---
I happened to have a not really sorted packed-refs file. As you might guess,
it was quite wtf-ing experience. It worked, mostly, but there was one branch
which just did not resolve, regardless of existing and being presented in
for-each-refs output.

I don't know where the corruption came from. I should admit it could even be a manual
editing but last time I did it (in that reporitory) was several years ago so it is unlikely.

I am not sure what should be the proper fix. I did a minimal detection, so that
it does not go unnoticed. Probably next step would be either fixing in `git fsck` call.

 refs/packed-backend.c               | 15 +++++++++++++++
 t/t3212-pack-refs-broken-sorting.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100755 t/t3212-pack-refs-broken-sorting.sh

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c01c7f5901..505f4535b5 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1088,6 +1088,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 	FILE *out;
 	struct strbuf sb = STRBUF_INIT;
 	char *packed_refs_path;
+	struct strbuf prev_ref = STRBUF_INIT;
 
 	if (!is_lock_file_locked(&refs->lock))
 		BUG("write_with_updates() called while unlocked");
@@ -1137,6 +1138,20 @@ static int write_with_updates(struct packed_ref_store *refs,
 		struct ref_update *update = NULL;
 		int cmp;
 
+		if (iter)
+		{
+			if (prev_ref.len &&  strcmp(prev_ref.buf, iter->refname) > 0)
+			{
+				strbuf_addf(err, "broken sorting in packed-refs: '%s' > '%s'",
+					    prev_ref.buf,
+					    iter->refname);
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
diff --git a/t/t3212-pack-refs-broken-sorting.sh b/t/t3212-pack-refs-broken-sorting.sh
new file mode 100755
index 0000000000..37a98a6fb1
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
+		git branch b$(printf "%02d" $num) || break
+	done &&
+	git pack-refs --all &&
+	head_object=$(git rev-parse HEAD) &&
+	printf "$head_object refs/heads/b00\\n" >>.git/packed-refs &&
+	git branch b11
+'
+
+test_expect_success 'off-order branch not found' '
+	! git show-ref --verify --quiet refs/heads/b00
+'
+
+test_expect_success 'subsequent pack-refs fails' '
+	! git pack-refs --all
+'
+
+test_done
-- 
2.19.0.1202.g68e1e8f04e

