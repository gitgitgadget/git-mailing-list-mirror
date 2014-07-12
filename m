From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 3/4] cache-tree: subdirectory tests
Date: Fri, 11 Jul 2014 21:44:35 -0700
Message-ID: <1405140276-32162-3-git-send-email-dturner@twitter.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 06:45:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5pBh-0000Mz-BW
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 06:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbaGLEpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 00:45:17 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39639 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbaGLEpD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 00:45:03 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so2543771pac.11
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 21:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZoMq4XXR/QjCnnuzY5uHq1IhhZJe/Ls9UZk5lL1Uyts=;
        b=WirroJ90esWKp/dV7z/tWyxo6q5dUvSUZBNHPW8jTKzQOAL8xWfhA8pT+EDh2x840+
         eE7FgOxKPRIfIH39KxqWjFer7Tll+h4XMro9KmPwQx2CMdXaEPtE5/EM1ylsefs/jz6b
         vBYo3mhyZiZayaTwKaUamN7N2u8iE1P2Y0jidbVJb0bodRf1Ca1r2RyF6rDiTpsRZ6oM
         gYvlhGBLBR7YksbgiLsWiEi4f21GWDN9LYcB3w8V96TiGtt7/jmvshfWeq8nFxqbFXon
         v79mm52xD4jxSWaQniSZpaKgL8eol+yoQGRYNJ/2OWaMWD7oNiysfRBKmnk15+HtoK48
         wFRQ==
X-Gm-Message-State: ALoCoQkgGPx6P9mS5WZA3y2uGKs1gqKwOzmCZwZ/N+ANpYMlqn7z+hkglLGinUW08S2RWmm0qySy
X-Received: by 10.68.57.140 with SMTP id i12mr3267021pbq.44.1405140302418;
        Fri, 11 Jul 2014 21:45:02 -0700 (PDT)
Received: from stross.twitter.corp (50-206-59-106-static.hfc.comcastbusiness.net. [50.206.59.106])
        by mx.google.com with ESMTPSA id fl6sm16828665pab.43.2014.07.11.21.45.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jul 2014 21:45:01 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1405140276-32162-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253378>

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
