Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5D21F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 20:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbdKMUQR (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 15:16:17 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36984 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755271AbdKMUQN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2017 15:16:13 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vADKCWCp027234;
        Mon, 13 Nov 2017 12:16:06 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e5xypb3h8-1;
        Mon, 13 Nov 2017 12:16:06 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 726E02265D35;
        Mon, 13 Nov 2017 12:16:06 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 669382CDE60;
        Mon, 13 Nov 2017 12:16:06 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/4] progress: fix progress meters when dealing with lots of work
Date:   Mon, 13 Nov 2017 12:15:58 -0800
Message-Id: <20171113201600.24878-3-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.44.gf995e411c7
In-Reply-To: <20171113201600.24878-1-newren@gmail.com>
References: <20171113201600.24878-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=12 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711130279
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The possibility of setting merge.renameLimit beyond 2^16 raises the
possibility that the values passed to progress can exceed 2^32.
Use uint64_t, because it "ought to be enough for anybody".  :-)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
This does imply 64-bit math for all progress operations.  Possible alternatives
I could think of listed at
https://public-inbox.org/git/CABPp-BH1Cpc9UfYpmBBAHWSqadg=QuD=28qx1oV29ZdvF4NbJw@mail.gmail.com/
Opinions of others on whether 64-bit is okay, or preference for which alternative
is picked?

 diffcore-rename.c |  4 ++--
 progress.c        | 22 +++++++++++-----------
 progress.h        |  8 ++++----
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0d8c3d2ee4..c03f484d53 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -534,7 +534,7 @@ void diffcore_rename(struct diff_options *options)
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
-				rename_dst_nr * rename_src_nr);
+				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
 	}
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
@@ -571,7 +571,7 @@ void diffcore_rename(struct diff_options *options)
 			diff_free_filespec_blob(two);
 		}
 		dst_cnt++;
-		display_progress(progress, (i+1)*rename_src_nr);
+		display_progress(progress, (uint64_t)(i+1)*(uint64_t)rename_src_nr);
 	}
 	stop_progress(&progress);
 
diff --git a/progress.c b/progress.c
index 289678d43d..837d3a8eb8 100644
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
+				fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
 					progress->title, percent, n,
 					progress->total, tp, eol);
 				fflush(stderr);
@@ -116,7 +116,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
 		}
 	} else if (progress_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
-			fprintf(stderr, "%s: %u%s%s",
+			fprintf(stderr, "%s: %"PRIuMAX"%s%s",
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
2.15.0.44.gf995e411c7

