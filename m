Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D85C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 23:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92A360F26
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 23:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbhIQXF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 19:05:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51041 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhIQXF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 19:05:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC839D8A40;
        Fri, 17 Sep 2021 19:04:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=m
        mO1u1sLm8Bkh9ItRhYonpfxeIn6nKpYparDqihFNb8=; b=q6tvJjhQ4VSTq8Tq6
        jcQ48tP3pnGiUIwBOgdBLTCVWU8rNloUcvEzNTaR9SHkS2PstY5Zjk13rnjERIMX
        D0ZvC9YjDwAyHXMt/WyqYNIA01U3xocUKW+z7ZrSLpSFlPhubD7MPJXMa+cIofuh
        /NfN24WTTrRy0JZ5JbXHRtpq/M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98A43D8A3F;
        Fri, 17 Sep 2021 19:04:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2152D8A3E;
        Fri, 17 Sep 2021 19:04:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH/RFC] range-diff: make output format more useful for "rebase
 --onto"
Date:   Fri, 17 Sep 2021 16:04:01 -0700
Message-ID: <xmqqv92yg5y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CDEB078-180B-11EC-B19F-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a range-diff output, we often see an early part of an updated
series having no changes since the previous iteration.  After
applying an updated patch submission to the same base as the
previous round,

    $ git range-diff master..topic@{1} master..topic

to view the differences since the previous edition, we might see
something like this:

    1:  9a05f02b1d = 1:  a05f02b1d9 t/helper/test-bitmap.c: add  ...
    2:  78de300e1f = 2:  8de300e1f7 pack-bitmap.c: propagate nam ...
    3:  7caca3c9f0 = 3:  caca3c9f07 midx.c: respect 'pack.writeB ...
    4:  72082224f1 = 4:  2082224f17 p5326: create missing 'perf- ...
    5:  097b89c815 = 5:  97b89c8150 p5326: don't set core.multiP ...
    6:  a1dd4c97b9 < -:  ---------- p5326: generate pack bitmaps ...
    -:  ---------- > 6:  bf4a60874a p5326: generate pack bitmaps ...
    7:  2b909ebad3 ! 7:  54156af0d6 t5326: test propagating hash ...
	@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'pack.preferBitmapTips' '
	 +	(
	 +		cd repo &&
    ...

Now, after noticing that up to step #5 there is no change since the
previous round, cleaning up the application result with

    $ git rebase --onto 097b89c815 97b89c8150

will help making it easier to see that earliser part did not change
before committing this in the longer term history.

The output format of the range-diff unfortunately makes it a bit
cumbersome than necessary to come up with the rebase command line.
Because "= 5:" gets in the way, copying the two object names from
there and pasting them as the command line arguments to "git rebase
--onto" becomes a chore.

Tweak the output so that the change numbers and comparison sign come
first on the line, followed by two object names and then the title
of commit, to make it easier to copy the two object names together.

The updated output format looks like this instead:

    1 = 1 a05f02b1d9 a05f02b1d9 : t/helper/test-bitmap.c: add  ...
    2 = 2 8de300e1f7 8de300e1f7 : pack-bitmap.c: propagate nam ...
    3 = 3 caca3c9f07 caca3c9f07 : midx.c: respect 'pack.writeB ...
    4 = 4 2082224f17 2082224f17 : p5326: create missing 'perf- ...
    5 = 5 97b89c8150 97b89c8150 : p5326: don't set core.multiP ...
    6 < - a1dd4c97b9 ---------- : p5326: generate pack bitmaps ...
    - > 6 ---------- bf4a60874a : p5326: generate pack bitmaps ...
    7 ! 7 2b909ebad3 54156af0d6 : t5326: test propagating hash ...
	@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'pack.preferBitmapTips' '
	 +	(
	 +		cd repo &&

Incidentally, it becomes easier to see the correspondence and spot
the reordering of the commits with this change, for the same reason
why it becomes easier to see the two commit object names---they sit
close to each other with their peers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Obviously an RFC.  The output format would be fairly subjective,
   but I do not care deeply enough to make it configurable.  If
   enough people appreciate the convenience of seeing the two object
   names and two change numbers next to each other like I do, and
   nobody processes the current output with tools, then it may be OK
   to take this patch as the final version, but otherwise, this is
   only meant as an inspiration piece for somebody else to have a
   mechanism to allow the output configurable in some way (which I
   am not intereseted in doing myself).
---
 range-diff.c          |  30 +++---
 t/t3206-range-diff.sh | 206 +++++++++++++++++++++---------------------
 2 files changed, 121 insertions(+), 115 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index cac89a2f4f..12927e24f7 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -401,26 +401,32 @@ static void output_pair_header(struct diff_options *diffopt,
 		status = '=';
 	}
 
+	/* "num_a ! num_b" or "num_a = num_b" */
 	strbuf_reset(buf);
 	strbuf_addstr(buf, status == '!' ? color_old : color);
 	if (!a_util)
-		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes->buf);
+		strbuf_addf(buf, "%*s ", patch_no_width, "-");
 	else
-		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
-			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
-
-	if (status == '!')
-		strbuf_addf(buf, "%s%s", color_reset, color);
+		strbuf_addf(buf, "%*d ", patch_no_width, a_util->i + 1);
 	strbuf_addch(buf, status);
-	if (status == '!')
-		strbuf_addf(buf, "%s%s", color_reset, color_new);
-
 	if (!b_util)
-		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes->buf);
+		strbuf_addf(buf, " %*s ", patch_no_width, "-");
 	else
