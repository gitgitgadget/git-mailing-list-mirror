X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Suggest use of "git add file1 file2" when there is nothing to commit.
Date: Fri, 15 Dec 2006 21:53:09 -0500
Message-ID: <20061216025309.GA19955@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 02:53:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34587>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvPfw-0001XS-1x for gcvg-git@gmane.org; Sat, 16 Dec
 2006 03:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750866AbWLPCxO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 21:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbWLPCxO
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 21:53:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56318 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750866AbWLPCxO (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 21:53:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvPfY-0008Gb-Pr; Fri, 15 Dec 2006 21:53:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3EF0A20FB65; Fri, 15 Dec 2006 21:53:10 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

If a user modifies files and runs 'git commit' (without the very
useful -a option) and they have not yet updated the index they
are probably coming from another SCM-like tool which would perform
the same as 'git commit -a' in this case.  Showing the user their
current status and a final line of "nothing to commit" is not very
reassuring, as the user might believe that Git did not recognize
their files were modified.

Instead we can suggest as part of the 'nothing to commit' message
that the user invoke 'git add' to add files to their next commit.

Suggested by Andy Parkins' Git 'niggles' list
(<200612132237.10051.andyparkins@gmail.com>).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-commit.sh |    2 +-
 wt-status.c   |   11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 05828bb..2672def 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -515,7 +515,7 @@ then
 	current="$(git-rev-parse --verify HEAD)"
 else
 	if [ -z "$(git-ls-files)" ]; then
-		echo >&2 Nothing to commit
+		echo >&2 'nothing to commit (use "git add file1 file2" to include for commit)'
 		exit 1
 	fi
 	PARENTS=""
diff --git a/wt-status.c b/wt-status.c
index 6e9414d..2173d4f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -15,6 +15,7 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
 	"\033[31m", /* WT_STATUS_CHANGED: red */
 	"\033[31m", /* WT_STATUS_UNTRACKED: red */
 };
+static const char* use_add_msg = "use \"git add file1 file2\" to include for commit";
 
 static int parse_status_slot(const char *var, int offset)
 {
@@ -162,8 +163,7 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 {
 	int i;
 	if (q->nr)
-		wt_status_print_header("Changed but not updated",
-				"use git-add on files to include for commit");
+		wt_status_print_header("Changed but not updated", use_add_msg);
 	for (i = 0; i < q->nr; i++)
 		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
 	if (q->nr)
@@ -249,8 +249,7 @@ static void wt_status_print_untracked(const struct wt_status *s)
 				continue;
 		}
 		if (!shown_header) {
-			wt_status_print_header("Untracked files",
-				"use \"git add\" to add to commit");
+			wt_status_print_header("Untracked files", use_add_msg);
 			shown_header = 1;
 		}
 		color_printf(color(WT_STATUS_HEADER), "#\t");
@@ -292,7 +291,9 @@ void wt_status_print(struct wt_status *s)
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
 	if (!s->commitable)
-		printf("%s\n", s->amend ? "# No changes" : "nothing to commit");
+		printf("%s (%s)\n",
+			s->amend ? "# No changes" : "nothing to commit",
+			use_add_msg);
 }
 
 int git_status_config(const char *k, const char *v)
-- 
1.4.4.2.g053a
