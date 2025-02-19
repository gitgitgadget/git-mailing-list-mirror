Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC331F2BA7
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975451; cv=none; b=c1dzks4GzGR6jAgQnqUd7XlG8eJXc0mmNIN0VgINIpAQNViDJaPimHFTeL2LnNA+58rUD5wwi6osM5IjbU8ZEp/fXwnFTbkLdgz23KzsmgLi5xVEPGqSMuCvbdh3KdMdzxUkjdQJ/tA/gJfVOIOG4/vMdk3p6kyr8r19M4Qqlbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975451; c=relaxed/simple;
	bh=/4sK7zh25CrrYQR3GvYRTHfdLJGeIsx7Rm+bg7jEQwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXIwAAM2r5h2YJltaZzRFppqyoYFOBnBnbH1wcMczZNPgI89WOO1J6kkVS60AjkdfpmdV0dgxn7S9XilQdPIEeymvgv8tLkj/MyUOrrRks8ucOULQzTuPjtMYo/v5UkZjsqcTstWJNd9lsFZleg858JzdL5h9YT406g+qXU/gKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sIbHkt/C; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sIbHkt/C"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739975448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6poHB484Uy9A9aqVi2HtVMRtKVtYU3qqD1Fgqp6DYQ=;
	b=sIbHkt/CpM/lHzPP25ticmWB9EGMb2OiryHAOgWYh24zsI0MstRwK11+P4PbdCTQKoB10r
	+EZC6gNHmdFevMdOJfXQMX7BAkbB1zTjUoy2k0xFIMkHJFGi4XWig+9GPakaar0dCF/bZH
	huB3/bxrAAPBn0SO8Ec4uYVOPNkGdhs=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 19 Feb 2025 15:30:25 +0100
Subject: [PATCH v2 7/7] http: silence stderr when progress is enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-toon-bundleuri-progress-v2-7-a84e7ffa921a@iotcl.com>
References: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
In-Reply-To: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

To download bundle URI bundles over HTTP(s), git-clone(1) spawns a
git-remote-http(1) subprocess. Because clone can continue without
bundles, all errors sent by the child process over stderr are
suppressed.

In previous commits, we've added progress output in the child process,
and this happens over stderr, so we can no longer silence stderr. But in
case a bundle could not be downloaded, the user sees the following
messages:

  fatal: failed to download file at URL 'http://127.0.0.1:5558/bundle-5.bundle'
  warning: failed to download bundle from URI 'http://127.0.0.1:5558/bundle-5.bundle'

Here the child git-remote-http(1) prints a "fatal" error and then the
parent git-clone(1) prints a "warning". This is confusing to the user.

Instead of suppressing stderr from the parent process, like we did
before, modify stderr to write to /dev/null in the child process itself,
while keep using the original stderr for progress logging only.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 http.c     |  5 ++++-
 progress.c | 17 +++++++++++++----
 progress.h |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 5517863808..5c0c6ef204 100644
--- a/http.c
+++ b/http.c
@@ -2133,7 +2133,10 @@ static int http_request(const char *url,
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
 	if (options && options->progress) {
-		progress = start_progress(the_repository, _("Downloading via HTTP"), 0);
+		progress = start_progress(the_repository,
+					  _("Downloading via HTTP"), 0);
+		progress_set_fd(progress, fileno(stderr));
+		freopen("/dev/null", "w", stderr);
 
 		curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 0L);
 		curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, progress);
diff --git a/progress.c b/progress.c
index 89abb231ae..1955262000 100644
--- a/progress.c
+++ b/progress.c
@@ -40,6 +40,7 @@ struct progress {
 	const char *title;
 	uint64_t last_value;
 	uint64_t total;
+	int fd;
 	unsigned last_percent;
 	unsigned delay;
 	unsigned sparse;
@@ -144,7 +145,9 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	}
 
 	if (show_update) {
-		if (is_foreground_fd(fileno(stderr)) || done) {
+		int fd = progress->fd ? progress->fd : fileno(stderr);
+
+		if (is_foreground_fd(fd) || done) {
 			const char *eol = done ? done : "\r";
 			size_t clear_len = counters_sb->len < last_count_len ?
 					last_count_len - counters_sb->len + 1 :
@@ -155,17 +158,17 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 			int cols = term_columns();
 
 			if (progress->split) {
-				fprintf(stderr, "  %s%*s", counters_sb->buf,
+				dprintf(fd, "  %s%*s", counters_sb->buf,
 					(int) clear_len, eol);
 			} else if (!done && cols < progress_line_len) {
 				clear_len = progress->title_len + 1 < cols ?
 					    cols - progress->title_len - 1 : 0;
-				fprintf(stderr, "%s:%*s\n  %s%s",
+				dprintf(fd, "%s:%*s\n  %s%s",
 					progress->title, (int) clear_len, "",
 					counters_sb->buf, eol);
 				progress->split = 1;
 			} else {
-				fprintf(stderr, "%s: %s%*s", progress->title,
+				dprintf(fd, "%s: %s%*s", progress->title,
 					counters_sb->buf, (int) clear_len, eol);
 			}
 			fflush(stderr);
@@ -287,6 +290,12 @@ void progress_set_total(struct progress *progress, uint64_t total)
 		progress->total = total;
 }
 
+void progress_set_fd(struct progress *progress, int fd)
+{
+	if (progress)
+		progress->fd = fd;
+}
+
 static int get_default_delay(void)
 {
 	static int delay_in_secs = -1;
diff --git a/progress.h b/progress.h
index 2e1bd738c2..f12c82adc4 100644
--- a/progress.h
+++ b/progress.h
@@ -16,6 +16,7 @@ void progress_test_force_update(void);
 void display_throughput(struct progress *progress, uint64_t total);
 void display_progress(struct progress *progress, uint64_t n);
 void progress_set_total(struct progress *progress, uint64_t total);
+void progress_set_fd(struct progress *progress, int fd);
 struct progress *start_progress(struct repository *r,
 				const char *title, uint64_t total);
 struct progress *start_sparse_progress(struct repository *r,

-- 
2.48.1.658.g4767266eb4