-		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
-			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
+		strbuf_addf(buf, " %*d ", patch_no_width, b_util->i + 1);
 
+	/* "commit_a commit_b : " */
+	if (!a_util)
+		strbuf_addstr(buf, dashes->buf);
+	else
+		strbuf_addstr(buf,
+			      find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
+	strbuf_addch(buf, ' ');
+	if (!b_util)
+		strbuf_addstr(buf, dashes->buf);
+	else
+		strbuf_addstr(buf,
+			      find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
+	strbuf_addstr(buf, " :");
 	commit = lookup_commit_reference(the_repository, oid);
 	if (commit) {
 		if (status == '!')
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e30bc48a29..3271f544fe 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -133,10 +133,10 @@ test_expect_success 'simple A..B A..C (unmodified)' '
 	git range-diff --no-color main..topic main..unmodified \
 		>actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
-	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
-	4:  $(test_oid t4) = 4:  $(test_oid u4) s/12/B/
+	1 = 1 $(test_oid t1) $(test_oid u1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid u2) : s/4/A/
+	3 = 3 $(test_oid t3) $(test_oid u3) : s/11/B/
+	4 = 4 $(test_oid t4) $(test_oid u4) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -156,7 +156,7 @@ test_expect_success 'simple A B C (unmodified)' '
 test_expect_success 'A^! and A^-<n> (unmodified)' '
 	git range-diff --no-color topic^! unmodified^-1 >actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t4) = 1:  $(test_oid u4) s/12/B/
+	1 = 1 $(test_oid t4) $(test_oid u4) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -169,10 +169,10 @@ test_expect_success 'A^{/..} is not mistaken for a range' '
 test_expect_success 'trivial reordering' '
 	git range-diff --no-color main topic reordered >actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid r1) s/5/A/
-	3:  $(test_oid t3) = 2:  $(test_oid r2) s/11/B/
-	4:  $(test_oid t4) = 3:  $(test_oid r3) s/12/B/
-	2:  $(test_oid t2) = 4:  $(test_oid r4) s/4/A/
+	1 = 1 $(test_oid t1) $(test_oid r1) : s/5/A/
+	3 = 2 $(test_oid t3) $(test_oid r2) : s/11/B/
+	4 = 3 $(test_oid t4) $(test_oid r3) : s/12/B/
+	2 = 4 $(test_oid t2) $(test_oid r4) : s/4/A/
 	EOF
 	test_cmp expect actual
 '
@@ -180,10 +180,10 @@ test_expect_success 'trivial reordering' '
 test_expect_success 'removed a commit' '
 	git range-diff --no-color main topic removed >actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid d1) s/5/A/
