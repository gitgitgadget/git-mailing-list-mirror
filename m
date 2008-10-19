From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: [PATCH] Teach/Fix -q/-v to pull/fetch
Date: Sun, 19 Oct 2008 20:17:57 +0200
Message-ID: <1224440277-2469-1-git-send-email-tuncer.ayaz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 13:05:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrcsD-0005DD-2n
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 20:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbYJSSSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 14:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYJSSSA
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 14:18:00 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:14462 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbYJSSR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 14:17:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1569996fkq.5
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=B+JZg5B32IUW6XYa+BlWj8vWxmXAEIV89u68f3whXRc=;
        b=NawRFRF5Pl2ugU0YBMFBJNbxhcM+1mAyjiOMV18PwPiijklJHpymEaK2B5FzA8Y4Ne
         rYO6YhpIFA9u6TnfKSLDMp1lijlRTmLL+sGf/oceEK7eIlLYCsi1NffuI24qDu+yjY0o
         H3B1sqqQ7J7oH5hRqUyAJmGa44aeS/RTeofGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=hiQOw/VB42gXk9D2J/HXXXgtl9PIfzEU5e3cmzPY5AmrQmc6nDE93Uktc2+ciUhI30
         qhcnNdB4k0fs2wdlxkVUN3001ooPx+3XvcTmCKRD2vWZllnL5GlcIhstEi4nNixTH28P
         US+4E5dkrAnk6DFG7+WxYIGvRQM4BzEpzlpZs=
Received: by 10.181.49.15 with SMTP id b15mr623547bkk.213.1224440276612;
        Sun, 19 Oct 2008 11:17:56 -0700 (PDT)
Received: from localhost (achn-4db49d68.pool.einsundeins.de [77.180.157.104])
        by mx.google.com with ESMTPS id 12sm13196599fks.9.2008.10.19.11.17.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Oct 2008 11:17:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98653>

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

This is the next attempt trying to incorporate Junio's
suggestions and I'm not sure about the following:
1) having the same option callback function in both modules
2) my adaption of the following two lines from
builtin-fetch.c to the new verbosity option:
    if (verbosity == VERBOSE)
        transport->verbose = 1;
    if (verbosity == QUIET)
        transport->verbose = -1;
3) my usage of OPTION_CALLBACK. therefore please
correct me if I did it wrong or my cb fun has an
obvious defect. it may very well have one :)

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 Documentation/merge-options.txt |    8 ++++++++
 builtin-fetch.c                 |   35 +++++++++++++++++++++++++----------
 builtin-merge.c                 |   36 +++++++++++++++++++++++++++++-------
 git-pull.sh                     |   10 ++++++++--
 4 files changed, 70 insertions(+), 19 deletions(-)

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
index ee93d3a..717e833 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -22,16 +22,31 @@ enum {
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
+
+static int option_parse_verbosity(const struct option *opt,
+			  const char *arg, int unset)
+{
+	if (!strcmp("quiet", opt->long_name))
+		verbosity = QUIET;
+	else if (!strcmp("verbose", opt->long_name))
+		verbosity = VERBOSE;
+	return 0;
+}
 
 static struct option builtin_fetch_options[] = {
-	OPT__QUIET(&quiet),
-	OPT__VERBOSE(&verbose),
+	{ OPTION_CALLBACK, 'q', "quiet", NULL, NULL,
+		"operate quietly",
+		PARSE_OPT_NOARG, option_parse_verbosity },
+	{ OPTION_CALLBACK, 'v', "verbose", NULL, NULL,
+		"be verbose",
+		PARSE_OPT_NOARG, option_parse_verbosity },
 	OPT_BOOLEAN('a', "append", &append,
 		    "append to .git/FETCH_HEAD instead of overwriting"),
 	OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
@@ -192,7 +207,6 @@ static int s_update_ref(const char *action,
 
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
-			    int verbose,
 			    char *display)
 {
 	struct commit *current = NULL, *updated;
@@ -210,7 +224,7 @@ static int update_local_ref(struct ref *ref,
 		die("object %s not found", sha1_to_hex(ref->new_sha1));
 
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
-		if (verbose)
+		if (verbosity == VERBOSE)
 			sprintf(display, "= %-*s %-*s -> %s", SUMMARY_WIDTH,
 				"[up to date]", REFCOL_WIDTH, remote,
 				pretty_ref);
@@ -366,18 +380,19 @@ static int store_updated_refs(const char *url, const char *remote_name,
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
@@ -622,9 +637,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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
index 5e2b7f1..6966831 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -50,6 +50,7 @@ static unsigned char head[20], stash[20];
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char *branch;
+static enum { QUIET, NORMAL, VERBOSE } verbosity = NORMAL;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -151,7 +152,23 @@ static int option_parse_n(const struct option *opt,
 	return 0;
 }
 
+static int option_parse_verbosity(const struct option *opt,
+			  const char *arg, int unset)
+{
+	if (!strcmp("quiet", opt->long_name))
+		verbosity = QUIET;
+	else if (!strcmp("verbose", opt->long_name))
+		verbosity = VERBOSE;
+	return 0;
+}
+
 static struct option builtin_merge_options[] = {
+	{ OPTION_CALLBACK, 'q', "quiet", NULL, NULL,
+		"operate quietly",
+		PARSE_OPT_NOARG, option_parse_verbosity },
+	{ OPTION_CALLBACK, 'v', "verbose", NULL, NULL,
+		"be verbose",
+		PARSE_OPT_NOARG, option_parse_verbosity },
 	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
 		"do not show a diffstat at the end of the merge",
 		PARSE_OPT_NOARG, option_parse_n },
@@ -249,7 +266,8 @@ static void restore_state(void)
 /* This is called when no merge was necessary. */
 static void finish_up_to_date(const char *msg)
 {
-	printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
+	if (verbosity > QUIET)
+		printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
 	drop_save();
 }
 
@@ -330,14 +348,15 @@ static void finish(const unsigned char *new_head, const char *msg)
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
@@ -871,6 +890,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if (verbosity > QUIET)
+		show_diffstat = 0;
 
 	if (squash) {
 		if (!allow_fast_forward)
@@ -1012,10 +1033,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
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
index 75c3610..8e25d44 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,6 +16,7 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
 
+quiet= verbose=
 strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
@@ -23,6 +24,10 @@ rebase=$(git config --bool branch.$curr_branch_short.rebase)
 while :
 do
 	case "$1" in
+	-q|--quiet)
+		quiet=-q ;;
+	-v|--verbose)
+		verbose=-v ;;
 	-n|--no-stat|--no-summary)
 		no_stat=-n ;;
 	--stat|--summary)
@@ -121,7 +126,7 @@ test true = "$rebase" && {
 		"refs/remotes/$origin/$reflist" 2>/dev/null)"
 }
 orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
-git fetch --update-head-ok "$@" || exit 1
+git fetch $verbose $quiet --update-head-ok "$@" || exit 1
 
 curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
 if test "$curr_head" != "$orig_head"
@@ -181,5 +186,6 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
+exec git-merge $quiet $verbose $no_stat $no_commit \
+	$squash $no_ff $log_arg $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.6.0.2.GIT
