From: Jeff King <peff@peff.net>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 01:27:33 -0500
Message-ID: <20071211062733.GA21768@coredump.intra.peff.net>
References: <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org> <20071210234941.GE22254@coredump.intra.peff.net> <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org> <20071211061743.GA21718@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:27:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yaz-0000O1-Ol
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXLKG1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbXLKG1h
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:27:37 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1692 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbXLKG1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:27:36 -0500
Received: (qmail 6633 invoked by uid 111); 11 Dec 2007 06:27:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 11 Dec 2007 01:27:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 01:27:33 -0500
Content-Disposition: inline
In-Reply-To: <20071211061743.GA21718@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67802>

Subject: [PATCH 1/2] Support GIT_PAGER_IN_USE environment variable

When deciding whether or not to turn on automatic color
support, git_config_colorbool checks whether stdout is a
tty. However, because we run a pager, if stdout is not a
tty, we must check whether it is because we started the
pager. This used to be done by checking the pager_in_use
variable.

This variable was set only when the git program being run
started the pager; there was no way for an external program
running git indicate that it had already started a pager.
This patch allows a program to set GIT_PAGER_IN_USE to a
true value to indicate that even though stdout is not a tty,
it is because a pager is being used.

Signed-off-by: Jeff King <peff@peff.net>
---

A few notes:

We could also just put the color.pager logic in git-svn, or in Git.pm,
and have it impact the stdout_is_tty argument; but the whole point of
--get-colorbool is to consolidate that logic.

We convert pager_in_use to a function; we could also just set the
variable early on, but I think this lazy evaluation is more robust.

This might have uses besides --get-colorbool (e.g., wrapper scripts
which start their own pager can still have git sub-commands understand
whether to turn on color).

 cache.h       |    2 +-
 color.c       |    2 +-
 environment.c |    1 -
 pager.c       |   15 ++++++++++++++-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 1bcb3df..27d90fe 100644
--- a/cache.h
+++ b/cache.h
@@ -608,7 +608,7 @@ extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char
 /* pager.c */
 extern void setup_pager(void);
 extern char *pager_program;
-extern int pager_in_use;
+extern int pager_in_use(void);
 extern int pager_use_color;
 
 extern char *editor_program;
diff --git a/color.c b/color.c
index 7bd424a..7f66c29 100644
--- a/color.c
+++ b/color.c
@@ -135,7 +135,7 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
  auto_color:
 	if (stdout_is_tty < 0)
 		stdout_is_tty = isatty(1);
-	if (stdout_is_tty || (pager_in_use && pager_use_color)) {
+	if (stdout_is_tty || (pager_in_use() && pager_use_color)) {
 		char *term = getenv("TERM");
 		if (term && strcmp(term, "dumb"))
 			return 1;
diff --git a/environment.c b/environment.c
index f3e3d41..18a1c4e 100644
--- a/environment.c
+++ b/environment.c
@@ -31,7 +31,6 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 16 * 1024 * 1024;
 char *pager_program;
-int pager_in_use;
 int pager_use_color = 1;
 char *editor_program;
 char *excludes_file;
diff --git a/pager.c b/pager.c
index fb7a1a6..0376953 100644
--- a/pager.c
+++ b/pager.c
@@ -5,6 +5,8 @@
  * something different on Windows, for example.
  */
 
+static int spawned_pager;
+
 static void run_pager(const char *pager)
 {
 	/*
@@ -41,7 +43,7 @@ void setup_pager(void)
 	else if (!*pager || !strcmp(pager, "cat"))
 		return;
 
-	pager_in_use = 1; /* means we are emitting to terminal */
+	spawned_pager = 1; /* means we are emitting to terminal */
 
 	if (pipe(fd) < 0)
 		return;
@@ -70,3 +72,14 @@ void setup_pager(void)
 	die("unable to execute pager '%s'", pager);
 	exit(255);
 }
+
+int pager_in_use(void)
+{
+	const char *env;
+
+	if (spawned_pager)
+		return 1;
+
+	env = getenv("GIT_PAGER_IN_USE");
+	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
+}
-- 
1.5.3.7.2230.g796d07-dirty
