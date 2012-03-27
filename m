From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Tue, 27 Mar 2012 14:05:03 -0400
Message-ID: <20120327180503.GB4659@sigill.intra.peff.net>
References: <20120327175933.GA1716@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:05:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCalc-0006sr-7W
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab2C0SFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 14:05:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34385
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754428Ab2C0SFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:05:06 -0400
Received: (qmail 5611 invoked by uid 107); 27 Mar 2012 18:05:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 14:05:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 14:05:03 -0400
Content-Disposition: inline
In-Reply-To: <20120327175933.GA1716@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194068>

If git receives an EACCES error while trying to execute an
external command, we currently give up and report the error.
However, the EACCES may be caused by an inaccessible
directory in the user's PATH.

In this case, execvp will skip over the inaccessible
directory and keep searching the PATH. If it finds
something, then that gets executed. Otherwise, the earlier
EACCES is remembered and returned.

However, git does not implement the same rule when looking
up aliases. It will return immediately upon seeing EACCES
from execvp, without trying aliases.  This renders aliases
unusable if there is an inaccessible directory in the PATH.

This patch implements a logical extension of execvp's lookup
rules to aliases. We will try to find aliases even after
execvp returns EACCES. If there is an alias, then we expand
it as usual.  If ther eisn't, then we will remember and
report the EACCES error.

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 3805616..917bc9e 100644
--- a/git.c
+++ b/git.c
@@ -496,7 +496,7 @@ static void execv_dashed_external(const char **argv)
 	 * OK to return. Otherwise, we just pass along the status code.
 	 */
 	status = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE | RUN_CLEAN_ON_EXIT);
-	if (status >= 0 || errno != ENOENT)
+	if (status >= 0 || (errno != ENOENT && errno != EACCES))
 		exit(status);
 
 	argv[0] = tmp;
@@ -586,14 +586,16 @@ int main(int argc, const char **argv)
 		static int done_help = 0;
 		static int was_alias = 0;
 		was_alias = run_argv(&argc, &argv);
-		if (errno != ENOENT)
-			break;
-		if (was_alias) {
+		if (was_alias && (errno == ENOENT || errno == EACCES)) {
 			fprintf(stderr, "Expansion of alias '%s' failed; "
-				"'%s' is not a git command\n",
-				cmd, argv[0]);
+				"'%s'%s\n", cmd, argv[0],
+				errno == ENOENT ?
+				  " is not a git command" :
+				  ": Permission denied");
 			exit(1);
 		}
+		if (errno != ENOENT)
+			break;
 		if (!done_help) {
 			cmd = argv[0] = help_unknown_cmd(cmd);
 			done_help = 1;
-- 
1.7.9.5.5.g9b709b
