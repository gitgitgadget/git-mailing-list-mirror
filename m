Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8ABB203BD
	for <e@80x24.org>; Fri, 15 Jul 2016 02:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbcGOCnD (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 22:43:03 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38616 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbcGOCnC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 22:43:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1bNt5a-0007bR-OU; Fri, 15 Jul 2016 11:42:54 +0900
From:	Mike Hommey <mh@glandium.org>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com
Subject: [PATCH] blame: Allow to blame paths freshly added to the index
Date:	Fri, 15 Jul 2016 11:42:54 +0900
Message-Id: <20160715024254.29186-1-mh@glandium.org>
X-Mailer: git-send-email 2.9.1.276.geea30e8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When blaming files, changes in the work tree are taken into account
and displayed as being "Not Committed Yet".

However, when blaming a file that is not known to the current HEAD,
git blame fails with `no such path 'foo' in HEAD`, even when the file
was git add'ed.

This would seem uninteresting with the plain `git blame` case, which
it is, but it becomes useful when using copy detection, and the new file
was created from pieces already in HEAD, moved or copied from other
files.
---
 builtin/blame.c               |  4 +++-
 t/t8003-blame-corner-cases.sh | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1e214bd..0858b18 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2240,7 +2240,9 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 		    sha1_object_info(blob_sha1, NULL) == OBJ_BLOB)
 			return;
 	}
-	die("no such path '%s' in HEAD", path);
+
+	if (cache_name_pos(path, strlen(path)) < 0)
+		die("no such path '%s' in HEAD", path);
 }
 
 static struct commit_list **append_parent(struct commit_list **tail, const unsigned char *sha1)
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index a9b266f..a0a09e2 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -137,6 +137,29 @@ test_expect_success 'blame wholesale copy and more' '
 
 '
 
+test_expect_success 'blame wholesale copy and more in the index' '
+
+	{
+		echo ABC
+		echo DEF
+		echo XXXX
+		echo YYYY
+		echo GHIJK
+	} >horse &&
+	git add horse &&
+	git blame -f -C -C1 -- horse | sed -e "$pick_fc" >current &&
+	{
+		echo mouse-Initial
+		echo mouse-Second
+		echo cow-Fifth
+		echo horse-Not
+		echo mouse-Third
+	} >expected &&
+	test_cmp expected current &&
+	git rm -f horse
+
+'
+
 test_expect_success 'blame path that used to be a directory' '
 	mkdir path &&
 	echo A A A A A >path/file &&
-- 
2.9.1.276.geea30e8

