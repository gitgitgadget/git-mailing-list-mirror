Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAF1EFFB6
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975435; cv=none; b=a9y2ngWU0AdXcaQUp3u2PkcKU/fJctsJxo6WMCRc1zJt8fUZvJyfOI/RACN+3zuJRoB6Q5qoHdyK6oJ2NG2yNUcsLQDGt7GLnD2g76ISk0bV/XDiqp2pZByJ4G3HlXe6Rmo1oxdIb7gYmmmEijkrIMPI8VZ9LqWFQOYMJulqTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975435; c=relaxed/simple;
	bh=rPk043vlhaQH9ChEkN8EBTp896ZI8/rPEQOyQpiQF88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pscyc4vFudKbRGoJ2ypz9uB3BskVbuERiiftdbDo3OHFzzkt/E3AzCciVS/02MiX1AlQ+SinZsuiPE76XvNH/LhOd3nc33v/BCN6qOhnoYaRGWA1NAHGa1rzLUv5f7CZlPOd546YtZaDLTXWuBAqA+54J1PBoOzqJKY0sXanhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fqNzdPvc; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fqNzdPvc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739975430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GO7ErZSa54MYeNSwHlazE0OuP8ObuUFXmROnJRJvYC4=;
	b=fqNzdPvcT+6TNH1mfgIbOuvXu8QnB9gGdYAsyJhX1LenpEZNSeLGlegD93B4h+AYkLoVnN
	2jUSLcUs16ZG1YzHhr80gwLdAMRkxSH/douzkhF1KrRP8Tag8blMbOw8Uo/6Dt3uxfiBrY
	jt6vg5AFFpHyOUUXyN23J7psDQtwoOI=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 19 Feb 2025 15:30:20 +0100
Subject: [PATCH v2 2/7] progress: allow pure-throughput progress meters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-toon-bundleuri-progress-v2-2-a84e7ffa921a@iotcl.com>
References: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
In-Reply-To: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

The progress code assumes we are counting something (usually
objects), even if we are measuring throughput. This works
for fetching packfiles, since they show us the object count
alongside the throughput, like:

  Receiving objects:   2% (301/11968), 22.00 MiB | 10.97 MiB/s

You can also tell the progress code you don't know how many
items you have (by specifying a total of 0), and it looks
like:

  Counting objects: 34957

However, if you're fetching a single large item, you want
throughput but you might not have a meaningful count. You
can say you are getting item 0 or 1 out of 1 total, but then
the percent meter is misleading:

  Downloading:   0% (0/1), 22.00 MiB | 10.97 MiB/s

or

  Downloading: 100% (0/1), 22.00 MiB | 10.97 MiB/s

Neither of those is accurate. You are probably somewhere
between zero and 100 percent through the operation, but you
don't know how far.

Telling it you don't know how many items is even uglier:

  Downloading: 1, 22.00 MiB | 10.97 MiB/s

Instead, this patch will omit the count entirely if you are
on the zero-th item of an unknown number of items. It looks
like:

  Downloading: 22.00 MiB | 10.97 MiB/s

Signed-off-by: Jeff King <peff@peff.net>
---
 progress.c                  | 17 +++++++++++------
 t/t0500-progress-display.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index e254877d2c..89abb231ae 100644
--- a/progress.c
+++ b/progress.c
@@ -135,7 +135,11 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 		}
 	} else if (progress_update) {
 		strbuf_reset(counters_sb);
-		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
+		if (n > 0)
+			strbuf_addf(counters_sb, "%" PRIuMAX "%s",
+				    (uintmax_t)n, tp);
+		else
+			strbuf_addstr(counters_sb, tp);
 		show_update = 1;
 	}
 
@@ -170,11 +174,12 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	}
 }
 
-static void throughput_string(struct strbuf *buf, uint64_t total,
-			      unsigned int rate)
+static void throughput_string(struct progress *progress, struct strbuf *buf,
+			      uint64_t total, unsigned int rate)
 {
 	strbuf_reset(buf);
-	strbuf_addstr(buf, ", ");
+	if (progress->total || progress->last_value > 0)
+		strbuf_addstr(buf, ", ");
 	strbuf_humanise_bytes(buf, total);
 	strbuf_addstr(buf, " | ");
 	strbuf_humanise_rate(buf, rate * 1024);
@@ -243,7 +248,7 @@ void display_throughput(struct progress *progress, uint64_t total)
 	tp->last_misecs[tp->idx] = misecs;
 	tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 
-	throughput_string(&tp->display, total, rate);
+	throughput_string(progress, &tp->display, total, rate);
 	if (progress->last_value != -1 && progress_update)
 		display(progress, progress->last_value, NULL);
 }
@@ -343,7 +348,7 @@ static void force_last_update(struct progress *progress, const char *msg)
 		unsigned int misecs, rate;
 		misecs = ((now_ns - progress->start_ns) * 4398) >> 32;
 		rate = tp->curr_total / (misecs ? misecs : 1);
-		throughput_string(&tp->display, tp->curr_total, rate);
+		throughput_string(progress, &tp->display, tp->curr_total, rate);
 	}
 	progress_update = 1;
 	buf = xstrfmt(", %s.\n", msg);
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index b7ed1db3a0..582b9fa899 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -263,6 +263,37 @@ test_expect_success 'progress display with throughput and total' '
 	test_cmp expect out
 '
 
+test_expect_success 'progress display throughput without total' '
+	cat >expect <<-\EOF &&
+	Working hard: <CR>
+	Working hard: 200.00 KiB | 100.00 KiB/s<CR>
+	Working hard: 300.00 KiB | 100.00 KiB/s<CR>
+	Working hard: 400.00 KiB | 100.00 KiB/s<CR>
+	Working hard: 400.00 KiB | 100.00 KiB/s, done.
+	EOF
+
+	cat >in <<-\EOF &&
+	start 0
+	throughput 102400 1000
+	update
+	progress 0
+	throughput 204800 2000
+	update
+	progress 0
+	throughput 307200 3000
+	update
+	progress 0
+	throughput 409600 4000
+	update
+	progress 0
+	stop
+	EOF
+	test-tool progress <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'cover up after throughput shortens' '
 	cat >expect <<-\EOF &&
 	Working hard: 1<CR>

-- 
2.48.1.658.g4767266eb4

