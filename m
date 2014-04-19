From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] run_external_diff: use an argv_array for the environment
Date: Sat, 19 Apr 2014 15:17:25 -0400
Message-ID: <20140419191725.GB8981@sigill.intra.peff.net>
References: <20140419191128.GA9266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbalX-0007jX-89
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbaDSTR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:17:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:34494 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755163AbaDSTR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 15:17:26 -0400
Received: (qmail 26398 invoked by uid 102); 19 Apr 2014 19:17:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Apr 2014 14:17:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Apr 2014 15:17:25 -0400
Content-Disposition: inline
In-Reply-To: <20140419191128.GA9266@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246532>

We currently use static buffers and a static array for
formatting the environment passed to the external diff.
There's nothing wrong in the code, but it is much easier to
verify that it is correct if we use a dynamic argv_array.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index b154284..760fc96 100644
--- a/diff.c
+++ b/diff.c
@@ -2904,11 +2904,9 @@ static void run_external_diff(const char *pgm,
 			      struct diff_options *o)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct argv_array env = ARGV_ARRAY_INIT;
 	int retval;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	const char *env[3] = { NULL };
-	char env_counter[50];
-	char env_total[50];
 
 	if (one && two) {
 		struct diff_tempfile *temp_one, *temp_two;
@@ -2933,15 +2931,13 @@ static void run_external_diff(const char *pgm,
 	}
 	fflush(NULL);
 
-	env[0] = env_counter;
-	snprintf(env_counter, sizeof(env_counter), "GIT_DIFF_PATH_COUNTER=%d",
-		 ++o->diff_path_counter);
-	env[1] = env_total;
-	snprintf(env_total, sizeof(env_total), "GIT_DIFF_PATH_TOTAL=%d", q->nr);
+	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
+	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
 
-	retval = run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env);
+	retval = run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv);
 	remove_tempfile();
 	argv_array_clear(&argv);
+	argv_array_clear(&env);
 	if (retval) {
 		fprintf(stderr, "external diff died, stopping at %s.\n", name);
 		exit(1);
-- 
1.9.1.656.ge8a0637
