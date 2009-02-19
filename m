From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/2] system_path(): simplify using strip_path_suffix(),
 and add suffix "git"
Date: Thu, 19 Feb 2009 20:10:53 +0100 (CET)
Message-ID: <b91ca090ef4eed9e457b579df2e3fbede3d26299.1235070304u.git.johannes.schindelin@gmx.de>
References: <499C63E7.5040306@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 19 20:11:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaEJA-00010m-BY
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 20:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbZBSTJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 14:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbZBSTJ6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 14:09:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:48805 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750984AbZBSTJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 14:09:57 -0500
Received: (qmail invoked by alias); 19 Feb 2009 19:09:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 19 Feb 2009 20:09:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18r8xBs9Q4rs9aZDweL7akR0DXNUOEoJpk5/SGo8P
	dRd8nAeYFTi+k7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <499C63E7.5040306@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110733>

At least for the author of this patch, the logic in system_path() was
too hard to understand.  Using the function strip_path_suffix() documents
the idea of the code better.

The real change is to add the suffix "git", so that a runtime prefix will
be computed correctly even when the executable was called in /git/ as is
the case in msysGit (Windows insists to search the current directory
before the PATH when looking for an executable).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 exec_cmd.c |   33 ++++-----------------------------
 1 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index f234066..217c125 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -23,35 +23,10 @@ const char *system_path(const char *path)
 	assert(argv0_path);
 	assert(is_absolute_path(argv0_path));
 
-	if (!prefix) {
-		const char *strip[] = {
-			GIT_EXEC_PATH,
-			BINDIR,
-			0
-		};
-		const char **s;
-
-		for (s = strip; *s; s++) {
-			const char *sargv = argv0_path + strlen(argv0_path);
-			const char *ss = *s + strlen(*s);
-			while (argv0_path < sargv && *s < ss
-				&& (*sargv == *ss ||
-				    (is_dir_sep(*sargv) && is_dir_sep(*ss)))) {
-				sargv--;
-				ss--;
-			}
-			if (*s == ss) {
-				struct strbuf d = STRBUF_INIT;
-				/* We also skip the trailing directory separator. */
-				assert(sargv - argv0_path - 1 >= 0);
-				strbuf_add(&d, argv0_path, sargv - argv0_path - 1);
-				prefix = strbuf_detach(&d, NULL);
-				break;
-			}
-		}
-	}
-
-	if (!prefix) {
+	if (!prefix &&
+	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
+	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
+	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
 		prefix = PREFIX;
 		fprintf(stderr, "RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
-- 
1.6.2.rc1.380.g0299c
