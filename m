From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Sun, 12 Oct 2008 18:54:38 +0200
Message-ID: <4ac8254d0810120954x2364054ahf2d49d6fbb7b0bb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 18:55:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp4EV-0004aw-7o
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 18:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbYJLQym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 12:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbYJLQym
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 12:54:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:13504 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbYJLQyl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 12:54:41 -0400
Received: by wr-out-0506.google.com with SMTP id 69so852226wri.5
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=zzu43pVXHrtvPnNk94RaQhwHjo6Ibt1MB9BpQrxbOmI=;
        b=A684zGEsnQgPPgtZ8vqCq9vPssvTaq1Tiwnk5mGEF1jP9PXoJ+Je0zfEqOUykXjPq2
         jw9I2p0fcNiD63CrBQTAV4QojYW+D0QZWpo2LxtUwB+J9DE0wEnhBTezvW5l0o7B8YvO
         cNAyUdOVLNOiHu5DjkzZuL0REYkle0oW8EdQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=YC5gkiFLNOf1sa3Wvdjc/0M821XNQdSftMDZQiKxaczXGWjb1OA+Qc6tnNDTW9L9Nf
         gL+eVAu0P7yZJ3Zg5oYU0YGJWQh27ABqzfm20HSIKqo7dgIPfuHwKdOfeDVqLrSgyIt5
         32o8E+3EzapzTIwjZgndK5b1f97qRIizejcqw=
Received: by 10.65.123.10 with SMTP id a10mr8420649qbn.12.1223830478984;
        Sun, 12 Oct 2008 09:54:38 -0700 (PDT)
Received: by 10.64.142.13 with HTTP; Sun, 12 Oct 2008 09:54:38 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98036>

After fixing clone -q I noticed that pull -q is does not do what
it's supposed to do and implemented --quiet/--verbose by
adding it to builtin-merge and fixing two places in builtin-fetch.

I have not touched/adjusted contrib/completion/git-completion.bash
but can take a look if wanted. I think it needs one or two adjustions
anyway caused by recent --OPTIONS changes in master.

I've tested the following invocations with the below changes applied:
$ git pull
$ git pull -q
$ git pull -v

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 Documentation/merge-options.txt |    8 ++++++
 builtin-fetch.c                 |    5 ++-
 builtin-merge.c                 |   52 +++++++++++++++++++++++---------------
 git-pull.sh                     |   10 +++++--
 4 files changed, 49 insertions(+), 26 deletions(-)

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
index ee93d3a..b5c2885 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -372,12 +372,13 @@ static int store_updated_refs(const char *url,
const char *remote_name,
 				SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
-			if (!shown_url) {
+			if ((verbose || !quiet) && !shown_url) {
 				fprintf(stderr, "From %.*s\n",
 						url_len, url);
 				shown_url = 1;
 			}
-			fprintf(stderr, " %s\n", note);
+			if(verbose || !quiet)
+				fprintf(stderr, " %s\n", note);
 		}
 	}
 	fclose(fp);
diff --git a/builtin-merge.c b/builtin-merge.c
index 38266ba..1f601d4 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -44,6 +44,7 @@ static const char * const builtin_merge_usage[] = {
 static int show_diffstat = 1, option_log, squash;
 static int option_commit = 1, allow_fast_forward = 1;
 static int allow_trivial = 1, have_message;
+static int quiet, verbose;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
 static unsigned char head[20], stash[20];
@@ -101,7 +102,7 @@ static struct strategy *get_strategy(const char *name)
 			struct cmdname *ent = main_cmds.names[i];
 			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
 				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
-						&& !all_strategy[j].name[ent->len])
+					&& !all_strategy[j].name[ent->len])
 					found = 1;
 			if (!found)
 				add_cmdname(&not_strategies, ent->name, ent->len);
@@ -152,6 +153,8 @@ static int option_parse_n(const struct option *opt,
 }

 static struct option builtin_merge_options[] = {
+	OPT__QUIET(&quiet),
+	OPT__VERBOSE(&verbose),
 	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
 		"do not show a diffstat at the end of the merge",
 		PARSE_OPT_NOARG, option_parse_n },
