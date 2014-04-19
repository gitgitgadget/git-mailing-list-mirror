From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] run_external_diff: use an argv_array for the command line
Date: Sat, 19 Apr 2014 15:17:06 -0400
Message-ID: <20140419191706.GA8981@sigill.intra.peff.net>
References: <20140419191128.GA9266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Max L <infthi.inbox@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:17:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbalG-0007Lr-Ch
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbaDSTRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:17:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:34491 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755023AbaDSTRI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 15:17:08 -0400
Received: (qmail 26351 invoked by uid 102); 19 Apr 2014 19:17:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Apr 2014 14:17:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Apr 2014 15:17:06 -0400
Content-Disposition: inline
In-Reply-To: <20140419191128.GA9266@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246531>

We currently generate the command-line for the external
command using a fixed-length array of size 10. But if there
is a rename, we actually need 11 elements (10 items, plus a
NULL), and end up writing a random NULL onto the stack.

Rather than bump the limit, let's just an argv_array, which
makes this sort of error impossible.

Noticed-by: Max L <infthi.inbox@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This was actually noticed by a GitHub user, who proposed bumping
the array size to 11:

  https://github.com/git/git/pull/92

Even though this fix is a bigger change, I'd rather do it this way, as
it is more obviously correct to a reader (and it solves the problem
forever). I pulled the name/email from that commit, but please let me
know if you'd prefer to be credited differently.

 diff.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 539997f..b154284 100644
--- a/diff.c
+++ b/diff.c
@@ -16,6 +16,7 @@
 #include "submodule.h"
 #include "ll-merge.h"
 #include "string-list.h"
+#include "argv-array.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -2902,9 +2903,8 @@ static void run_external_diff(const char *pgm,
 			      int complete_rewrite,
 			      struct diff_options *o)
 {
-	const char *spawn_arg[10];
+	struct argv_array argv = ARGV_ARRAY_INIT;
 	int retval;
-	const char **arg = &spawn_arg[0];
 	struct diff_queue_struct *q = &diff_queued_diff;
 	const char *env[3] = { NULL };
 	char env_counter[50];
@@ -2915,23 +2915,22 @@ static void run_external_diff(const char *pgm,
 		const char *othername = (other ? other : name);
 		temp_one = prepare_temp_file(name, one);
 		temp_two = prepare_temp_file(othername, two);
-		*arg++ = pgm;
-		*arg++ = name;
-		*arg++ = temp_one->name;
-		*arg++ = temp_one->hex;
-		*arg++ = temp_one->mode;
-		*arg++ = temp_two->name;
-		*arg++ = temp_two->hex;
-		*arg++ = temp_two->mode;
+		argv_array_push(&argv, pgm);
+		argv_array_push(&argv, name);
+		argv_array_push(&argv, temp_one->name);
+		argv_array_push(&argv, temp_one->hex);
+		argv_array_push(&argv, temp_one->mode);
+		argv_array_push(&argv, temp_two->name);
+		argv_array_push(&argv, temp_two->hex);
+		argv_array_push(&argv, temp_two->mode);
 		if (other) {
-			*arg++ = other;
-			*arg++ = xfrm_msg;
+			argv_array_push(&argv, other);
+			argv_array_push(&argv, xfrm_msg);
 		}
 	} else {
-		*arg++ = pgm;
-		*arg++ = name;
+		argv_array_push(&argv, pgm);
+		argv_array_push(&argv, name);
 	}
-	*arg = NULL;
 	fflush(NULL);
 
 	env[0] = env_counter;
@@ -2940,8 +2939,9 @@ static void run_external_diff(const char *pgm,
 	env[1] = env_total;
 	snprintf(env_total, sizeof(env_total), "GIT_DIFF_PATH_TOTAL=%d", q->nr);
 
-	retval = run_command_v_opt_cd_env(spawn_arg, RUN_USING_SHELL, NULL, env);
+	retval = run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env);
 	remove_tempfile();
+	argv_array_clear(&argv);
 	if (retval) {
 		fprintf(stderr, "external diff died, stopping at %s.\n", name);
 		exit(1);
-- 
1.9.1.656.ge8a0637
