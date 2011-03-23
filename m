From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] pager: save the original stderr when redirecting to pager
Date: Wed, 23 Mar 2011 14:18:53 -0400
Message-ID: <20110323181853.GA17533@sigill.intra.peff.net>
References: <20110323181756.GA17415@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:19:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Se4-0005C1-UY
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 19:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462Ab1CWSS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 14:18:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39347
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756166Ab1CWSSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 14:18:55 -0400
Received: (qmail 8325 invoked by uid 107); 23 Mar 2011 18:19:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 14:19:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 14:18:53 -0400
Content-Disposition: inline
In-Reply-To: <20110323181756.GA17415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169864>

When we redirect stdout to the pager, we also redirect
stderr (if it would otherwise go to the terminal) so that
error messages do not get overwritten by the pager.

However, some stderr output may still want to go to the
terminal, because they are time-sensitive (like progress
reports) and should be overwritten by the pager.

This patch stashes away the original stderr descriptor and
creates a new stdio buffer for it.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |    2 ++
 pager.c |    7 ++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 872bc9b..a6ce524 100644
--- a/cache.h
+++ b/cache.h
@@ -1067,6 +1067,8 @@ extern int pager_use_color;
 extern const char *editor_program;
 extern const char *askpass_program;
 extern const char *excludes_file;
+extern FILE *original_stderr;
+extern int original_stderr_fd;
 
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
diff --git a/pager.c b/pager.c
index dac358f..701926f 100644
--- a/pager.c
+++ b/pager.c
@@ -12,6 +12,8 @@
  */
 
 static int spawned_pager;
+FILE *original_stderr;
+int original_stderr_fd = -1;
 
 #ifndef WIN32
 static void pager_preexec(void)
@@ -97,8 +99,11 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	if (isatty(2))
+	if (isatty(2)) {
+		original_stderr_fd = dup(2);
+		original_stderr = fdopen(original_stderr_fd, "w");
 		dup2(pager_process.in, 2);
+	}
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
-- 
1.7.4.39.ge4c30