-	2:  $(test_oid t2) < -:  $(test_oid __) s/4/A/
-	3:  $(test_oid t3) = 2:  $(test_oid d2) s/11/B/
-	4:  $(test_oid t4) = 3:  $(test_oid d3) s/12/B/
+	1 = 1 $(test_oid t1) $(test_oid d1) : s/5/A/
+	2 < - $(test_oid t2) $(test_oid __) : s/4/A/
+	3 = 2 $(test_oid t3) $(test_oid d2) : s/11/B/
+	4 = 3 $(test_oid t4) $(test_oid d3) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -191,11 +191,11 @@ test_expect_success 'removed a commit' '
 test_expect_success 'added a commit' '
 	git range-diff --no-color main topic added >actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid a1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid a2) s/4/A/
-	-:  $(test_oid __) > 3:  $(test_oid a3) s/6/A/
-	3:  $(test_oid t3) = 4:  $(test_oid a4) s/11/B/
-	4:  $(test_oid t4) = 5:  $(test_oid a5) s/12/B/
+	1 = 1 $(test_oid t1) $(test_oid a1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid a2) : s/4/A/
+	- > 3 $(test_oid __) $(test_oid a3) : s/6/A/
+	3 = 4 $(test_oid t3) $(test_oid a4) : s/11/B/
+	4 = 5 $(test_oid t4) $(test_oid a5) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -203,10 +203,10 @@ test_expect_success 'added a commit' '
 test_expect_success 'new base, A B C' '
 	git range-diff --no-color main topic rebased >actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid b1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid b2) s/4/A/
-	3:  $(test_oid t3) = 3:  $(test_oid b3) s/11/B/
-	4:  $(test_oid t4) = 4:  $(test_oid b4) s/12/B/
+	1 = 1 $(test_oid t1) $(test_oid b1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid b2) : s/4/A/
+	3 = 3 $(test_oid t3) $(test_oid b3) : s/11/B/
+	4 = 4 $(test_oid t4) $(test_oid b4) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -215,11 +215,11 @@ test_expect_success 'new base, B...C' '
 	# this syntax includes the commits from main!
 	git range-diff --no-color topic...rebased >actual &&
 	cat >expect <<-EOF &&
-	-:  $(test_oid __) > 1:  $(test_oid b5) unrelated
-	1:  $(test_oid t1) = 2:  $(test_oid b1) s/5/A/
-	2:  $(test_oid t2) = 3:  $(test_oid b2) s/4/A/
-	3:  $(test_oid t3) = 4:  $(test_oid b3) s/11/B/
-	4:  $(test_oid t4) = 5:  $(test_oid b4) s/12/B/
+	- > 1 $(test_oid __) $(test_oid b5) : unrelated
+	1 = 2 $(test_oid t1) $(test_oid b1) : s/5/A/
+	2 = 3 $(test_oid t2) $(test_oid b2) : s/4/A/
+	3 = 4 $(test_oid t3) $(test_oid b3) : s/11/B/
+	4 = 5 $(test_oid t4) $(test_oid b4) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -227,9 +227,9 @@ test_expect_success 'new base, B...C' '
 test_expect_success 'changed commit' '
 	git range-diff --no-color topic...changed >actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
-	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
+	1 = 1 $(test_oid t1) $(test_oid c1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid c2) : s/4/A/
+	3 ! 3 $(test_oid t3) $(test_oid c3) : s/11/B/
 	    @@ file: A
 	      9
 	      10
@@ -239,7 +239,7 @@ test_expect_success 'changed commit' '
 	      12
 	      13
 	      14
-	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
+	4 ! 4 $(test_oid t4) $(test_oid c4) : s/12/B/
 	    @@ file
 	     @@ file: A
 	      9
