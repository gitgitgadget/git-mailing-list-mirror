From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/9 v4] rev-list: add "--bisect-replace" to list revisions
 with fixed up history
Date: Tue, 11 Nov 2008 06:40:39 +0100
Message-ID: <20081111064039.1c93fdd2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 06:40:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzlz3-0004Ob-PZ
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 06:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYKKFi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 00:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbYKKFi1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 00:38:27 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:52597 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbYKKFi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 00:38:26 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 29B2D1972D;
	Tue, 11 Nov 2008 06:38:24 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id DA3C219702;
	Tue, 11 Nov 2008 06:38:23 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100619>

This should help both human and scripts deal better with
"bisect-replace-*" branches.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-rev-list.txt     |    1 +
 Documentation/rev-list-options.txt |   15 +++++++++++++++
 builtin-rev-list.c                 |   12 +++++++++---
 t/t6035-bisect-replace.sh          |   12 ++++++++++++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 1c9cc28..4cc8abf 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -41,6 +41,7 @@ SYNOPSIS
 	     [ \--bisect ]
 	     [ \--bisect-vars ]
 	     [ \--bisect-all ]
+	     [ \--bisect-replace ]
 	     [ \--merge ]
 	     [ \--reverse ]
 	     [ \--walk-reflogs ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 68a253f..36253b8 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -507,6 +507,21 @@ may not compile for example).
 This option can be used along with `--bisect-vars`, in this case,
 after all the sorted commit objects, there will be the same text as if
 `--bisect-vars` had been used alone.
+
+--bisect-replace::
+
+This option will make use of the "bisect-replace-*" branches if any,
+but will not perform other bisection calculation.
+
+The purpose of the "bisect-replace-*" branches is to be grafted into
+other branches when bisecting, so that bisection can be performed on
+a fixed up history.
+
+The other `--bisect*` options use the "bisect-replace-*" branches by
+default when they perform their bisection calculations. With the
+"--bisect-replace" option, you can see what is the result of using the
+"bisect-replace-*" branches without the effects of other bisection
+calculations.
 endif::git-rev-list[]
 
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c0717f6..75cc1fc 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -47,12 +47,14 @@ static const char rev_list_usage[] =
 "  special purpose:\n"
 "    --bisect\n"
 "    --bisect-vars\n"
-"    --bisect-all"
+"    --bisect-all\n"
+"    --bisect-replace"
 ;
 
 static struct rev_info revs;
 
 static int bisect_list;
+static int bisect_replace_only;
 static int show_timestamp;
 static int hdr_termination;
 static const char *header_prefix;
@@ -681,6 +683,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_show_vars = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--bisect-replace")) {
+			bisect_replace_only = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--stdin")) {
 			if (read_from_stdin++)
 				die("--stdin given twice?");
@@ -713,10 +719,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = revs.verbose_header ||
 		revs.grep_filter.pattern_list;
 
-	if (bisect_list) {
+	if (bisect_list || bisect_replace_only)
 		bisect_replace_all();
+	if (bisect_list)
 		revs.limited = 1;
-	}
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/t/t6035-bisect-replace.sh b/t/t6035-bisect-replace.sh
index 6ab3667..bc07206 100755
--- a/t/t6035-bisect-replace.sh
+++ b/t/t6035-bisect-replace.sh
@@ -125,6 +125,18 @@ test_expect_success 'standard bisect works' '
      git bisect reset
 '
 
+test_expect_success '"git rev-list --bisect-replace" works' '
+     echo "$HASH7" >> rev_list.expect &&
+     echo "$HASH6" >> rev_list.expect &&
+     echo "$HASH5" >> rev_list.expect &&
+     echo "$HASHFIX4" >> rev_list.expect &&
+     echo "$HASHFIX3" >> rev_list.expect &&
+     echo "$HASHFIX2" >> rev_list.expect &&
+     echo "$HASH1" >> rev_list.expect &&
+     git rev-list --bisect-replace $HASH7 > rev_list.output &&
+     test_cmp rev_list.expect rev_list.output
+'
+
 #
 #
 test_done
-- 
1.6.0.3.614.g0f3b9
