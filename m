From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/10] bisect: implement "read_bisect_paths" to read paths
 in "$GIT_DIR/BISECT_NAMES"
Date: Thu, 26 Mar 2009 05:55:59 +0100
Message-ID: <20090326055559.743cb502.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmhfq-0003rO-Ex
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbZCZE5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbZCZE5C
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:57:02 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:39801 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbZCZE5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:57:00 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4B11D94000E;
	Thu, 26 Mar 2009 05:56:50 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id EB758940051;
	Thu, 26 Mar 2009 05:56:47 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114731>

This is needed because  "git bisect--helper" must read bisect paths
in "$GIT_DIR/BISECT_NAMES", so that a bisection can be performed only
on commits that touches paths in this file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/bisect.c b/bisect.c
index ce62696..a6fd826 100644
--- a/bisect.c
+++ b/bisect.c
@@ -4,6 +4,7 @@
 #include "revision.h"
 #include "refs.h"
 #include "list-objects.h"
+#include "quote.h"
 #include "bisect.h"
 
 
@@ -424,6 +425,33 @@ static int read_bisect_refs(void)
 	return for_each_bisect_ref(register_ref, NULL);
 }
 
+void read_bisect_paths()
+{
+	struct strbuf str = STRBUF_INIT;
+	const char *filename = git_path("BISECT_NAMES");
+	FILE *fp = fp = fopen(filename, "r");
+
+	if (!fp)
+		die("Could not open file '%s': %s", filename, strerror(errno));
+
+	while (strbuf_getline(&str, fp, '\n') != EOF) {
+		char *quoted, *dequoted;
+		strbuf_trim(&str);
+		quoted = strbuf_detach(&str, NULL);
+		if (!*quoted)
+			continue;
+		dequoted = sq_dequote(quoted);
+		if (!dequoted)
+			die("Badly quoted content in file '%s': %s",
+			    filename, quoted);
+		ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
+		rev_argv[rev_argv_nr++] = dequoted;
+	}
+
+	strbuf_release(&str);
+	fclose(fp);
+}
+
 static int skipcmp(const void *a, const void *b)
 {
 	return hashcmp(a, b);
@@ -485,14 +513,11 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	return filtered;
 }
 
-int bisect_next_vars(const char *prefix)
+static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
 {
-	struct rev_info revs;
-	int reaches = 0, all = 0;
-
-	init_revisions(&revs, prefix);
-	revs.abbrev = 0;
-	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+	init_revisions(revs, prefix);
+	revs->abbrev = 0;
+	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
 	/* argv[0] will be ignored by setup_revisions */
 	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
@@ -504,9 +529,22 @@ int bisect_next_vars(const char *prefix)
 	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
 	rev_argv[rev_argv_nr++] = xstrdup("--");
 
-	setup_revisions(rev_argv_nr, rev_argv, &revs, NULL);
+	read_bisect_paths();
+
+	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
+	rev_argv[rev_argv_nr++] = NULL;
+
+	setup_revisions(rev_argv_nr, rev_argv, revs, NULL);
+
+	revs->limited = 1;
+}
+
+int bisect_next_vars(const char *prefix)
+{
+	struct rev_info revs;
+	int reaches = 0, all = 0;
 
-	revs.limited = 1;
+	bisect_rev_setup(&revs, prefix);
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
-- 
1.6.2.1.317.g3d804
