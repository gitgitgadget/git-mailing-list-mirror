Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i5D9iWZo"
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB7FF2
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:39:30 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c27ee9c36bso1747425a12.1
        for <git@vger.kernel.org>; Sun, 03 Dec 2023 05:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701610770; x=1702215570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMUjySH3u9UK+l6BUcuuMftVY/wlV19i/Ue6UnYzbso=;
        b=i5D9iWZoytUZZBtFv5aiTIVPy7YMyoK8pf6MZEoXjVf5R2tQlQAa/ViFf5XqMkpB0x
         PNtrYQuaG5F63OkmcvioKQOfP4UkCzgTNyqiNLdC+LwxgtnboRFqqPQ8gfDbuX6WEcy5
         yuJiPiaL5wZlyw/wyD62z49GdU3eQ+9hP20g4DXdH0CS2ngBF0Ux+fyOo8Eywrr+74Q+
         kjTSa2jGan8lrdYJ+EZj4HhootBu7FvfACrZJY4+FMtlEQUJ+AJQOBLXivs96SnE4xuj
         bTLQHywngBl6ILSla6lyKTNDn/0dr2b2YMym4zQgGQhvP4eVc66sG7O8JSewh9JCGLeG
         stEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701610770; x=1702215570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMUjySH3u9UK+l6BUcuuMftVY/wlV19i/Ue6UnYzbso=;
        b=wV3hI0enDrRNoH5p3TaQ5VtRvyYRNmlolQWPlvdtJkEVpPJYms9w3/0sy/y7jA6zQI
         YNqPLGPWlpO3Iz0q6Zmta1IN2m49Oi5cHOYOWNZq3/EjUA32hjt6HGLqdzlg24dc9WmZ
         F/Y0L/myoHkQpPYqmfvvtHWQLLYQHCEU59PcnZo4dfLC0Qcr0Gnr1RhuKLklzyrtrlir
         3uh7LI33dfpJx0OfK/BgydNj++/KWuU0tcZzwsRxmHvlwaQnHcogps/iW7f4xPfxGayb
         IusFasFODqhs/5zzCBP6X6UO+SBKVzZqy0XwkRiNw2lmGgn2THk0VaBnZRgRDP3FWHvS
         fN+A==
X-Gm-Message-State: AOJu0Yx0mzYGgbw6n9F3+ugxreKLUDrXYSvQsDT8jhWpNG3DGoYKFUmd
	cV/ZEl3VVUr3enmphx44juhHM7tE3U7BaQw1548=
X-Google-Smtp-Source: AGHT+IFDEzpmcEyUYp3svCJBx1P7laerlLEAqokTqUjf/oTsioD/HqQmGkENaipZJtMq2cg4IcXeCA==
X-Received: by 2002:a05:6a20:de14:b0:18c:b133:dea4 with SMTP id kz20-20020a056a20de1400b0018cb133dea4mr2569163pzb.42.1701610770116;
        Sun, 03 Dec 2023 05:39:30 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id s4-20020a637704000000b005c65e82a0cbsm2515110pgc.17.2023.12.03.05.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 05:39:29 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
X-Google-Original-From: Han Young <hanyoung@protonmail.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [RFC PATCH 3/4] parallel-checkout: add parallel_unlink
Date: Sun,  3 Dec 2023 21:39:10 +0800
Message-ID: <20231203133911.41594-4-hanyoung@protonmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231203133911.41594-1-hanyoung@protonmail.com>
References: <20231203133911.41594-1-hanyoung@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Young <hanyang.tony@bytedance.com>

Add parallel_unlink to parallel-checkout, parallel_unlink uses multiple threads to unlink entries. Because the path to be removed is sorted, each thread iterate through the entry list interleaved to distribute the workload as evenly as possible. Due to the multithread nature, it's not possible to remove all the dirs in one pass. The dir one thread is about to remove may have item that are being removed by another thread. Whenever we failed to remove the dir, we save it in a hashset. When every thread has finished its job, we remove all the entries in the hashset.
---
Note that we display progress after thread join, the progress count is updated for every thread instead of every path.
During testing, threads almost finished at around the same time. This caused the abrupt progress update.
We can use a mutex to display the progress, but that nullified the optimization on environment with fast file deletion time.

 parallel-checkout.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
 parallel-checkout.h | 25 ++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/parallel-checkout.c b/parallel-checkout.c
index b5a714c711..6e62e044d8 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -328,6 +328,24 @@ static int close_and_clear(int *fd)
 	return ret;
 }
 
