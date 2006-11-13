X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: [PATCH] Catch errors when writing an index that contains invalid objects.
Date: Mon, 13 Nov 2006 13:50:00 +0000 (UTC)
Message-ID: <11634257782215-git-send-email-j.sixt@eudaptics.com>
References: <11634257784001-git-send-email-j.sixt@eudaptics.com>
Reply-To: Johannes Sixt <j.sixt@eudaptics.com>
NNTP-Posting-Date: Mon, 13 Nov 2006 13:50:00 +0000 (UTC)
Cc: Johannes Sixt <johannes.sixt@telecom.at>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Original-Date: Mo, 13 Nov 2006 14:49:38 +0100
X-Mailer: git-send-email 1.4.1.rc1.g47e5
In-Reply-To: <11634257784001-git-send-email-j.sixt@eudaptics.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31297>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjcC3-0004T8-FM for gcvg-git@gmane.org; Mon, 13 Nov
 2006 14:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754621AbWKMNtn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 08:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754651AbWKMNtm
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 08:49:42 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:37924 "EHLO
 linz.eudaptics.com") by vger.kernel.org with ESMTP id S1754621AbWKMNtm (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 08:49:42 -0500
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4]) by
 linz.eudaptics.com (Postfix) with ESMTP id 743BE9614; Mon, 13 Nov 2006
 14:49:39 +0100 (CET)
Received: by srv.linz.eudaptics (Postfix, from userid 503) id E9A11FE; Mon,
 13 Nov 2006 14:49:38 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

From: Johannes Sixt <johannes.sixt@telecom.at>

If git-write-index is called without --missing-ok, it reports invalid
objects that it finds in the index. But without this patch it dies
right away or may run into an infinite loop.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 cache-tree.c     |    2 ++
 t/t0000-basic.sh |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index a803262..9b73c86 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -282,6 +282,8 @@ static int update_one(struct cache_tree 
 				    baselen + sublen + 1,
 				    missing_ok,
 				    dryrun);
+		if (subcnt < 0)
+			return subcnt;
 		i += subcnt - 1;
 		sub->used = 1;
 	}
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2c9bbb5..6aff0b8 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -209,6 +209,28 @@ test_expect_success \
     'validate object ID for a known tree.' \
     'test "$ptree" = 3c5e5399f3a333eddecce7a9b9465b63f65f51e2'
 
+cat >badobjects <<EOF
+100644 blob 1000000000000000000000000000000000000000	dir/file1
+100644 blob 2000000000000000000000000000000000000000	dir/file2
+100644 blob 3000000000000000000000000000000000000000	dir/file3
+100644 blob 4000000000000000000000000000000000000000	dir/file4
+100644 blob 5000000000000000000000000000000000000000	dir/file5
+EOF
+
+rm .git/index
+test_expect_success \
+    'put invalid objects into the index.' \
+    'git-update-index --index-info < badobjects'
+
+test_expect_failure \
+    'writing this tree without --missing-ok.' \
+    'git-write-tree'
+
+test_expect_success \
+    'writing this tree with --missing-ok.' \
+    'git-write-tree --missing-ok'
+
+
 ################################################################
 rm .git/index
 test_expect_success \
-- 
1.4.1.rc1.g47e5
