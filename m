From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 11/16] unpack-trees: preserve index extensions
Date: Tue, 12 Apr 2016 20:33:04 -0400
Message-ID: <1460507589-25525-12-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:33:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kd-0002my-5V
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758938AbcDMAdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 20:33:41 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:32888 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758934AbcDMAdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:39 -0400
Received: by mail-qk0-f175.google.com with SMTP id n63so2389023qkf.0
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8zPVmTrX6Q9KZICCGc+wNr2wxz/6gOInNEMrVMfAMxo=;
        b=EonqTg65mcqYh3QY3rfc+JtR/wxOKkwLTD0MbexEramKIsNglPoS/8Fv6MEUPNNBrY
         WN1bxquZCpn1GyfNzGh97GiQ6IZfTUVlEFLOoS3MG6JXLHT0owNoO+iqRRcxkhMkwerN
         l+z6x1ulXsV5jbn+5bX7FZSZgvBsOEJjvM1H0VUGqIYE5kWxIVoyiz+x3eF3JcPGLOVm
         gAkk24ze3yfEyjBlOKwwgOriNLiHd4bGGvSXzc/jn70j0YA7lZ563INNtDJccjlNvyOq
         XKNxVI6fU6BgEsay69My3Pua1LOUz+Uao85IrunqNd2WH0SnXlTnvUWnwC1VKm4ksr94
         6wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8zPVmTrX6Q9KZICCGc+wNr2wxz/6gOInNEMrVMfAMxo=;
        b=E4S2U9wVTQsHiBQTia+oSh/lJcwHzuGCC5IkV+h+6IVCDkSFi2IlIMRK3hlAm2xVlK
         lkC0dtjBd3IpHTUZnKs3SPOQIv3mZyw3S1iMwOFlCDHE4+c7+BHTCWyBIkBzWqtQdStI
         ji2MgAbIHPcE6IrSoDLshdrHH0+QSoKtuA1e+Z/UAgjVZpqoHbX6LXnaT488OMq1tBRU
         qKLSbTg/dxq9dI1QNQ6rzREBnJaShdpVQ01jT65i/aro7Hsqr4/HGjgG2uhzZzMu2s1n
         +kDK/MOB+vl2dQaXnb3xSadKln3iNO0w1vHZUFEE1x8NtdCf40QSdUjP2B9ymNQa8kDX
         XM9Q==
X-Gm-Message-State: AOPr4FWCCdu71XWHnv2wDFjeF7Lz2OmXD15pL2EKYLGeT37zywNozm/u31K2VJnodYCnKA==
X-Received: by 10.55.166.132 with SMTP id p126mr7278364qke.8.1460507613255;
        Tue, 12 Apr 2016 17:33:33 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291344>

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
index e43a6e1..5713835 100644
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
index 89c4356..264a25b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2807,3 +2807,11 @@ void stat_validity_update(struct stat_validity *sv, int fd)
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
