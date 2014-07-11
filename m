From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 3/4] cache-tree: subdirectory tests
Date: Fri, 11 Jul 2014 16:22:26 -0700
Message-ID: <1405120947-3142-3-git-send-email-dturner@twitter.com>
References: <1405120947-3142-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 01:23:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5k9b-00078d-FU
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 01:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbaGKXWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 19:22:55 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:44929 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbaGKXWw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 19:22:52 -0400
Received: by mail-qc0-f171.google.com with SMTP id w7so1629074qcr.16
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 16:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZoMq4XXR/QjCnnuzY5uHq1IhhZJe/Ls9UZk5lL1Uyts=;
        b=RMjDP+AAEIM+g6cB4gWPesyUzbGjgQnzzfdZwBfx+2dZXGF9cMTfVQ7Im8/5YPUtXL
         Q88NjIBJY7klAo8G9taDDn5gL+6kfsN8n6H81O/xU7kRA7AxmfeT/dYIrJFyvzMy/fvm
         gGh3y/Z/NxSzRjpyIlYUzGTGPFc2ih2Cdzio3xUudcGeh+F48z+yCI7L1o0JEBH+rZHt
         cUCqgpFDMtqehr/e0skSDU/AVllEuKHO6ygNRPmsmJcTSKBjyDnqOVqNXGd7xerXZm9r
         myXY9A/GLxKbM/1Uw7MaBCm2qZDLA918QJDGiYvEeE4iHz+Ejk2kqbJ/KRql3oMRdWyi
         cG4A==
X-Gm-Message-State: ALoCoQk44rr6MFfxS42OAXaUgTabclKUu6S1/CLddg+jAhRZJtZoTCdasQpfOPGL4CVTkVeGu301
X-Received: by 10.224.38.71 with SMTP id a7mr703867qae.44.1405120972186;
        Fri, 11 Jul 2014 16:22:52 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id k7sm6652126qas.24.2014.07.11.16.22.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jul 2014 16:22:51 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1405120947-3142-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253350>

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
