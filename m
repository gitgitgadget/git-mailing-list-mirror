Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01C27FD44
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149384; cv=none; b=jcriJorI+ZK2awtl6bpEJUqx8v308Rk8NUWkJQ9iLTlfPnSkY51ChTtDMhcDvuJwGBNVyMMOkoXDqLvUvVe8S1K2T0eaBlqdTsxtjVxos/qqFDNr05r0+PGb3uzmd58BH4mKJYYX25BSJS6o/GZs90s4KbDq9yOLlxs9T1N/2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149384; c=relaxed/simple;
	bh=m/NZVyLt1Ek8Y2DaIok2IRjm5n+BAF5Y/Ophm+oDV0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQ9GNJbYUuvq1Gd6ljDnkC92l6if1ODLhxlRIeSSm6Kk/2sF4CcbmACKli3IIVC6nkizQEZTUU+gGjdXTqOb67lvpApk8QBE1hLCrFvwg2n0409eKJ7/DQVJkDfQQdQwdd6joSs8bHAo6g5hrgfPZcfWglaURyY0zmu91Psx+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4c9gWJ5y7yzRq1w;
	Mon, 25 Aug 2025 21:16:12 +0200 (CEST)
Message-ID: <7b848623-ce64-4679-9b5e-9d91d947b269@kdbg.org>
Date: Mon, 25 Aug 2025 21:16:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] progress: pay attention to (customized) delay time
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
 <86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org> <xmqq4itxvi3z.fsf@gitster.g>
 <08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org>
 <2d56de10-f829-4bc8-9c76-76eab6b137ae@kdbg.org> <xmqq349fs5ee.fsf@gitster.g>
 <jq5ul4zwdex6peuub3upwzxz3d5zcnuh7adseyg6wa6dpiu4ci@fuwe2t2vbguo>
 <xmqq8qj7qlqf.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq8qj7qlqf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
 Compared to the first round, this replaces sig_atomic_t by int. I
 didn't use bool just in case the patch goes on top of a maintenance
 track that does not have the "bool is allowed" policy.

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
index 8d5ae70f3a..8315bdc3d4 100644
--- a/progress.c
+++ b/progress.c
@@ -114,16 +114,19 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
 	int show_update = 0;
+	int update = !!progress_update;
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


