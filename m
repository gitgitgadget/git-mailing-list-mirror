From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Mon, 13 Oct 2008 23:03:05 +0200
Message-ID: <4ac8254d0810131403i4c8c57d6r71531e34321e9b50@mail.gmail.com>
References: <4ac8254d0810120954x2364054ahf2d49d6fbb7b0bb1@mail.gmail.com>
	 <20081012200833.GC5255@spearce.org>
	 <4ac8254d0810121431v1a67afc8ua92842b3d8c39328@mail.gmail.com>
	 <4ac8254d0810121436x6285d17ew631f04e768a6fb62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:04:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpUaU-00072F-Iz
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbYJMVDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754930AbYJMVDI
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:03:08 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:64901 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbYJMVDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:03:07 -0400
Received: by an-out-0708.google.com with SMTP id d40so145449and.103
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hgbpmKaKNuMqNSVOeTKI9oDawr3DT++HwGT/WFjDqYY=;
        b=gPdF8HArvgaXL0bkTMovwqjzylLEYkdMlMlLF1Jb9m5kCYtoDcLLfBA5UH6u3ELXyD
         GsI0UtHs77tc52W0mA1PFfdvsT2277vhrGBJ7vHW6GXFlaGqXYZtwO+KHjROJcGKTqmi
         Yd1N5UbOGfXN3rh7qaZfph6Je+eqmOUEP6Rhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gWZxPmoWwcfaoJPqVCJkWCmMeiwMmyTH06P6N+/KhZkI1z7ueu0kj7ZLLL4t2jwC/n
         dzw4D1fvgxE6bEfJl5/7CJOa47o3IeMjQe+kzNkpy5PUu29WaO4LAgs5iWWol6/c6err
         CUiFl3vB92DCp6DdKrf3KGlBnCI7t/qy4ASus=
Received: by 10.100.57.13 with SMTP id f13mr6407639ana.143.1223931785863;
        Mon, 13 Oct 2008 14:03:05 -0700 (PDT)
Received: by 10.64.142.13 with HTTP; Mon, 13 Oct 2008 14:03:05 -0700 (PDT)
In-Reply-To: <4ac8254d0810121436x6285d17ew631f04e768a6fb62@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98144>

Hi Shawn and list,

I've updated the patch to current Junio master.

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

@@ -330,14 +334,15 @@ static void finish(const unsigned char
*new_head, const char *msg)
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
@@ -871,6 +876,8 @@ int cmd_merge(int argc, const char **argv, const
char *prefix)

 	argc = parse_options(argc, argv, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if (!verbose && quiet)
+		show_diffstat = 0;

 	if (squash) {
 		if (!allow_fast_forward)
@@ -1012,10 +1019,11 @@ int cmd_merge(int argc, const char **argv,
const char *prefix)

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
@@ -181,5 +186,6 @@ merge_name=$(git fmt-merge-msg $log_arg
<"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
+exec git-merge $quiet $verbose $no_stat $no_commit \
+	$squash $no_ff $log_arg $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.6.0.2.GIT
