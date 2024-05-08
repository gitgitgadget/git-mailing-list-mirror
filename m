Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970665BD1
	for <git@vger.kernel.org>; Wed,  8 May 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172313; cv=none; b=G81nNYwKeVGIQ0edhgJZ76Tx7dKhnpzDKCxYuH9yGDHhpPLzl2QWZY0TeJR4JTiIfqiUIgjgNuoBxQgPt3X7sxEgqrGuBcFEiZKx1zi/tRjm/5Y/8DglEsOhFWVTpnHnvLTv3lY2AHSe8eEodT4te5fUz3GPw2xxxNO1OI6ki1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172313; c=relaxed/simple;
	bh=ang7xvGKhm3AsRN0AO+s0RZ9WpoB5PzcrvguBCWTv64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5PcCi3+ovxoc5iqry6JpSiIeCEDlco1y7ybFyIMWgjOLDbRqrUO4mHzI07Fkla8KP2SPjM4JM5Pvn2TZTxvIBfH7yvNGIvPlgvHax2HDiVJKOdccLYnNxOLOz7/b/28t3djIp59dWV01K656PYZ2eQ8XvN6BiLlo6Q6wszZfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fm31wUIv; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fm31wUIv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1715172307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0kir6kTaBL8aB4hqDzIa/JIYmbAwXC8yfn5loQ3F6Y=;
	b=fm31wUIv5rUWDebf96IJ2ehWWzsa0tj1yjlTidDHCviDgMbvw5g4mPF+9F9msfSLZEO/H5
	eE414zRmlspLy+uZcy4yzXUmugpC6Po1f8viyazUneDASEnMZG/CsjkcTh3ekNlgzOb8DU
	KeNEiKIrbXOEDCI622e0mA/Pm07I+/4=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 1/4] progress: add function to set total
Date: Wed,  8 May 2024 14:44:50 +0200
Message-ID: <20240508124453.600871-2-toon@iotcl.com>
In-Reply-To: <20240508124453.600871-1-toon@iotcl.com>
References: <20240508124453.600871-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We're about to add the use of progress through curl. Although, curl
doesn't know the total at the start of the download, but might receive
this information in the Content-Length header when the download starts.

To allow users set the total size after calling start_progress(), add a
function progress_set_total().

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 progress.c                  |  6 ++++++
 progress.h                  |  1 +
 t/helper/test-progress.c    |  5 +++++
 t/t0500-progress-display.sh | 24 ++++++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/progress.c b/progress.c
index c83cb60bf1..494b26eb20 100644
--- a/progress.c
+++ b/progress.c
@@ -271,6 +271,12 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	return progress;
 }
 
+void progress_set_total(struct progress *progress, uint64_t total)
+{
+	if (progress)
+		progress->total = total;
+}
+
 static int get_default_delay(void)
 {
 	static int delay_in_secs = -1;
diff --git a/progress.h b/progress.h
index 3a945637c8..52f75ab1bf 100644
--- a/progress.h
+++ b/progress.h
@@ -14,6 +14,7 @@ void progress_test_force_update(void);
 
 void display_throughput(struct progress *progress, uint64_t total);
 void display_progress(struct progress *progress, uint64_t n);
+void progress_set_total(struct progress *progress, uint64_t total);
 struct progress *start_progress(const char *title, uint64_t total);
 struct progress *start_sparse_progress(const char *title, uint64_t total);
 struct progress *start_delayed_progress(const char *title, uint64_t total);
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 66acb6a06c..622b1f738d 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -70,6 +70,11 @@ int cmd__progress(int argc, const char **argv)
 			if (*end != '\0')
 				die("invalid input: '%s'\n", line.buf);
 			display_progress(progress, item_count);
+		} else if (skip_prefix(line.buf, "total ", (const char **) &end)) {
+			uint64_t total = strtoull(end, &end, 10);
+			if (*end != '\0')
+				die("invalid input: '%s'\n", line.buf);
+			progress_set_total(progress, total);
 		} else if (skip_prefix(line.buf, "throughput ",
 				       (const char **) &end)) {
 			uint64_t byte_count, test_ms;
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 1eb3a8306b..82a3b834a6 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -56,6 +56,30 @@ test_expect_success 'progress display with total' '
 	test_cmp expect out
 '
 
+test_expect_success 'progress display modify total' '
+	cat >expect <<-\EOF &&
+	Working hard: 1<CR>
+	Working hard:  66% (2/3)<CR>
+	Working hard: 100% (3/3)<CR>
+	Working hard: 100% (3/3), done.
+	EOF
+
+	cat >in <<-\EOF &&
+	start 0
+	update
+	progress 1
+	update
+	total 3
+	progress 2
+	progress 3
+	stop
+	EOF
+	test-tool progress <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'progress display breaks long lines #1' '
 	sed -e "s/Z$//" >expect <<\EOF &&
 Working hard.......2.........3.........4.........5.........6:   0% (100/100000)<CR>
-- 
2.44.0.651.g21306a098c

