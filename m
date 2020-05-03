Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2014C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98FB20721
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgECJL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 05:11:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:35004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727116AbgECJL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 05:11:59 -0400
Received: (qmail 21736 invoked by uid 109); 3 May 2020 09:11:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 09:11:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4791 invoked by uid 111); 3 May 2020 09:12:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 05:12:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 05:11:57 -0400
From:   Jeff King <peff@peff.net>
To:     clime <clime7@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 1/2] ref-filter: apply --ignore-case to all sorting keys
Message-ID: <20200503091157.GA170902@coredump.intra.peff.net>
References: <20200503090952.GA170768@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200503090952.GA170768@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the ref-filter users (for-each-ref, branch, and tag) take an
--ignore-case option which makes filtering and sorting case-insensitive.
However, this option was applied only to the first element of the
ref_sorting list. So:

  git for-each-ref --ignore-case --sort=refname

would do what you expect, but:

  git for-each-ref --ignore-case --sort=refname --sort=taggername

would sort the primary key (taggername) case-insensitively, but sort the
refname case-sensitively. We have two options here:

  - teach callers to set ignore_case on the whole list

  - replace the ref_sorting list with a struct that contains both the
    list of sorting keys, as well as options that apply to _all_
    keys

I went with the first one here, as it gives more flexibility if we later
want to let the users set the flag per-key (presumably through some
special syntax when defining the key; for now it's all or nothing
through --ignore-case).

The new test covers this by sorting on both tagger and subject
case-insensitively, which should compare "a" and "A" identically, but
still sort them before "b" and "B". We'll break ties by sorting on the
refname to give ourselves a stable output (this is actually supposed to
be done automatically, but there's another bug which will be fixed in
the next commit).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c        |  2 +-
 builtin/for-each-ref.c  |  2 +-
 builtin/tag.c           |  2 +-
 ref-filter.c            |  6 ++++++
 ref-filter.h            |  2 ++
 t/t6300-for-each-ref.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d8297f80ff..86341cc835 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -739,7 +739,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 */
 		if (!sorting)
 			sorting = ref_default_sorting();
-		sorting->ignore_case = icase;
+		ref_sorting_icase_all(sorting, icase);
 		print_ref_list(&filter, sorting, &format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 465153e853..57489e4eab 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -70,7 +70,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	if (!sorting)
 		sorting = ref_default_sorting();
-	sorting->ignore_case = icase;
+	ref_sorting_icase_all(sorting, icase);
 	filter.ignore_case = icase;
 
 	filter.name_patterns = argv;
diff --git a/builtin/tag.c b/builtin/tag.c
index dd160b49c7..ff7610b5c8 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -485,7 +485,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (!sorting)
 		sorting = ref_default_sorting();
-	sorting->ignore_case = icase;
+	ref_sorting_icase_all(sorting, icase);
 	filter.ignore_case = icase;
 	if (cmdmode == 'l') {
 		int ret;
diff --git a/ref-filter.c b/ref-filter.c
index 35776838f4..bdb3535ce5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2317,6 +2317,12 @@ static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
 	return 0;
 }
 
+void ref_sorting_icase_all(struct ref_sorting *sorting, int flag)
+{
+	for (; sorting; sorting = sorting->next)
+		sorting->ignore_case = !!flag;
+}
+
 void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 {
 	QSORT_S(array->items, array->nr, compare_refs, sorting);
diff --git a/ref-filter.h b/ref-filter.h
index 64330e9601..8ecc33cdfa 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -114,6 +114,8 @@ void ref_array_clear(struct ref_array *array);
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
+/*  Set the ignore_case flag for all elements of a sorting list */
+void ref_sorting_icase_all(struct ref_sorting *sorting, int flag);
 /*  Based on the given format and quote_style, fill the strbuf */
 int format_ref_array_item(struct ref_array_item *info,
 			  const struct ref_format *format,
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b3c1092338..c9caf26327 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -895,4 +895,44 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
 	test_cmp expect actual
 '
 
+test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
+	# name refs numerically to avoid case-insensitive filesystem conflicts
+	nr=0 &&
+	for email in a A b B
+	do
+		for subject in a A b B
+		do
+			GIT_COMMITTER_EMAIL="$email@example.com" \
+			git tag -m "tag $subject" icase-$(printf %02d $nr) &&
+			nr=$((nr+1))||
+			return 1
+		done
+	done &&
+	git for-each-ref --ignore-case \
+		--format="%(taggeremail) %(subject) %(refname)" \
+		--sort=refname \
+		--sort=subject \
+		--sort=taggeremail \
+		refs/tags/icase-* >actual &&
+	cat >expect <<-\EOF &&
+	<a@example.com> tag a refs/tags/icase-00
+	<a@example.com> tag A refs/tags/icase-01
+	<A@example.com> tag a refs/tags/icase-04
+	<A@example.com> tag A refs/tags/icase-05
+	<a@example.com> tag b refs/tags/icase-02
+	<a@example.com> tag B refs/tags/icase-03
+	<A@example.com> tag b refs/tags/icase-06
+	<A@example.com> tag B refs/tags/icase-07
+	<b@example.com> tag a refs/tags/icase-08
+	<b@example.com> tag A refs/tags/icase-09
+	<B@example.com> tag a refs/tags/icase-12
+	<B@example.com> tag A refs/tags/icase-13
+	<b@example.com> tag b refs/tags/icase-10
+	<b@example.com> tag B refs/tags/icase-11
+	<B@example.com> tag b refs/tags/icase-14
+	<B@example.com> tag B refs/tags/icase-15
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.26.2.957.g6dc93e954a

