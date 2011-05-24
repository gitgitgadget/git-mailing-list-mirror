From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] handle_options(): do not miscount how many arguments
 were used
Date: Tue, 24 May 2011 18:50:35 -0400
Message-ID: <20110524225035.GD24527@sigill.intra.peff.net>
References: <20110524224903.GA16265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 00:50:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP0R0-0004YC-O4
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 00:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686Ab1EXWui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 18:50:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36217
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932302Ab1EXWuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 18:50:37 -0400
Received: (qmail 22801 invoked by uid 107); 24 May 2011 22:50:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 18:50:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 18:50:35 -0400
Content-Disposition: inline
In-Reply-To: <20110524224903.GA16265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174358>

From: Junio C Hamano <gitster@pobox.com>

The handle_options() function advances the base of the argument array and
returns the number of arguments it used. The caller in handle_alias()
wants to reallocate the argv array it passes to this function, and
attempts to do so by subtracting the returned value to compensate for the
change handle_options() makes to the new_argv.

But handle_options() did not correctly count when "-c <config=value>" is
given, causing a wrong pointer to be passed to realloc().

Fix it by saving the original argv at the beginning of handle_options(),
and return the difference between the final value of argv, which will
relieve the places that move the array pointer from the additional burden
of keeping track of "handled" counter.

Noticed-by: Kazuki Tsujimoto
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 git.c                  |    6 ++----
 t/t1300-repo-config.sh |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index a5ef3c6..89721d4 100644
--- a/git.c
+++ b/git.c
@@ -66,7 +66,7 @@ static void commit_pager_choice(void) {
 
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
-	int handled = 0;
+	const char **orig_argv = *argv;
 
 	while (*argc > 0) {
 		const char *cmd = (*argv)[0];
@@ -122,7 +122,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-			handled++;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
@@ -162,9 +161,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 
 		(*argv)++;
 		(*argc)--;
-		handled++;
 	}
-	return handled;
+	return (*argv) - orig_argv;
 }
 
 static int handle_alias(int *argcp, const char ***argv)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index fe7a153..3db5626 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -897,7 +897,7 @@ test_expect_success 'key sanity-checking' '
 	git config foo."ba =z".bar false
 '
 
-test_expect_failure 'git -c works with aliases of builtins' '
+test_expect_success 'git -c works with aliases of builtins' '
 	git config alias.checkconfig "-c foo.check=bar config foo.check" &&
 	echo bar >expect &&
 	git checkconfig >actual &&
-- 
1.7.4.5.7.g2e01
