Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8022BAF9
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756049485; cv=none; b=rVffMFEYnjZE2LhQYTZLZ2582GooC7vCtaw0MSmkU6T8WdV+AVSOuYCnKkpIyoT0OKH2k0m2WXqpHALKma/zslMt4/lRmV9pDVXxuCiP+flI/1Dypyr2ulk8ya+ClCGNzbXMDciUoblJwEdBDGWW+ezdxpUCgy158PNdMW22r+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756049485; c=relaxed/simple;
	bh=Z8DG0MgTUE0iU3d2B7uMbYiRIRygP4b32N0rlNeu/S4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jflSnWwh1Q4LzGxFbVYtiGtMpKHjA0h8+xaI3H8d4XmtUbDOWIRZ5Ag5lFJbKHUqgNu5eAvYI6dlciqzclPDxrQ3QuPGExNfy9A8lPJKnanwt7oK82G0PcAIDtfsNTPRmbqq6N81IiY3p5k5vdM/CcC1PAXcfX7tmPEPdzSEDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4c8yZH33znzRq1l;
	Sun, 24 Aug 2025 17:31:18 +0200 (CEST)
Message-ID: <2d56de10-f829-4bc8-9c76-76eab6b137ae@kdbg.org>
Date: Sun, 24 Aug 2025 17:31:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] progress: pay attention to (customized) delay time
From: Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
 <86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org> <xmqq4itxvi3z.fsf@gitster.g>
 <08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org>
Content-Language: en-US
In-Reply-To: <08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.08.25 um 00:03 schrieb Johannes Sixt:
> That said, I am not very happy about the new calls introduced in
> display_progress(), either. I'll see whether I can produce some
> performance measurements.

I haven't made up my mind, yet, whether I want to persue the direction
any further. Since we do not have a low-latency implementation of
getnanotime() for all supported systems, calling the function tens of
thousands of times per second could be too burdensome for some of them.

> I observe a behavior change with delayed progress indicators that I have
> to understand and fix it before I can submit the cleaned up patches.

But I found a bug in the delayed progress indicators: the initial delay
time is always just one second instead of the configured time (two
seconds by default).

Below is a fix. This is a minimal patch. It could be extended to reduce
the number of local flag variables in display() and perhaps also reduce
indentation levels with some early returns.

If Carlo wants to advance the original patches, this patch also provides
an obvious point where the alarm clock can be re-armed outside the
signal handler. It would be where we set progress_update = 0.

----- 8< -----
Subject: [PATCH] progress: pay attention to (customized) delay time

Using one of the start_delayed_*() functions, clients of the progress
API can request that a progress meter is only shown after some time.
To do that, the implementation intends to count down the number of
seconds stored in struct progress by observing flag progress_update,
which the timer interrupt handler sets when a second has elapsed. This
works during the first second of the delay. But the code forgets to
reset the flag to zero, so that subsequent calls of display_progress()
think that another second has elapsed and decrease the count again
until zero is reached. Due to the frequency of the calls, this happens
without an observable delay in practice, so that the effective delay is
always just one second.

This bug has been with us since the inception of the feature. Despite
having been touched on various occasions, such as 8aade107dd84
(progress: simplify "delayed" progress API), 9c5951cacf5c (progress:
drop delay-threshold code), and 44a4693bfcec (progress: create
GIT_PROGRESS_DELAY), the short delay went unnoticed.

Copy the flag state into a local variable and reset the global flag
right away so that we can detect the next clock tick correctly.

Since we have not had any complaints that the delay of one second is
too short nor that GIT_PROGRESS_DELAY is ignored, people seem to be
comfortable with the status quo. Therefore, set the default to 1 to
keep the current behavior.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Documentation/git.adoc |  2 +-
 progress.c             | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 743b7b00e4..03e9e69d25 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -684,7 +684,7 @@ other
 
 `GIT_PROGRESS_DELAY`::
 	A number controlling how many seconds to delay before showing
-	optional progress indicators. Defaults to 2.
+	optional progress indicators. Defaults to 1.
 
 `GIT_EDITOR`::
 	This environment variable overrides `$EDITOR` and `$VISUAL`.
diff --git a/progress.c b/progress.c
index 8d5ae70f3a..39a1101420 100644
--- a/progress.c
+++ b/progress.c
@@ -114,16 +114,19 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
 	int show_update = 0;
+	sig_atomic_t update = progress_update;
 	int last_count_len = counters_sb->len;
 
-	if (progress->delay && (!progress_update || --progress->delay))
+	progress_update = 0;
+
+	if (progress->delay && (!update || --progress->delay))
 		return;
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
-		if (percent != progress->last_percent || progress_update) {
+		if (percent != progress->last_percent || update) {
 			progress->last_percent = percent;
 
 			strbuf_reset(counters_sb);
@@ -133,7 +136,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 				    tp);
 			show_update = 1;
 		}
-	} else if (progress_update) {
+	} else if (update) {
 		strbuf_reset(counters_sb);
 		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
 		show_update = 1;
@@ -166,7 +169,6 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 			}
 			fflush(stderr);
 		}
-		progress_update = 0;
 	}
 }
 
@@ -281,7 +283,7 @@ static int get_default_delay(void)
 	static int delay_in_secs = -1;
 
 	if (delay_in_secs < 0)
-		delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 2);
+		delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 1);
 
 	return delay_in_secs;
 }
-- 
2.51.0.205.g9a02ae2892