@@ -256,10 +256,10 @@ test_expect_success 'changed commit' '
 test_expect_success 'changed commit with --no-patch diff option' '
 	git range-diff --no-color --no-patch topic...changed >actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
-	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
-	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
+	1 = 1 $(test_oid t1) $(test_oid c1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid c2) : s/4/A/
+	3 ! 3 $(test_oid t3) $(test_oid c3) : s/11/B/
+	4 ! 4 $(test_oid t4) $(test_oid c4) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -267,12 +267,12 @@ test_expect_success 'changed commit with --no-patch diff option' '
 test_expect_success 'changed commit with --stat diff option' '
 	git range-diff --no-color --stat topic...changed >actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
-	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
+	1 = 1 $(test_oid t1) $(test_oid c1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid c2) : s/4/A/
+	3 ! 3 $(test_oid t3) $(test_oid c3) : s/11/B/
 	     a => b | 2 +-
 	     1 file changed, 1 insertion(+), 1 deletion(-)
-	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
+	4 ! 4 $(test_oid t4) $(test_oid c4) : s/12/B/
 	     a => b | 2 +-
 	     1 file changed, 1 insertion(+), 1 deletion(-)
 	EOF
@@ -282,9 +282,9 @@ test_expect_success 'changed commit with --stat diff option' '
 test_expect_success 'changed commit with sm config' '
 	git range-diff --no-color --submodule=log topic...changed >actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
-	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
+	1 = 1 $(test_oid t1) $(test_oid c1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid c2) : s/4/A/
+	3 ! 3 $(test_oid t3) $(test_oid c3) : s/11/B/
 	    @@ file: A
 	      9
 	      10
@@ -294,7 +294,7 @@ test_expect_success 'changed commit with sm config' '
 	      12
 	      13
 	      14
-	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
+	4 ! 4 $(test_oid t4) $(test_oid c4) : s/12/B/
 	    @@ file
 	     @@ file: A
 	      9
@@ -311,8 +311,8 @@ test_expect_success 'changed commit with sm config' '
 test_expect_success 'renamed file' '
 	git range-diff --no-color --submodule=log topic...renamed-file >actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid n1) s/5/A/
-	2:  $(test_oid t2) ! 2:  $(test_oid n2) s/4/A/
+	1 = 1 $(test_oid t1) $(test_oid n1) : s/5/A/
+	2 ! 2 $(test_oid t2) $(test_oid n2) : s/4/A/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -325,7 +325,7 @@ test_expect_success 'renamed file' '
 	    Z@@
 	    Z 1
 	    Z 2
-	3:  $(test_oid t3) ! 3:  $(test_oid n3) s/11/B/
+	3 ! 3 $(test_oid t3) $(test_oid n3) : s/11/B/
 	    @@ Metadata
 	    Z ## Commit message ##
 	    Z    s/11/B/
@@ -337,7 +337,7 @@ test_expect_success 'renamed file' '
 	    Z 8
 	    Z 9
 	    Z 10
-	4:  $(test_oid t4) ! 4:  $(test_oid n4) s/12/B/
+	4 ! 4 $(test_oid t4) $(test_oid n4) : s/12/B/
 	    @@ Metadata
 	    Z ## Commit message ##
 	    Z    s/12/B/
@@ -356,7 +356,7 @@ test_expect_success 'renamed file' '
 test_expect_success 'file with mode only change' '
 	git range-diff --no-color --submodule=log topic...mode-only-change >actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
-	1:  $(test_oid t2) ! 1:  $(test_oid o1) s/4/A/
+	1 ! 1 $(test_oid t2) $(test_oid o1) : s/4/A/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -372,7 +372,7 @@ test_expect_success 'file with mode only change' '
 	    Z 7
 	    +
 	    + ## other-file (new) ##
-	2:  $(test_oid t3) ! 2:  $(test_oid o2) s/11/B/
+	2 ! 2 $(test_oid t3) $(test_oid o2) : s/11/B/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -388,7 +388,7 @@ test_expect_success 'file with mode only change' '
 	    Z 14
 	    +
 	    + ## other-file (mode change 100644 => 100755) ##
