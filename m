From: David Turner <dturner@twopensource.com>
Subject: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Mon, 30 Jun 2014 17:13:15 -0700
Message-ID: <1404173597-24713-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 02:13:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1lhe-0007mU-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 02:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbaGAANh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 20:13:37 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:40983 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbaGAANg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 20:13:36 -0400
Received: by mail-qc0-f176.google.com with SMTP id w7so7654919qcr.21
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 17:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J0soLnHs7T9AT1iBK7TGQyEyTxTjk6woGq9rBlokz1o=;
        b=bLGxGQg+lr8LEA0dvh1a/gNHIqndeAoIr46p0llrkV6Dfa48bHjZU/ASP1HsZerE0Z
         ppsv0tlXoTerhSi2ioLYwzbpO2pMinzq21TeB+TQu7zcI4ts062etvprosSE2zNZEarc
         rrqYOecBgIFifhLN/0LHL/jqlGA5Xav29iN5ZOnQK9irmVVibN/ewOk33g+J04xmZA/s
         BvHySDeB+5k8VvtiV4j6nxTj6JDIB9n2BXt8kiZ1rd4yNVyZEExNyJm06DN8ahPgvQT1
         6FTQXV/nIGdg9w5dRAwOpIpaCfRHzvTN5FSLNbkDiR7H9Lu9z73rcBUI9gkgYrJ7TuGA
         Ew5Q==
X-Gm-Message-State: ALoCoQkDUUL7J+B1V9+u1gmiewXSTnXooHX3gkVDAVL6aGw48AwhxuleGM966wjcHzTlzTbcBbL6
X-Received: by 10.140.98.195 with SMTP id o61mr28746563qge.41.1404173615980;
        Mon, 30 Jun 2014 17:13:35 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id p3sm316651qga.33.2014.06.30.17.13.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jun 2014 17:13:35 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252705>

When git checkout checks out a branch, create or update the
cache-tree so that subsequent operations are faster.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/checkout.c    |  8 ++++++++
 cache-tree.c          |  5 +++--
 t/t0090-cache-tree.sh | 15 ++++++++++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

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
index 6c33e28..7c60675 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index gives cache-tree' '
 	test_shallow_cache_tree
 '
 
-test_expect_failure 'checkout gives cache-tree' '
+test_expect_success 'checkout gives cache-tree' '
+	git tag current
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
