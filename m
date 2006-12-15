X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Suggest use of 'git add' when 'nothing to commit' gets shown.
Date: Thu, 14 Dec 2006 19:13:50 -0500
Message-ID: <20061215001350.GA26755@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 00:14:04 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34447>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0i7-00070O-Ex for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752052AbWLOANz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWLOANz
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:13:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44235 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752052AbWLOANy (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 19:13:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv0hp-0007II-QE; Thu, 14 Dec 2006 19:13:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 698A220FB65; Thu, 14 Dec 2006 19:13:50 -0500 (EST)
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

Suggested by Andy Parkins in his Git 'niggles' list
(<200612132237.10051.andyparkins@gmail.com>).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-commit.sh |    2 +-
 wt-status.c   |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 05828bb..fb69e11 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -515,7 +515,7 @@ then
 	current="$(git-rev-parse --verify HEAD)"
 else
 	if [ -z "$(git-ls-files)" ]; then
-		echo >&2 Nothing to commit
+		echo >&2 "Nothing to commit (use \"git add\" include for commit)"
 		exit 1
 	fi
 	PARENTS=""
diff --git a/wt-status.c b/wt-status.c
index 6e9414d..f9ed54f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -163,7 +163,7 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 	int i;
 	if (q->nr)
 		wt_status_print_header("Changed but not updated",
-				"use git-add on files to include for commit");
+				"use \"git add\" on files to include for commit");
 	for (i = 0; i < q->nr; i++)
 		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
 	if (q->nr)
@@ -250,7 +250,7 @@ static void wt_status_print_untracked(const struct wt_status *s)
 		}
 		if (!shown_header) {
 			wt_status_print_header("Untracked files",
-				"use \"git add\" to add to commit");
+				"use \"git add\" on files to include for commit");
 			shown_header = 1;
 		}
 		color_printf(color(WT_STATUS_HEADER), "#\t");
@@ -292,7 +292,8 @@ void wt_status_print(struct wt_status *s)
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
 	if (!s->commitable)
-		printf("%s\n", s->amend ? "# No changes" : "nothing to commit");
+		printf("%s (use \"git add\" include for commit)\n",
+			s->amend ? "# No changes" : "Nothing to commit");
 }
 
 int git_status_config(const char *k, const char *v)
-- 
1.4.4.2.g72f5
