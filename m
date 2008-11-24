From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 8/9 v5] rev-list: make it possible to disable replacing
 using "--no-bisect-replace"
Date: Mon, 24 Nov 2008 22:20:13 +0100
Message-ID: <20081124222013.d01897de.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 22:19:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4iqS-0005An-OD
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 22:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbYKXVSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 16:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbYKXVSc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 16:18:32 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:46264 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbYKXVSc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 16:18:32 -0500
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 0D8E03EA0B9;
	Mon, 24 Nov 2008 22:18:30 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id B598F3EA0D2;
	Mon, 24 Nov 2008 22:18:29 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101625>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-rev-list.txt     |    1 +
 Documentation/rev-list-options.txt |   10 ++++++++++
 builtin-rev-list.c                 |   20 ++++++++++++++++----
 t/t6035-bisect-replace.sh          |   10 ++++++++++
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 4cc8abf..b466da3 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -42,6 +42,7 @@ SYNOPSIS
 	     [ \--bisect-vars ]
 	     [ \--bisect-all ]
 	     [ \--bisect-replace ]
+	     [ \--no-bisect-replace ]
 	     [ \--merge ]
 	     [ \--reverse ]
 	     [ \--walk-reflogs ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b35f9d8..9abdaee 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -589,6 +589,16 @@ default when they perform their bisection calculations. With the
 "--bisect-replace" option, you can see what is the result of using the
 "refs/replace/bisect/*" refs without the effects of other bisection
 calculations.
+
+--no-bisect-replace::
+
+With this option, 'rev-list' will not make use of the
+"refs/replace/bisect/*" refs, even if another `--bisect*` option is
+used.
+
+By default, if any `--bisect*` option is used, 'rev-list' will graft
+commits given by "refs/replace/bisect/*" refs into other branches when
+bisecting, so that bisection can be performed on a fixed up history.
 endif::git-rev-list[]
 
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 1b18c65..e8febd0 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -48,13 +48,20 @@ static const char rev_list_usage[] =
 "    --bisect\n"
 "    --bisect-vars\n"
 "    --bisect-all\n"
-"    --bisect-replace"
+"    --bisect-replace\n"
+"    --no-bisect-replace"
 ;
 
 static struct rev_info revs;
 
+enum {
+	REPLACE_UNSET,
+	REPLACE_DEFAULT,
+	REPLACE_SET
+};
+
 static int bisect_list;
-static int bisect_replace_only;
+static int bisect_force_replace = REPLACE_DEFAULT;
 static int show_timestamp;
 static int hdr_termination;
 static const char *header_prefix;
@@ -684,7 +691,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--bisect-replace")) {
-			bisect_replace_only = 1;
+			bisect_force_replace = REPLACE_SET;
+			continue;
+		}
+		if (!strcmp(arg, "--no-bisect-replace")) {
+			bisect_force_replace = REPLACE_UNSET;
 			continue;
 		}
 		if (!strcmp(arg, "--stdin")) {
@@ -719,7 +730,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = revs.verbose_header ||
 		revs.grep_filter.pattern_list;
 
-	if (bisect_list || bisect_replace_only)
+	if (bisect_force_replace != REPLACE_UNSET &&
+	    (bisect_list || bisect_force_replace == REPLACE_SET))
 		bisect_replace_all();
 	if (bisect_list)
 		revs.limited = 1;
diff --git a/t/t6035-bisect-replace.sh b/t/t6035-bisect-replace.sh
index dabf1ae..f22a2e5 100755
--- a/t/t6035-bisect-replace.sh
+++ b/t/t6035-bisect-replace.sh
@@ -154,6 +154,16 @@ test_expect_success 'git bisect works when starting on the replace branch' '
      git bisect reset
 '
 
+test_expect_success '"git rev-list --no-bisect-replace" works' '
+     git rev-list --bisect-all --no-bisect-replace $HASH6 > rev_list.txt &&
+     test_must_fail grep $HASHFIX2 rev_list.txt &&
+     test_must_fail grep $HASHFIX3 rev_list.txt &&
+     test_must_fail grep $HASHFIX4 rev_list.txt &&
+     grep $HASH2 rev_list.txt &&
+     grep $HASH3 rev_list.txt &&
+     grep $HASH4 rev_list.txt
+'
+
 #
 #
 test_done
-- 
1.5.6.1.1657.g6a50
