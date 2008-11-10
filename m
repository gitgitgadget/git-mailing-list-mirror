From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] git push: Interpret $GIT_DIR/branches in a Cogito compatible way
Date: Mon, 10 Nov 2008 22:47:11 +0100
Message-ID: <1226353631-3716-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 22:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzecX-0004Cx-Kr
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 22:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbYKJVrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 16:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbYKJVrO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 16:47:14 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:44051 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbYKJVrN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 16:47:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id B273B6805045;
	Mon, 10 Nov 2008 22:47:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mLPKFfHOkVz; Mon, 10 Nov 2008 22:47:11 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 84E7168018C8; Mon, 10 Nov 2008 22:47:11 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100580>

Current git versions ignore everything after # (called <head> in the
following) when pushing. Older versions (before cf818348f1ab57),
interpret #<head> as part of the URL, which make git bail out.

Ignoring the <head> part for push (fetch respects them) is unlogical.
As branches origin from Cogito, it is the best to correct this by
using the behaviour of cg-push:

push HEAD to remote refs/heads/<head>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Documentation/urls-remotes.txt |   19 +++++++++++----
 remote.c                       |   11 ++++++++
 t/t5516-fetch-push.sh          |   50 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 504ae8a..d9e284c 100644
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
+refsprecs, if you don't provide one on the command line.
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
index e530a21..660b2ce 100644
--- a/remote.c
+++ b/remote.c
@@ -297,6 +297,17 @@ static void read_branches_file(struct remote *remote)
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
index a6532cb..4426df9 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -523,4 +523,54 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 	! grep "warning.*this may cause confusion" stderr
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
