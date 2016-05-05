From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 12/19] unpack-trees: preserve index extensions
Date: Thu,  5 May 2016 17:47:04 -0400
Message-ID: <1462484831-13643-13-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:47:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR7m-00082K-VN
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757950AbcEEVrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:47:49 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33945 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757917AbcEEVrq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:46 -0400
Received: by mail-qk0-f178.google.com with SMTP id r184so50943058qkc.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkTK0O1V8R7LQDI/dIopowwZyS/eF6MgMZR6yezZdTU=;
        b=WjxwgBFdDP2SCK6rjtV5lL0DnkmpGwW9WkXSEpgmrEWWvS/8Ognlb52PS2Yy+0Fg10
         K39SJPo2LWMo8gn7xuX9GvhGwcltxJNt0MDf2Zo5jcg3bMamM243eeq8lwY9utoyVGGS
         G6q5oqFlj93pETo50dClkIczizWShxgKlzH7xCR/7tManpjrF/obTugtUIxFfSemz12D
         CK19z2rRz/p2kxzoNh86+8IQqBCcU8nJXcQAM7XJNTXhPpWG13PVcaxvNMvbAnQZrMp4
         hJjGONqBMvaNoFXKClBSd0LVub53d+D0ushrm/MiKGKjkXIV51e2LSTdds2tUYQtdneR
         yUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gkTK0O1V8R7LQDI/dIopowwZyS/eF6MgMZR6yezZdTU=;
        b=RVfYXqc7/F4o63ewdTziGQhx9uOistkouUGhYUTdFy7LCZuhegbazpdJbo7t+uydoG
         MGBuwJpxTgaJrwTaavUKYYE0XycwvykNBShGPnCbAoed7s4xTryTxx0z09jeUSDuY4Qx
         XfMngOCUX2NC/WbI1hi0MgqisffyuZUEzP8B9iX4VPgDncPaqCdNJNOsVB3LlqSJKd2T
         D9NqJKhA2jcVzbZ7m4KvJ6gYcZZvjxs8+SLCM23wEdwBwGvEtBtzGaDthA12oVmDfm0n
         jWXZmJY2rdg31ddjqcRnwutohB7z11TLD0V5EIZEF0wKQCGUZCzyRMOrs8ETtlOysG+y
         ShcA==
X-Gm-Message-State: AOPr4FXVzrz8VJ6JxsAHZSSkYeiwFS/RcIInPGmIU5kPRKCUkzPDKJYOVwUgEbZJ0ofUoA==
X-Received: by 10.55.24.159 with SMTP id 31mr17729904qky.123.1462484860890;
        Thu, 05 May 2016 14:47:40 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293693>

Make git checkout (and other unpack_tree operations) preserve the
untracked cache and watchman status. This is valuable for two reasons:

1. Often, an unpack_tree operation will not touch large parts of the
working tree, and thus most of the untracked cache will continue to be
valid.

2. Even if the untracked cache were entirely invalidated by such an
operation, the user has signaled their intention to have such a cache,
and we don't want to throw it away.

The same logic applies to the watchman state.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 cache.h                           |  1 +
 read-cache.c                      |  8 ++++++++
 t/t7063-status-untracked-cache.sh | 22 ++++++++++++++++++++++
 t/test-lib-functions.sh           |  4 ++++
 unpack-trees.c                    |  1 +
 5 files changed, 36 insertions(+)

diff --git a/cache.h b/cache.h
index a167920..e65234d 100644
--- a/cache.h
+++ b/cache.h
@@ -580,6 +580,7 @@ extern void write_watchman_ext(struct strbuf *sb, struct index_state* istate);
 #define CLOSE_LOCK		(1 << 1)
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 extern int discard_index(struct index_state *);
+extern void move_index_extensions(struct index_state *dst, struct index_state *src);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
diff --git a/read-cache.c b/read-cache.c
index b44b18b..4ad2c19 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2770,3 +2770,11 @@ void stat_validity_update(struct stat_validity *sv, int fd)
 		fill_stat_data(sv->sd, &st);
 	}
 }
+
+void move_index_extensions(struct index_state *dst, struct index_state *src)
+{
+	dst->untracked = src->untracked;
+	src->untracked = NULL;
+	dst->last_update = src->last_update;
+	src->last_update = NULL;
+}
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a971884..083516d 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -646,4 +646,26 @@ test_expect_success 'test ident field is working' '
 	test_cmp ../expect ../err
 '
 
+test_expect_success 'untracked cache survives a checkout' '
+	git commit --allow-empty -m empty &&
+	test-dump-untracked-cache >../before &&
+	test_when_finished  "git checkout master" &&
+	git checkout -b other_branch &&
+	test-dump-untracked-cache >../after &&
+	test_cmp ../before ../after &&
+	test_commit test &&
+	test-dump-untracked-cache >../before &&
+	git checkout master &&
+	test-dump-untracked-cache >../after &&
+	test_cmp ../before ../after
+'
+
+test_expect_success 'untracked cache survives a commit' '
+	test-dump-untracked-cache >../before &&
+	git add done/two &&
+	git commit -m commit &&
+	test-dump-untracked-cache >../after &&
+	test_cmp ../before ../after
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d99eb3..e974b5b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -186,6 +186,10 @@ test_commit () {
 		test_tick
 	fi &&
 	git commit $signoff -m "$1" &&
+	if [ "$(git config core.bare)" = false ]
+	then
+	    git update-index --force-untracked-cache
+	fi
 	git tag "${4:-$1}"
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 9f55cc2..fc90eb3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1215,6 +1215,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
+		move_index_extensions(&o->result, o->dst_index);
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
-- 
2.4.2.767.g62658d5-twtrsrc
