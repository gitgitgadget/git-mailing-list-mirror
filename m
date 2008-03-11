From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Tue, 11 Mar 2008 21:58:20 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803112157560.3873@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 11 22:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZBYp-00039W-Dw
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 21:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbYCKU6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbYCKU6S
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 16:58:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:51043 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750992AbYCKU6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 16:58:17 -0400
Received: (qmail invoked by alias); 11 Mar 2008 20:58:15 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp037) with SMTP; 11 Mar 2008 21:58:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MFKBwsi5MKImqLBiSrP53NvjQXD09YWu8TsIU25
	hd0iE36us2SNf1
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76899>


If "--prune" is passed to gc, it still just calls "git prune".
Otherwise, "prune --expire 2.weeks.ago" is called, where the grace
period is overrideable by the config variable gc.pruneExpire.

While adding a test to t5304-prune.sh (since it really tests the
implicit call to "prune"), the original test for "prune --expire"
is moved there from t1410-reflog.sh, where it did not belong.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I am really tempted to reduce the grace period further, but
	I'd like to hear opinions first.  Is 3.days.ago too short?

 Documentation/config.txt |    5 +++++
 Documentation/git-gc.txt |   16 +++++++++++-----
 builtin-gc.c             |   19 +++++++++++++++++--
 t/t1410-reflog.sh        |   18 ------------------
 t/t5304-prune.sh         |   36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 14df635..adde89a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -590,6 +590,11 @@ gc.packrefs::
 	at some stage, and setting this to `false` will continue to
 	prevent `git pack-refs` from being run from `git gc`.
 
+gc.pruneexpire::
+	When `git gc` is run without `--prune`, it will still call
+	`prune`, but with `--expire 2.weeks.ago`.  Override the value
+	with this config variable.
+
 gc.reflogexpire::
 	`git reflog expire` removes reflog entries older than
 	this time; defaults to 90 days.
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 2e7be91..2042d9f 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -28,13 +28,19 @@ OPTIONS
 --prune::
 	Usually `git-gc` packs refs, expires old reflog entries,
 	packs loose objects,
-	and removes old 'rerere' records.  Removal
+	and removes old 'rerere' records.  Unilateral removal
 	of unreferenced loose objects is an unsafe operation
 	while other git operations are in progress, so it is not
-	done by default.  Pass this option if you want it, and only
-	when you know nobody else is creating new objects in the
-	repository at the same time (e.g. never use this option
-	in a cron script).
+	done by default.
++
+Instead, `git-prune` is called with an option telling it to expire
+only unreferenced loose objects that are at least 2 weeks old.  Set
+the config variable `gc.pruneexpire` to override this grace period.
++
+Pass `--prune` to expire all unreferenced loose objects, but only
+when you know nobody else is creating new objects in the
+repository at the same time (e.g. never use this option
+in a cron script).
 
 --aggressive::
 	Usually 'git-gc' runs very quickly while providing good disk
diff --git a/builtin-gc.c b/builtin-gc.c
index 7cad366..8d07350 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -26,12 +26,13 @@ static int pack_refs = 1;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 20;
+static char *prune_expire = "2.weeks.ago";
 
 #define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
 static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
 static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL};
-static const char *argv_prune[] = {"prune", NULL};
+static const char *argv_prune[] = {"prune", NULL, NULL, NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
 static int gc_config(const char *var, const char *value)
@@ -55,6 +56,14 @@ static int gc_config(const char *var, const char *value)
 		gc_auto_pack_limit = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.pruneexpire")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!approxidate(value))
+			return error("Invalid gc.pruneExpire: '%s'", value);
+		prune_expire = xstrdup(value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
@@ -235,7 +244,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_repack[0]);
 
-	if (prune && run_command_v_opt(argv_prune, RUN_GIT_CMD))
+	if (!prune) {
+		argv_prune[1] = "--expire";
+		argv_prune[2] = prune_expire;
+		argv_prune[3] = NULL;
+	}
+
+	if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_prune[0]);
 
 	if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 24476be..73f830d 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -202,22 +202,4 @@ test_expect_success 'delete' '
 
 '
 
-test_expect_success 'prune --expire' '
-
-	before=$(git count-objects | sed "s/ .*//") &&
-	BLOB=$(echo aleph | git hash-object -w --stdin) &&
-	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE &&
-	git reset --hard &&
-	git prune --expire=1.hour.ago &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE &&
-	test-chmtime -86500 $BLOB_FILE &&
-	git prune --expire 1.day &&
-	test $before = $(git count-objects | sed "s/ .*//") &&
-	! test -f $BLOB_FILE
-
-'
-
 test_done
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 6560af7..2a88b3f 100644
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -29,4 +29,40 @@ test_expect_success 'prune stale packs' '
 
 '
 
+test_expect_success 'prune --expire' '
+
+	before=$(git count-objects | sed "s/ .*//") &&
+	BLOB=$(echo aleph | git hash-object -w --stdin) &&
+	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	git prune --expire=1.hour.ago &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	test-chmtime -86500 $BLOB_FILE &&
+	git prune --expire 1.day &&
+	test $before = $(git count-objects | sed "s/ .*//") &&
+	! test -f $BLOB_FILE
+
+'
+
+test_expect_success 'gc: implicit prune --expire' '
+
+	before=$(git count-objects | sed "s/ .*//") &&
+	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
+echo blob: $BLOB &&
+	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	test-chmtime -$((86400*14-30)) $BLOB_FILE &&
+	git gc &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	test-chmtime -$((86400*14+1)) $BLOB_FILE &&
+	git gc &&
+	test $before = $(git count-objects | sed "s/ .*//") &&
+	! test -f $BLOB_FILE
+
+'
+
 test_done
-- 
1.5.4.4.646.ge37ad
