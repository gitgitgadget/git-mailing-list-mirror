From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Fri,  7 Nov 2008 04:26:27 +0100
Message-ID: <1226028387-23867-1-git-send-email-tuncer.ayaz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 04:27:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyI0l-0007vf-3T
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 04:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYKGD0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 22:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbYKGD0g
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 22:26:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:59982 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYKGD0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 22:26:35 -0500
Received: by fg-out-1718.google.com with SMTP id 19so773186fgg.17
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 19:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=cWyuMwF5KgiYWaSKLZ+Xe4Wtati30jtil1gsUjqrbQA=;
        b=phjdH+bGose8KUInhbUebhokW88SNEtJchuOxLnO+rVwDhaptMJarR3JLw32eGxYGa
         CvBzeqr+4lR0bjZkSSPHyGdqREeLWVABSuDm75rZ5Zmnen1eeyFODlthGiC4tmx6WnIz
         +eyqtbYPgKQ3/37TCoRMtESGtg2sSOsOdE1fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=jcyK2TCbVnlN6i5bnRfpdHmpdwRi6iZrr9luFDCht7g0NxOY2zbsw//ViOZJ/an+ad
         dOzh+cQUlANkmOI506WY6e0fHHZiBtN0duTrUd1ALNLaiBAb8jhLwG9vLrLc7GtPYRNC
         yvjMfTBR1VWhcyLKGrniow7bMFpxY2vdxP2Sc=
Received: by 10.181.56.1 with SMTP id i1mr884283bkk.195.1226028392867;
        Thu, 06 Nov 2008 19:26:32 -0800 (PST)
Received: from localhost (achn-4db49b42.pool.einsundeins.de [77.180.155.66])
        by mx.google.com with ESMTPS id 22sm3435865fkr.4.2008.11.06.19.26.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Nov 2008 19:26:31 -0800 (PST)
X-Mailer: git-send-email 1.6.0.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100283>

Implement git-pull --quiet and git-pull --verbose by
adding the options to git-pull and fixing verbosity
handling in git-fetch.

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 Documentation/merge-options.txt |    8 +++++
 builtin-fetch.c                 |   21 +++++++------
 builtin-merge.c                 |   22 ++++++++++----
 git-pull.sh                     |   10 ++++--
 t/t5521-pull-options.sh         |   60 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 20 deletions(-)
 create mode 100755 t/t5521-pull-options.sh

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 007909a..427cdef 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,3 +1,11 @@
+-q::
+--quiet::
+	Operate quietly.
+
+-v::
+--verbose::
+	Be verbose.
+
 --stat::
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.stat.
diff --git a/builtin-fetch.c b/builtin-fetch.c
index f151cfa..efc5801 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -22,16 +22,17 @@ enum {
 	TAGS_SET = 2
 };
 
