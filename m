From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 11/16] unpack-trees: preserve index extensions
Date: Wed,  6 Apr 2016 18:11:57 -0400
Message-ID: <1459980722-4836-12-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:12:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvh0-0004mU-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbcDFWMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 18:12:52 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36159 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbcDFWMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:48 -0400
Received: by mail-qk0-f177.google.com with SMTP id i4so23617416qkc.3
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4tiZEfK7BD49p0J1blYJorKZeyZDMGnxprYY+mlovEU=;
        b=v5yHRX/CFXoVHQVxrVQP7mpOjhlj6Gujidvg0kU+28SRYoiSWxPr/azqqCQTIpNjcN
         FAK3X51h3YEt9qS+jEvcZzChD/DKT9R63ftMJGInyZkB7CfXJg8cszviMalzq5NcwNyV
         Uw6rvrcPoZ9a5H/thfLiH5XfeH2K/UErmh+J2bVzZvlDOR/nDuDem7jTNV+gOtf1V9kt
         n3HftPoe4nzNF6z0SwMPDDZuOkvt2I4kP0GYExFI8ktEMxQhHPk0h8vhJvScfufkIxXB
         uMWW3nHQsbb775IEECKeLa/T+aQIphPSYYniyNRazfa0pfEfA/qwAjyK5T/biMrH5FQQ
         R9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4tiZEfK7BD49p0J1blYJorKZeyZDMGnxprYY+mlovEU=;
        b=cJ70OHh6/ChxQN7pjDSUSAWHxegzpevhKGOfLl7VpCZD+9o4LJ/blzFBa172zTOzp7
         kbL4DxRndbhhewHa4AKUWt0FNzvOISIbqByg2YPp8nfNzEB82ASuYCKL93EnWOc/gwJr
         IRVpAmZH3ndoF1spb2B6N4bC78ictZXB2iWTwujRwGTzMWTIVuBYg+A1KXc6GUlyFNWK
         81BAR3JpVR1sJeDF1hHdulTD93hfijDN9sSDd9fu69AEn3hPPvd2MUKud3I7oBZwk/k6
         SXVOq+iUdGZRApe6ylsgnrkAjILFrjwb4S8XHaFS3sMV0Iiy/UXAmPh5JOcjt4DcsHz2
         AbUA==
X-Gm-Message-State: AD7BkJLwIlS8zqbf260dOBIGTCAgpIOMpYN7VgFpj3OWgMH2eEoIWnQ4Peh43YnsA7eKQQ==
X-Received: by 10.55.203.18 with SMTP id d18mr51786896qkj.25.1459980767239;
        Wed, 06 Apr 2016 15:12:47 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290876>

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
index b6e9244..470cd7b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2725,3 +2725,11 @@ void stat_validity_update(struct stat_validity *sv, int fd)
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
