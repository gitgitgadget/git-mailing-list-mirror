Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HlYCikfe"
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ECFF2
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:39:27 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d8750718adso1287549a34.0
        for <git@vger.kernel.org>; Sun, 03 Dec 2023 05:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701610765; x=1702215565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RvYv7uHu7brJsj9pn123xeFDsX9i1hM3oiiLxym4YM=;
        b=HlYCikfesY/VvUaqL7n5J+mvAUyWY1aERgsfYHaSBptdhrzh866NBHyYrDbEvm8/Sg
         misKdi1YYOvcWq4NDp9aZTHii6o/SCd7tZFxghz1eYq4ha/gUxHok1hm5AK/Bu+ZIVQN
         NJ1gGzWUWhvAhE4xeh3BPzW1jxgWQDVdSDARJWUaR+MnRiw6lrYHDITt2KSkILIhE1MK
         xlAYb2ViTeFCAWwbGT5xDDnUervDYDJsDl8Evdn5LEtPQDYdFPS5TNIiX157Tvg+Xnzi
         kRtXsMONBumhCjsUfEw9+CzmzvC14FosyiBUp28Z60C6F5OxH37zCE2nVkrSld9f6Pye
         A6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701610765; x=1702215565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RvYv7uHu7brJsj9pn123xeFDsX9i1hM3oiiLxym4YM=;
        b=vdGS67Md1ov3XsNZlO0Oj4U+HO1retV3uLcfUvcjj1Wm/ZTfXVLuUn6ktXqKZPCEZ5
         O8HvL9kUMI26kNJEONyXkkBybUtBaUYbRw4xMdy9luTbHfw+VFptVh/BMMZ3EViHZvsb
         Rfe1HniGEl4ebedJNZl7cO9bUC7TEk9AeF5DvY9G1vRDv9zbO2LzE1W6EeYJz873Utpx
         RnvS8iOF9077sh+P/I4pBHhK2ARUoxgOM39jhqO688m74txrso+yjHCg5rr8Tcw104Lz
         8FBjnyYXmXwlglxVnVjdhbV15EaaQG72BMMYiZwBDLEmkJZf9sGtweMuev5IUysNFqds
         AipQ==
X-Gm-Message-State: AOJu0Yw5iUCVVWhWKd3Pfx/8LUeWRIG8EPoVnma/tfSg96Fbou3qcg4o
	NvYPz0Q79mtWVbYMAByX8yUSImuubOV6vCVjrl0=
X-Google-Smtp-Source: AGHT+IGe4CCyrTyG2Ny01ldNVuHjyluwJIG2na+HDTAKDqpM2NNStJUmz3eGdhy1wzvkBQdTL6xzsQ==
X-Received: by 2002:a05:6871:2303:b0:1fb:3741:4dc5 with SMTP id sf3-20020a056871230300b001fb37414dc5mr441179oab.34.1701610765560;
        Sun, 03 Dec 2023 05:39:25 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id s4-20020a637704000000b005c65e82a0cbsm2515110pgc.17.2023.12.03.05.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 05:39:25 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
X-Google-Original-From: Han Young <hanyoung@protonmail.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [RFC PATCH 1/4] symlinks: add and export threaded rmdir variants
Date: Sun,  3 Dec 2023 21:39:08 +0800
Message-ID: <20231203133911.41594-2-hanyoung@protonmail.com>
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

Add and export threaded variants of remove dir related functions, these functions will be used by parallel unlink
---
Most of the code of threaded_schedule_dir_for_removal and threaded_do_remove_scheduled_dirs is duplicated.
We can remove the duplication either via breaking the function into smaller functions, or pass the cache as parameters.
If we choose to pass the cache explicitly, default cache in both entry.c and symlinks.c probably need to be moved to
unpack-trees.c. I'm not satisfied with using mutex guarded hashset to ensure every dir is removed. But I can't come
up with a better way.

 symlinks.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 symlinks.h |   6 +++
 2 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index b29e340c2d..c8cb0a7eb7 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -2,9 +2,9 @@
 #include "gettext.h"
 #include "setup.h"
 #include "symlinks.h"
+#include "hashmap.h"
+#include "pthread.h"
 
-static int threaded_check_leading_path(struct cache_def *cache, const char *name,
-				       int len, int warn_on_lstat_err);
 static int threaded_has_dirs_only_path(struct cache_def *cache, const char *name, int len, int prefix_len);
 
 /*
@@ -229,7 +229,7 @@ int check_leading_path(const char *name, int len, int warn_on_lstat_err)
  * directory, or if we were unable to lstat() it. If warn_on_lstat_err is true,
  * also emit a warning for this error.
  */
