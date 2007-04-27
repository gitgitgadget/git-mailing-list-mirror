From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Apply mailmap in git-blame output.
Date: Fri, 27 Apr 2007 00:54:17 -0700
Message-ID: <117766045855-git-send-email-junkio@cox.net>
References: <11776604573799-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 09:54:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhLHo-0008Et-4w
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 09:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbXD0HyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 03:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbXD0HyX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 03:54:23 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51150 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462AbXD0HyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 03:54:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427075419.WVTF24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Fri, 27 Apr 2007 03:54:19 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id s7uJ1W0011kojtg0000200; Fri, 27 Apr 2007 03:54:18 -0400
X-Mailer: git-send-email 1.5.2.rc0.765.g34a89
In-Reply-To: <11776604573799-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45698>

This makes git-blame to use the same mailmap used by
git-shortlog.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-blame.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index c2919b3..3d7590f 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -17,14 +17,17 @@
 #include "xdiff-interface.h"
 #include "cache-tree.h"
 #include "log-tree.h"
+#include "path-list.h"
+#include "mailmap.h"
 
 static char blame_usage[] =
-"git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
+"git-blame [-c] [-b] [-l] [--root] [-x] [-t] [-f] [-n] [-s] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
 "  -c                  Use the same output mode as git-annotate (Default: off)\n"
 "  -b                  Show blank SHA-1 for boundary commits (Default: off)\n"
 "  -l                  Show long commit SHA1 (Default: off)\n"
 "  --root              Do not treat root commits as boundaries (Default: off)\n"
 "  -t                  Show raw timestamp (Default: off)\n"
+"  -x                  Do not use .mailmap file\n"
 "  -f, --show-name     Show original filename (Default: auto)\n"
 "  -n, --show-number   Show original linenumber (Default: off)\n"
 "  -s                  Suppress author name and timestamp (Default: off)\n"
@@ -45,7 +48,9 @@ static int show_root;
 static int blank_boundary;
 static int incremental;
 static int cmd_is_annotate;
+static int no_mailmap;
 static int log;
+static struct path_list mailmap;
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -1386,8 +1391,8 @@ static void get_ac_line(const char *inbuf, const char *what,
 			int bufsz, char *person, const char **mail,
 			unsigned long *time, const char **tz)
 {
-	int len;
-	char *tmp, *endp;
+	int len, tzlen, maillen;
+	char *tmp, *endp, *timepos;
 
 	tmp = strstr(inbuf, what);
 	if (!tmp)
@@ -1413,17 +1418,42 @@ static void get_ac_line(const char *inbuf, const char *what,
 	while (*tmp != ' ')
 		tmp--;
 	*tz = tmp+1;
+	tzlen = (person+len)-(tmp+1);
 
 	*tmp = 0;
 	while (*tmp != ' ')
 		tmp--;
 	*time = strtoul(tmp, NULL, 10);
+	timepos = tmp;
 
 	*tmp = 0;
 	while (*tmp != ' ')
 		tmp--;
 	*mail = tmp + 1;
 	*tmp = 0;
+	maillen = timepos - tmp;
+
+	if (!mailmap.nr)
+		return;
+
+	/*
+	 * mailmap expansion may make the name longer.
+	 * make room by pushing stuff down.
+	 */
+	tmp = person + bufsz - (tzlen + 1);
+	memmove(tmp, *tz, tzlen);
+	tmp[tzlen] = 0;
+	*tz = tmp;
+
+	tmp = tmp - (maillen + 1);
+	memmove(tmp, *mail, maillen);
+	tmp[maillen] = 0;
+	*mail = tmp;
+
+	/*
+	 * Now, convert e-mail using mailmap
+	 */
+	map_email(&mailmap, tmp + 1, person, tmp-person-1);
 }
 
 static void get_commit_info(struct commit *commit,
@@ -2269,6 +2299,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		else if (!strcmp("-p", arg) ||
 			 !strcmp("--porcelain", arg))
 			output_option |= OUTPUT_PORCELAIN;
+		else if (!strcmp("-x", arg) ||
+			 !strcmp("--no-mailmap", arg))
+			no_mailmap = 1;
 		else if (!strcmp("--", arg)) {
 			seen_dashdash = 1;
 			i++;
@@ -2473,6 +2506,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		die("reading graft file %s failed: %s",
 		    revs_file, strerror(errno));
 
+	if (!no_mailmap && !access(".mailmap", R_OK))
+		read_mailmap(&mailmap, ".mailmap", NULL);
+
 	assign_blame(&sb, &revs, opt);
 
 	if (incremental || log)
-- 
1.5.2.rc0.746.gcf51
