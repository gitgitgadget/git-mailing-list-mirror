From: tuncer.ayaz@gmail.com
Subject: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Mon, 13 Oct 2008 23:42:28 +0200
Message-ID: <1223934148-13942-1-git-send-email-tuncer.ayaz@gmail.com>
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 23:43:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpVCh-0005UV-3g
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbYJMVmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbYJMVmh
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:42:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:8421 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbYJMVmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:42:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1417236fgg.17
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ECzjGo/1IeUfKTuh6DbVBHiVyxft9Qygx5ROX018Twc=;
        b=ZdO39K5/a6H4jAYWr4fakZxE2unXFuJNsCb+/PCuXp4fnnvGSWG+lKACA7rxBd2rKL
         Ni3Q7FCysM/biu9nq3QLeiE41B2yFSu4EbppEPQkS+YtUVd6xxzW9mjwBcJ55R7DeKLZ
         gqFspBd8cuZ5Wpk/ZmtVQ2v4lhrIubsCZ+D1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZimyswPy5c+Tt75C3teZDbkJnmBTOqikxAkDe+WfiL0OULHVLJ8ZDXkISvQ58qrr4o
         JLdM+KdQ9L3pVbqmaChBGkluGbI4aII4YMxZTa1RTOLS7xq+E3zOs76gSUedKrTaEXNG
         sX6prb7pbfLXuQywiKt+NM2JAV7XfxK35ZGPg=
Received: by 10.181.21.6 with SMTP id y6mr5214073bki.103.1223934154014;
        Mon, 13 Oct 2008 14:42:34 -0700 (PDT)
Received: from localhost (achn-4db4b520.pool.einsundeins.de [77.180.181.32])
        by mx.google.com with ESMTPS id k29sm7116679fkk.2.2008.10.13.14.42.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 14:42:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98158>

From: Tuncer Ayaz <tuncer.ayaz@gmail.com>

Updated patch to current Junio master.

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 Documentation/merge-options.txt |    8 ++++++++
 builtin-fetch.c                 |    5 +++--
 builtin-merge.c                 |   22 +++++++++++++++-------
 git-pull.sh                     |   10 ++++++++--
 4 files changed, 34 insertions(+), 11 deletions(-)

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
index ee93d3a..287ce33 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -372,12 +372,13 @@ static int store_updated_refs(const char *url, const char *remote_name,
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
+			if (verbose || !quiet)
+				fprintf(stderr, " %s\n", note);
 		}
 	}
 	fclose(fp);
diff --git a/builtin-merge.c b/builtin-merge.c
index 5e2b7f1..4f90501 100644
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
@@ -152,6 +153,8 @@ static int option_parse_n(const struct option *opt,
 }
 
 static struct option builtin_merge_options[] = {
+	OPT__QUIET(&quiet),
+	OPT__VERBOSE(&verbose),
 	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
 		"do not show a diffstat at the end of the merge",
 		PARSE_OPT_NOARG, option_parse_n },
@@ -249,7 +252,8 @@ static void restore_state(void)
 /* This is called when no merge was necessary. */
 static void finish_up_to_date(const char *msg)
 {
-	printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
+	if (verbose || !quiet)
+		printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
 	drop_save();
 }
 
@@ -330,14 +334,15 @@ static void finish(const unsigned char *new_head, const char *msg)
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
 	else {
-		printf("%s\n", msg);
+		if (verbose || !quiet)
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
@@ -871,6 +876,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if (!verbose && quiet)
+		show_diffstat = 0;
 
 	if (squash) {
 		if (!allow_fast_forward)
@@ -1012,10 +1019,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
 
-		printf("Updating %s..%s\n",
-			hex,
-			find_unique_abbrev(remoteheads->item->object.sha1,
-			DEFAULT_ABBREV));
+		if (verbose || !quiet)
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
