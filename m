From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 12/19] unpack-trees: preserve index extensions
Date: Wed, 27 Apr 2016 16:04:34 -0400
Message-ID: <1461787481-877-13-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:05:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avViN-0003J5-Rm
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbcD0UF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:05:29 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36293 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbcD0UFY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:24 -0400
Received: by mail-qk0-f174.google.com with SMTP id x7so23489087qkd.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZzFqbfP0OrRpvQkArQxWcaYwGwaRD+aIakjhqrDwJlo=;
        b=KEMekc6XUJM/y1wroo5bfsnnbnRRnvloeB16k4TjYQgq+ZR14PTufEcrcGsnQTvjpo
         JjSjpENoovOPrLhMGdwxQjOC6gLXfO70BBpM2zhNIIlX47wDkvjtmCA2wSWyWgq2wOiz
         EtLoSBr9DEJuv+wanA8wRsHzCeYULJaxU5/AlguUQAxX3+CGXQaXG+aqbdOl+m1Kpcvi
         tu0rpTuUk8bbg1jyR6qEvqCZU1fpRRZVzUeFxNgr6MD9naDv/qlMYZBclPwSlnzATgpo
         CIFxzeuTBhxC8wnUpq6nMXPftP/94rF5W/ImkG9GE7jqk1tXJniQGpyIEB9eQPO+kuC7
         u7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZzFqbfP0OrRpvQkArQxWcaYwGwaRD+aIakjhqrDwJlo=;
        b=mOQwTg1vE8c2jibaLzVJBrQJq0p4Jo0rJeybWMuHCUHYHr46AHaLYCmxpCndyDMHXI
         WcRUhF/Z28GxYRoel7RZ+gOGXU4rvA2ZUkZ/3nXoHva1yVtKCtG3YfEZwf2YYPc3iG0g
         J2XOnLX9wZZGGQ0EHgTGONsbJfCcBIpTNDy5kq9SV+9Dc2yKAKYutY1tZB1mafQH4+Oc
         FvcGhRTGMUb2LpWsayDnCQsoo8y6NbkMCfJFsiyvkFwRz4opW3nzS4K/RC3YAjMSbTo4
         lBgh8McxK4/6L5R/VO+9g3Mi1HPM96RHIgOpl9zmI/T0PR+CZhfcg3XehyFWZjCyeS9B
         0EgA==
X-Gm-Message-State: AOPr4FXtsB+71iEdYkkAqzjmF6GHyAJFCOBG1FLhVshT6IXAhukEexLz6g2+67U2054OgQ==
X-Received: by 10.55.117.12 with SMTP id q12mr11062338qkc.192.1461787523276;
        Wed, 27 Apr 2016 13:05:23 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292792>

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
index 4cc89bb..49fa128 100644
--- a/cache.h
+++ b/cache.h
@@ -571,6 +571,7 @@ extern void write_watchman_ext(struct strbuf *sb, struct index_state* istate);
 #define CLOSE_LOCK		(1 << 1)
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 extern int discard_index(struct index_state *);
+extern void move_index_extensions(struct index_state *dst, struct index_state *src);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
diff --git a/read-cache.c b/read-cache.c
index a57f605..470a27d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2768,3 +2768,11 @@ void stat_validity_update(struct stat_validity *sv, int fd)
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