-	3:  $(test_oid t4) = 3:  $(test_oid o3) s/12/B/
+	3 = 3 $(test_oid t4) $(test_oid o3) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -396,8 +396,8 @@ test_expect_success 'file with mode only change' '
 test_expect_success 'file added and later removed' '
 	git range-diff --no-color --submodule=log topic...added-removed >actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid s1) s/5/A/
-	2:  $(test_oid t2) ! 2:  $(test_oid s2) s/4/A/
+	1 = 1 $(test_oid t1) $(test_oid s1) : s/5/A/
+	2 ! 2 $(test_oid t2) $(test_oid s2) : s/4/A/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -413,7 +413,7 @@ test_expect_success 'file added and later removed' '
 	    Z 7
 	    +
 	    + ## new-file (new) ##
-	3:  $(test_oid t3) ! 3:  $(test_oid s3) s/11/B/
+	3 ! 3 $(test_oid t3) $(test_oid s3) : s/11/B/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -429,7 +429,7 @@ test_expect_success 'file added and later removed' '
 	    Z 14
 	    +
 	    + ## new-file (deleted) ##
-	4:  $(test_oid t4) = 4:  $(test_oid s4) s/12/B/
+	4 = 4 $(test_oid t4) $(test_oid s4) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -442,8 +442,8 @@ test_expect_success 'no commits on one side' '
 test_expect_success 'changed message' '
 	git range-diff --no-color topic...changed-message >actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid m1) s/5/A/
-	2:  $(test_oid t2) ! 2:  $(test_oid m2) s/4/A/
+	1 = 1 $(test_oid t1) $(test_oid m1) : s/5/A/
+	2 ! 2 $(test_oid t2) $(test_oid m2) : s/4/A/
 	    @@ Metadata
 	    Z ## Commit message ##
 	    Z    s/4/A/
@@ -453,16 +453,16 @@ test_expect_success 'changed message' '
 	    Z ## file ##
 	    Z@@
 	    Z 1
-	3:  $(test_oid t3) = 3:  $(test_oid m3) s/11/B/
-	4:  $(test_oid t4) = 4:  $(test_oid m4) s/12/B/
+	3 = 3 $(test_oid t3) $(test_oid m3) : s/11/B/
+	4 = 4 $(test_oid t4) $(test_oid m4) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'dual-coloring' '
 	sed -e "s|^:||" >expect <<-EOF &&
-	:<YELLOW>1:  $(test_oid c1) = 1:  $(test_oid m1) s/5/A/<RESET>
-	:<RED>2:  $(test_oid c2) <RESET><YELLOW>!<RESET><GREEN> 2:  $(test_oid m2)<RESET><YELLOW> s/4/A/<RESET>
+	:<YELLOW>1 = 1 $(test_oid c1) $(test_oid m1) : s/5/A/<RESET>
+	:<RED>2 ! 2 $(test_oid c2) $(test_oid m2) :<RESET><YELLOW> s/4/A/<RESET>
 	:    <REVERSE><CYAN>@@<RESET> <RESET>Metadata<RESET>
 	:      ## Commit message ##<RESET>
 	:         s/4/A/<RESET>
@@ -472,7 +472,7 @@ test_expect_success 'dual-coloring' '
 	:      ## file ##<RESET>
 	:    <CYAN> @@<RESET>
 	:      1<RESET>
-	:<RED>3:  $(test_oid c3) <RESET><YELLOW>!<RESET><GREEN> 3:  $(test_oid m3)<RESET><YELLOW> s/11/B/<RESET>
+	:<RED>3 ! 3 $(test_oid c3) $(test_oid m3) :<RESET><YELLOW> s/11/B/<RESET>
 	:    <REVERSE><CYAN>@@<RESET> <RESET>file: A<RESET>
 	:      9<RESET>
 	:      10<RESET>
