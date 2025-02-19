Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AAA43146
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975431; cv=none; b=G+INKEFxUjT/fMu76jIO8+VFKJriCZ2URuTcEcuKSJD0kRehI5g7WgbWTASBo8p5/F00sM3WSS2786c9e1YKGqW2jVyKCKxk306UawgxB3cvJkgQCgbh8QMSzgfgD9VB8u6GNU63TTo0TM7/uOY3/yVtAmkczS0OKIrrD9H69wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975431; c=relaxed/simple;
	bh=8t7iiEpU1JdkoSqyYGcGS9HozQr5T7EygVxICBSOMHo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DFyb+cpeIvv8vTV7h3Nj1fwimkxP39IOU9P7hI43Fv9MT/g15C9nnCqIg+CkbbYGqjIJgTT+tB6xY3raqsPkOkCCXq/yyxtQI+2xerI+uSLutrGTnuRGUC/qgHs0OpBMc4NFsGS+F2mXoavjuk7rYddUwbXad+244Odcr6jJBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=krQvAtip; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="krQvAtip"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739975425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGXiIPmvRL+ddoitRboCK2puiCJvZEAbBzTtqww2JSo=;
	b=krQvAtip82GYJKDYFgGmbPt5zMUijpSoYQb9YwRy1gT1KB9Xr9qMmHqeHKSRjAXyN2QavE
	oEj7GC4Qxpvk1GB9uyY5MklhepUbczJCcRdTU5v5KUwfoQTpSHof0RFDZmXFuRhS7y6CQm
	Nje1Ghkm6DvmwA4FFul1+KUAw2TwmgA=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/7] Show progress when downloading from bundle URIs
Date: Wed, 19 Feb 2025 15:30:18 +0100
Message-Id: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPvqtWcC/x2NSw6DMAwFr4K8bpATPgVWvUfFgo8BSzRBDqBWi
 Ls3sJwnvZkDPAmThyo6QGhnz84GMI8IuqmxIynuA4NBk6HRpVqds6rdbD/TJqwWcaOQ9yrpSzQ
 0UNtgDuG9CA38vc3vOvDEfnXyu0O7vtbLmWKGhTZpmiVxjlg8tdJ34sVu7ea4cx+oz/P8A/VDn
 CeoAAAA
X-Change-ID: 20250219-toon-bundleuri-progress-3d902efeba06
In-Reply-To: <20240508124453.600871-1-toon@iotcl.com>
References: <20240508124453.600871-1-toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>
X-Migadu-Flow: FLOW_OUT

When a user clones a repository, they see what's happening in the
messages like "Enumerating objects" and "Receiving objects". But when
a user clones a repository that uses bundle URIs they see:

    Cloning into 'repo.git'

And then they have to wait until all bundles are downloaded before they
see any other message. When the bundles are large, this can take a lot
of time and the user might consider the process hangs and they kill it.

This patch series introduces progress displayed to the user while
bundles are downloaded. The full output of a clone using bundle URIs
will look something like:

    Cloning into 'repo.git'...
    Downloading via HTTP:  21% (351812809/1620086598), 315.34 MiB | 49.84 MiB/s
    Downloading via HTTP:  77% (1247493865/1620086598), 1.15 GiB | 34.31 MiB/s
    Downloading via HTTP: 100% (1620086598/1620086598), 1.50 GiB | 37.97 MiB/s, done.
    remote: Enumerating objects: 1322255, done.
    remote: Counting objects: 100% (611708/611708), done.
    remote: Total 1322255 (delta 611708), reused 611708 (delta 611708), pack-reused 710547
    Receiving objects: 100% (1322255/1322255), 539.66 MiB | 31.57 MiB/s, done.
    etc...

In this version I'm adding two commits from Peff. And I'm adding one
commit on top to fix the failure in t5558. I'd like to get some feedback
on that commit in particular.

---
Changes in v2:
- Added commit "http: silence stderr when progress is enabled"
- Added commit "progress: allow pure-throughput progress meters" from
  https://lore.kernel.org/git/20111110075300.GK27950@sigill.intra.peff.net/
- Added commit "http: turn off curl signals" from
  https://lore.kernel.org/git/20240509165212.GC1708095@coredump.intra.peff.net/
- Cleanup both CURLOPT_NOPROGRESS and CURLOPT_NOPROGRESS.
- Remove unneeded fflush().
- Link to v1: https://lore.kernel.org/git/20240508124453.600871-1-toon@iotcl.com/

Signed-off-by: Toon Claes <toon@iotcl.com>

---
Jeff King (2):
      progress: allow pure-throughput progress meters
      http: turn off curl signals