+void *parallel_unlink_proc(void *_data)
+{
+	struct parallel_unlink_data *data = _data;
+	struct cache_def cache = CACHE_DEF_INIT;
+	int i = data->start;
+	data->cnt = 0;
+
+	while (i < data->len) {
+		const struct cache_entry *ce = data->cache[i];
+		if (ce->ce_flags & CE_WT_REMOVE) {
+			++data->cnt;
+			threaded_unlink_entry(ce, data->super_prefix, data->removal_cache, &cache);
+		}
+		i += data->step;
+	}
+	return &data->cnt;
+}
+
 void write_pc_item(struct parallel_checkout_item *pc_item,
 		   struct checkout *state)
 {
@@ -678,3 +696,65 @@ int run_parallel_checkout(struct checkout *state, int num_workers, int threshold
 	finish_parallel_checkout();
 	return ret;
 }
+
+unsigned run_parallel_unlink(struct index_state *index,
+			  struct progress *progress,
+			  const char *super_prefix, int num_workers, int threshold,
+			  unsigned cnt)
+{
+	int i, use_parallel = 0, errs = 0;
+	if (num_workers > 1 && index->cache_nr >= threshold) {
+		int unlink_cnt = 0;
+		for (i = 0; i < index->cache_nr; i++) {
+			const struct cache_entry *ce = index->cache[i];
+			if (ce->ce_flags & CE_WT_REMOVE) {
+				unlink_cnt++;
+			}
+		}
+		if (unlink_cnt >= threshold) {
+			use_parallel = 1;
+		}
+	}
+	if (use_parallel) {
+		struct parallel_unlink_data *unlink_data;
+		CALLOC_ARRAY(unlink_data, num_workers);
+		threaded_init_remove_scheduled_dirs();
+		struct strbuf removal_caches[num_workers];
+		for (i = 0; i < num_workers; i++) {
+			struct parallel_unlink_data *data = &unlink_data[i];
+			strbuf_init(&removal_caches[i], 50);
+			data->start = i;
+			data->cache = index->cache;
+			data->len = index->cache_nr;
+			data->step = num_workers;
+			data->super_prefix = super_prefix;
+			data->removal_cache = &removal_caches[i];
+			errs = pthread_create(&data->pthread, NULL, parallel_unlink_proc, data);
+			if (errs)
+				die(_("unable to create parallel_checkout thread: %s"), strerror(errs));
+		}
+		for (i = 0; i < num_workers; i++) {
+			void *t_cnt;
+			if (pthread_join(unlink_data[i].pthread, &t_cnt))
+				die("unable to join parallel_unlink_thread");
+			cnt += *((unsigned *)t_cnt);
+			display_progress(progress, cnt);
+		}
+		threaded_remove_scheduled_dirs_clean_up();
+		for (i = 0; i < num_workers; i++) {
+			threaded_remove_scheduled_dirs(&removal_caches[i]);
+		}
+		remove_marked_cache_entries(index, 0);
+	} else {
+		for (i = 0; i < index->cache_nr; i++) {
+			const struct cache_entry *ce = index->cache[i];
+			if (ce->ce_flags & CE_WT_REMOVE) {
+				display_progress(progress, ++cnt);
+				unlink_entry(ce, super_prefix);
+			}
+		}
+		remove_marked_cache_entries(index, 0);
+	    remove_scheduled_dirs();
+	}
+	return cnt;
+}
diff --git a/parallel-checkout.h b/parallel-checkout.h
index c575284005..e851b773d9 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -43,6 +43,18 @@ size_t pc_queue_size(void);
 int run_parallel_checkout(struct checkout *state, int num_workers, int threshold,
 			  struct progress *progress, unsigned int *progress_cnt);
 
+/*
+ * Unlink all the unlink entries in the index, returning the number of entries
+ * unlinked plus the origin value of cnt. If the number of entries
+ * to be removed is smaller than the specified threshold, the operation
+ * is performed sequentially.
+ */
+unsigned run_parallel_unlink(struct index_state *index,
+			  struct progress *progress,
+			  const char *super_prefix,
+			  int num_workers, int threshold,
+			  unsigned cnt);
+
 /****************************************************************
  * Interface with checkout--worker
  ****************************************************************/
@@ -76,6 +88,19 @@ struct parallel_checkout_item {
 	struct stat st;
 };
 
+struct parallel_unlink_data {
+	pthread_t pthread;
+	struct cache_entry **cache;
+	struct strbuf *removal_cache;
+	size_t len;
+	int start;
+	size_t step;
+	unsigned cnt;
+	const char *super_prefix;
+};
+
+void *parallel_unlink_proc(void *_data);
+
 /*
  * The fixed-size portion of `struct parallel_checkout_item` that is sent to the
  * workers. Following this will be 2 strings: ca.working_tree_encoding and
-- 
2.43.0

