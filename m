From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 20 Oct 2008 18:28:40 +0200
Message-ID: <1224520120-32406-1-git-send-email-tuncer.ayaz@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 23:11:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krxdw-00056g-Dy
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 18:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYJTQ2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 12:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYJTQ2v
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 12:28:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:50989 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbYJTQ2u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 12:28:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1450632fgg.17
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sp9511APOT+TLVk4nZ6fu6NVkIcvyBpZKebBQ8si+Z8=;
        b=CU0RBJY1cLzaCwlzgAGSSrL/DlgNZYTXnIaSolTfexlbRHr54H2TnDq8WmvlZooPcL
         Ox7bbTiDqEDBTRVq5vAnqZ2m3Jd65SNyPOmFUDi4aimE9Ai4kmDfaXZbLCs82Zglz0hl
         IwuB7ACWsQ1QVKHpb1MzAN29aGAeaxxiLPhbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=u/jqT5+BQ4llDJDwSH5gYzqHxE5ZtL746uHfSvXV/1Qw0Fq05wj+e4E5CQ8vpruVc3
         i8QPTTkMTqcSVuk3ikn9YofBtA/Y8hWW/TM/zAK+E1lvC9MXvIVEPDzw9Jxq8FY7N/h6
         Q9/U6y9OlytWrBvGzih9AMhWX+NNhShbmtVMs=
Received: by 10.181.234.8 with SMTP id l8mr891773bkr.113.1224520128225;
        Mon, 20 Oct 2008 09:28:48 -0700 (PDT)
Received: from localhost (achn-4db49b08.pool.einsundeins.de [77.180.155.8])
        by mx.google.com with ESMTPS id 31sm15166374fkt.3.2008.10.20.09.28.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 09:28:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98707>

After fixing clone -q I noticed that pull -q does not do what
it's supposed to do and implemented --quiet/--verbose by
adding it to builtin-merge and fixing two places in builtin-fetch.

I have not touched/adjusted contrib/completion/git-completion.bash
but can take a look if wanted. I think it already needs one or two
adjustments caused by recent --OPTIONS changes in master.

I've tested the following invocations with the below changes applied:
$ git pull
$ git pull -q
$ git pull -v
$ git fetch -q
$ git pull -q -v -q

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 Documentation/merge-options.txt |    8 ++++++++
 builtin-fetch.c                 |   21 +++++++++++----------
 builtin-merge.c                 |   22 +++++++++++++++-------
 git-pull.sh                     |   11 ++++++++---
 4 files changed, 42 insertions(+), 20 deletions(-)

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
index ee93d3a..b067512 100644
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
@@ -622,9 +623,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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
index 75c3610..9c0a812 100755
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
+		verbosity="$verbosity -q" ;;
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
 if test "$curr_head" != "$orig_head"
@@ -181,5 +185,6 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
+exec git-merge $verbosity $no_stat $no_commit \
+	$squash $no_ff $log_arg $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.6.0.2.GIT
