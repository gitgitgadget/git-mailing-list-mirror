From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 3/4] cache-tree: subdirectory tests
Date: Sat,  5 Jul 2014 21:06:58 -0700
Message-ID: <1404619619-4774-3-git-send-email-dturner@twitter.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 06:07:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3djs-0005RB-B1
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 06:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbaGFEHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 00:07:33 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33737 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbaGFEHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 00:07:30 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so3684600pac.11
        for <git@vger.kernel.org>; Sat, 05 Jul 2014 21:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QH9g1460tzYRyGDUrqhNEzKfeprAWklfG6/BzZci0Ts=;
        b=WtAv5//1I4uWp1pl6D7WHEMBPPTz0EHpUjtmGvWkAvdBagvheJrx6W0bb3z/lZ75in
         fMhFBp7G+mk1jQ5J+fSNHMyOiuKoeUw3FPBCSENVQAWzrFQEMNEa3zDgUlNrCmWED/96
         GsfiYCkU/DM9p1N28nhdXwYaHzaAxvRNCjbmc1rxSJhbctz9Lh805tgwkRrZT3tcH+8o
         KmLCn4IDLlgqP+7iob7wk+4jKFVOEvwGWPBnQGIFOV9tE6yaIk0aM3nfRZTyhc89bWcd
         NjOoyNelgRXfOGRLGDsrWQ8mFEO9T/OaWGDZxPDOB9YesIbmTV6nwHdesfHo5jCJ5Vg9
         YdQQ==
X-Gm-Message-State: ALoCoQmDDKtV3RZhUMtXsPA/cgPjEewffXWk71yFd8CR238YB1ZIqhxj+Zi0YRULSmcmiR3JDSSl
X-Received: by 10.68.231.229 with SMTP id tj5mr10392686pbc.101.1404619649635;
        Sat, 05 Jul 2014 21:07:29 -0700 (PDT)
Received: from stross.twitter.corp (c-67-169-40-58.hsd1.ca.comcast.net. [67.169.40.58])
        by mx.google.com with ESMTPSA id by1sm48542593pbb.75.2014.07.05.21.07.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Jul 2014 21:07:28 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1404619619-4774-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252926>

Add tests to confirm that invalidation of subdirectories nether over-
nor under-invalidates.

Signed-off-by: David Turner <dturner@twitter.com>
---
 t/t0090-cache-tree.sh | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 98fb1ab..8437c5f 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -21,10 +21,13 @@ test_shallow_cache_tree () {
 	cmp_cache_tree expect
 }
 
+# Test that the cache-tree for a given directory is invalid.
+# If no directory is given, check that the root is invalid
 test_invalid_cache_tree () {
-	echo "invalid                                   (0 subtrees)" >expect &&
-	printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
-	cmp_cache_tree expect
+	test-dump-cache-tree >actual &&
+	sed -e "s/$_x40/SHA/" -e "s/[0-9]* subtrees//g" <actual >filtered &&
+	expect=$(printf "invalid                                  $1 ()\n") &&
+	fgrep "$expect" filtered
 }
 
 test_no_cache_tree () {
@@ -49,6 +52,25 @@ test_expect_success 'git-add invalidates cache-tree' '
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