Toon Claes (5):
      progress: add function to set total
      http: add the ability to log progress
      remote-curl: optionally show progress for HTTP get
      bundle-uri: enable git-remote-https progress
      http: silence stderr when progress is enabled

 bundle-uri.c                |  2 +-
 http.c                      | 39 ++++++++++++++++++++++++++++++++
 http.h                      |  5 +++++
 progress.c                  | 40 ++++++++++++++++++++++++---------
 progress.h                  |  2 ++
 remote-curl.c               |  8 ++++++-
 t/helper/test-progress.c    |  5 +++++
 t/t0500-progress-display.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++
 t/t5557-http-get.sh         | 15 +++++++++++++
 9 files changed, 159 insertions(+), 12 deletions(-)
---

Range-diff versus v1:

1:  3eb1958b8b ! 1:  7acc83d92b progress: add function to set total
    @@ Commit message
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## progress.c ##
    -@@ progress.c: static struct progress *start_progress_delay(const char *title, uint64_t total,
    +@@ progress.c: static struct progress *start_progress_delay(struct repository *r,
      	return progress;
      }
      
    @@ progress.h: void progress_test_force_update(void);
      void display_throughput(struct progress *progress, uint64_t total);
      void display_progress(struct progress *progress, uint64_t n);
     +void progress_set_total(struct progress *progress, uint64_t total);
    - struct progress *start_progress(const char *title, uint64_t total);
    - struct progress *start_sparse_progress(const char *title, uint64_t total);
    - struct progress *start_delayed_progress(const char *title, uint64_t total);
    + struct progress *start_progress(struct repository *r,
    + 				const char *title, uint64_t total);
    + struct progress *start_sparse_progress(struct repository *r,
     
      ## t/helper/test-progress.c ##
     @@ t/helper/test-progress.c: int cmd__progress(int argc, const char **argv)
      			if (*end != '\0')
    - 				die("invalid input: '%s'\n", line.buf);
    + 				die("invalid input: '%s'", line.buf);
      			display_progress(progress, item_count);
     +		} else if (skip_prefix(line.buf, "total ", (const char **) &end)) {
     +			uint64_t total = strtoull(end, &end, 10);
-:  ---------- > 2:  7a81cda492 progress: allow pure-throughput progress meters
-:  ---------- > 3:  86a9120539 http: turn off curl signals
2:  b74ce999a1 ! 4:  3a73d68448 http: add the ability to log progress
    @@ http.c: static void http_opt_request_remainder(CURL *curl, off_t pos)
      #define HTTP_REQUEST_FILE	1
      
     +static int http_progress_callback(void *clientp, curl_off_t dltotal,
    -+				  curl_off_t dlnow, curl_off_t ultotal,
    -+				  curl_off_t ulnow)
    ++				  curl_off_t dlnow, curl_off_t ultotal UNUSED,
    ++				  curl_off_t ulnow UNUSED)
     +{
     +	struct progress *progress = clientp;
     +
    @@ http.c: static int http_request(const char *url,
      	    http_follow_config == HTTP_FOLLOW_INITIAL)
      		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
     +	if (options && options->progress) {
    -+		progress = start_progress(_("Downloading via HTTP"), 0);
    ++		progress = start_progress(the_repository, _("Downloading via HTTP"), 0);
     +
     +		curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 0L);
     +		curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, progress);
    @@ http.c: static int http_request(const char *url,
      	ret = run_one_slot(slot, &results);
      
     +	if (progress) {
    ++		curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 1L);
     +		curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, NULL);
    ++		curl_easy_setopt(slot->curl, CURLOPT_XFERINFOFUNCTION, NULL);
     +		stop_progress(&progress);
     +	}
     +
3:  5b5e7e86c5 ! 5:  01b2a0042f remote-curl: optionally show progress for HTTP get
    @@ t/t5557-http-get.sh: test_expect_success 'get by URL: 200' '
     +	EOF
     +
     +	git remote-http $url <input 2>err &&
    -+        test_grep "^Downloading via HTTP: 100%" err
    ++	test_grep "^Downloading via HTTP: 100%" err
     +'
     +
      test_done
4:  98ef4dfade ! 6:  3df90aa17b bundle-uri: enable git-remote-https progress
    @@ bundle-uri.c: static int download_https_uri_to_file(const char *file, const char
      	}
      
     +	fprintf(child_in, "option progress true\n");
    -+	fflush(child_in);
    -+
      	fprintf(child_in, "get %s %s\n\n", uri, file);
      
      cleanup:
-:  ---------- > 7:  c30c3bf4fe http: silence stderr when progress is enabled


---

base-commit: a554262210b4a2ee6fa2d594e1f09f5830888c56
change-id: 20250219-toon-bundleuri-progress-3d902efeba06

Thanks
--
Toon

