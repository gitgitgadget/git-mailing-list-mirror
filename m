From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 3/4] cache-tree: subdirectory tests
Date: Sun, 13 Jul 2014 13:28:18 -0700
Message-ID: <1405283299-25636-3-git-send-email-dturner@twitter.com>
References: <1405283299-25636-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twopensource.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 22:29:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6QOW-0001W4-Nk
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 22:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbaGMU3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 16:29:06 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:38839 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbaGMU3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 16:29:03 -0400
Received: by mail-pd0-f169.google.com with SMTP id ft15so4088035pdb.14
        for <git@vger.kernel.org>; Sun, 13 Jul 2014 13:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wsjGcz1z6Jv6uzmpRUZkJqve2UKk+oI573voQ+8CL1c=;
        b=hcVZDc+nEQdst3+j/2YKAkKuKHO5Yz8S6VB7LfF6uCjf4DiF/sYnplEnCEXzlltgi7
         hn3pu1qt6ZJMltw77hw3OneXfrnwpLvXvYMK30KXuoF/mTkjR7pYKBK135VGeJa3Pdc4
         Sbfn3GfC8Ou4oVkXXsnhveGK0Ql2c8WPqrmAw0/oLF5H0Wv23DL8AWEyBhOHSS9hypxf
         QV5mkOv3fbZ34mXRV/nimTAljJSw500XR2bw26L5LJZXouuhBghEYFS6dcsnLbggAtwK
         9I3qPC1J6/M9hIiiNT8pQekTFk/VJlv434ahmdts7T/8JtKLusWPMWHB0prKJY0svEK4
         QWeA==
X-Gm-Message-State: ALoCoQksmG0IkaXXFHW82FW0HgxTVOOnBYY4oYeSpU6KYeIeTH1h2J9kJnYPHm0ayMxYS/MtwFWR
X-Received: by 10.66.180.34 with SMTP id dl2mr74348pac.124.1405283342929;
        Sun, 13 Jul 2014 13:29:02 -0700 (PDT)
Received: from stross.twitter.corp (mobile-166-137-185-178.mycingular.net. [166.137.185.178])
        by mx.google.com with ESMTPSA id jb5sm8609217pbd.73.2014.07.13.13.28.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Jul 2014 13:29:02 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1405283299-25636-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253459>

From: David Turner <dturner@twopensource.com>

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
