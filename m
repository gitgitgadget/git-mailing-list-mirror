From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 09/18] revert: make pick_commits() return an error on --ff
	incompatible option
Date: Thu, 25 Nov 2010 22:20:40 +0100
Message-ID: <20101125212050.5188.43278.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIe-0007NM-3G
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab0KZFzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:03 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47647 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab0KZFzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:01 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 80509A61E3;
	Fri, 26 Nov 2010 06:54:54 +0100 (CET)
X-git-sha1: 01d59d9c2f4f67d3ccbbc3a7b2f4252f4cb8605a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162192>

As we want to use pick_commits() many times and write TODO and DONE
file in case of errors, we must not die in case of error inside
pick_commits() but return an error.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1f20251..57d4300 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -578,33 +578,33 @@ static void read_and_refresh_cache(const char *me)
 	rollback_lock_file(&index_lock);
 }
 
+static int ff_incompatible(int val, const char *opt)
+{
+	return val ? error("cherry-pick --ff cannot be used with %s", opt) : 0;
+}
+
 static int pick_commits(struct args_info *infos)
 {
 	struct rev_info revs;
 	struct commit *commit;
+	int res = 0;
 
-	if (infos->allow_ff) {
-		if (infos->signoff)
-			die("cherry-pick --ff cannot be used with --signoff");
-		if (infos->no_commit)
-			die("cherry-pick --ff cannot be used with --no-commit");
-		if (infos->no_replay)
-			die("cherry-pick --ff cannot be used with -x");
-		if (infos->edit)
-			die("cherry-pick --ff cannot be used with --edit");
-	}
+	if (infos->allow_ff &&
+	    ((res = ff_incompatible(infos->signoff, "--signoff")) ||
+	     (res = ff_incompatible(infos->no_commit, "--no_commit")) ||
+	     (res = ff_incompatible(infos->no_replay, "-x")) ||
+	     (res = ff_incompatible(infos->edit, "--edit"))))
+			return res;
 
 	read_and_refresh_cache(me);
 
 	prepare_revs(&revs, infos);
 
-	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit(infos, commit);
-		if (res)
-			return res;
-	}
+	while ((commit = get_revision(&revs)) &&
+	       !(res = do_pick_commit(infos, commit)))
+		; /* do nothing */
 
-	return 0;
+	return res;
 }
 
 static int revert_or_cherry_pick(int argc, const char **argv, int revert, int edit)
-- 
1.7.3.2.504.g59d466
