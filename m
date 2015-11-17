From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1] blame: avoid checking if a file exists on the working tree if a revision is provided
Date: Mon, 16 Nov 2015 19:07:17 -0600
Message-ID: <1447722437-14937-1-git-send-email-eantoranz@gmail.com>
Cc: max@max630.net, peff@peff.net,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 02:07:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyUk9-0002sc-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 02:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbbKQBH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 20:07:29 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35953 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbKQBH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 20:07:28 -0500
Received: by ykdr82 with SMTP id r82so269024830ykd.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 17:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=H2UOhyyhvB+PLaxq31JdwxtdXVDhm5CeplyS+eSjlZc=;
        b=QddPy6R4b0bHFxGjLftAHosMWTrLI1AO9F9PJ4sNjH94rFICnh7DUD7XAPo4uvS+gZ
         0ShUVjHwQQ1Z2h4RZ8aPd8RJMc+sUSbU0mgA/04obz+wEn5Qt8BrXuqdwt9KxmD6rfwb
         FDX4zz8+VMRbZzFmUU8EMrd60AzGzsvH2JqNEEk2dqt+UtyrX5M1aScilskGgBqI6t4l
         rxj9+v6dTze1oiD6+X/7UmhhqhlQkX2oUnso+FWTqo95dVuIRpnXer8sLTUAEQw4m+3G
         rBhFUZancODpBpI0vm8Dlhn3ZfkPcxafA5kZMEuKvtANDWgZKvM5UsFJSiP1IYw/FpnW
         vCQA==
X-Received: by 10.129.124.130 with SMTP id x124mr37900755ywc.34.1447722447872;
        Mon, 16 Nov 2015 17:07:27 -0800 (PST)
Received: from linuxerio.cabletica.com (ip157-11-15-186.ct.co.cr. [186.15.11.157])
        by smtp.gmail.com with ESMTPSA id e66sm8114143ywd.33.2015.11.16.17.07.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Nov 2015 17:07:27 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281377>

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
 builtin/blame.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 83612f5..db430d5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2683,8 +2683,6 @@ parse_done:
 		argv[argc - 1] = "--";
 
 		setup_work_tree();
-		if (!file_exists(path))
-			die_errno("cannot stat path '%s'", path);
 	}
 
 	revs.disable_stdin = 1;
-- 
2.6.2
