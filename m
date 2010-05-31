From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/8] revert: refactor code into a do_pick_commit() function
Date: Mon, 31 May 2010 21:42:34 +0200
Message-ID: <20100531194240.28729.42538.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 05:04:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJHmP-0000XE-WA
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 05:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab0FADET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 23:04:19 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:42020 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab0FADEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 23:04:16 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6DADA818023;
	Tue,  1 Jun 2010 05:04:08 +0200 (CEST)
X-git-sha1: 9cf098e3a19ffb36ee5829d968ef72221bff75d3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148064>

This is needed because we are going to make it possible
to cherry-pick many commits instead of just one in the following
commits. And we will be able to do that by just calling
do_pick_commit() once for each commit to cherry-pick.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   44 +++++++++++++++++++++++++-------------------
 1 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9085894..070e02e 100644
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
@@ -374,24 +374,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 
-	git_config(git_default_config, NULL);
-	me = action == REVERT ? "revert" : "cherry-pick";
-	setenv(GIT_REFLOG_ACTION, me, 0);
-	parse_args(argc, argv);
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
@@ -538,6 +520,30 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	return 0;
 }
 
+static int revert_or_cherry_pick(int argc, const char **argv)
+{
+	git_config(git_default_config, NULL);
+	me = action == REVERT ? "revert" : "cherry-pick";
+	setenv(GIT_REFLOG_ACTION, me, 0);
+	parse_args(argc, argv);
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
1.7.1.361.g42de.dirty
