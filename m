From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 08/18] revert: refactor code into a new pick_commits()
	function
Date: Thu, 25 Nov 2010 22:20:39 +0100
Message-ID: <20101125212050.5188.13304.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrGt-0006kW-P7
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab0KZFy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:54:56 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47590 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab0KZFy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:54:56 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 03571A6209;
	Fri, 26 Nov 2010 06:54:48 +0100 (CET)
X-git-sha1: 003ef050b2fc6bb9b6782bf7bf7fb60709f51146 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162190>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 443b529..1f20251 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -578,36 +578,28 @@ static void read_and_refresh_cache(const char *me)
 	rollback_lock_file(&index_lock);
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv, int revert, int edit)
+static int pick_commits(struct args_info *infos)
 {
-	struct args_info infos;
 	struct rev_info revs;
 	struct commit *commit;
 
-	memset(&infos, 0, sizeof(infos));
-	git_config(git_default_config, NULL);
-	infos.action = revert ? REVERT : CHERRY_PICK;
-	me = revert ? "revert" : "cherry-pick";
-	setenv(GIT_REFLOG_ACTION, me, 0);
-	parse_args(argc, argv, &infos);
-
-	if (infos.allow_ff) {
-		if (infos.signoff)
+	if (infos->allow_ff) {
+		if (infos->signoff)
 			die("cherry-pick --ff cannot be used with --signoff");
-		if (infos.no_commit)
+		if (infos->no_commit)
 			die("cherry-pick --ff cannot be used with --no-commit");
-		if (infos.no_replay)
+		if (infos->no_replay)
 			die("cherry-pick --ff cannot be used with -x");
-		if (infos.edit)
+		if (infos->edit)
 			die("cherry-pick --ff cannot be used with --edit");
 	}
 
 	read_and_refresh_cache(me);
 
-	prepare_revs(&revs, &infos);
+	prepare_revs(&revs, infos);
 
 	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit(&infos, commit);
+		int res = do_pick_commit(infos, commit);
 		if (res)
 			return res;
 	}
@@ -615,6 +607,20 @@ static int revert_or_cherry_pick(int argc, const char **argv, int revert, int ed
 	return 0;
 }
 
+static int revert_or_cherry_pick(int argc, const char **argv, int revert, int edit)
+{
+	struct args_info infos;
+
+	git_config(git_default_config, NULL);
+	me = revert ? "revert" : "cherry-pick";
+	setenv(GIT_REFLOG_ACTION, me, 0);
+	memset(&infos, 0, sizeof(infos));
+	infos.action = revert ? REVERT : CHERRY_PICK;
+	parse_args(argc, argv, &infos);
+
+	return pick_commits(&infos);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	return revert_or_cherry_pick(argc, argv, 1, isatty(0));
-- 
1.7.3.2.504.g59d466
