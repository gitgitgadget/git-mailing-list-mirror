Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Cg6PucVN"
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841FCFC
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:39:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso3959001b3a.0
        for <git@vger.kernel.org>; Sun, 03 Dec 2023 05:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701610772; x=1702215572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHK+vVu5ipNW149NlqulqGnnHdAIPxaJYBu04rkWNCc=;
        b=Cg6PucVNQHjD1VuX33xF1RLJrQn5SuGpvKNH79pDURnl09mv/KanrFm+CT1j0jadP4
         xrZ1GQVSpvYx3K68hRdSCoEx/U4eYE8tuW71fjQ9dA+Nu2Ds6VR8+SKcUbPzWOOZIGHK
         HiJQ2bv4unLFLOVlj5tkbYzctY9Z1Fby5WEhjv9+rxihquryit7Qw1dLf8AwnTjzMd5u
         i+t8IP7LpcY4VhBkBKy3nYi2SUu82uJk34S9iVqAQodlwNnpT3fZTGb7grLRZwlrBRGZ
         C0Oe0QeCpQtsVSrfzRCkwBH6dnf0GyfwdOTKpipMTpsYafUGJSGweC1AY6ZIqFYn6MnD
         EDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701610773; x=1702215573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHK+vVu5ipNW149NlqulqGnnHdAIPxaJYBu04rkWNCc=;
        b=ARIn+axHWOfKFpnjmUkYAyGf/5xNjiXl3W9UHf9CAiNvsUePxyeI7P/LJ1CE3kvWKW
         bMbpAg7Gc/7RUeMCWEeEUchKMoxpp5yILQbTNq4iHCtuUM2gEh20kr72Rd6b0e35ggsU
         giEiKlvnqB1/T+M9qCdlXdLq75bWpSS4NqB9fA6psHnJ7t46C/7a2LV36Rp4m7Yko2KH
         lrppbA7nksJiKfG+QMI5Vc+C4CmzgQF07if+0Gc925esES6T8n8pXWrddrQzAyTJvIh4
         KKNoTcOdODB21fnQecNgTbuKWL6s1GSVJuD3ZojBK1Y27yWTG3PcN06r/Ffiz/Cy84Ej
         ZLNQ==
X-Gm-Message-State: AOJu0YyRWt9vNX6no6asdJixqtRHoPG1aj3Jw9OqVtvYE0SuEpGUFxKo
	+UHGg87ouWnoynnCv+qmEmg2BJs3/czyGgEf83A=
X-Google-Smtp-Source: AGHT+IEoRee87/6F2GBxdLF6X/WiYmGzP/uNEm8IjK54ASUgXU5vUyocBN0oniOAnaEVUdqU8UlNnA==
X-Received: by 2002:a05:6a20:6a23:b0:18f:97c:9758 with SMTP id p35-20020a056a206a2300b0018f097c9758mr3490124pzk.64.1701610772754;
        Sun, 03 Dec 2023 05:39:32 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id s4-20020a637704000000b005c65e82a0cbsm2515110pgc.17.2023.12.03.05.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 05:39:32 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
X-Google-Original-From: Han Young <hanyoung@protonmail.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [RFC PATCH 4/4] unpack-trees: introduce parallel_unlink
Date: Sun,  3 Dec 2023 21:39:11 +0800
Message-ID: <20231203133911.41594-5-hanyoung@protonmail.com>
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

We have parallel_checkout option since 04155bdad, but the unlink is still executed single threaded. On very large repo, checkout across directory rename or restructure commit can lead to large amount of unlinked entries. In some instance, the unlink operation can be slower than the parallel checkout. This commit add parallel unlink support, parallel unlink uses multithreaded removal of entries.
---
Unlink operation by itself is way faster than checkout, the default threshold should be way higher
than parallel_checkout. I hardcoded the threshold to be 100 times higher, probably need to introduce
a new config option with sensible default.
To discover how many entries to remove require us to iterate index->cache, this is fast even for large
number of entries compare to filesystem operation.
I think we can reuse checkout.workers as the main switch for parallel_unlink, since it's also part of
checkout process.

 unpack-trees.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index c2b20b80d5..53589cde8a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -452,17 +452,8 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, NULL);
 
-	for (i = 0; i < index->cache_nr; i++) {
-		const struct cache_entry *ce = index->cache[i];
-
-		if (ce->ce_flags & CE_WT_REMOVE) {
-			display_progress(progress, ++cnt);
-			unlink_entry(ce, o->super_prefix);
-		}
-	}
-
-	remove_marked_cache_entries(index, 0);
-	remove_scheduled_dirs();
+	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
+	cnt = run_parallel_unlink(index, progress, o->super_prefix, pc_workers, pc_threshold * 100, cnt);
 
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
@@ -474,8 +465,6 @@ static int check_updates(struct unpack_trees_options *o,
 		 */
 		prefetch_cache_entries(index, must_checkout);
 
-	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
-
 	enable_delayed_checkout(&state);
 	if (pc_workers > 1)
 		init_parallel_checkout();
-- 
2.43.0

