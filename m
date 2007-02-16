From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] pager: use an environment variable for pager_in_use
Date: Fri, 16 Feb 2007 19:22:31 +0100
Message-ID: <20070216182231.GA31676@moooo.ath.cx>
References: <20070216151925.GA28974@moooo.ath.cx> <20070216155658.GB7183@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 19:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI7jx-0001lO-Vg
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 19:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946191AbXBPSWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 13:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946190AbXBPSWj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 13:22:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:33340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946189AbXBPSWh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 13:22:37 -0500
Received: (qmail invoked by alias); 16 Feb 2007 18:22:36 -0000
X-Provags-ID: V01U2FsdGVkX1/+znwLO7L+eugOSKHqgtProM9aaw/3iKYHCr1pJu
	UnMg==
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070216155658.GB7183@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39936>

When running a shell script the value of pager_in_use is
lost for later processes.  Therefore pager_in_use is
replaced by the environment variable GIT_PAGER_IN_USE.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---

Jeff King <peff@peff.net> wrote:
> Your analysis looks right to me.  I think you would need to set
> GIT_PAGER_IN_USE in the environment whenever you turn on the pager in
> the git wrapper, and then set git's internal pager_in_use variable based
> on that.
This patch replaces pager_in_use because pager_in_use was only used at
two places (one sets it, the other reads it).
---
 cache.h       |    1 -
 color.c       |    2 +-
 environment.c |    1 -
 pager.c       |    3 ++-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index c62b0b0..aeaac9f 100644
--- a/cache.h
+++ b/cache.h
@@ -445,7 +445,6 @@ extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char
 
 /* pager.c */
 extern void setup_pager(void);
-extern int pager_in_use;
 extern int pager_use_color;
 
 /* base85 */
diff --git a/color.c b/color.c
index 09d82ee..50e073a 100644
--- a/color.c
+++ b/color.c
@@ -121,7 +121,7 @@ int git_config_colorbool(const char *var, const char *value)
 	if (!value)
 		return 1;
 	if (!strcasecmp(value, "auto")) {
-		if (isatty(1) || (pager_in_use && pager_use_color)) {
+		if (isatty(1) || (getenv("GIT_PAGER_IN_USE") && pager_use_color)) {
 			char *term = getenv("TERM");
 			if (term && strcmp(term, "dumb"))
 				return 1;
diff --git a/environment.c b/environment.c
index 54c22f8..5b477c3 100644
--- a/environment.c
+++ b/environment.c
@@ -26,7 +26,6 @@ const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
-int pager_in_use;
 int pager_use_color = 1;
 
 static const char *git_dir;
diff --git a/pager.c b/pager.c
index 5f280ab..f59c94f 100644
--- a/pager.c
+++ b/pager.c
@@ -38,7 +38,8 @@ void setup_pager(void)
 	else if (!*pager || !strcmp(pager, "cat"))
 		return;
 
-	pager_in_use = 1; /* means we are emitting to terminal */
+	/* means we are emitting to terminal */
+	setenv("GIT_PAGER_IN_USE", "1", 0);
 
 	if (pipe(fd) < 0)
 		return;
-- 
1.5.0
