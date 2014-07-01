From: David Turner <dturner@twopensource.com>
Subject: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Tue,  1 Jul 2014 12:14:33 -0700
Message-ID: <1404242075-7068-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 21:16:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X23X4-0007qs-G2
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 21:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758517AbaGATPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 15:15:54 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:65531 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbaGATPx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 15:15:53 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so3807559qgf.14
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 12:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2mcATPiz0jsZtpIdLi8NnMNlPlPCZLvrN+ffLjwDMH8=;
        b=S1rOJT8Kco77S30EJGW+tz7SAhaZ7yjsw3R9pMi/HYq4KSvF4avsywgBjJ0THREGFw
         1ZnfY42cyMH9BMJVQUPdbBiinOxS24qDvzXa56Xu3KzYMoElxYi6lOBY/UOWL5AiFZfF
         gK33/P8UAUoksz2G/NZx2KORiM5JkFceeOAmAWS9vHjREM4jYIBQSHqlj4abOFdeVHkB
         NoteYNigJ5atPHrLgpVGIz6HIBjxuMr0Da770VYRNOPJt5uHkDTLkP17dK2IiGtwaN0D
         qIH2jcm3YTTzZtOsZh5O+NbW4XKHypYRbRtsuKRhqxcqpW+nFT2WKBLkIksj6AJcuJVS
         3NiQ==
X-Gm-Message-State: ALoCoQnlhrRAeCuds0D7JkLWZ3KDdYgtKuvdEL3+8WqSAEcpUoC9zep8U60XwBbEHHwCSskWqg4K
X-Received: by 10.140.101.86 with SMTP id t80mr45833002qge.108.1404242152651;
        Tue, 01 Jul 2014 12:15:52 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id i44sm1094930qgd.13.2014.07.01.12.15.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Jul 2014 12:15:51 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252737>

When git checkout checks out a branch, create or update the
cache-tree so that subsequent operations are faster.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/checkout.c    |  8 ++++++++
 cache-tree.c          |  5 +++--
 t/t0090-cache-tree.sh | 19 ++++++++++++++++---
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 07cf555..a023a86 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -553,6 +553,14 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 	}
 
+	if (!active_cache_tree)
+		active_cache_tree = cache_tree();
+
+	if (!cache_tree_fully_valid(active_cache_tree))
+		cache_tree_update(active_cache_tree,
+				  (const struct cache_entry * const *)active_cache,
+				  active_nr, 0);
+
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
diff --git a/cache-tree.c b/cache-tree.c
index 7fa524a..28d2356 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -612,9 +612,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 			cache_tree_find(active_cache_tree, prefix);
 		if (!subtree)
 			return WRITE_TREE_PREFIX_ERROR;
-		hashcpy(sha1, subtree->sha1);
+		if (sha1)
+			hashcpy(sha1, subtree->sha1);
 	}
-	else
+	else if (sha1)
 		hashcpy(sha1, active_cache_tree->sha1);
 
 	if (0 <= newfd)
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 6c33e28..98fb1ab 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -44,14 +44,14 @@ test_expect_success 'read-tree HEAD establishes cache-tree' '
 
 test_expect_success 'git-add invalidates cache-tree' '
 	test_when_finished "git reset --hard; git read-tree HEAD" &&
-	echo "I changed this file" > foo &&
+	echo "I changed this file" >foo &&
 	git add foo &&
 	test_invalid_cache_tree
 '
 
 test_expect_success 'update-index invalidates cache-tree' '
 	test_when_finished "git reset --hard; git read-tree HEAD" &&
-	echo "I changed this file" > foo &&
+	echo "I changed this file" >foo &&
 	git update-index --add foo &&
 	test_invalid_cache_tree
 '
@@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index gives cache-tree' '
 	test_shallow_cache_tree
 '
 
-test_expect_failure 'checkout gives cache-tree' '
+test_expect_success 'checkout gives cache-tree' '
+	git tag current &&
 	git checkout HEAD^ &&
 	test_shallow_cache_tree
 '
 
+test_expect_success 'checkout -b gives cache-tree' '
+	git checkout current &&
+	git checkout -b prev HEAD^ &&
+	test_shallow_cache_tree
+'
+
+test_expect_success 'checkout -B gives cache-tree' '
+	git checkout current &&
+	git checkout -B prev HEAD^ &&
+	test_shallow_cache_tree
+'
+
 test_done
-- 
2.0.0.390.gcb682f8
