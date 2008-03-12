From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 21:55:47 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803122153440.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site> <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZXzr-0008Md-7n
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 21:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYCLUzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 16:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYCLUzo
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 16:55:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:48971 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750795AbYCLUzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 16:55:43 -0400
Received: (qmail invoked by alias); 12 Mar 2008 20:55:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 12 Mar 2008 21:55:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xGENiUEnxoDUnJywrP2mhzt/XxjassgzIwx4N8s
	5Ws554fXqDgltD
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejaf65q0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76986>


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

or even "never", if you feel really paranoid.

Note that this new behaviour makes "--prune" be a no-op.

While adding a test to t5304-prune.sh (since it really tests the implicit
call to "prune"), also the original test for "prune --expire" was moved
there from t1410-reflog.sh, where it did not belong.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 12 Mar 2008, Junio C Hamano wrote:

	> Brandon Casey <casey@nrlssc.navy.mil> writes:
	> 
	> > I am not suggesting that git-gc stop parsing --prune and 
	> > instead start erroring out on it. If it is ok to change the behavior 
	> > of git-gc, it seems like it is ok to change the behavior of 'git-gc 
	> > --prune' in the same way, especially if the change makes it less 
	> > destructive.
	> 
	> Yeah, gc.pruneexpire does sound like it applies to both implicit 
	> ones and explicit ones, doesn't it?  I think your suggestion makes 
	> sense.

	Okay, I give up my resistance.

	Changes since v3: --prune is not even described in the man page 
	anymore, since it now is a no-op.

	Interdiff will follow in its own mail...

 Documentation/config.txt |    4 ++++
 Documentation/git-gc.txt |   17 +++++------------
 builtin-gc.c             |   15 +++++++++++++--
 t/t1410-reflog.sh        |   18 ------------------
 t/t5304-prune.sh         |   44 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 32 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f64b269..a2f1df2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -590,6 +590,10 @@ gc.packrefs::
 	at some stage, and setting this to `false` will continue to
 	prevent `git pack-refs` from being run from `git gc`.
 
+gc.pruneexpire::
+	When `git gc` is run, it will call `prune --expire 2.weeks.ago`.
+	Override the grace period with this config variable.
+
 gc.reflogexpire::
 	`git reflog expire` removes reflog entries older than
 	this time; defaults to 90 days.
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 2e7be91..229a7c9 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git-gc' [--prune] [--aggressive] [--auto] [--quiet]
+'git-gc' [--aggressive] [--auto] [--quiet]
 
 DESCRIPTION
 -----------
@@ -25,17 +25,6 @@ operating performance. Some git commands may automatically run
 OPTIONS
 -------
 
---prune::
-	Usually `git-gc` packs refs, expires old reflog entries,
-	packs loose objects,
-	and removes old 'rerere' records.  Removal
-	of unreferenced loose objects is an unsafe operation
-	while other git operations are in progress, so it is not
-	done by default.  Pass this option if you want it, and only
-	when you know nobody else is creating new objects in the
-	repository at the same time (e.g. never use this option
-	in a cron script).
-
 --aggressive::
 	Usually 'git-gc' runs very quickly while providing good disk
 	space utilization and performance.  This option will cause
@@ -104,6 +93,10 @@ the value, the more time is spent optimizing the delta compression.  See
 the documentation for the --window' option in linkgit:git-repack[1] for
 more details.  This defaults to 10.
 
+The optional configuration variable 'gc.pruneExpire' controls how old
+the unreferenced loose objects have to be before they are pruned.  The
+default is "2 weeks ago".
+
 See Also
 --------
 linkgit:git-prune[1]
diff --git a/builtin-gc.c b/builtin-gc.c
index 7cad366..8bd54d8 100644
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
+static const char *argv_prune[] = {"prune", "--expire", NULL, NULL};
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
 
@@ -235,7 +245,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_repack[0]);
 
-	if (prune && run_command_v_opt(argv_prune, RUN_GIT_CMD))
+	argv_prune[2] = prune_expire;
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
