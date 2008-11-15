From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Sat, 15 Nov 2008 20:23:00 +0100
Message-ID: <1226776980-9674-1-git-send-email-tuncer.ayaz@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 20:24:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Qks-0002Gr-Ut
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 20:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbYKOTXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 14:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYKOTXK
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 14:23:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:39051 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbYKOTXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 14:23:08 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1543710fgg.17
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vB5fjWWfy9mqcnODAziIqyManosBcwbcNe6NV+2LpD0=;
        b=plLasnAUU5oMT0p51Lnyn5FRL6X4PTrVEqKQfGaYP5fP+yAEDpseqqBJsFnPH8yt3l
         i1Ld4h91900dN3V7uiR+Xo2tECkR3LPlgeUVmDghDfzklLAvcdoHU9QnISnem9GjC/wb
         qv/rQEoLnUNskT7hQ7iO7mUy6amDH7ka6x/h0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GMCT3PYEVhBhtGusj5ggOsXg8/pbCLIdPRTpga2IJxC/edbr7yPmNyzrvb0isVmuTn
         rMzU+4sR6tKg9M/bhMYQ/eZDT55n1BeI+A8KLCTGbr95RDvOfqisQUIPIAv1kp25kDHr
         LXHWolU5SReYRWZhVz4/mZla7fD4+44vpSxA4=
Received: by 10.181.234.13 with SMTP id l13mr594983bkr.123.1226776986278;
        Sat, 15 Nov 2008 11:23:06 -0800 (PST)
Received: from localhost (achn-4db4b3de.pool.einsundeins.de [77.180.179.222])
        by mx.google.com with ESMTPS id d13sm2426890fka.19.2008.11.15.11.23.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 11:23:05 -0800 (PST)
X-Mailer: git-send-email 1.6.0.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101087>

Implement git-pull --quiet and git-pull --verbose by
adding the options to git-pull and fixing verbosity
handling in git-fetch.

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 Documentation/merge-options.txt |    8 +++++
 builtin-fetch.c                 |   19 ++++++------
 builtin-merge.c                 |   21 +++++++++----
 git-pull.sh                     |   10 ++++--
 parse-options.c                 |   22 ++++++++++++++
 parse-options.h                 |    6 ++++
 t/t5521-pull-options.sh         |   60 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 126 insertions(+), 20 deletions(-)
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
index f151cfa..7568163 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -22,7 +22,7 @@ enum {
 	TAGS_SET = 2
 };
 
-static int append, force, keep, update_head_ok, verbose, quiet;
+static int append, force, keep, update_head_ok, verbosity;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -30,8 +30,7 @@ static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
 
 static struct option builtin_fetch_options[] = {
-	OPT__QUIET(&quiet),
-	OPT__VERBOSE(&verbose),
+	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN('a', "append", &append,
 		    "append to .git/FETCH_HEAD instead of overwriting"),
 	OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
@@ -192,7 +191,6 @@ static int s_update_ref(const char *action,
 
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
-			    int verbose,
 			    char *display)
 {
 	struct commit *current = NULL, *updated;
@@ -210,7 +208,7 @@ static int update_local_ref(struct ref *ref,
 		die("object %s not found", sha1_to_hex(ref->new_sha1));
 
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
-		if (verbose)
+		if (verbosity > 0)
 			sprintf(display, "= %-*s %-*s -> %s", SUMMARY_WIDTH,
 				"[up to date]", REFCOL_WIDTH, remote,
 				pretty_ref);
@@ -366,18 +364,19 @@ static int store_updated_refs(const char *url, const char *remote_name,
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
+			if (verbosity >= 0 && !shown_url) {
 				fprintf(stderr, "From %.*s\n",
 						url_len, url);
 				shown_url = 1;
 			}
-			fprintf(stderr, " %s\n", note);
+			if (verbosity >= 0)
+				fprintf(stderr, " %s\n", note);
 		}
 	}
 	fclose(fp);
@@ -637,9 +636,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		remote = remote_get(argv[0]);
 
 	transport = transport_get(remote, remote->url[0]);
-	if (verbose >= 2)
+	if (verbosity >= 2)
 		transport->verbose = 1;
-	if (quiet)
+	if (verbosity < 0)
 		transport->verbose = -1;
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
diff --git a/builtin-merge.c b/builtin-merge.c
index 5e7910b..7c2b90c 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -50,6 +50,7 @@ static unsigned char head[20], stash[20];
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char *branch;
+static int verbosity;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -171,6 +172,7 @@ static struct option builtin_merge_options[] = {
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
 		"message to be used for the merge commit (if any)",
 		option_parse_message),
+	OPT__VERBOSITY(&verbosity),
 	OPT_END()
 };
 
@@ -250,7 +252,8 @@ static void restore_state(void)
 /* This is called when no merge was necessary. */
 static void finish_up_to_date(const char *msg)
 {
-	printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
+	if (verbosity >= 0)
+		printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
 	drop_save();
 }
 
@@ -331,14 +334,15 @@ static void finish(const unsigned char *new_head, const char *msg)
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
 	else {
-		printf("%s\n", msg);
+		if (verbosity >= 0)
+			printf("%s\n", msg);
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
 	if (squash) {
 		squash_message();
 	} else {
-		if (!merge_msg.len)
+		if (verbosity >= 0 && !merge_msg.len)
 			printf("No merge message -- not updating HEAD\n");
 		else {
 			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
@@ -872,6 +876,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if (verbosity < 0)
+		show_diffstat = 0;
 
 	if (squash) {
 		if (!allow_fast_forward)
@@ -1013,10 +1019,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
 
-		printf("Updating %s..%s\n",
-			hex,
-			find_unique_abbrev(remoteheads->item->object.sha1,
-			DEFAULT_ABBREV));
+		if (verbosity >= 0)
+			printf("Updating %s..%s\n",
+				hex,
+				find_unique_abbrev(remoteheads->item->object.sha1,
+				DEFAULT_ABBREV));
 		strbuf_addstr(&msg, "Fast forward");
 		if (have_message)
 			strbuf_addstr(&msg,
diff --git a/git-pull.sh b/git-pull.sh
index 664fe34..a9dc713 100755
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
+		verbosity="$verbosity -v" ;;
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
diff --git a/parse-options.c b/parse-options.c
index fd08bb4..9eb55cc 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -484,6 +484,28 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
+int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
+			   int unset)
+{
+	int *target = opt->value;
+
+	if (unset)
+		/* --no-quiet, --no-verbose */
+		*target = 0;
+	else if (opt->short_name == 'v') {
+		if (*target >= 0)
+			(*target)++;
+		else
+			*target = 1;
+	} else {
+		if (*target <= 0)
+			(*target)--;
+		else
+			*target = -1;
+	}
+	return 0;
+}
+
 /*
  * This should really be OPTION_FILENAME type as a part of
  * parse_options that take prefix to do this while parsing.
diff --git a/parse-options.h b/parse-options.h
index 5199950..034162e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -150,9 +150,15 @@ extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
 extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
+extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var)  OPT_BOOLEAN('v', "verbose", (var), "be verbose")
 #define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")
+#define OPT__VERBOSITY(var) \
+	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, "be more verbose", \
+	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
+	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, "be more quiet", \
+	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
 #define OPT__DRY_RUN(var)  OPT_BOOLEAN('n', "dry-run", (var), "dry run")
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), "n", \
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
