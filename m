Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B6D1F462
	for <e@80x24.org>; Tue, 21 May 2019 23:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfEUXWV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 19:22:21 -0400
Received: from buzz.no-dns-yet.org.uk ([81.187.49.251]:57388 "EHLO
        buzz.no-dns-yet.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEUXWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 19:22:21 -0400
X-Greylist: delayed 1921 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 19:22:20 EDT
Received: from simon by buzz.no-dns-yet.org.uk with local (Exim 4.90_1)
        (envelope-from <simon@no-dns-yet.org.uk>)
        id 1hTDaK-0000DF-OJ; Tue, 21 May 2019 23:50:16 +0100
Date:   Tue, 21 May 2019 23:50:16 +0100
From:   Simon Williams <simon@no-dns-yet.org.uk>
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-p4: Allow unshelving of branched files
Message-ID: <20190521225016.GA32526@buzz.no-dns-yet.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When unshelving a changelist, git-p4 tries to work out the appropriate
parent commit in a given branch (default: HEAD).  To do this, it looks
at the state of any pre-existing files in the target Perforce branch,
omiting files added in the shelved changelist.  Currently, only files
added (or move targets) are classed as new.  However, files integrated
from other branches (i.e. a 'branch' action) also need to be considered
as added, for this purpose.

Signed-off-by: Simon Williams <simon@no-dns-yet.org.uk>
---
 git-p4.py           | 2 +-
 t/t9832-unshelve.sh | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 5b79920f46..81a525858b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1309,7 +1309,7 @@ def processContent(self, git_mode, relPath, contents):
 
 class Command:
     delete_actions = ( "delete", "move/delete", "purge" )
-    add_actions = ( "add", "move/add" )
+    add_actions = ( "add", "branch", "move/add" )
 
     def __init__(self):
         self.usage = "usage: %prog [options]"
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index 41c09f11f4..cde9f86cd6 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -22,7 +22,10 @@ test_expect_success 'init depot' '
 		: >file_to_move &&
 		p4 add file_to_delete &&
 		p4 add file_to_move &&
-		p4 submit -d "add files to delete"
+		p4 submit -d "add files to delete" &&
+		echo file_to_integrate >file_to_integrate &&
+		p4 add file_to_integrate &&
+		p4 submit -d "add file to integrate"
 	)
 '
 
@@ -40,6 +43,7 @@ test_expect_success 'create shelved changelist' '
 		p4 delete file_to_delete &&
 		p4 edit file_to_move &&
 		p4 move file_to_move moved_file &&
+		p4 integrate file_to_integrate integrated_file &&
 		p4 opened &&
 		p4 shelve -i <<EOF
 Change: new
@@ -53,6 +57,7 @@ Files:
 	//depot/file_to_delete
 	//depot/file_to_move
 	//depot/moved_file
+	//depot/integrated_file
 EOF
 
 	) &&
@@ -65,6 +70,7 @@ EOF
 		test_path_is_file file2 &&
 		test_cmp file1 "$cli"/file1 &&
 		test_cmp file2 "$cli"/file2 &&
+		test_cmp file_to_integrate "$cli"/integrated_file &&
 		test_path_is_missing file_to_delete &&
 		test_path_is_missing file_to_move &&
 		test_path_is_file moved_file
-- 
2.17.1


-- 
Simon Williams <simon@no-dns-yet.org.uk>
PGP Key ID: 0xF4A23C69

