From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 12/19] unpack-trees: preserve index extensions
Date: Mon,  9 May 2016 16:48:42 -0400
Message-ID: <1462826929-7567-13-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:50:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7O-0003yU-3n
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbcEIUtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:49:23 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34267 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbcEIUtV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:21 -0400
Received: by mail-qg0-f44.google.com with SMTP id 90so95696199qgz.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ltfAmexHiu3cm06Z7fdpuNTrxYQ7r+HvlsZ9Zlg5R74=;
        b=VtQu5GrjuzT2+K7VactP3Wp+OSux05cEK9kYNTJRc/VMNFRU3gmNTk5XP5v2Mg2vlM
         LtCOq7877eh4kur2N+3I8dURjXmFouNlEAbaFpbSoqfI6BoKse8iSOVknqsJ9MBu/yqn
         KjCeGm+1nour4SJiUAQB/R/xEl4xQ34W9ea/VY7Z91Lyq+7wJatClSRNq+EWiXDRHQ5G
         sGEV0Ha6ZQFdfkod9S1uEdjLj3odZYNlRKbl8u1brdvfmuYw7vuz6ty6GeczbRDqKimy
         KGZsrfS2VwgLXm/TtRmvrcrqMzjIGjBJ0ok/eB7RyK9Ud/i/2XluWdJusTiIj87KqlIN
         fswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ltfAmexHiu3cm06Z7fdpuNTrxYQ7r+HvlsZ9Zlg5R74=;
        b=WB3CWuBUwfYsjZcGbbxZlyjoZYCuHFyBgjnG+Us03mjeI5NMNFHSnQg4BCRaXBIZOg
         vEaCz1HRLXBvrV+vxWdh19kYSmefVAdslC1mVllR0+jHlnyLSp32IxdKPQXPVuu/fBuB
         GfHxgVHBhFf/uiPD4JXRq7OZQeQgtNchVDlMRPHTgoRmIZIUpPSNkHbZHDKrIomOTvE9
         lguH/EExzYO/ouwYybSVMEBwNU1R9rzZcDBNQ2dUSpKI3iHPka3sADyTPILDnWF2u0c9
         SPTZX0r5Wa9BkDFosZqUfeQxukojjGWKfOgpX83NPd3aEPY4LtIpgEfc8tDQ98ycAiKo
         YLFw==
X-Gm-Message-State: AOPr4FXX6axt9tITZ7pZE72vQp9x240UmgE2h7iz805CkV2R5byy+8rn31vLUaKLTzs0mg==
X-Received: by 10.140.239.137 with SMTP id k131mr39983657qhc.11.1462826959840;
        Mon, 09 May 2016 13:49:19 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294057>

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
index 633e1dd..1b372ed 100644
--- a/cache.h
+++ b/cache.h
@@ -580,6 +580,7 @@ extern void write_watchman_ext(struct strbuf *sb, struct index_state *istate);
 #define CLOSE_LOCK		(1 << 1)
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 extern int discard_index(struct index_state *);
+extern void move_index_extensions(struct index_state *dst, struct index_state *src);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
diff --git a/read-cache.c b/read-cache.c
index b4ed18e..76b65c2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2769,3 +2769,11 @@ void stat_validity_update(struct stat_validity *sv, int fd)
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
