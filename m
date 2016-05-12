From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 13/20] unpack-trees: preserve index extensions
Date: Thu, 12 May 2016 16:20:08 -0400
Message-ID: <1463084415-19826-14-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6y-0005fv-QN
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbcELUVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:21:21 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33637 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbcELUUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:45 -0400
Received: by mail-io0-f173.google.com with SMTP id f89so108985602ioi.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I0h8/synjXWwjIjqSZi0Lvx5etuenYXEyyWdvdVvKuU=;
        b=BCCV0/cW41/TJQ1y6SNmiVpOzVFUlyocoRiidk9RDuMwlAM5kv61ZwFPLNnM/z5nuc
         11W0A7PTGktkSJiQcdBgQop2LRk5CEr7Xt3ErvxZIlpD0PHm+WtWBKSOKT7yB0u9bBxs
         oyTQF2jfr8aJYGpVq/PlNfEcp71SFeZXtFYyNbe1NDn+BfXumrTUQA2GaS2iauuMgh/J
         XYRz2ckiS7kT9j/qbMcbpN6dV0m5xOrAPG+Ju45QFyQPInVeH+mojTKhB6tWKlI4UI0C
         THin+bux7M7mzdvgR0E2i6h8yy6IMaRwvNRRTbBFw2yFgwZooO7zBVrpiIqh4fLYDyhn
         4vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I0h8/synjXWwjIjqSZi0Lvx5etuenYXEyyWdvdVvKuU=;
        b=GXWGrbQAKkoyAzB5WSzE0tVAo1pW7F998MBUjskCQlwaDyHWTFtK6RHV0+ZJSxpaD0
         lC/HQaIZt6z9yqkhVRlOGIPLxi/OafDz8nTzD6c798+yixUBUrktHwCgChsSedZutH+k
         VbzAoc64OokXLcGf0+Uq6zvG6/OpJ6nbwyf7ToYE4bSSXeTfibh0YlAPpuUdDW4sVmIC
         0O6RGtbyoDZU3UcHxI3VMnKsJfFwPTdxmBtAa8dcHrTrSH+MRg3uRbTFAldf2RkNQlkr
         mO8zmHAW8p7bAv5pbsYzqnrzkQ5Lat55z1TX6s/rdup6UfWoOB8WPVpGGDJSk9VGB0S0
         /G5g==
X-Gm-Message-State: AOPr4FWQEfArmoJESgTL92lu2cPZSF8mVvZa2zBehWXa3YiDG11VHJ3yDMR3Bxj1TYWFlQ==
X-Received: by 10.107.151.206 with SMTP id z197mr8983883iod.191.1463084444419;
        Thu, 12 May 2016 13:20:44 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294469>

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
index 8f6b956..75a1b05 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2771,3 +2771,11 @@ void stat_validity_update(struct stat_validity *sv, int fd)
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
