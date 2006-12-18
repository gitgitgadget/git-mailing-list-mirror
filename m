X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Only warn about missing branch.<n>.merge in pull.
Date: Mon, 18 Dec 2006 04:12:06 -0500
Message-ID: <20061218091206.GA11284@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 09:12:24 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34730>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwEXm-0003Ew-Cn for gcvg-git@gmane.org; Mon, 18 Dec
 2006 10:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753577AbWLRJMT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 04:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbWLRJMT
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 04:12:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56123 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753577AbWLRJMS (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 04:12:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwEXa-000326-T3; Mon, 18 Dec 2006 04:12:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6745920FB65; Mon, 18 Dec 2006 04:12:07 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Commit 62b339a5 added a warning for git-pull to notify the user when
they have not configured the setting 'branch.<n>.merge' (where <n>
is the current branch) and no arguments were given to git-pull to
specify the branches to merge.

Unfortunately this warning also appears in git-fetch when no
arguments were supplied, as the warning is being output at the
same time that the contents of FETCH_HEAD is being determined.
This causes users who fetch into local tracking branches prior
to merging to receive unexpected/unnecessary warnings:

  $ git fetch
  Warning: No merge candidate found because value of config option
           "branch.sp/topic.merge" does not match any remote branch fetched.

This warning may also cause problems for other Porcelain that use
git-fetch as "plumbing", as the other Porcelain may not actually
use (or honor) the branch.<n>.merge configuration option.

Instead we should delay the warning about no matching branches until
we are actually in git-pull and are trying to setup the call to
git-merge to actually carry out the merge.  This way direct users
of git-fetch do not receive these warnings.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-parse-remote.sh |   10 ----------
 git-pull.sh         |   16 +++++++++++++++-
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index f27c3c2..7a1cf5c 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -134,7 +134,6 @@ canon_refs_list_for_fetch () {
 	# or the first one otherwise; add prefix . to the rest
 	# to prevent the secondary branches to be merged by default.
 	merge_branches=
-	found_mergeref=
 	curr_branch=
 	if test "$1" = "-d"
 	then
@@ -174,10 +173,6 @@ canon_refs_list_for_fetch () {
 			    dot_prefix= && break
 			done
 		fi
-		if test -z $dot_prefix
-		then
-			found_mergeref=true
-		fi
 		case "$remote" in
 		'') remote=HEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
@@ -198,11 +193,6 @@ canon_refs_list_for_fetch () {
 		fi
 		echo "${dot_prefix}${force}${remote}:${local}"
 	done
-	if test -z "$found_mergeref" -a "$curr_branch"
-	then
-		echo >&2 "Warning: No merge candidate found because value of config option
-         \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
-	fi
 }
 
 # Returns list of src: (no store), or src:dst (store)
diff --git a/git-pull.sh b/git-pull.sh
index e23beb6..d43a565 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -76,7 +76,21 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
 
 case "$merge_head" in
 '')
-	echo >&2 "No changes."
+	echo >&2 "warning: No branches were selected for merge."
+	if test $# = 0
+	then
+		branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
+		remote=$(git-repo-config --get-all "branch.$branch.remote")
+		if test -z "$remote"
+		then
+			echo >&2 "warning: (Config option 'branch.$branch.remote' not set.)"
+		fi
+		merge=$(git-repo-config --get-all "branch.$branch.merge")
+		if test -z "$merge"
+		then
+			echo >&2 "warning: (Config option 'branch.$branch.merge' not set.)"
+		fi
+	fi
 	exit 0
 	;;
 ?*' '?*)
-- 
