From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] run_external_diff: clean up error handling
Date: Sat, 19 Apr 2014 15:19:19 -0400
Message-ID: <20140419191919.GC8981@sigill.intra.peff.net>
References: <20140419191128.GA9266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:19:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbanO-0001p7-DN
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbaDSTTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:19:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:34496 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754991AbaDSTTV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 15:19:21 -0400
Received: (qmail 26613 invoked by uid 102); 19 Apr 2014 19:19:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Apr 2014 14:19:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Apr 2014 15:19:19 -0400
Content-Disposition: inline
In-Reply-To: <20140419191128.GA9266@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246533>

When the external diff reports an error, we try to clean up
and die. However, we can make this process a bit simpler:

  1. We do not need to bother freeing memory, since we are
     about to exit.  Nor do we need to clean up our
     tempfiles, since the atexit() handler will do it for
     us. So we can die as soon as we see the error.

  3. We can just call die() rather than fprintf/exit. This
     does technically change our exit code, but the exit
     code of "1" is not meaningful here. In fact, it is
     probably wrong, since "1" from diff usually means
     "completed successfully, but there were differences".

And while we're there, we can mark the error message for
translation, and drop the full stop at the end to make it
more like our other messages.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that we do have to update one test, which was expecting difftool to
exit with 1 (and difftool just propagates diff's exit status in this
case). I couldn't find any reasoning in the history for this exit(1),
and it dates all the way back to May 2005. So I do not think it had any
particular purpose, and for the reasons above, I do not think anyone
would be sane to be relying on it.

 diff.c              | 9 +++------
 t/t7800-difftool.sh | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 760fc96..b517d01 100644
--- a/diff.c
+++ b/diff.c
@@ -2905,7 +2905,6 @@ static void run_external_diff(const char *pgm,
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct argv_array env = ARGV_ARRAY_INIT;
-	int retval;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
 	if (one && two) {
@@ -2934,14 +2933,12 @@ static void run_external_diff(const char *pgm,
 	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
 	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
 
-	retval = run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv);
+	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv))
+		die(_("external diff died, stopping at %s"), name);
+
 	remove_tempfile();
 	argv_array_clear(&argv);
 	argv_array_clear(&env);
-	if (retval) {
-		fprintf(stderr, "external diff died, stopping at %s.\n", name);
-		exit(1);
-	}
 }
 
 static int similarity_index(struct diff_filepair *p)
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 5a193c5..dc30a51 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -58,7 +58,7 @@ test_expect_success PERL 'custom tool commands override built-ins' '
 
 test_expect_success PERL 'difftool ignores bad --tool values' '
 	: >expect &&
-	test_expect_code 1 \
+	test_must_fail \
 		git difftool --no-prompt --tool=bad-tool branch >actual &&
 	test_cmp expect actual
 '
-- 
1.9.1.656.ge8a0637
