From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v2] blame: avoid checking if a file exists on the working tree if a revision is provided
Date: Mon, 16 Nov 2015 19:29:22 -0600
Message-ID: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
Cc: max@max630.net, peff@peff.net,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 02:29:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyV5f-0000KY-Rn
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 02:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbbKQB3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 20:29:40 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36299 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbKQB3e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 20:29:34 -0500
Received: by ykdr82 with SMTP id r82so269505462ykd.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 17:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SQaUKSWHvFGZhRh/aJf4IyX9ieLvrnVqoyzXF8DUeO8=;
        b=gVtEYAlWjU/6Y2RZptNBWE9VlwOn/o5+toZ6BDZdtvw2ixocQ1eww2h7x16WRJjMya
         rp/cR3HxZXrxtz3zxv/XRQXimaZRORTnJU1x4GraLveyEyknxUrwShzyFFvGaxUmXQSk
         ApDz6w5lBDsLDhPHvtqz58oktu/6Xm8mH15SM77JRQbcggE4td3mW4ADTbUnLXuGBO8y
         HT0v8yWNu5yq5E685bnUTvyK1Rr/SMlX2UOEoChLvsNmwpeuOSDldn/76U1MxYsXshmd
         86jizkGvIxdXRmHsgTQ5vm/CgJrzYvcgpdRbbflb07dteyM9czD7pIBcj+vuWCzm29I4
         boTg==
X-Received: by 10.13.228.65 with SMTP id n62mr39819820ywe.302.1447723773572;
        Mon, 16 Nov 2015 17:29:33 -0800 (PST)
Received: from linuxerio.cabletica.com (ip157-11-15-186.ct.co.cr. [186.15.11.157])
        by smtp.gmail.com with ESMTPSA id m65sm37648448ywf.56.2015.11.16.17.29.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Nov 2015 17:29:32 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281380>

If a file has been deleted/renamed, blame refused to display
blame content even if the path provided does match an existing
blob on said revision.

$ git status
On branch hide
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        deleted:    testfile1.txt

no changes added to commit (use "git add" and/or "git commit -a")

Before:
$ git blame testfile1.txt
fatal: cannot stat path 'testfile1.txt': No such file or directory
$ git blame testfile1.txt HEAD
fatal: cannot stat path 'testfile1.txt': No such file or directory

After:
$ git blame testfile1.txt
fatal: Cannot lstat 'testfile1.txt': No such file or directory
$ git blame testfile1.txt HEAD
^da1a96f testfile2.txt (Edmundo Carmona Antoranz 2015-11-10 17:52:00 -0600 1) testfile 2
^da1a96f testfile2.txt (Edmundo Carmona Antoranz 2015-11-10 17:52:00 -0600 2)
^da1a96f testfile2.txt (Edmundo Carmona Antoranz 2015-11-10 17:52:00 -0600 3) Some content

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/blame.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 83612f5..856971a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2683,12 +2683,13 @@ parse_done:
 		argv[argc - 1] = "--";
 
 		setup_work_tree();
-		if (!file_exists(path))
-			die_errno("cannot stat path '%s'", path);
 	}
 
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
+	if (!revs.pending.nr && !file_exists(path))
+		die_errno("cannot stat path '%s'", path);
+
 	memset(&sb, 0, sizeof(sb));
 
 	sb.revs = &revs;
-- 
2.6.2