@@ -482,7 +482,7 @@ test_expect_success 'dual-coloring' '
 	:      12<RESET>
 	:      13<RESET>
 	:      14<RESET>
-	:<RED>4:  $(test_oid c4) <RESET><YELLOW>!<RESET><GREEN> 4:  $(test_oid m4)<RESET><YELLOW> s/12/B/<RESET>
+	:<RED>4 ! 4 $(test_oid c4) $(test_oid m4) :<RESET><YELLOW> s/12/B/<RESET>
 	:    <REVERSE><CYAN>@@<RESET> <RESET>file<RESET>
 	:    <CYAN> @@ file: A<RESET>
 	:      9<RESET>
@@ -506,10 +506,10 @@ do
 		test_when_finished "rm 000?-*" &&
 		test_line_count = 5 actual &&
 		test_i18ngrep "^Range-diff:$" 0000-* &&
-		grep "= 1: .* s/5/A" 0000-* &&
-		grep "= 2: .* s/4/A" 0000-* &&
-		grep "= 3: .* s/11/B" 0000-* &&
-		grep "= 4: .* s/12/B" 0000-*
+		grep "= 1 .* : s/5/A" 0000-* &&
+		grep "= 2 .* : s/4/A" 0000-* &&
+		grep "= 3 .* : s/11/B" 0000-* &&
+		grep "= 4 .* : s/12/B" 0000-*
 	'
 done
 
@@ -518,7 +518,7 @@ test_expect_success 'format-patch --range-diff as commentary' '
 	test_when_finished "rm 0001-*" &&
 	test_line_count = 1 actual &&
 	test_i18ngrep "^Range-diff:$" 0001-* &&
-	grep "> 1: .* new message" 0001-*
+	grep "> 1 .* : new message" 0001-*
 '
 
 test_expect_success 'format-patch --range-diff reroll-count with a non-integer' '
@@ -526,7 +526,7 @@ test_expect_success 'format-patch --range-diff reroll-count with a non-integer'
 	test_when_finished "rm v2.9-0001-*" &&
 	test_line_count = 1 actual &&
 	test_i18ngrep "^Range-diff:$" v2.9-0001-* &&
-	grep "> 1: .* new message" v2.9-0001-*
+	grep "> 1 .* : new message" v2.9-0001-*
 '
 
 test_expect_success 'format-patch --range-diff reroll-count with a integer' '
@@ -534,7 +534,7 @@ test_expect_success 'format-patch --range-diff reroll-count with a integer' '
 	test_when_finished "rm v2-0001-*" &&
 	test_line_count = 1 actual &&
 	test_i18ngrep "^Range-diff ..* v1:$" v2-0001-* &&
-	grep "> 1: .* new message" v2-0001-*
+	grep "> 1 .* : new message" v2-0001-*
 '
 
 test_expect_success 'format-patch --range-diff with v0' '
@@ -542,7 +542,7 @@ test_expect_success 'format-patch --range-diff with v0' '
 	test_when_finished "rm v0-0001-*" &&
 	test_line_count = 1 actual &&
 	test_i18ngrep "^Range-diff:$" v0-0001-* &&
-	grep "> 1: .* new message" v0-0001-*
+	grep "> 1 .* : new message" v0-0001-*
 '
 
 test_expect_success 'range-diff overrides diff.noprefix internally' '
@@ -566,10 +566,10 @@ test_expect_success 'range-diff compares notes by default' '
 	git range-diff --no-color main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
-	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
-	4:  $(test_oid t4) ! 4:  $(test_oid u4) s/12/B/
+	1 = 1 $(test_oid t1) $(test_oid u1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid u2) : s/4/A/
+	3 = 3 $(test_oid t3) $(test_oid u3) : s/11/B/
+	4 ! 4 $(test_oid t4) $(test_oid u4) : s/12/B/
 	    @@ Commit message
 	    Z
 	    Z
