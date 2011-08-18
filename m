From: Jeff King <peff@peff.net>
Subject: [PATCH 04/10] setup_pager: set GIT_PAGER_IN_USE
Date: Wed, 17 Aug 2011 22:02:29 -0700
Message-ID: <20110818050227.GD2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:02:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtukZ-00076t-Kp
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab1HRFCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:02:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45180
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab1HRFCf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:02:35 -0400
Received: (qmail 18293 invoked by uid 107); 18 Aug 2011 05:03:14 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:03:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:02:29 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179561>

We have always set a global "spawned_pager" variable when we
start the pager. This lets us make the auto-color decision
later in the program as as "we are outputting to a terminal,
or to a pager which can handle colors".

Commit 6e9af86 added support for the GIT_PAGER_IN_USE
environment variable. An external program calling git (e.g.,
git-svn) could set this variable to indicate that it had
already started the pager, and that the decision about
auto-coloring should take that into account.

However, 6e9af86 failed to do the reverse, which is to tell
external programs when git itself has started the pager.
Thus a git command implemented as an external script that
has the pager turned on (e.g., "git -p stash show") would
not realize it was going to a pager, and would suppress
colors.

This patch remedies that; we always set GIT_PAGER_IN_USE
when we start the pager, and the value is respected by both
this program and any spawned children.

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c          |    8 +-------
 t/t7006-pager.sh |   11 +++++++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/pager.c b/pager.c
index dac358f..975955b 100644
--- a/pager.c
+++ b/pager.c
@@ -11,8 +11,6 @@
  * something different on Windows.
  */
 
-static int spawned_pager;
-
 #ifndef WIN32
 static void pager_preexec(void)
 {
@@ -78,7 +76,7 @@ void setup_pager(void)
 	if (!pager)
 		return;
 
-	spawned_pager = 1; /* means we are emitting to terminal */
+	setenv("GIT_PAGER_IN_USE", "true", 1);
 
 	/* spawn the pager */
 	pager_argv[0] = pager;
@@ -109,10 +107,6 @@ void setup_pager(void)
 int pager_in_use(void)
 {
 	const char *env;
-
-	if (spawned_pager)
-		return 1;
-
 	env = getenv("GIT_PAGER_IN_USE");
 	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
 }
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 2ac729f..4884e1b 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -181,6 +181,17 @@ test_expect_success 'color when writing to a file intended for a pager' '
 	colorful colorful.log
 '
 
+test_expect_success TTY 'colors are sent to pager for external commands' '
+	test_config alias.externallog "!git log" &&
+	test_config color.ui auto &&
+	(
+		TERM=vt100 &&
+		export TERM &&
+		test_terminal git -p externallog
+	) &&
+	colorful paginated.out
+'
+
 # Use this helper to make it easy for the caller of your
 # terminal-using function to specify whether it should fail.
 # If you write
-- 
1.7.6.10.g62f04
