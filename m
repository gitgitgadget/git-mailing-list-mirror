From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] revert: refactor code that prints success or failure
	message
Date: Mon, 12 Jul 2010 13:54:53 +0200
Message-ID: <20100712115455.12251.53947.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 16:56:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYKQI-0007F6-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 16:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927Ab0GLOzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 10:55:53 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:40345 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755544Ab0GLOzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 10:55:52 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f08.orange.fr (SMTP Server) with ESMTP id 1845A800113E;
	Mon, 12 Jul 2010 16:55:50 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f08.orange.fr (SMTP Server) with ESMTP id 0B025800110C;
	Mon, 12 Jul 2010 16:55:50 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-89.w90-12.abo.wanadoo.fr [90.12.251.89])
	by mwinf2f08.orange.fr (SMTP Server) with ESMTP id 520B68001131;
	Mon, 12 Jul 2010 16:55:49 +0200 (CEST)
X-ME-UUID: 20100712145549336.520B68001131@mwinf2f08.orange.fr
X-git-sha1: e03434a4e41e2640055fc3068e174845be029fdf 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150818>

This patch refactors the code that prints a message like
"Automatic cherry-pick failed. <help message>". This code was
duplicated in both do_recursive_merge() and do_pick_commit().

To do that, now do_recursive_merge() returns an int to signal
success or failure. And in case of failure we just return 1
from do_pick_commit() instead of doing "exit(1)" from either
do_recursive_merge() or do_pick_commit().

In case of successful merge, do_recursive_merge() used to print
something like "Finished one cherry-pick." but nothing was
printed in case a special strategy like "resolve" was used.
Now in this case a message like "Finished one cherry-pick with
strategy resolve." is printed.

So the command behavior should be more consistent wether we are
using a special strategy or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
	I also wonder why messages like "Finished one cherry-pick."
	are printed on stderr instead of stdout.
	Maybe this could be changed in this patch or in
	another one.

	And while at making a backward incompatible change, maybe
	we could change the message to something like:

	"Finished cherry-pick <sha1>"

 builtin/revert.c                    |   51 ++++++++++++++++++++---------------
 t/t3508-cherry-pick-many-commits.sh |   26 +++++++++++++++++-
 2 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8b9d829..b082bb4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -311,10 +311,9 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from)
 	return write_ref_sha1(ref_lock, to, "cherry-pick");
 }
 
-static void do_recursive_merge(struct commit *base, struct commit *next,
-			       const char *base_label, const char *next_label,
-			       unsigned char *head, struct strbuf *msgbuf,
-			       char *defmsg)
+static int do_recursive_merge(struct commit *base, struct commit *next,
+			      const char *base_label, const char *next_label,
+			      unsigned char *head, struct strbuf *msgbuf)
 {
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
@@ -357,14 +356,9 @@ static void do_recursive_merge(struct commit *base, struct commit *next,
 					i++;
 			}
 		}
-		write_message(msgbuf, defmsg);
-		fprintf(stderr, "Automatic %s failed.%s\n",
-			me, help_msg());
-		rerere(allow_rerere_auto);
-		exit(1);
 	}
-	write_message(msgbuf, defmsg);
-	fprintf(stderr, "Finished one %s.\n", me);
+
+	return !clean;
 }
 
 static int do_pick_commit(void)
@@ -375,6 +369,8 @@ static int do_pick_commit(void)
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
+	struct strbuf mebuf = STRBUF_INIT;
+	int res;
 
 	if (no_commit) {
 		/*
@@ -470,30 +466,41 @@ static int do_pick_commit(void)
 		}
 	}
 
-	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT)
-		do_recursive_merge(base, next, base_label, next_label,
-				   head, &msgbuf, defmsg);
-	else {
-		int res;
+	strbuf_addstr(&mebuf, me);
+
+	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
+		res = do_recursive_merge(base, next, base_label, next_label,
+					 head, &msgbuf);
+		write_message(&msgbuf, defmsg);
+	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
+
+		strbuf_addf(&mebuf, " with strategy %s", strategy);
 		write_message(&msgbuf, defmsg);
+
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
 		res = try_merge_command(strategy, common,
 					sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
-		if (res) {
-			fprintf(stderr, "Automatic %s with strategy %s failed.%s\n",
-				me, strategy, help_msg());
-			rerere(allow_rerere_auto);
-			exit(1);
-		}
 	}
 
+	if (res) {
+		fprintf(stderr, "Automatic %s failed.%s\n",
+			mebuf.buf, help_msg());
+		rerere(allow_rerere_auto);
+	} else {
+		fprintf(stderr, "Finished one %s.\n", mebuf.buf);
+	}
+
+	strbuf_release(&mebuf);
 	free_message(&msg);
 
+	if (res)
+		return 1;
+
 	/*
 	 *
 	 * If we are cherry-pick, and if the merge did not result in
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index f90ed3d..6555f92 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -23,12 +23,36 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick first..fourth works' '
+	cat <<-EOF > expected &&
+	Finished one cherry-pick.
+	Finished one cherry-pick.
+	Finished one cherry-pick.
+	EOF
+
+	git checkout -f master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick first..fourth 2>actual &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+	test_cmp expected actual &&
+	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
+'
+
+test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
+	cat <<-EOF > expected &&
+	Finished one cherry-pick with strategy resolve.
+	Finished one cherry-pick with strategy resolve.
+	Finished one cherry-pick with strategy resolve.
+	EOF
+
 	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
-	git cherry-pick first..fourth &&
+	git cherry-pick --strategy resolve first..fourth 2>actual &&
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
+	test_cmp expected actual &&
 	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
 '
 
-- 
1.7.2.rc1.213.gf3fb81