@@ -590,10 +590,10 @@ test_expect_success 'range-diff with --no-notes' '
 	git range-diff --no-color --no-notes main..topic main..unmodified \
 		>actual &&
 	cat >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
-	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
-	4:  $(test_oid t4) = 4:  $(test_oid u4) s/12/B/
+	1 = 1 $(test_oid t1) $(test_oid u1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid u2) : s/4/A/
+	3 = 3 $(test_oid t3) $(test_oid u3) : s/11/B/
+	4 = 4 $(test_oid t4) $(test_oid u4) : s/12/B/
 	EOF
 	test_cmp expect actual
 '
@@ -608,10 +608,10 @@ test_expect_success 'range-diff with multiple --notes' '
 	git range-diff --no-color --notes=note1 --notes=note2 main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
-	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
-	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
-	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
-	4:  $(test_oid t4) ! 4:  $(test_oid u4) s/12/B/
+	1 = 1 $(test_oid t1) $(test_oid u1) : s/5/A/
+	2 = 2 $(test_oid t2) $(test_oid u2) : s/4/A/
+	3 = 3 $(test_oid t3) $(test_oid u3) : s/11/B/
+	4 ! 4 $(test_oid t4) $(test_oid u4) : s/12/B/
 	    @@ Commit message
 	    Z
 	    Z
@@ -639,10 +639,10 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "= 4: .* s/12/B" 0000-* &&
+	grep "= 1 .* : s/5/A" 0000-* &&
+	grep "= 2 .* : s/4/A" 0000-* &&
+	grep "= 3 .* : s/11/B" 0000-* &&
+	grep "= 4 .* : s/12/B" 0000-* &&
 	! grep "Notes" 0000-* &&
 	! grep "note" 0000-*
 '
@@ -656,10 +656,10 @@ test_expect_success 'format-patch --range-diff with --no-notes' '
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "= 4: .* s/12/B" 0000-* &&
+	grep "= 1 .* : s/5/A" 0000-* &&
+	grep "= 2 .* : s/4/A" 0000-* &&
+	grep "= 3 .* : s/11/B" 0000-* &&
+	grep "= 4 .* : s/12/B" 0000-* &&
 	! grep "Notes" 0000-* &&
 	! grep "note" 0000-*
 '
@@ -673,10 +673,10 @@ test_expect_success 'format-patch --range-diff with --notes' '
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "! 4: .* s/12/B" 0000-* &&
+	grep "= 1 .* : s/5/A" 0000-* &&
+	grep "= 2 .* : s/4/A" 0000-* &&
+	grep "= 3 .* : s/11/B" 0000-* &&
+	grep "! 4 .* : s/12/B" 0000-* &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	    @@ Commit message
 	    Z
@@ -702,10 +702,10 @@ test_expect_success 'format-patch --range-diff with format.notes config' '
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "! 4: .* s/12/B" 0000-* &&
+	grep "= 1 .* : s/5/A" 0000-* &&
+	grep "= 2 .* : s/4/A" 0000-* &&
+	grep "= 3 .* : s/11/B" 0000-* &&
+	grep "! 4 .* : s/12/B" 0000-* &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	    @@ Commit message
 	    Z
@@ -733,10 +733,10 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "! 4: .* s/12/B" 0000-* &&
+	grep "= 1 .* : s/5/A" 0000-* &&
+	grep "= 2 .* : s/4/A" 0000-* &&
+	grep "= 3 .* : s/11/B" 0000-* &&
+	grep "! 4 .* : s/12/B" 0000-* &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	    @@ Commit message
 	    Z
@@ -768,7 +768,7 @@ test_expect_success '--left-only/--right-only' '
 	git range-diff -s --left-only ...common >actual &&
 	head_oid=$(git rev-parse --short HEAD) &&
 	common_oid=$(git rev-parse --short common) &&
-	echo "1:  $head_oid = 2:  $common_oid common" >expect &&
+	echo "1 = 2 $head_oid $common_oid : common" >expect &&
 	test_cmp expect actual
 '
 
-- 
2.33.0-658-g7721ff4416

