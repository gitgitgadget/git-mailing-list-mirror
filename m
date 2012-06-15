From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] fix pager.diff with diff --no-index
Date: Fri, 15 Jun 2012 16:29:48 -0400
Message-ID: <20120615202948.GA12326@sigill.intra.peff.net>
References: <20120615202813.GA12253@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:29:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfd9Y-0001xH-9r
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825Ab2FOU3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 16:29:52 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57780
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757759Ab2FOU3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 16:29:52 -0400
Received: (qmail 3865 invoked by uid 107); 15 Jun 2012 20:29:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 16:29:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 16:29:48 -0400
Content-Disposition: inline
In-Reply-To: <20120615202813.GA12253@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200095>

git-diff does not rely on the git wrapper to setup its
pager; instead, it sets it up on its own after seeing
whether --quiet or --exit-code has been specified.  After
diff_no_index was split off from cmd_diff, commit b3fde6c
(git diff --no-index: default to page like other diff
frontends, 2008-05-26) duplicated the one-liner from
cmd_diff to turn on the pager.

Later, commit 8f0359f (Allow pager of diff command be
enabled/disabled, 2008-07-21) taught the the version in
cmd_diff to respect the pager.diff config, but the version
in diff_no_index was left behind. This meant that

  git -c pager.diff=0 diff a b

would not use a pager, but

  git -c pager.diff=0 diff --no-index a b

would.  Let's fix it by factoring out a common function.

While we're there, let's update the antiquated comment,
which claims that the pager interferes with propagating the
exit code; this has not been the case since ea27a18 (spawn
pager via run_command interface, 2008-07-22).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin.h       |  2 ++
 builtin/diff.c  | 24 +++++++++++++++++-------
 diff-no-index.c |  7 +------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin.h b/builtin.h
index 338f540..e426de3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -41,6 +41,8 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c);
 
 extern int check_pager_config(const char *cmd);
+struct diff_options;
+extern void setup_diff_pager(struct diff_options *);
 
 extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, char **buf, unsigned long *buf_size);
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 9069dc4..da8f6aa 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -304,13 +304,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
-	/*
-	 * If the user asked for our exit code then don't start a
-	 * pager or we would end up reporting its exit code instead.
-	 */
-	if (!DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS) &&
-	    check_pager_config("diff") != 0)
-		setup_pager();
+	setup_diff_pager(&rev.diffopt);
 
 	/*
 	 * Do we have --cached and not have a pending object, then
@@ -421,3 +415,19 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		refresh_index_quietly();
 	return result;
 }
+
+void setup_diff_pager(struct diff_options *opt)
+{
+	/*
+	 * If the user asked for our exit code, then either they want --quiet
+	 * or --exit-code. We should definitely not bother with a pager in the
+	 * former case, as we will generate no output. Since we still properly
+	 * report our exit code even when a pager is run, we _could_ run a
+	 * pager with --exit-code. But since we have not done so historically,
+	 * and because it is easy to find people oneline advising "git diff
+	 * --exit-code" in hooks and other scripts, we do not do so.
+	 */
+	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
+	    check_pager_config("diff") != 0)
+		setup_pager();
+}
diff --git a/diff-no-index.c b/diff-no-index.c
index f0b0010..fc1decd 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -224,12 +224,7 @@ void diff_no_index(struct rev_info *revs,
 		}
 	}
 
-	/*
-	 * If the user asked for our exit code then don't start a
-	 * pager or we would end up reporting its exit code instead.
-	 */
-	if (!DIFF_OPT_TST(&revs->diffopt, EXIT_WITH_STATUS))
-		setup_pager();
+	setup_diff_pager(&revs->diffopt);
 
 	if (prefix) {
 		int len = strlen(prefix);
-- 
1.7.11.rc2.4.g0b9de53
