From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH v2] git push: Interpret $GIT_DIR/branches in a Cogito compatible way
Date: Tue, 11 Nov 2008 22:51:00 +0100
Message-ID: <1226440260-26943-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 22:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L019q-0002xC-2c
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 22:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbYKKVvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 16:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbYKKVvF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 16:51:05 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:52973 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYKKVvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 16:51:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 2FB80680437E;
	Tue, 11 Nov 2008 22:51:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q-wVvatBeoFO; Tue, 11 Nov 2008 22:51:01 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0BD6968018C8; Tue, 11 Nov 2008 22:51:00 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100684>

Current git versions ignore everything after # (called <head> in the
following) when pushing. Older versions (before cf818348f1ab57),
interpret #<head> as part of the URL, which make git bail out.

As branches origin from Cogito, it is the best to correct this by
using the behaviour of cg-push:

push HEAD to remote refs/heads/<head>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
Rebased to maint. One line dropped from commit message. Fixed typo,
reported by Mike Ralphson. 

urls-remote.txt is unchanged between maint and next.
remote.c contains no changes in read_branches_file.
t5516 needed a manual invention.

Apart from merge problems (test ordering) in t5516, it should apply 
to master or next too.

 Documentation/urls-remotes.txt |   19 +++++++++++----
 remote.c                       |   11 ++++++++
 t/t5516-fetch-push.sh          |   50 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 504ae8a..41ec777 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -68,13 +68,22 @@ This file should have the following format:
 ------------
 
 `<url>` is required; `#<head>` is optional.
-When you do not provide a refspec on the command line,
-git will use the following refspec, where `<head>` defaults to `master`,
-and `<repository>` is the name of this file
-you provided in the command line.
+
+Depending on the operation, git will use one of the following
+refspecs, if you don't provide one on the command line.
+`<branch>` is the name of this file in `$GIT_DIR/branches` and
+`<head>` defaults to `master`.
+
+git fetch uses:
+
+------------
+	refs/heads/<head>:refs/heads/<branch>
+------------
+
+git push uses:
 
 ------------
-	refs/heads/<head>:<repository>
+	HEAD:refs/heads/<head>
 ------------
 
 
diff --git a/remote.c b/remote.c
index 7688f3b..91f1b7c 100644
--- a/remote.c
+++ b/remote.c
@@ -298,6 +298,17 @@ static void read_branches_file(struct remote *remote)
 	}
 	add_url_alias(remote, p);
 	add_fetch_refspec(remote, strbuf_detach(&branch, 0));
+	/*
+	 * Cogito compatible push: push current HEAD to remote #branch
+	 * (master if missing)
+	 */
+	strbuf_init(&branch, 0);
+	strbuf_addstr(&branch, "HEAD");
+	if (frag)
+		strbuf_addf(&branch, ":refs/heads/%s", frag);
+	else
+		strbuf_addstr(&branch, ":refs/heads/master");
+	add_push_refspec(remote, strbuf_detach(&branch, 0));
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 598664c..f9e8780 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -494,4 +494,54 @@ test_expect_success 'allow deleting an invalid remote ref' '
 
 '
 
+test_expect_success 'fetch with branches' '
+	mk_empty &&
+	git branch second $the_first_commit &&
+	git checkout second &&
+	echo ".." > testrepo/.git/branches/branch1 &&
+	(cd testrepo &&
+		git fetch branch1 &&
+		r=$(git show-ref -s --verify refs/heads/branch1) &&
+		test "z$r" = "z$the_commit" &&
+		test 1 = $(git for-each-ref refs/heads | wc -l)
+	) &&
+	git checkout master
+'
+
+test_expect_success 'fetch with branches containing #' '
+	mk_empty &&
+	echo "..#second" > testrepo/.git/branches/branch2 &&
+	(cd testrepo &&
+		git fetch branch2 &&
+		r=$(git show-ref -s --verify refs/heads/branch2) &&
+		test "z$r" = "z$the_first_commit" &&
+		test 1 = $(git for-each-ref refs/heads | wc -l)
+	) &&
+	git checkout master
+'
+
+test_expect_success 'push with branches' '
+	mk_empty &&
+	git checkout second &&
+	echo "testrepo" > .git/branches/branch1 &&
+	git push branch1 &&
+	(cd testrepo &&
+		r=$(git show-ref -s --verify refs/heads/master) &&
+		test "z$r" = "z$the_first_commit" &&
+		test 1 = $(git for-each-ref refs/heads | wc -l)
+	)
+'
+
+test_expect_success 'push with branches containing #' '
+	mk_empty &&
+	echo "testrepo#branch3" > .git/branches/branch2 &&
+	git push branch2 &&
+	(cd testrepo &&
+		r=$(git show-ref -s --verify refs/heads/branch3) &&
+		test "z$r" = "z$the_first_commit" &&
+		test 1 = $(git for-each-ref refs/heads | wc -l)
+	) &&
+	git checkout master
+'
+
 test_done
-- 
1.5.6.5