-static int append, force, keep, update_head_ok, verbose, quiet;
+static int append, force, keep, update_head_ok;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
+static enum { QUIET, NORMAL, VERBOSE } verbosity = NORMAL;
 
 static struct option builtin_fetch_options[] = {
-	OPT__QUIET(&quiet),
-	OPT__VERBOSE(&verbose),
+	OPT_SET_INT('v', "verbose", &verbosity, "be verbose", VERBOSE),
+	OPT_SET_INT('q', "quiet", &verbosity, "operate quietly", QUIET),
 	OPT_BOOLEAN('a', "append", &append,
 		    "append to .git/FETCH_HEAD instead of overwriting"),
 	OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
@@ -192,7 +193,6 @@ static int s_update_ref(const char *action,
 
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
-			    int verbose,
 			    char *display)
 {
 	struct commit *current = NULL, *updated;
@@ -210,7 +210,7 @@ static int update_local_ref(struct ref *ref,
 		die("object %s not found", sha1_to_hex(ref->new_sha1));
 
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
-		if (verbose)
+		if (verbosity == VERBOSE)
 			sprintf(display, "= %-*s %-*s -> %s", SUMMARY_WIDTH,
 				"[up to date]", REFCOL_WIDTH, remote,
 				pretty_ref);
@@ -366,18 +366,19 @@ static int store_updated_refs(const char *url, const char *remote_name,
 			note);
 
 		if (ref)
-			rc |= update_local_ref(ref, what, verbose, note);
+			rc |= update_local_ref(ref, what, note);
 		else
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
 				SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
-			if (!shown_url) {
+			if (verbosity > QUIET && !shown_url) {
 				fprintf(stderr, "From %.*s\n",
 						url_len, url);
 				shown_url = 1;
 			}
-			fprintf(stderr, " %s\n", note);
+			if (verbosity > QUIET)
+				fprintf(stderr, " %s\n", note);
 		}
 	}
 	fclose(fp);
@@ -637,9 +638,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		remote = remote_get(argv[0]);
 
 	transport = transport_get(remote, remote->url[0]);
-	if (verbose >= 2)
+	if (verbosity == VERBOSE)
 		transport->verbose = 1;
-	if (quiet)
+	if (verbosity == QUIET)
 		transport->verbose = -1;
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
diff --git a/builtin-merge.c b/builtin-merge.c
index 5e7910b..76e2890 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -50,6 +50,7 @@ static unsigned char head[20], stash[20];
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char *branch;
+static enum { QUIET, NORMAL, VERBOSE } verbosity = NORMAL;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -152,6 +153,8 @@ static int option_parse_n(const struct option *opt,
 }
 
 static struct option builtin_merge_options[] = {
+	OPT_SET_INT('v', "verbose", &verbosity, "be verbose", VERBOSE),
+	OPT_SET_INT('q', "quiet", &verbosity, "operate quietly", QUIET),
 	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
 		"do not show a diffstat at the end of the merge",
 		PARSE_OPT_NOARG, option_parse_n },
@@ -250,7 +253,8 @@ static void restore_state(void)
 /* This is called when no merge was necessary. */
 static void finish_up_to_date(const char *msg)
 {
-	printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
+	if (verbosity > QUIET)
+		printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
 	drop_save();
 }
 
@@ -331,14 +335,15 @@ static void finish(const unsigned char *new_head, const char *msg)
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
 	else {
-		printf("%s\n", msg);
+		if (verbosity > QUIET)
+			printf("%s\n", msg);
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
 	if (squash) {
 		squash_message();
 	} else {
-		if (!merge_msg.len)
+		if (verbosity > QUIET && !merge_msg.len)
 			printf("No merge message -- not updating HEAD\n");
 		else {
 			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
@@ -872,6 +877,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if (verbosity > QUIET)
+		show_diffstat = 0;
 
 	if (squash) {
 		if (!allow_fast_forward)
@@ -1013,10 +1020,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
 
-		printf("Updating %s..%s\n",
-			hex,
-			find_unique_abbrev(remoteheads->item->object.sha1,
-			DEFAULT_ABBREV));
+		if (verbosity > QUIET)
+			printf("Updating %s..%s\n",
+				hex,
+				find_unique_abbrev(remoteheads->item->object.sha1,
+				DEFAULT_ABBREV));
 		strbuf_addstr(&msg, "Fast forward");
 		if (have_message)
 			strbuf_addstr(&msg,
diff --git a/git-pull.sh b/git-pull.sh
index 664fe34..8866f2a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,13 +16,17 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
 
-strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
+strategy_args= no_stat= no_commit= squash= no_ff= log_arg= verbosity=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
 while :
 do
 	case "$1" in
+	-q|--quiet)
+		verbosity=-q ;;
+	-v|--verbose)
+		verbosity=-v ;;
 	-n|--no-stat|--no-summary)
 		no_stat=-n ;;
 	--stat|--summary)
@@ -121,7 +125,7 @@ test true = "$rebase" && {
 		"refs/remotes/$origin/$reflist" 2>/dev/null)"
 }
 orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
-git fetch --update-head-ok "$@" || exit 1
+git fetch $verbosity --update-head-ok "$@" || exit 1
 
 curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
 if test -n "$orig_head" && test "$curr_head" != "$orig_head"
@@ -182,4 +186,4 @@ test true = "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
 exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
-	"$merge_name" HEAD $merge_head
+	"$merge_name" HEAD $merge_head $verbosity
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
new file mode 100755
index 0000000..83e2e8a
--- /dev/null
+++ b/t/t5521-pull-options.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='pull options'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+test_expect_success 'setup' '
+	mkdir parent &&
+	(cd parent && git init &&
+	 echo one >file && git add file &&
+	 git commit -m one)
+'
+
+cd "$D"
+
+test_expect_success 'git pull -q' '
+	mkdir clonedq &&
+	cd clonedq &&
+	git pull -q "$D/parent" >out 2>err &&
+	test ! -s out
+'
+
+cd "$D"
+
+test_expect_success 'git pull' '
+	mkdir cloned &&
+	cd cloned &&
+	git pull "$D/parent" >out 2>err &&
+	test -s out
+'
+cd "$D"
+
+test_expect_success 'git pull -v' '
+	mkdir clonedv &&
+	cd clonedv &&
+	git pull -v "$D/parent" >out 2>err &&
+	test -s out
+'
+
+cd "$D"
+
+test_expect_success 'git pull -v -q' '
+	mkdir clonedvq &&
+	cd clonedvq &&
+	git pull -v -q "$D/parent" >out 2>err &&
+	test ! -s out
+'
+
+cd "$D"
+
+test_expect_success 'git pull -q -v' '
+	mkdir clonedqv &&
+	cd clonedqv &&
+	git pull -q -v "$D/parent" >out 2>err &&
+	test -s out
+'
+
+test_done
-- 
1.6.0.2.GIT
