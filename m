Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4793EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 16:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGTQs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 12:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTQsr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 12:48:47 -0400
Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4AA1737
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 09:48:41 -0700 (PDT)
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1qMWpS-00065e-2P
        for git@vger.kernel.org;
        Thu, 20 Jul 2023 18:48:39 +0200
Received: from [10.20.10.230] (port=44656 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.96)
        (envelope-from <bb@drbeat.li>)
        id 1qMWpR-007AkA-1q;
        Thu, 20 Jul 2023 18:48:37 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 1A68D1800FD; Thu, 20 Jul 2023 18:48:37 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Calvin Wan <calvinwan@google.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH v2 2/2] wrapper: use trace2 counters to collect fsync stats
Date:   Thu, 20 Jul 2023 18:48:23 +0200
Message-Id: <20230720164823.625815-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.35.1.720.g215f5dbbfb
In-Reply-To: <xmqqbkg75tkm.fsf@gitster.g>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As mentioned in the thread starting at [1], trace2 counters should be
used to count events instead of ad-hoc static variables.

Convert the two fsync static variables to trace2 counters, reducing the
coupling between wrapper.c and the trace2 subsystem. Adjust t/t5351 to
match the trace2 counter output format.

The counters are not per-thread because the ones being replaced also
were not.

[1] https://lore.kernel.org/git/20230627195251.1973421-2-calvinwan@google.com/

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
v2:
- Adjust t/t5351
- Update commit message

 t/t5351-unpack-large-objects.sh |  6 +++---
 trace2.c                        |  1 -
 trace2.h                        |  4 ++++
 trace2/tr2_ctr.c                | 10 ++++++++++
 wrapper.c                       | 19 ++-----------------
 wrapper.h                       |  5 -----
 6 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index 8c8af99b844b..43cbcd5d497e 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -55,7 +55,7 @@ check_fsync_events () {
 
 	cat >expect &&
 	sed -n \
-		-e '/^{"event":"data",.*"category":"fsync",/ {
+		-e '/^{"event":"counter",.*"category":"fsync",/ {
 			s/.*"category":"fsync",//;
 			s/}$//;
 			p;
@@ -78,8 +78,8 @@ test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
 		flush_count=1
 	fi &&
 	check_fsync_events trace2.txt <<-EOF &&
-	"key":"fsync/writeout-only","value":"6"
-	"key":"fsync/hardware-flush","value":"$flush_count"
+	"name":"writeout-only","count":6
+	"name":"hardware-flush","count":$flush_count
 	EOF
 
 	test_dir_is_empty dest.git/objects/pack &&
diff --git a/trace2.c b/trace2.c
index 49c23bfd05a7..6dc74dff4c73 100644
--- a/trace2.c
+++ b/trace2.c
@@ -276,7 +276,6 @@ void trace2_cmd_exit_fl(const char *file, int line, int code)
 	if (!trace2_enabled)
 		return;
 
-	trace_git_fsync_stats();
 	trace2_collect_process_info(TRACE2_PROCESS_INFO_EXIT);
 
 	tr2main_exit_code = code;
diff --git a/trace2.h b/trace2.h
index 64c747c1df1b..12211d3bd61b 100644
--- a/trace2.h
+++ b/trace2.h
@@ -552,6 +552,10 @@ enum trace2_counter_id {
 	TRACE2_COUNTER_ID_TEST1 = 0, /* emits summary event only */
 	TRACE2_COUNTER_ID_TEST2,     /* emits summary and thread events */
 
+	/* counts number of fsyncs */
+	TRACE2_COUNTER_ID_FSYNC_WRITEOUT_ONLY,
+	TRACE2_COUNTER_ID_FSYNC_HARDWARE_FLUSH,
+
 	/* Add additional counter definitions before here. */
 	TRACE2_NUMBER_OF_COUNTERS
 };
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index b342d3b1a3c0..6491d25396e0 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -27,6 +27,16 @@ static struct tr2_counter_metadata tr2_counter_metadata[TRACE2_NUMBER_OF_COUNTER
 		.name = "test2",
 		.want_per_thread_events = 1,
 	},
+	[TRACE2_COUNTER_ID_FSYNC_WRITEOUT_ONLY] = {
+		.category = "fsync",
+		.name = "writeout-only",
+		.want_per_thread_events = 0,
+	},
+	[TRACE2_COUNTER_ID_FSYNC_HARDWARE_FLUSH] = {
+		.category = "fsync",
+		.name = "hardware-flush",
+		.want_per_thread_events = 0,
+	},
 
 	/* Add additional metadata before here. */
 };
diff --git a/wrapper.c b/wrapper.c
index 22be9812a724..dea54a326073 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -10,9 +10,6 @@
 #include "strbuf.h"
 #include "trace2.h"
 
-static intmax_t count_fsync_writeout_only;
-static intmax_t count_fsync_hardware_flush;
-
 #ifdef HAVE_RTLGENRANDOM
 /* This is required to get access to RtlGenRandom. */
 #define SystemFunction036 NTAPI SystemFunction036
@@ -551,7 +548,7 @@ int git_fsync(int fd, enum fsync_action action)
 {
 	switch (action) {
 	case FSYNC_WRITEOUT_ONLY:
-		count_fsync_writeout_only += 1;
+		trace2_counter_add(TRACE2_COUNTER_ID_FSYNC_WRITEOUT_ONLY, 1);
 
 #ifdef __APPLE__
 		/*
@@ -583,7 +580,7 @@ int git_fsync(int fd, enum fsync_action action)
 		return -1;
 
 	case FSYNC_HARDWARE_FLUSH:
-		count_fsync_hardware_flush += 1;
+		trace2_counter_add(TRACE2_COUNTER_ID_FSYNC_HARDWARE_FLUSH, 1);
 
 		/*
 		 * On macOS, a special fcntl is required to really flush the
@@ -600,18 +597,6 @@ int git_fsync(int fd, enum fsync_action action)
 	}
 }
 
-static void log_trace_fsync_if(const char *key, intmax_t value)
-{
-	if (value)
-		trace2_data_intmax("fsync", the_repository, key, value);
-}
-
-void trace_git_fsync_stats(void)
-{
-	log_trace_fsync_if("fsync/writeout-only", count_fsync_writeout_only);
-	log_trace_fsync_if("fsync/hardware-flush", count_fsync_hardware_flush);
-}
-
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	int err;
diff --git a/wrapper.h b/wrapper.h
index c85b1328d163..79a9c1b5077b 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -87,11 +87,6 @@ enum fsync_action {
  */
 int git_fsync(int fd, enum fsync_action action);
 
-/*
- * Writes out trace statistics for fsync using the trace2 API.
- */
-void trace_git_fsync_stats(void);
-
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to unlink an object that does
-- 
2.41.0

