From: David Turner <dturner@twopensource.com>
Subject: [PATCH 15/19] unpack-trees: preserve index extensions
Date: Wed,  9 Mar 2016 13:36:18 -0500
Message-ID: <1457548582-28302-16-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiz8-0007g4-FA
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933880AbcCIShX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:37:23 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36144 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933844AbcCISgt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:49 -0500
Received: by mail-qk0-f175.google.com with SMTP id s68so24058766qkh.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LkmlvaPdw9qUd9kkjGt6pKoZqeARnFW5XL9rPa+DNUw=;
        b=vWOMUXPB2LNbBFgXikfdYbyjcbWn8YZk2uno0AswVeHQxv0+DYLYhUN3x79NJz4GnJ
         HNKCvsYgudBrU5cODEeC6LL2ouaH+ei3jB2stJ/XJ44a1xHAz5H1bp2fY9xI4gQKidf/
         aAXmIztmF6D616sSLzbTKbLgOi1KT884BOjlALofraDTZRlqHkci0SA+1X1xzYFemEPY
         o6LU6qXD/x9NEq7zi+nKdE7sz1xnIs0c6cw/SIpVs1snPlb86YIuckRSD94kOIc2uwro
         hgs545cmi13f0kT4qNAfKx2rGLxYE90ZUXQqjuL56F+T8nzTcTiPLqoXi8lkKgyDzeVf
         la9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LkmlvaPdw9qUd9kkjGt6pKoZqeARnFW5XL9rPa+DNUw=;
        b=SIVi4unm1uOiRP8/pBzBAYZo75MKrf8YQ/MU5/IhkcrP5eTONg7ky7omDIxatag+fK
         +Z+shCT00oAMMtiIyV4NJtzV3yl07PhTp3xuhXHQ9gRTXKAfRYKLrMNvbsHuQ+uyf+QM
         UFCEWcs+edyTmM6zjR/Tormod1z0kfxTZLQ6QU8eT7MldGGwMiU7yanXunLexxUPCi0d
         UY/L/rl6yLKVklh5a/OT5uSdkYTQLjxAoNDZEWyPbjXbp+7rmGiFLcFM9iSEK/EhJTLZ
         MKE66x6iwiDMy3QmyVajpvedZTNI0DdNib0bNSAG7kH9XqwUqkW+T8gsEZQv9Wxr09mX
         HCbA==
X-Gm-Message-State: AD7BkJIri1mOup9GwmjIOqye1yxVE2xzxvNlxxrNO99lvOBNctN4YMR1Y/3/u9ySoaBbsA==
X-Received: by 10.55.73.85 with SMTP id w82mr45618673qka.52.1457548607105;
        Wed, 09 Mar 2016 10:36:47 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:46 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288565>

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
 t/t7063-status-untracked-cache.sh | 23 +++++++++++++++++++++++
 t/test-lib-functions.sh           |  4 ++++
 unpack-trees.c                    |  1 +
 5 files changed, 37 insertions(+)

diff --git a/cache.h b/cache.h
index 272c928..03c34f1 100644
--- a/cache.h
+++ b/cache.h
@@ -572,6 +572,7 @@ extern void write_watchman_ext(struct strbuf *sb, struct index_state* istate);
 #define REFRESH_DAEMON		(1 << 2)
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 extern int discard_index(struct index_state *);
+extern void move_index_extensions(struct index_state *dst, struct index_state *src);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
diff --git a/read-cache.c b/read-cache.c
index 78f5f0e..40d789a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2591,3 +2591,11 @@ void report_index_stats(struct trace_key *key)
 			 "index stats: file writes       = %10u\n",
 			 nr_read_index, nr_read_shm_index, nr_write_index);
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
index a971884..a2c8535 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -646,4 +646,27 @@ test_expect_success 'test ident field is working' '
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
