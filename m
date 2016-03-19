From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 12/17] unpack-trees: preserve index extensions
Date: Fri, 18 Mar 2016 21:04:45 -0400
Message-ID: <1458349490-1704-13-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:08:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5NY-00012F-Qk
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbcCSBI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 21:08:26 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34344 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbcCSBIW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:08:22 -0400
Received: by mail-qg0-f53.google.com with SMTP id w104so114670868qge.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/grfEnbin4YUQp6SGnR7ZPWS/ldc8hzqcQDFMIz91Gw=;
        b=gxbXRv95al/SGPlRXCqZE4W4tI9thhUatVCDG3wa0P1TwkKwvSHt0Xw14y7zr7XOcR
         JdYv9DXHM03irU5OjxZPSP0cMgP9NcnV6NPaHw0LSgpf5yGe4+pn5F0cu5I6/M6TYFRF
         cH35scyaRIa010HY0wqDijADvN9qApnp7NdtZ/1s/VMCX6RnHQqZHgnyu/gNs7VwENsH
         goM5KvxbIYqwPgRftGTSGXm2FXSCnLcEXFyPYunKb9f0xbHySC7aOQ289Q9Alg/ULelG
         fTA5egCaYnxCMzGYIzUNtiEDe8dCOYPeD+csJGBcqujuGcMAdthgfKVuflqzcNkGtG4y
         8ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/grfEnbin4YUQp6SGnR7ZPWS/ldc8hzqcQDFMIz91Gw=;
        b=RL+MD7kIJEfi849hCEXaDEBXPULdSM9zIWJ8tjFi1JecyxfxZRq7n1Pyf0haFCgYl7
         RRZMY6uBKIggVs4dbhBRAsuRIWlOOTdj/385Qle6XndF+tCevBQcwvj+YpQHV8dFwOGP
         s/2jIUcF2dMrHloet+eOsFHDPKl2Qgeu65jOeFpKtZ6TDeQXr4w44PriReiw029HEfd+
         8kOGkmtV9D5SLSVEQzQemaw8aC5S5gcCqrBALKpbpyo9ZYVkBhcCsyWJnAaXjjykYARU
         bwT6FVGKS7/+zMPgBKLToLVfdspydF10NqMtlCBkHb1fmH3HLAs6j/vRwysHCUQGoo7S
         CXIA==
X-Gm-Message-State: AD7BkJInsOvNV2bugLZ6SAkc+fwU/Q6EL/9blqeMOk7ixwO4D/6BPeGZTY57Kb/SN/3+uw==
X-Received: by 10.140.230.18 with SMTP id a18mr27976308qhc.3.1458349701162;
        Fri, 18 Mar 2016 18:08:21 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.08.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:08:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289280>

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
index 9fa339a..4ae7dd0 100644
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
index 8e886d1..c141fec 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2742,3 +2742,11 @@ void stat_validity_update(struct stat_validity *sv, int fd)
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
