Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8201F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 17:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbdKJRqA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 12:46:00 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38348 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752520AbdKJRp7 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 12:45:59 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAHce28009803
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e536317d4-1
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 66B9122F444B
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 5F45F2CDEB4
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] progress: Fix progress meters when dealing with lots of work
Date:   Fri, 10 Nov 2017 09:39:55 -0800
Message-Id: <20171110173956.25105-4-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110173956.25105-1-newren@gmail.com>
References: <20171110173956.25105-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100246
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The possibility of setting merge.renameLimit beyond 2^16 raises the
possibility that the values passed to progress can exceed 2^32.  For my
usecase of interest, I only needed to pass a value a little over 2^31.  If
I were only interested in fixing my usecase, I could have simply changed
last_value from int to unsigned, and casted each of rename_dst_nr and
rename_src_nr (in merge-recursive.c) from int to unsigned just before
multiplying them.  However, as long as we're making changes to allow
larger progress meters, we may as well make a little more room in general.
Use uint64_t, because it "ought to be enough for anybody".  :-)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c |  4 ++--
 progress.c        | 22 +++++++++++-----------
 progress.h        |  8 ++++----
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7f9a463f5a..6ba6157c61 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -531,7 +531,7 @@ void diffcore_rename(struct diff_options *options)
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
-				rename_dst_nr * rename_src_nr);
+				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
 	}
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
@@ -568,7 +568,7 @@ void diffcore_rename(struct diff_options *options)
 			diff_free_filespec_blob(two);
 		}
 		dst_cnt++;
-		display_progress(progress, (i+1)*rename_src_nr);
+		display_progress(progress, (uint64_t)(i+1)*(uint64_t)rename_src_nr);
 	}
 	stop_progress(&progress);
 
diff --git a/progress.c b/progress.c
index 289678d43d..7e4a2f9532 100644
--- a/progress.c
+++ b/progress.c
@@ -30,8 +30,8 @@ struct throughput {
 
 struct progress {
 	const char *title;
-	int last_value;
-	unsigned total;
+	uint64_t last_value;
+	uint64_t total;
 	unsigned last_percent;
 	unsigned delay;
 	unsigned delayed_percent_threshold;
@@ -79,7 +79,7 @@ static int is_foreground_fd(int fd)
 	return tpgrp < 0 || tpgrp == getpgid(0);
 }
 
-static int display(struct progress *progress, unsigned n, const char *done)
+static int display(struct progress *progress, uint64_t n, const char *done)
 {
 	const char *eol, *tp;
 
@@ -106,7 +106,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
 			if (is_foreground_fd(fileno(stderr)) || done) {
-				fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
+				fprintf(stderr, "%s: %3u%% (%lu/%lu)%s%s",
 					progress->title, percent, n,
 					progress->total, tp, eol);
 				fflush(stderr);
@@ -116,7 +116,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
 		}
 	} else if (progress_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
-			fprintf(stderr, "%s: %u%s%s",
+			fprintf(stderr, "%s: %lu%s%s",
 				progress->title, n, tp, eol);
 			fflush(stderr);
 		}
@@ -127,7 +127,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
 	return 0;
 }
 
-static void throughput_string(struct strbuf *buf, off_t total,
+static void throughput_string(struct strbuf *buf, uint64_t total,
 			      unsigned int rate)
 {
 	strbuf_reset(buf);
@@ -138,7 +138,7 @@ static void throughput_string(struct strbuf *buf, off_t total,
 	strbuf_addstr(buf, "/s");
 }
 
-void display_throughput(struct progress *progress, off_t total)
+void display_throughput(struct progress *progress, uint64_t total)
 {
 	struct throughput *tp;
 	uint64_t now_ns;
@@ -200,12 +200,12 @@ void display_throughput(struct progress *progress, off_t total)
 		display(progress, progress->last_value, NULL);
 }
 
-int display_progress(struct progress *progress, unsigned n)
+int display_progress(struct progress *progress, uint64_t n)
 {
 	return progress ? display(progress, n, NULL) : 0;
 }
 
-static struct progress *start_progress_delay(const char *title, unsigned total,
+static struct progress *start_progress_delay(const char *title, uint64_t total,
 					     unsigned percent_threshold, unsigned delay)
 {
 	struct progress *progress = malloc(sizeof(*progress));
@@ -227,12 +227,12 @@ static struct progress *start_progress_delay(const char *title, unsigned total,
 	return progress;
 }
 
-struct progress *start_delayed_progress(const char *title, unsigned total)
+struct progress *start_delayed_progress(const char *title, uint64_t total)
 {
 	return start_progress_delay(title, total, 0, 2);
 }
 
-struct progress *start_progress(const char *title, unsigned total)
+struct progress *start_progress(const char *title, uint64_t total)
 {
 	return start_progress_delay(title, total, 0, 0);
 }
diff --git a/progress.h b/progress.h
index 6392b63371..70a4d4a0d6 100644
--- a/progress.h
+++ b/progress.h
@@ -3,10 +3,10 @@
 
 struct progress;
 
-void display_throughput(struct progress *progress, off_t total);
-int display_progress(struct progress *progress, unsigned n);
-struct progress *start_progress(const char *title, unsigned total);
-struct progress *start_delayed_progress(const char *title, unsigned total);
+void display_throughput(struct progress *progress, uint64_t total);
+int display_progress(struct progress *progress, uint64_t n);
+struct progress *start_progress(const char *title, uint64_t total);
+struct progress *start_delayed_progress(const char *title, uint64_t total);
 void stop_progress(struct progress **progress);
 void stop_progress_msg(struct progress **progress, const char *msg);
 
-- 
2.15.0.5.g9567be9905

