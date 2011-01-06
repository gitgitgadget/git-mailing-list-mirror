From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] diffcore-rename: fall back to -C when -C -C busts the
 rename limit
Date: Thu,  6 Jan 2011 13:50:06 -0800
Message-ID: <1294350606-19530-4-git-send-email-gitster@pobox.com>
References: <1294350606-19530-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 22:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaxjF-0005g3-Bp
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab1AFVuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:50:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab1AFVuS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:50:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EAF8D315A
	for <git@vger.kernel.org>; Thu,  6 Jan 2011 16:50:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fwFT
	H8TIvnRpGltyicKpFvtPywQ=; b=ux3h09EpB0o4dqeHUmTFaU0LYd/I/7cmKuMN
	MlHr/RNSIrNCZO7TK/eEQ3jBh8z8o5QlM4tq6f0C/k1mCDr/LV9ljqqo3UHu1Q8O
	nKxzbfhUWzM8coNtKsPE6ob85mHtO5JzeimXBiN3kTEqmxFclgAIJPgJK6uP+JxP
	9RV5Ur4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Tssh/I
	OQCuSjXYIqvZMJisSC7K0I5Xz2u0SLb4hqvMkPSjhxJNbgD7F2YJQU27o6i6C+aD
	YYGT3sWAu/p1p1yIf8FRJp2JRyi4lhjqlFYIofd9iq23Oc4OPR1fsbtxeneX4KI8
	ZMqUSyrkHiJ378p9daPdhLLMtrwWcBHHqKjc4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E7E4E3159
	for <git@vger.kernel.org>; Thu,  6 Jan 2011 16:50:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 27D543158 for
 <git@vger.kernel.org>; Thu,  6 Jan 2011 16:50:53 -0500 (EST)
X-Mailer: git-send-email 1.7.4.rc1.214.g2a4f9
In-Reply-To: <1294350606-19530-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 09835764-19DF-11E0-BF18-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164677>

When there are too many paths in the project, the number of rename source
candidates "git diff -C -C" finds will exceed the rename detection limit,
and no inexact rename detection is performed.  We however could fall back
to "git diff -C" if the number of paths modified are sufficiently small.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-rename.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9ce81b6..4851af3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -415,11 +415,18 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
 		m[worst] = *o;
 }
 
+/*
+ * Returns:
+ * 0 if we are under the limit;
+ * 1 if we need to disable inexact rename detection;
+ * 2 if we would be under the limit if we were given -C instead of -C -C.
+ */
 static int too_many_rename_candidates(int num_create,
 				      struct diff_options *options)
 {
 	int rename_limit = options->rename_limit;
 	int num_src = rename_src_nr;
+	int i;
 
 	/*
 	 * This basically does a test for the rename matrix not
@@ -436,6 +443,19 @@ static int too_many_rename_candidates(int num_create,
 	    (num_create * num_src <= rename_limit * rename_limit))
 		return 0;
 
+	/* Are we running under -C -C? */
+	if (!DIFF_OPT_TST(options, FIND_COPIES_HARDER))
+		return 1;
+
+	/* Would we bust the limit if we were running under -C? */
+	for (num_src = i = 0; i < rename_src_nr; i++) {
+		if (diff_unmodified_pair(rename_src[i].p))
+			continue;
+		num_src++;
+	}
+	if ((num_create <= rename_limit || num_src <= rename_limit) &&
+	    (num_create * num_src <= rename_limit * rename_limit))
+		return 2;
 	return 1;
 }
 
@@ -446,7 +466,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
-	int i, j, rename_count;
+	int i, j, rename_count, skip_unmodified = 0;
 	int num_create, num_src, dst_cnt;
 
 	if (!minimum_score)
@@ -508,10 +528,18 @@ void diffcore_rename(struct diff_options *options)
 	if (!num_create)
 		goto cleanup;
 
-	if (too_many_rename_candidates(num_create, options)) {
+	switch (too_many_rename_candidates(num_create, options)) {
+	case 1:
 		if (options->warn_on_too_large_rename)
 			warning("too many files (created: %d deleted: %d), skipping inexact rename detection", num_create, num_src);
 		goto cleanup;
+	case 2:
+		if (options->warn_on_too_large_rename)
+			warning("too many files, falling back to -C");
+		skip_unmodified = 1;
+		break;
+	default:
+		break;
 	}
 
 	mx = xcalloc(num_create * NUM_CANDIDATE_PER_DST, sizeof(*mx));
@@ -529,6 +557,11 @@ void diffcore_rename(struct diff_options *options)
 		for (j = 0; j < rename_src_nr; j++) {
 			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
+
+			if (skip_unmodified &&
+			    diff_unmodified_pair(rename_src[j].p))
+				continue;
+
 			this_src.score = estimate_similarity(one, two,
 							     minimum_score);
 			this_src.name_score = basename_same(one, two);
-- 
1.7.4.rc1.214.g2a4f9
