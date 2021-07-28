Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B98C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5BC6104F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhG1RzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:55:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64129 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG1RzM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 13:55:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24F29E3147;
        Wed, 28 Jul 2021 13:55:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aOtbICWzJ/bpnl83OLdUvMxGP7Zvhr20Bn3Na8
        /LOa4=; b=iCOH/cMOuPxPOhVRud3sXsSfvA1MrmXIrGdxK7156BTLrElV0T4gPo
        v8kY4e2E7yxxMQyXPLdW8oCSJ4QsvId//sjliA02QUh4L9jcLRqpo7tp07BWoEeK
        e2v0Qpw/QtrUp/BXEpV++lQnp8Q0o4vja68UBuBUH/LgjmveXtdM0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1CF6E3145;
        Wed, 28 Jul 2021 13:55:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE3C3E3144;
        Wed, 28 Jul 2021 13:55:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH] ll-merge: teach ll_binary_merge() a trivial three-way merge
References: <20210728024434.20230-1-jerry@skydio.com>
        <xmqqh7gfawlt.fsf@gitster.g>
Date:   Wed, 28 Jul 2021 10:55:07 -0700
In-Reply-To: <xmqqh7gfawlt.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        27 Jul 2021 21:30:38 -0700")
Message-ID: <xmqqeebi9vd0.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F208FE98-EFCC-11EB-9059-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The low-level binary merge code assumed that the caller will not
feed trivial merges that would have been resolved at the tree level;
because of this, ll_binary_merge() assumes the ancestor is different
from either side, always failing the merge in conflict unless -Xours
or -Xtheirs is in effect.

But "git apply --3way" codepath could ask us to perform three-way
merge between two binaries A and B using A as the ancestor version.
The current code always fails such an application, but when given a
binary patch that turns A into B and asked to apply it to A, there
is no reason to fail such a request---we can trivially tell that the
result must be B.

Arguably, this fix may belong to one level higher at ll_merge()
function, which dispatches to lower-level merge drivers, possibly
even before it renormalizes the three input buffers.  But let's
first see how this goes.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
[jc: stolen new tests from Jerry's patch]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time as a proper patch form.  I am asking Elijah's input as
   I suspect this belongs to ll_merge() layer and it may impact not
   just "apply --3way" codepath (which is the primary intended user
   of this "feature") but the merge strategies.  On the other hand,
   properly written merge strategies would not pass trivial merges
   down to the low-level backends, so it may not matter much to,
   say, "merge -sort" and friends.

 ll-merge.c                | 56 +++++++++++++++++++++++++++------------
 t/t4108-apply-threeway.sh | 45 +++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 261657578c..301e244971 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -46,6 +46,13 @@ void reset_merge_attributes(void)
 	merge_attributes = NULL;
 }
 
+static int same_mmfile(mmfile_t *a, mmfile_t *b)
+{
+	if (a->size != b->size)
+		return 0;
+	return !memcmp(a->ptr, b->ptr, a->size);
+}
+
 /*
  * Built-in low-levels
  */
@@ -58,9 +65,18 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   const struct ll_merge_options *opts,
 			   int marker_size)
 {
+	int status;
 	mmfile_t *stolen;
 	assert(opts);
 
+	/*
+	 * With -Xtheirs or -Xours, we have cleanly merged;
+	 * otherwise we got a conflict, unless 3way trivially
+	 * resolves.
+	 */
+	status = (opts->variant == XDL_MERGE_FAVOR_OURS ||
+		  opts->variant == XDL_MERGE_FAVOR_THEIRS) ? 0 : 1;
+
 	/*
 	 * The tentative merge result is the common ancestor for an
 	 * internal merge.  For the final merge, it is "ours" by
@@ -68,18 +84,30 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	 */
 	if (opts->virtual_ancestor) {
 		stolen = orig;
+		status = 0;
 	} else {
-		switch (opts->variant) {
-		default:
-			warning("Cannot merge binary files: %s (%s vs. %s)",
-				path, name1, name2);
-			/* fallthru */
-		case XDL_MERGE_FAVOR_OURS:
-			stolen = src1;
-			break;
-		case XDL_MERGE_FAVOR_THEIRS:
+		if (same_mmfile(orig, src1)) {
 			stolen = src2;
-			break;
+			status = 0;
+		} else if (same_mmfile(orig, src2)) {
+			stolen = src1;
+			status = 0;
+		} else if (same_mmfile(src1, src2)) {
+			stolen = src1;
+			status = 0;
+		} else {
+			switch (opts->variant) {
+			default:
+				warning("Cannot merge binary files: %s (%s vs. %s)",
+					path, name1, name2);
+				/* fallthru */
+			case XDL_MERGE_FAVOR_OURS:
+				stolen = src1;
+				break;
+			case XDL_MERGE_FAVOR_THEIRS:
+				stolen = src2;
+				break;
+			}
 		}
 	}
 
@@ -87,13 +115,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	result->size = stolen->size;
 	stolen->ptr = NULL;
 
-	/*
-	 * With -Xtheirs or -Xours, we have cleanly merged;
-	 * otherwise we got a conflict.
-	 */
-	return opts->variant == XDL_MERGE_FAVOR_OURS ||
-	       opts->variant == XDL_MERGE_FAVOR_THEIRS ?
-	       0 : 1;
+	return status;
 }
 
 static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 65147efdea..cc3aa3314a 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -230,4 +230,49 @@ test_expect_success 'apply with --3way --cached and conflicts' '
 	test_cmp expect.diff actual.diff
 '
 
+test_expect_success 'apply binary file patch' '
+	git reset --hard main &&
+	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
+	git add bin.png &&
+	git commit -m "add binary file" &&
+
+	cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
+
+	git diff --binary >bin.diff &&
+	git reset --hard &&
+
+	# Apply must succeed.
+	git apply bin.diff
+'
+
+test_expect_success 'apply binary file patch with 3way' '
+	git reset --hard main &&
+	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
+	git add bin.png &&
+	git commit -m "add binary file" &&
+
+	cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
+
+	git diff --binary >bin.diff &&
+	git reset --hard &&
+
+	# Apply must succeed.
+	git apply --3way --index bin.diff
+'
+
+test_expect_success 'apply full-index patch with 3way' '
+	git reset --hard main &&
+	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
+	git add bin.png &&
+	git commit -m "add binary file" &&
+
+	cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
+
+	git diff --full-index >bin.diff &&
+	git reset --hard &&
+
+	# Apply must succeed.
+	git apply --3way --index bin.diff
+'
+
 test_done
-- 
2.32.0-561-g6177dfa0d2

