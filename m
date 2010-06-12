From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] commit: use value of GIT_REFLOG_ACTION env variable as reflog
	message
Date: Sat, 12 Jun 2010 18:42:35 +0200
Message-ID: <20100612164236.4195.23396.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Kristian Hogsberg <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:43:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTnr-0001LJ-Fv
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab0FLQnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 12:43:23 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:43201 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab0FLQnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 12:43:22 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1AA27818141;
	Sat, 12 Jun 2010 18:43:14 +0200 (CEST)
X-git-sha1: 77401439e6ba196282e0dd9666ba32471c90fd68 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149021>

The environment variable GIT_REFLOG_ACTION was used by git-commit.sh,
but when it was converted to a builtin
(f5bbc3225c4b073a7ff3218164a0c820299bc9c6, Port git commit to C,
Nov 8 2007) this was lost.

Let's use it again as it is more user friendly when reverting or
cherry-picking to see "revert" or "cherry-pick" in the reflog rather
than to just see "commit".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/commit.c              |   13 +++++++++----
 t/t3501-revert-cherry-pick.sh |    6 ++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9d21904..1de1bc8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1257,13 +1257,16 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Determine parents */
+	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (initial_commit) {
-		reflog_msg = "commit (initial)";
+		if (!reflog_msg)
+			reflog_msg = "commit (initial)";
 	} else if (amend) {
 		struct commit_list *c;
 		struct commit *commit;
 
-		reflog_msg = "commit (amend)";
+		if (!reflog_msg)
+			reflog_msg = "commit (amend)";
 		commit = lookup_commit(head_sha1);
 		if (!commit || parse_commit(commit))
 			die("could not parse HEAD commit");
@@ -1274,7 +1277,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		struct strbuf m = STRBUF_INIT;
 		FILE *fp;
 
-		reflog_msg = "commit (merge)";
+		if (!reflog_msg)
+			reflog_msg = "commit (merge)";
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 		fp = fopen(git_path("MERGE_HEAD"), "r");
 		if (fp == NULL)
@@ -1297,7 +1301,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (allow_fast_forward)
 			parents = reduce_heads(parents);
 	} else {
-		reflog_msg = "commit";
+		if (!reflog_msg)
+			reflog_msg = "commit";
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 	}
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 7f85815..e4fbf7a 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -47,7 +47,8 @@ test_expect_success 'cherry-pick after renaming branch' '
 	git cherry-pick added &&
 	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
 	test -f opos &&
-	grep "Add extra line at the end" opos
+	grep "Add extra line at the end" opos &&
+	git reflog -1 | grep cherry-pick
 
 '
 
@@ -57,7 +58,8 @@ test_expect_success 'revert after renaming branch' '
 	git revert added &&
 	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
 	test -f spoo &&
-	! grep "Add extra line at the end" spoo
+	! grep "Add extra line at the end" spoo &&
+	git reflog -1 | grep revert
 
 '
 
-- 
1.7.1.468.g58a2d