-static int threaded_check_leading_path(struct cache_def *cache, const char *name,
+int threaded_check_leading_path(struct cache_def *cache, const char *name,
 				       int len, int warn_on_lstat_err)
 {
 	int flags;
@@ -277,6 +277,51 @@ static int threaded_has_dirs_only_path(struct cache_def *cache, const char *name
 }
 
 static struct strbuf removal = STRBUF_INIT;
+static struct hashmap dir_set;
+pthread_mutex_t dir_set_mutex = PTHREAD_MUTEX_INITIALIZER;
+struct rmdir_hash_entry {
+      struct hashmap_entry hash;
+      char *dir;
+      size_t dirlen;
+};
+
+/* rmdir_hashmap comparison function */
+static int rmdir_hash_entry_cmp(const void *cmp_data UNUSED,
+			       const struct hashmap_entry *eptr,
+			       const struct hashmap_entry *entry_or_key UNUSED,
+			       const void *keydata)
+{
+	const struct rmdir_hash_entry *a, *b;
+
+	a = container_of(eptr, const struct rmdir_hash_entry, hash);
+	return strcmp(a->dir, (char *)keydata);
+}
+
+void threaded_init_remove_scheduled_dirs(void)
+{
+	unsigned flags = 0;
+	hashmap_init(&dir_set, rmdir_hash_entry_cmp, &flags, 0);
+}
+
+static void add_dir_to_rmdir_hash(char *dir, size_t dirlen)
+{
+	struct rmdir_hash_entry *e;
+	struct hashmap_entry *ent;
+	int hash = strhash(dir);
+	pthread_mutex_lock(&dir_set_mutex);
+	ent = hashmap_get_from_hash(&dir_set, hash, dir);
+
+	if (!ent) {
+		e = xmalloc(sizeof(struct rmdir_hash_entry));
+		hashmap_entry_init(&e->hash, hash);
+		char *_dir= xmallocz(dirlen);
+		memcpy(_dir, dir, dirlen+1);
+		e->dir = _dir;
+		e->dirlen = dirlen;
+		hashmap_put_entry(&dir_set, e, hash);
+	}
+	pthread_mutex_unlock(&dir_set_mutex);
+}
 
 static void do_remove_scheduled_dirs(int new_len)
 {
@@ -294,6 +339,26 @@ static void do_remove_scheduled_dirs(int new_len)
 	removal.len = new_len;
 }
 
+
+static void threaded_do_remove_scheduled_dirs(int new_len, struct strbuf *removal)
+{
+	while (removal->len > new_len) {
+		removal->buf[removal->len] = '\0';
+		if (startup_info->original_cwd &&
+		     !strcmp(removal->buf, startup_info->original_cwd))
+			 break;
+		if (rmdir(removal->buf)) {
+			add_dir_to_rmdir_hash(removal->buf, removal->len);
+			break;
+		}
+		do {
+			removal->len--;
+		} while (removal->len > new_len &&
+			 removal->buf[removal->len] != '/');
+	}
+	removal->len = new_len;
+}
+
 void schedule_dir_for_removal(const char *name, int len)
 {
 	int match_len, last_slash, i, previous_slash;
@@ -327,11 +392,60 @@ void schedule_dir_for_removal(const char *name, int len)
 		strbuf_add(&removal, &name[match_len], last_slash - match_len);
 }
 
+void threaded_schedule_dir_for_removal(const char *name, int len, struct strbuf *removal_cache)
+{
+	int match_len, last_slash, i, previous_slash;
+
+	if (startup_info->original_cwd &&
+	    !strcmp(name, startup_info->original_cwd))
+		return;	/* Do not remove the current working directory */
+
+	match_len = last_slash = i =
+		longest_path_match(name, len, removal_cache->buf, removal_cache->len,
+				   &previous_slash);
+	/* Find last slash inside 'name' */
+	while (i < len) {
+		if (name[i] == '/')
+			last_slash = i;
+		i++;
+	}
+
+	/*
+	 * If we are about to go down the directory tree, we check if
+	 * we must first go upwards the tree, such that we then can
+	 * remove possible empty directories as we go upwards.
+	 */
+	if (match_len < last_slash && match_len < removal_cache->len)
+		threaded_do_remove_scheduled_dirs(match_len, removal_cache);
+	/*
+	 * If we go deeper down the directory tree, we only need to
+	 * save the new path components as we go down.
+	 */
+	if (match_len < last_slash)
+		strbuf_add(removal_cache, &name[match_len], last_slash - match_len);
+}
+
 void remove_scheduled_dirs(void)
 {
 	do_remove_scheduled_dirs(0);
 }
 
+void threaded_remove_scheduled_dirs_clean_up(void)
+{
+	struct hashmap_iter iter;
+	const struct rmdir_hash_entry *entry;
+
+	hashmap_for_each_entry(&dir_set, &iter, entry, hash /* member name */) {
+		schedule_dir_for_removal(entry->dir, entry->dirlen);
+	}
+	remove_scheduled_dirs();
+}
+
+void threaded_remove_scheduled_dirs(struct strbuf *removal_cache)
+{
+	threaded_do_remove_scheduled_dirs(0, removal_cache);
+}
+
 void invalidate_lstat_cache(void)
 {
 	reset_lstat_cache(&default_cache);
diff --git a/symlinks.h b/symlinks.h
index 7ae3d5b856..7898eae941 100644
--- a/symlinks.h
+++ b/symlinks.h
@@ -20,9 +20,15 @@ static inline void cache_def_clear(struct cache_def *cache)
 int has_symlink_leading_path(const char *name, int len);
 int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
 int check_leading_path(const char *name, int len, int warn_on_lstat_err);
+int threaded_check_leading_path(struct cache_def *cache, const char *name,
+				       int len, int warn_on_lstat_err);
 int has_dirs_only_path(const char *name, int len, int prefix_len);
 void invalidate_lstat_cache(void);
 void schedule_dir_for_removal(const char *name, int len);
+void threaded_schedule_dir_for_removal(const char *name, int len, struct strbuf *removal_cache);
 void remove_scheduled_dirs(void);
+void threaded_remove_scheduled_dirs(struct strbuf *removal_cache);
+void threaded_init_remove_scheduled_dirs(void);
+void threaded_remove_scheduled_dirs_clean_up(void);
 
 #endif /* SYMLINKS_H */
-- 
2.43.0