@@ -250,7 +253,8 @@ static void restore_state(void)
 /* This is called when no merge was necessary. */
 static void finish_up_to_date(const char *msg)
 {
-	printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
+	if(verbose || !quiet)
+		printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
 	drop_save();
 }

@@ -262,7 +266,8 @@ static void squash_message(void)
 	struct commit_list *j;
 	int fd;

-	printf("Squash commit -- not updating HEAD\n");
+	if(verbose || !quiet)
+		printf("Squash commit -- not updating HEAD\n");
 	fd = open(git_path("SQUASH_MSG"), O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die("Could not write to %s", git_path("SQUASH_MSG"));
@@ -282,18 +287,20 @@ static void squash_message(void)
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");

-	strbuf_init(&out, 0);
-	strbuf_addstr(&out, "Squashed commit of the following:\n");
-	while ((commit = get_revision(&rev)) != NULL) {
-		strbuf_addch(&out, '\n');
-		strbuf_addf(&out, "commit %s\n",
-			sha1_to_hex(commit->object.sha1));
-		pretty_print_commit(rev.commit_format, commit, &out, rev.abbrev,
-			NULL, NULL, rev.date_mode, 0);
+	if(verbose || !quiet) {
+		strbuf_init(&out, 0);
+		strbuf_addstr(&out, "Squashed commit of the following:\n");
+		while ((commit = get_revision(&rev)) != NULL) {
+			strbuf_addch(&out, '\n');
+			strbuf_addf(&out, "commit %s\n",
+						sha1_to_hex(commit->object.sha1));
+			pretty_print_commit(rev.commit_format, commit, &out, rev.abbrev,
+								NULL, NULL, rev.date_mode, 0);
+		}
+		write(fd, out.buf, out.len);
+		close(fd);
+		strbuf_release(&out);
 	}
-	write(fd, out.buf, out.len);
-	close(fd);
-	strbuf_release(&out);
 }

 static int run_hook(const char *name)
@@ -333,14 +340,15 @@ static void finish(const unsigned char
*new_head, const char *msg)
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
 	else {
-		printf("%s\n", msg);
+		if(verbose || !quiet)
+			printf("%s\n", msg);
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
 	if (squash) {
 		squash_message();
 	} else {
-		if (!merge_msg.len)
+		if ((verbose || !quiet) && !merge_msg.len)
 			printf("No merge message -- not updating HEAD\n");
 		else {
 			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
@@ -877,6 +885,8 @@ int cmd_merge(int argc, const char **argv, const
char *prefix)

 	argc = parse_options(argc, argv, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if(!verbose && quiet)
+		show_diffstat = 0;

 	if (squash) {
 		if (!allow_fast_forward)
@@ -1019,11 +1029,11 @@ int cmd_merge(int argc, const char **argv,
const char *prefix)
 		char hex[41];

 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
-
-		printf("Updating %s..%s\n",
-			hex,
-			find_unique_abbrev(remoteheads->item->object.sha1,
-			DEFAULT_ABBREV));
+		if(verbose || !quiet)
+			printf("Updating %s..%s\n",
+				   hex,
+				   find_unique_abbrev(remoteheads->item->object.sha1,
+									  DEFAULT_ABBREV));
 		strbuf_init(&msg, 0);
 		strbuf_addstr(&msg, "Fast forward");
 		if (have_message)
diff --git a/git-pull.sh b/git-pull.sh
index 75c3610..d84ceb5 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,13 +16,17 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."

-strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
+quiet= verbose= strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
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
@@ -121,7 +125,7 @@ test true = "$rebase" && {
 		"refs/remotes/$origin/$reflist" 2>/dev/null)"
 }
 orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
-git fetch --update-head-ok "$@" || exit 1
+git fetch $verbose $quiet --update-head-ok "$@" || exit 1

 curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
 if test "$curr_head" != "$orig_head"
@@ -181,5 +185,5 @@ merge_name=$(git fmt-merge-msg $log_arg
<"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
+exec git-merge $quiet $verbose $no_stat $no_commit $squash $no_ff
$log_arg $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.6.0.2.GIT
