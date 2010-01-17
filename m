From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 20/20] builtin-gc: Teach the new --notes option to
 garbage-collect notes
Date: Sun, 17 Jan 2010 22:04:37 +0100
Message-ID: <1263762277-31419-21-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcKN-0007dl-JI
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab0AQVFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793Ab0AQVFs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:48 -0500
Received: from smtp.getmail.no ([84.208.15.66]:56386 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754803Ab0AQVFl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:41 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002LDT93Y850@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:27 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:27 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137339>

The new --notes option triggers a call to gc_notes(), which removes note
objects that reference non-existing objects.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-gc.txt |    5 ++-
 builtin-gc.c             |   13 ++++++
 t/t3306-notes-gc.sh      |  106 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 1 deletions(-)
 create mode 100755 t/t3306-notes-gc.sh

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 4cd9cdf..b3d1107 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune]
+'git gc' [--aggressive] [--auto] [--quiet] [--notes] [--prune=<date> | --no-prune]
 
 DESCRIPTION
 -----------
@@ -70,6 +70,9 @@ automatic consolidation of packs.
 --quiet::
 	Suppress all progress reports.
 
+--notes::
+	Prune note objects where the referenced object no longer exists.
+
 Configuration
 -------------
 
diff --git a/builtin-gc.c b/builtin-gc.c
index 093517e..b051bc8 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -12,6 +12,7 @@
 
 #include "builtin.h"
 #include "cache.h"
+#include "notes.h"
 #include "parse-options.h"
 #include "run-command.h"
 
@@ -177,7 +178,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int aggressive = 0;
 	int auto_gc = 0;
 	int quiet = 0;
+	int notes = 0;
 	char buf[80];
+	struct notes_tree *t;
 
 	struct option builtin_gc_options[] = {
 		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
@@ -186,6 +189,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increased runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
 		OPT_BOOLEAN('q', "quiet", &quiet, "suppress progress reports"),
+		OPT_BOOLEAN(0, "notes", &notes, "delete orphaned note objects"),
 		OPT_END()
 	};
 
@@ -235,6 +239,15 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_reflog, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_reflog[0]);
 
+	if (notes) {
+		init_notes(NULL, NULL, NULL, 0);
+		t = &default_notes_tree;
+		gc_notes(t);
+		if (commit_notes(t, "Notes tree cleaned up by 'git gc --notes'"))
+			die("Failed to garbage-collect notes tree @ '%s'", t->ref);
+		free_notes(t);
+	}
+
 	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_repack[0]);
 
diff --git a/t/t3306-notes-gc.sh b/t/t3306-notes-gc.sh
new file mode 100755
index 0000000..1d8233d
--- /dev/null
+++ b/t/t3306-notes-gc.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+test_description='Test git gc --notes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: create a few commits with notes' '
+
+	: > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m 1st &&
+	git notes edit -m "Note #1" &&
+	: > file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m 2nd &&
+	git notes edit -m "Note #2" &&
+	: > file3 &&
+	git add file3 &&
+	test_tick &&
+	git commit -m 3rd &&
+	git notes edit -m "Note #3"
+'
+
+cat > expect <<END_OF_LOG
+commit 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3rd
+
+Notes:
+    Note #3
+
+commit 08341ad9e94faa089d60fd3f523affb25c6da189
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    2nd
+
+Notes:
+    Note #2
+
+commit ab5f302035f2e7aaf04265f08b42034c23256e1f
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    1st
+
+Notes:
+    Note #1
+END_OF_LOG
+
+test_expect_success 'verify commits and notes' '
+
+	git log > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'remove some commits' '
+
+	git reset --hard HEAD~2 &&
+	git reflog expire --expire=now HEAD &&
+	git gc --prune=now
+'
+
+test_expect_success 'verify that commits are gone' '
+
+	! git cat-file -p 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	! git cat-file -p 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	git cat-file -p ab5f302035f2e7aaf04265f08b42034c23256e1f
+'
+
+test_expect_success 'verify that notes are still present' '
+
+	git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
+'
+
+test_expect_success 'garbage-collect (without --notes)' '
+
+	git gc --prune=now --aggressive
+'
+
+test_expect_success 'verify that notes are still present' '
+
+	git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
+'
+
+test_expect_success 'garbage-collect notes' '
+
+	git gc --notes --prune=now --aggressive
+'
+
+test_expect_success 'verify that notes are gone' '
+
+	! git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	! git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
+'
+
+test_done
-- 
1.6.6.rc1.321.g0496e
