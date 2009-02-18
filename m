From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] system_path(): simplify using strip_path_suffix(), and
 add suffix "git"
Date: Wed, 18 Feb 2009 16:11:08 +0100 (CET)
Message-ID: <ba10ee3899e1b274c71c91a48a5319d9f18db502.1234969572u.git.johannes.schindelin@gmx.de>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 18 16:13:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZo7B-0005Kd-Sa
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 16:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbZBRPLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 10:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbZBRPLM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 10:11:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:38691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754053AbZBRPLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 10:11:10 -0500
Received: (qmail invoked by alias); 18 Feb 2009 15:11:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 18 Feb 2009 16:11:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197INNgWyl7dCwYHVhi1VQR01p8xY6SpkVNh/Dacx
	2IaEMQwSdb4rPC
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1234969572u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110550>

At least for the author of this patch, the logic in system_path() was
too hard to understand.  Using the function strip_path_suffix() documents
the idea of the code better.

The real change is to add the suffix "git", so that a runtime prefix will
be computed correctly even when the executable was called in /git/ as is
the case in msysGit (Windows insists to search the current directory
before the PATH when looking for an executable).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 exec_cmd.c |   32 +++-----------------------------
 1 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index f234066..f89268b 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -23,35 +23,9 @@ const char *system_path(const char *path)
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
+	if (!prefix && strip_path_suffix(argv0_path, GIT_EXEC_PATH, &prefix) &&
+			strip_path_suffix(argv0_path, BINDIR, &prefix) &&
+			strip_path_suffix(argv0_path, "git", &prefix)) {
 		prefix = PREFIX;
 		fprintf(stderr, "RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
-- 
1.6.1.1.825.g72a9f
