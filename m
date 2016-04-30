From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 12/19] unpack-trees: preserve index extensions
Date: Fri, 29 Apr 2016 21:02:06 -0400
Message-ID: <1461978133-13966-13-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJE-00082g-6Y
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbcD3BCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:02:55 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35473 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbcD3BCn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:43 -0400
Received: by mail-qg0-f46.google.com with SMTP id f74so49689594qge.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Cz2F1qAbE2HRtuvZjMwHcUW0mBkL2+zdlLNbYGr+Y4=;
        b=pJw3U1mBZ87VKUA8QtU9xiufE4dYtSIGSz7PJtPXuJj4Ktjrfw1PGaF6p1rifo1sB7
         YyfKOBKiaE24Z8dkQSwaLtthrr9361ZC59XVTg9uYvo8S1srYktJY81ONluih7NHAJmj
         JdINYT/p7zWGGM98w16SrSO2FRhZ7Qp/5/SJPOW/2MVhSt+wMPVkfz+CIa5U2rxZsL+x
         s5Zs5hZW/ZwPQEYfInbD5ClPjpfET9d/pZqLKsY2sy3cY4fIz4r993o2CwjUT2hn1Shr
         70ydu+3q9hwgbjzqyBkEqHE5vYhhbOfRBF7lcpksq1QnGBwiHlOdVZqpfSUfLGRe8Mce
         9UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Cz2F1qAbE2HRtuvZjMwHcUW0mBkL2+zdlLNbYGr+Y4=;
        b=EHYEbOAPM6Zr8cA4unFKpxAuq5ugg1jDt3y3nme/VXSWeZQ2bZ++dZRX4QU1wFXAfY
         qfQ4rpVxypNAt4/XDbAObpxsH8Y9An2fQ2J5UIMgdxmKH8GQdVozNsN0HqRapBP8+GEx
         8IpdbGBToM8VPLCmOXBUbFvBgNasTa+Hk2SkE/XHhTvXdSVcW/Xa/aRZqSZqv2yu2ez1
         YcMwyo6q1duy3Vw3vIuDjQr+oRqs0mZZSDJ4cYaK45cXbayLFASXNkaMCx1GDPj9zsJ+
         TLgF9HZPjOS4c68MI4tD/NIkOpoxsmrlKFropOGiXnxOw1JbLs6RUKQBVZ+l4R8+KVWj
         /3IQ==
X-Gm-Message-State: AOPr4FXqnbfAU4bnT6Y9/3qHN3WVEpg6f5NYHDdJHizqmOqvTCv+OgX8A3xkMupFfF5ItA==
X-Received: by 10.140.32.161 with SMTP id h30mr21549956qgh.51.1461978157381;
        Fri, 29 Apr 2016 18:02:37 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293110>

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
index e3f3a1a..1779fa2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2767,3 +2767,11 @@ void stat_validity_update(struct stat_validity *sv, int fd)
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
