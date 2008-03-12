From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 20:53:25 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803122051340.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <alpine.LSU.1.00.0803122005330.1656@racer.site> <7viqzr69ka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:54:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZX1V-0006Ja-T6
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbYCLTxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYCLTxV
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:53:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:42966 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751907AbYCLTxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:53:20 -0400
Received: (qmail invoked by alias); 12 Mar 2008 19:53:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 12 Mar 2008 20:53:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HWvU65S6H8vzlrkKfmDZikXZsxh9/0Sxpw2pQlu
	FzzN1szGzdWsZM
X-X-Sender: gene099@racer.site
In-Reply-To: <7viqzr69ka.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76978>


The only reason we did not call "prune" in git-gc was that it is an
inherently dangerous operation: if there is a commit going on, you will
prune loose objects that were just created, and are, in fact, needed by the
commit object just about to be created.

Since it is dangerous, we told users so.  That led to many users not even
daring to run it when it was actually safe. Besides, they are users, and
should not have to remember such details as when to call git-gc with
--prune, or to call git-prune directly.

Of course, the consequence was that "git gc --auto" gets triggered much
more often than we would like, since unreferenced loose objects (such as
left-overs from a rebase or a reset --hard) were never pruned.

Alas, git-prune recently learnt the option --expire <minimum-age>, which
makes it a much safer operation.  This allows us to call prune from git-gc,
with a grace period of 2 weeks for the unreferenced loose objects (this
value was determined in a discussion on the git list as a safe one).

If you want to override this grace period, just set the config variable
gc.pruneExpire to a different value; an example would be

	[gc]
		pruneExpire = 6.months.ago

if you feel really paranoid.

Note that this new behaviour does not affect git-gc when you pass the
option --prune; in that case, prune will clean up the loose objects with no
grace period at all.

While adding a test to t5304-prune.sh (since it really tests the implicit
call to "prune"), also the original test for "prune --expire" was moved
there from t1410-reflog.sh, where it did not belong.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This checks for an invalid gc.pruneExpire by assuming that an 
	invalid date string is not "now", but parses to the same value
	(or actually newer, since between the two calls to approxidate(), 
	there is a slight chance of a wrapover to the next second).

	So yes, gc.pruneExpire = never should work now.

 Documentation/config.txt |    5 +++++
 Documentation/git-gc.txt |   16 +++++++++++-----
 builtin-gc.c             |   20 ++++++++++++++++++--
 t/t1410-reflog.sh        |   18 ------------------
 t/t5304-prune.sh         |   44 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f64b269..db5b2dc 100644
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
index 7cad366..9663fae 100644
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
@@ -55,6 +56,15 @@ static int gc_config(const char *var, const char *value)
 		gc_auto_pack_limit = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.pruneexpire")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (strcmp(value, "now") &&
+				approxidate(value) - approxidate("now") >= 0)
+			return error("Invalid gc.pruneExpire: '%s'", value);
+		prune_expire = xstrdup(value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
@@ -235,7 +245,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
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
index 6560af7..3b6b01d 100644
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -29,4 +29,48 @@ test_expect_success 'prune stale packs' '
 
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
+test_expect_success 'gc: refuse to start with invalid gc.pruneExpire' '
+
+	git config gc.pruneExpire invalid &&
+	test_must_fail git gc &&
+	git config gc.pruneExpire now &&
+	git gc
+
+'
+
 test_done
-- 
1.5.4.4.694.g43223
