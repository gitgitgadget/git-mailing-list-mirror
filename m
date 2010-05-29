From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/4] revert: refactor code into a do_pick_commit() function
Date: Sat, 29 May 2010 06:40:41 +0200
Message-ID: <20100529044044.569.69037.chriscool@tuxfamily.org>
References: <20100529043738.569.85482.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 29 06:41:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIDrb-0007PG-L4
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 06:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123Ab0E2ElX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 00:41:23 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56269 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab0E2ElW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 00:41:22 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4A6B481806B;
	Sat, 29 May 2010 06:41:15 +0200 (CEST)
X-git-sha1: 492411482f6b97ccd46ce9eeff66614d9dc1a674 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100529043738.569.85482.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147954>

This is needed because we are going to make it possible
to cherry-pick many commits instead of just one in the following
commit. And we will be able to do that by just calling
do_pick_commit() one for each commit to cherry-pick.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   52 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9737ad5..70372dc 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -365,7 +365,7 @@ static void do_recursive_merge(struct commit *base, struct commit *next,
 	fprintf(stderr, "Finished one %s.\n", me);
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int do_pick_commit()
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -374,28 +374,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 
-	git_config(git_default_config, NULL);
-	me = action == REVERT ? "revert" : "cherry-pick";
-	setenv(GIT_REFLOG_ACTION, me, 0);
-	parse_args(argc, argv);
-
-	/* this is copied from the shell script, but it's never triggered... */
-	if (action == REVERT && !no_replay)
-		die("revert is incompatible with replay");
-
-	if (allow_ff) {
-		if (signoff)
-			die("cherry-pick --ff cannot be used with --signoff");
-		if (no_commit)
-			die("cherry-pick --ff cannot be used with --no-commit");
-		if (no_replay)
-			die("cherry-pick --ff cannot be used with -x");
-		if (edit)
-			die("cherry-pick --ff cannot be used with --edit");
-	}
-
-	if (read_cache() < 0)
-		die("git %s: failed to read the index", me);
 	if (no_commit) {
 		/*
 		 * We do not intend to commit immediately.  We just want to
@@ -542,6 +520,34 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	return 0;
 }
 
+static int revert_or_cherry_pick(int argc, const char **argv)
+{
+	git_config(git_default_config, NULL);
+	me = action == REVERT ? "revert" : "cherry-pick";
+	setenv(GIT_REFLOG_ACTION, me, 0);
+	parse_args(argc, argv);
+
+	/* this is copied from the shell script, but it's never triggered... */
+	if (action == REVERT && !no_replay)
+		die("revert is incompatible with replay");
+
+	if (allow_ff) {
+		if (signoff)
+			die("cherry-pick --ff cannot be used with --signoff");
+		if (no_commit)
+			die("cherry-pick --ff cannot be used with --no-commit");
+		if (no_replay)
+			die("cherry-pick --ff cannot be used with -x");
+		if (edit)
+			die("cherry-pick --ff cannot be used with --edit");
+	}
+
+	if (read_cache() < 0)
+		die("git %s: failed to read the index", me);
+
+	return do_pick_commit();
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	if (isatty(0))
-- 
1.7.1.346.g7c1d7.dirty
