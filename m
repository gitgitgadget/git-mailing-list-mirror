From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 3/4] cache-tree: subdirectory tests
Date: Mon,  7 Jul 2014 17:33:44 -0700
Message-ID: <1404779625-16972-3-git-send-email-dturner@twitter.com>
References: <1404779625-16972-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 02:34:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4JMQ-0007xF-6G
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 02:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbaGHAeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 20:34:11 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:35493 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbaGHAeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 20:34:08 -0400
Received: by mail-qc0-f176.google.com with SMTP id w7so4550740qcr.7
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 17:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6tLbM6hsJV46RszQqU5yOcL1+GlE1tZD516pa/XDDo=;
        b=CR4CN5s55JRNtwtL/YpdLJuDPg7/ze1HIUpqO6JvzvNL6Uf426n01gej0QFYhyjq/q
         40I68or64FIDY8IMuDCHo7I+5HiqlNtrtQb7l6NgHpCn0RRVJkZ6lb2iLCSSnVpOoWpE
         Dh7fDvbLPBcffq6aNwcjNi31NNu+jgG9oprrvY7JWFYM2Ija2Kpu34zhA6X7S9u54138
         t+MSFyTAptjegYBNvbBlz3QpaAXua+BLHbrsKGfxo/caINWLnTJz0kK2NQfBvdTsVsGB
         DLIfE50suyLGeqmrN7ubkJtWqUYFd/xV9Qx7yufVX5vnE16JSl+PUimA9BYZbgZbCqr1
         IdLQ==
X-Gm-Message-State: ALoCoQl1kxtghXfR4Ts3x7VDqY9vZewNhya8T2C7Hzj+/jsoPBI1RPff2EamQJc4N48FnJCBCc02
X-Received: by 10.224.126.70 with SMTP id b6mr56061752qas.74.1404779647716;
        Mon, 07 Jul 2014 17:34:07 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id z14sm77426952qaw.7.2014.07.07.17.34.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jul 2014 17:34:07 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1404779625-16972-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252998>

Add tests to confirm that invalidation of subdirectories neither over-
nor under-invalidates.

Signed-off-by: David Turner <dturner@twitter.com>
---
 t/t0090-cache-tree.sh | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 98fb1ab..496c034 100755
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
+	sed -n -e "s/$_x40/SHA/" -e "s/[0-9]* subtrees//g" -e '/#(ref)/d' -e '/^invalid /p' >actual &&
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
