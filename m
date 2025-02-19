Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF621EE033
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975433; cv=none; b=qM00pQE+NVmaUuBnXd6o+YzYn3fjzFCafAuod7V9moFLvtK505v9suW1pXj0DupEXX+Yz0D2v6lI9PdFrEMtfxDam5c5QkGQrbtZW8h73NW61uv+TcbknkCKo1BHUHkRPcbKFC0LgzpS4vGGtaYRvNawTiVsrCN2FZDUD99xBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975433; c=relaxed/simple;
	bh=ck2NaxiBtNSGrjFUCxhbgr3gx5cLAQ4U9aiCK0etdHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jI3axIzGX1qrIAx32kkvaBa3jmRyOdViXV5ozvJ/T0nzLcuF2U/R9f9CMIpM2c+KBbUjzh7OiPfwoxSgZ59CU5mg1MOSlrIOMYe8H6vPfz1sGL7dojMzll/R2O0dbM1g45Z6ptRLH+iClAIciJNdP+q3X99kfK3Ntjx4+aOJSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=W3FVYySh; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="W3FVYySh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739975427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyZ49PjE5mJs6PKOchVpXIREqu9Yt/p3wuGT8XVdAdA=;
	b=W3FVYyShzLnrfs2EzSYMV0q0ckC1b6t1VkaZf1NHDGzD4SPW4zwrwzQs4wn+3xfqQZh3n2
	4ypj6627s/5wYYyJC9UuudbduMAoIUMbwS3eAAIbAdnKfG18RedHKV1FtgvfwD/BIRgQaB
	QcV6OKLPjZLwwW3Q3qqNL0jp/mJ0zkQ=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 19 Feb 2025 15:30:19 +0100
Subject: [PATCH v2 1/7] progress: add function to set total
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-toon-bundleuri-progress-v2-1-a84e7ffa921a@iotcl.com>
References: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
In-Reply-To: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
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
index 8d5ae70f3a..e254877d2c 100644
--- a/progress.c
+++ b/progress.c
@@ -276,6 +276,12 @@ static struct progress *start_progress_delay(struct repository *r,
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
index ed068c7bab..2e1bd738c2 100644
--- a/progress.h
+++ b/progress.h
@@ -15,6 +15,7 @@ void progress_test_force_update(void);
 
 void display_throughput(struct progress *progress, uint64_t total);
 void display_progress(struct progress *progress, uint64_t n);
+void progress_set_total(struct progress *progress, uint64_t total);
 struct progress *start_progress(struct repository *r,
 				const char *title, uint64_t total);
 struct progress *start_sparse_progress(struct repository *r,
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 1f75b7bd19..3a73d6fe0a 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -74,6 +74,11 @@ int cmd__progress(int argc, const char **argv)
 			if (*end != '\0')
 				die("invalid input: '%s'", line.buf);
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
index d1a498a216..b7ed1db3a0 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -55,6 +55,30 @@ test_expect_success 'progress display with total' '
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
2.48.1.658.g4767266eb4

