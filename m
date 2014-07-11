From: David Turner <dturner@twopensource.com>
Subject: [PATCH 3/4 v6] cache-tree: subdirectory tests
Date: Thu, 10 Jul 2014 17:31:25 -0700
Message-ID: <1405038686-1138-3-git-send-email-dturner@twitter.com>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 02:32:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Okt-0002jd-8Z
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 02:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbaGKAb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 20:31:57 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:59638 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaGKAb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 20:31:56 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so351162qcy.17
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 17:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZoMq4XXR/QjCnnuzY5uHq1IhhZJe/Ls9UZk5lL1Uyts=;
        b=HGUEkRu8z9ZSIAWG6ihVXmBHYfW+p7NM94LfEVbxvAGnZfxBtD9HKCByoKdYKxJpHq
         +WgcIH7xs2YZud0D9HMzYr7H8J1R5SyJc58BA5i7qaNgENdeG9J/8/U6h5fqM1Y5Of1T
         sukFbZ5piSH9G7udWVU39nQgYJv82PjMJvbdd0eHvoRbmsu0fqyO7rI70WbIqvz/VEzq
         AspSBMI5BzFQwr+RM8HexH7I9D8FUdAa5E5HkbqNs9f9qv4/jcYL2P245S5JvSZVll3Y
         zjwbzfHS1SH8z1NH52u2r3esrI+0FRm5Hm8bfn5BrupIA+nd7DsI6S0nZATJ1+lxpvaS
         LCsQ==
X-Gm-Message-State: ALoCoQka5pyQ4eyx3Tqbyv14v+OjuB/uZJnHTZBggp4Q/BuQKXQ9yA3ltnHlurPkf3O7oLz92r0K
X-Received: by 10.229.84.133 with SMTP id j5mr10393457qcl.14.1405038715662;
        Thu, 10 Jul 2014 17:31:55 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id s62sm752254qga.28.2014.07.10.17.31.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jul 2014 17:31:55 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1405038686-1138-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253243>

Add tests to confirm that invalidation of subdirectories neither over-
nor under-invalidates.

Signed-off-by: David Turner <dturner@twitter.com>
---
 t/t0090-cache-tree.sh | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 98fb1ab..3a3342e 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -22,9 +22,10 @@ test_shallow_cache_tree () {
 }
 
 test_invalid_cache_tree () {
-	echo "invalid                                   (0 subtrees)" >expect &&
-	printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
-	cmp_cache_tree expect
+	printf "invalid                                  %s ()\n" "" "$@" >expect &&
+	test-dump-cache-tree | \
+	sed -n -e "s/[0-9]* subtrees//" -e '/#(ref)/d' -e '/^invalid /p' >actual &&
+	test_cmp expect actual
 }
 
 test_no_cache_tree () {
@@ -49,6 +50,25 @@ test_expect_success 'git-add invalidates cache-tree' '
 	test_invalid_cache_tree
 '
 
+test_expect_success 'git-add in subdir invalidates cache-tree' '
+	test_when_finished "git reset --hard; git read-tree HEAD" &&
+	mkdir dirx &&
+	echo "I changed this file" >dirx/foo &&
+	git add dirx/foo &&
+	test_invalid_cache_tree
+'
+
+test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
+	git tag no-children &&
+	test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
+	mkdir dir1 dir2 &&
+	test_commit dir1/a &&
+	test_commit dir2/b &&
+	echo "I changed this file" >dir1/a &&
+	git add dir1/a &&
+	test_invalid_cache_tree dir1/
+'
+
 test_expect_success 'update-index invalidates cache-tree' '
 	test_when_finished "git reset --hard; git read-tree HEAD" &&
 	echo "I changed this file" >foo &&
-- 
2.0.0.390.gcb682f8
