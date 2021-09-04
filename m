Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F488C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727CF61054
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhIDMmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 08:42:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:39316 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236678AbhIDMma (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 08:42:30 -0400
Received: (qmail 32475 invoked by uid 109); 4 Sep 2021 12:41:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Sep 2021 12:41:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11368 invoked by uid 111); 4 Sep 2021 12:41:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Sep 2021 08:41:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Sep 2021 08:41:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH 1/2] ref-filter: hacky "streaming" mode
Message-ID: <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref-filter code is very keen to collect all of the refs in an array
before writing any output. This makes things slower than necessary when
using the default sort order (which is already sorted by refname when we
call for_each_ref()), and when no filtering options require it.

This commit adds a mildly-ugly interface to detect this case and stream
directly from filter_refs(). The caller just needs to call the
"maybe_stream" function. Either way, they can call the usual sort/print
functions; they'll just be noops if we did stream instead of collecting.

Here are some timings on a fully-packed 500k-ref repo:

  Benchmark #1: ./git.orig for-each-ref --format='%(objectname) %(refname)'
    Time (mean ± σ):     340.2 ms ±   5.3 ms    [User: 300.5 ms, System: 39.6 ms]
    Range (min … max):   332.9 ms … 347.0 ms    10 runs

  Benchmark #2: ./git.stream for-each-ref --format='%(objectname) %(refname)'
    Time (mean ± σ):     224.0 ms ±   3.4 ms    [User: 222.7 ms, System: 1.3 ms]
    Range (min … max):   218.1 ms … 228.5 ms    13 runs

  Summary
    './git.stream for-each-ref --format='%(objectname) %(refname)'' ran
      1.52 ± 0.03 times faster than './git.orig for-each-ref --format='%(objectname) %(refname)''

So we definitely shave off some time, though we're still _much_ slower
than a simple `wc -l <packed-refs` (which is around 10ms, though of
course it isn't actually doing as much work).

The point here is to reduce overall effort, though of course the time to
first output is much improved in the streaming version, too (about 250ms
versus 4ms).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/for-each-ref.c |  7 ++++++
 ref-filter.c           | 50 ++++++++++++++++++++++++++++++++++--------
 ref-filter.h           |  8 +++++++
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89cb6307d4..fe0b92443f 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -70,6 +70,13 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
+	/*
+	 * try streaming, but only without maxcount; in theory the ref-filter
+	 * code could learn about maxcount, but for now it is our own thing
+	 */
+	if (!maxcount)
+		ref_filter_maybe_stream(&filter, sorting, icase, &format);
+
 	if (!sorting)
 		sorting = ref_default_sorting();
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
diff --git a/ref-filter.c b/ref-filter.c
index 93ce2a6ef2..17b78b1d30 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2283,15 +2283,19 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 			return 0;
 	}
 
-	/*
-	 * We do not open the object yet; sort may only need refname
-	 * to do its job and the resulting list may yet to be pruned
-	 * by maxcount logic.
-	 */
-	ref = ref_array_push(ref_cbdata->array, refname, oid);
-	ref->commit = commit;
-	ref->flag = flag;
-	ref->kind = kind;
+	if (ref_cbdata->filter->streaming_format) {
+		pretty_print_ref(refname, oid, ref_cbdata->filter->streaming_format);
+	} else {
+		/*
+		 * We do not open the object yet; sort may only need refname
+		 * to do its job and the resulting list may yet to be pruned
+		 * by maxcount logic.
+		 */
+		ref = ref_array_push(ref_cbdata->array, refname, oid);
+		ref->commit = commit;
+		ref->flag = flag;
+		ref->kind = kind;
+	}
 
 	return 0;
 }
@@ -2563,6 +2567,34 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	QSORT_S(array->items, array->nr, compare_refs, sorting);
 }
 
+void ref_filter_maybe_stream(struct ref_filter *filter,
+			     const struct ref_sorting *sort, int icase,
+			     struct ref_format *format)
+{
+	/* streaming only works with default for_each_ref sort order */
+	if (sort || icase)
+		return;
+
+	/* these filters want to see all candidates up front */
+	if (filter->reachable_from || filter->unreachable_from)
+		return;
+
+	/*
+	 * the %(symref) placeholder is broken with pretty_print_ref(),
+	 * which our streaming code uses. I suspect this is a sign of breakage
+	 * in other callers like verify_tag(), which should be fixed. But for
+	 * now just disable streaming.
+	 *
+	 * Note that this implies we've parsed the format already with
+	 * verify_ref_format().
+	 */
+	if (need_symref)
+		return;
+
+	/* OK to stream */
+	filter->streaming_format = format;
+}
+
 static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
 	struct strbuf *s = &state->stack->output;
diff --git a/ref-filter.h b/ref-filter.h
index c15dee8d6b..ecea1837a2 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -69,6 +69,9 @@ struct ref_filter {
 		lines;
 	int abbrev,
 		verbose;
+
+	/* if non-NULL, streaming output during filter_refs() is enabled */
+	struct ref_format *streaming_format;
 };
 
 struct ref_format {
@@ -135,6 +138,11 @@ char *get_head_description(void);
 /*  Set up translated strings in the output. */
 void setup_ref_filter_porcelain_msg(void);
 
+/* enable streaming during filter_refs() if options allow it */
+void ref_filter_maybe_stream(struct ref_filter *filter,
+			     const struct ref_sorting *sort, int icase,
+			     struct ref_format *format);
+
 /*
  * Print a single ref, outside of any ref-filter. Note that the
  * name must be a fully qualified refname.
-- 
2.33.0.618.g5b11852304

