Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B11F5820
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755966310; cv=none; b=Pp2iWp3yRfEIP/CFbrtZ1X7RKJTBy1w30/Vvx1AvTK29T/PT4knvOsNnjoNfo/f87wYBJpTL/un/ekIm2cwOnEzo7rfC4jP/0jE74ELTsrtwrOZUdczG9CcRmOACrzuDjW3M+jQXjG+LoAxhfC4RvfgTRgMYICc2lbgqpX9SiVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755966310; c=relaxed/simple;
	bh=hFPRjQJvKCgBdjD5fx5+7BtDNeVsX8wrNzWnrcc2v44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/Zv2/0M8MY1dT9aBAdaUwWbH2RuFh/1kNMTkDti6jHurgFBpuKtbShQJVVthxQglgUGNz0iXCguTv33b/BJ/hu4ZjyaBxHjmIElw3WhPr89Pqwh7QTzO9DuZGJWvVtFuC1AeUrMHNAI43xC9ELuNoi8ebRvwosqOEa+nVR/L7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4c8Mpf5ppWzRmx3;
	Sat, 23 Aug 2025 18:24:58 +0200 (CEST)
Message-ID: <86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
Date: Sat, 23 Aug 2025 18:24:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] progress: replace setitimer() with alarm()
Content-Language: en-US
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 23.08.25 um 15:22 schrieb Carlo Marcelo Arenas Belón via GitGitGadget:
> The first patch does the minimum changes required to swap the underlying
> function, but introduce a race condition that is addressed in the second
> patch.
> 
> A third patch that does further changes to the Windows compatibility layer
> was punted.
> 
> Carlo Marcelo Arenas Belón (2): progress: replace setitimer() with alarm()
> progress: add a shutting down state to the SIGALRM handler
> 
After having looked at the progress code for a bit, see this:

We use SIGALRM to raise a flag that tells the progress code to act in
some way. The progress code does not act asynchronously, but only when
there is an opportunity to look at the flag, i.e., it acts synchronously
in response to a third party (SIGALRM) that told it that it's time to
act.

But we can change the progress code to do the time keeping itself.
Instead of looking whether a flag was raised, we can let it look at the
wall clock and check whether an interval has elapsed.

A prototype implementation looks like the patch below. It works quite
well for `git clone` on Linux. I have even lowered the interval to 1/8th
of a second to get more frequent updates. After a change like this, we
can remove all the creepy SIGALRM/alarm/setitimer stuff.

What do you think?

 progress.c               | 65 +++++++++++-----------------------------
 progress.h               |  2 +-
 t/helper/test-progress.c |  2 +-
 3 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/progress.c b/progress.c
index 8d5ae70f3a..eb1d2f14e0 100644
--- a/progress.c
+++ b/progress.c
@@ -38,6 +38,7 @@ struct throughput {
 struct progress {
 	struct repository *repo;
 	const char *title;
+	uint64_t last_update;
 	uint64_t last_value;
 	uint64_t total;
 	unsigned last_percent;
@@ -50,57 +51,26 @@ struct progress {
 	int split;
 };
 
-static volatile sig_atomic_t progress_update;
-
 /*
  * These are only intended for testing the progress output, i.e. exclusively
  * for 'test-tool progress'.
  */
 int progress_testing;
 uint64_t progress_test_ns = 0;
-void progress_test_force_update(void)
+void progress_test_force_update(struct progress *progress)
 {
-	progress_update = 1;
+	progress->last_update = 0;
 }
 
 
-static void progress_interval(int signum UNUSED)
+static bool check_update_delay_expired(struct progress *progress)
 {
-	progress_update = 1;
-}
-
-static void set_progress_signal(void)
-{
-	struct sigaction sa;
-	struct itimerval v;
-
-	if (progress_testing)
-		return;
-
-	progress_update = 0;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = progress_interval;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGALRM, &sa, NULL);
-
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
-}
-
-static void clear_progress_signal(void)
-{
-	struct itimerval v = {{0,},};
-
-	if (progress_testing)
-		return;
-
-	setitimer(ITIMER_REAL, &v, NULL);
-	signal(SIGALRM, SIG_IGN);
-	progress_update = 0;
+	uint64_t now = getnanotime();
+	/* about every 1/8th of a second */
+	bool update = (now - progress->last_update) / (1024 * 1024 * 1024 / 8) > 0;
+	if (update)
+		progress->last_update = now;
+	return update;
 }
 
 static int is_foreground_fd(int fd)
@@ -109,7 +79,8 @@ static int is_foreground_fd(int fd)
 	return tpgrp < 0 || tpgrp == getpgid(0);
 }
 
-static void display(struct progress *progress, uint64_t n, const char *done)
+static void display(struct progress *progress, uint64_t n, const char *done,
+		    bool progress_update)
 {
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
@@ -243,15 +214,16 @@ void display_throughput(struct progress *progress, uint64_t total)
 	tp->last_misecs[tp->idx] = misecs;
 	tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 
+	bool progress_update = check_update_delay_expired(progress);
 	throughput_string(&tp->display, total, rate);
 	if (progress->last_value != -1 && progress_update)
-		display(progress, progress->last_value, NULL);
+		display(progress, progress->last_value, NULL, progress_update);
 }
 
 void display_progress(struct progress *progress, uint64_t n)
 {
 	if (progress)
-		display(progress, n, NULL);
+		display(progress, n, NULL, check_update_delay_expired(progress));
 }
 
 static struct progress *start_progress_delay(struct repository *r,
@@ -262,6 +234,7 @@ static struct progress *start_progress_delay(struct repository *r,
 	progress->repo = r;
 	progress->title = title;
 	progress->total = total;
+	progress->last_update = getnanotime();
 	progress->last_value = -1;
 	progress->last_percent = -1;
 	progress->delay = delay;
@@ -271,7 +244,6 @@ static struct progress *start_progress_delay(struct repository *r,
 	strbuf_init(&progress->counters_sb, 0);
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
-	set_progress_signal();
 	trace2_region_enter("progress", title, r);
 	return progress;
 }
@@ -339,9 +311,9 @@ static void force_last_update(struct progress *progress, const char *msg)
 		rate = tp->curr_total / (misecs ? misecs : 1);
 		throughput_string(&tp->display, tp->curr_total, rate);
 	}
-	progress_update = 1;
+	progress->last_update = 0;
 	buf = xstrfmt(", %s.\n", msg);
-	display(progress, progress->last_value, buf);
+	display(progress, progress->last_value, buf, check_update_delay_expired(progress));
 	free(buf);
 }
 
@@ -374,7 +346,6 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		force_last_update(progress, msg);
 	log_trace2(progress);
 
-	clear_progress_signal();
 	strbuf_release(&progress->counters_sb);
 	if (progress->throughput)
 		strbuf_release(&progress->throughput->display);
diff --git a/progress.h b/progress.h
index ed068c7bab..cca479bd26 100644
--- a/progress.h
+++ b/progress.h
@@ -9,7 +9,7 @@ struct repository;
 
 extern int progress_testing;
 extern uint64_t progress_test_ns;
-void progress_test_force_update(void);
+void progress_test_force_update(struct progress *progress);
 
 #endif
 
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 1f75b7bd19..e2ca5fb726 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -87,7 +87,7 @@ int cmd__progress(int argc, const char **argv)
 			progress_test_ns = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
 		} else if (!strcmp(line.buf, "update")) {
-			progress_test_force_update();
+			progress_test_force_update(progress);
 		} else if (!strcmp(line.buf, "stop")) {
 			stop_progress(&progress);
 		} else {
-- 
2.51.0.205.g9a02ae2892

