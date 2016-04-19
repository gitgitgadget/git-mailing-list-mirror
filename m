From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 11/15] unpack-trees: preserve index extensions
Date: Tue, 19 Apr 2016 19:28:05 -0400
Message-ID: <1461108489-29376-12-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:29:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4l-00005W-J4
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbcDSX2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:28:46 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36344 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbcDSX2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:33 -0400
Received: by mail-qg0-f44.google.com with SMTP id f52so19236562qga.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XoShMF02lQVD5O+iJy/LC2q9ml2AM8hHV2jwH7BibWA=;
        b=VUrrMJrWAmMPfrn0XlFK3gRM5PT8ioXaFlLVJigOBMIc9yuyEh/DboTnHzUwOM/oEW
         hsj5NxR+nCxOn/lG7vKhKwxEzYV3Hl6Y695EUk4ePuaFKlqppa/wHjrbJycSutebSOP/
         ODVIky6znwT1X/j0rIYxIAF+sVxoPHJxc/7sBeEVHiwjdP/5/WMEW6BWuHlGK+PQwdut
         JzyIncQRSDVhlNEH+ZSu01Njn+BnfTKqJS/DBVbq3kMouXBzHJYsbJcKSDX6NPZ5cO5I
         jsrR9XAb6uSPVFo4Ao8ZQhG5ullZ4Bf2Oy6lwvB8ugI3w9XIKP0v2RaKedzBMiI1TJmt
         /bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XoShMF02lQVD5O+iJy/LC2q9ml2AM8hHV2jwH7BibWA=;
        b=mL/YQLCusyngy0XcCYVhSQKSL+Yl+XNJbR3kd4CyRpaSlIcKD8LNsaa2pX7HAyZTRK
         Z1MqzTZNDR02GOo+DDrYr8guF7i3Badh5N9t1iDvtiRN3M+3aEKY3JCcQsdpk+tiil9A
         +iX3eY4t9cmDy9LPtk73WWaXA8uKJEdqR3++94Xmsk/sz+Z2NBKfuOu7d4BCVO895mjD
         +WTShuhF1PSQIdaI0XtAmbR9rw9XDLBKFsDH2YpY2CE7LvzmBYpxOlRk2EGGne4cDW9o
         /FwcVqjjh+wTAoVypDfh0MWFVFvxhI4ysl45K0ksvBsv99zi+XBWESHzgiyYMDxlrjud
         4dtw==
X-Gm-Message-State: AOPr4FVz4HraFJdBExheq9vZe79cGSHPQtnCGjNdFZaj1QWx9K0xe0j4YNp/Otw+coaB6w==
X-Received: by 10.140.169.132 with SMTP id p126mr7453070qhp.71.1461108507730;
        Tue, 19 Apr 2016 16:28:27 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291967>

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
index fb0168e..65f22f9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2745,3 +2745,11 @@ void stat_validity_update(struct stat_validity *sv, int fd)
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
