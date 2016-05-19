From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 13/20] unpack-trees: preserve index extensions
Date: Thu, 19 May 2016 17:45:50 -0400
Message-ID: <1463694357-6503-14-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VmY-0006fg-43
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbcESVq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:46:56 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33908 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358AbcESVqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:53 -0400
Received: by mail-qg0-f42.google.com with SMTP id 90so51216725qgz.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=axgf3EMr5P9oJGFXh8rZDCO91rbS0DZV4BYggqjqSZk=;
        b=XeeQzSY12Sl1AtFcK2EPt9RHcbKypPyUy0UrogdI46pHU4rd9BJo7AJ7E/pb4B37GC
         TgycY2HHCYqUtCPqlFNixf2SbVsPFjbDfFfALA6/HXTDwSTilSnXMwfdOFVCi5QoYgRV
         3YvNpOez3F466lQ02T7SW9nSmrjdj4CiRRQ+zoLZgkcigQj2gmJyQGmfKpY3VefEY3Ij
         ZFWJrzEHoUGvTSAfGYUwuzPim9vO48gvKeEZg0JSAvXvFgKbNcEKfpA6E7AWMpOsFOaQ
         BpJeS4ZB+8plP9Ai9IUksHacUpqrsr+1h1D5MAsAE0x7BvhdssEfFQytT+oKyHu97tIE
         MYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=axgf3EMr5P9oJGFXh8rZDCO91rbS0DZV4BYggqjqSZk=;
        b=iDlzw+uqbPFj+NDmOzZv5cx7W4smNLW+B3XM5qOMgAUxWsrMRlgYOny1W5OXcHh1vk
         Y6G6BO8SDqO1YGyYXkgTG1JLhWYfcFNYfyNC4uu2A9QABlKKK4zjZHjJ+Kh2Ft7OSUBG
         eh/8ZnqoTPhdlyyu+6thw9paTZMfEEfJPk3GdiRXYGRimoH3TNsFfwHUJbO2DsJMM2dQ
         Qg7NJQhvx+amOZYeD6ARw1yTMAvH9Er0YH9Ha229fVhZJOwr+ccCCFKvl3/VZrx6goGq
         5PstxlTLbBe+8BTCpyI6RGOJuIIivnqGq5rX5txSduDm0OJBN5HaHIvuuzET62A9hsgw
         HuSQ==
X-Gm-Message-State: AOPr4FXcPBfPaUhIjn2X6Jvvxy80dt3xdSu2wDkjaXhc9qEssZCU6AKaYHfclFrb8qljTw==
X-Received: by 10.140.104.48 with SMTP id z45mr16254948qge.49.1463694412675;
        Thu, 19 May 2016 14:46:52 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295114>

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
index 8ec4be3..82d4446 100644
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
