From: "Bernhard R. Link" <brlink@debian.org>
Subject: [PATCH v2] Let format-patch and rebase ignore trivial merges.
Date: Fri, 18 Dec 2009 16:11:02 +0100
Message-ID: <20091218151102.GB7211@pcpool00.mathematik.uni-freiburg.de>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de> <4B29106C.1040501@viscovery.net> <7vaaxhfcfe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 16:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLeU9-0007l6-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 16:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbZLRPLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 10:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbZLRPLH
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 10:11:07 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:36355
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754210AbZLRPLF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 10:11:05 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLeTu-00050c-PB; Fri, 18 Dec 2009 16:11:02 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLeTu-0003GJ-My; Fri, 18 Dec 2009 16:11:02 +0100
Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com,
	j.sixt@viscovery.net
Content-Disposition: inline
In-Reply-To: <7vaaxhfcfe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135414>

As git rebase and git format-patch linearize commits,
having the same change in different branches causes in the
best case duplicate patches in the produced series and in the
worst case conflicts. If there are trivial merges involved
(i.e. merges that do not change the tree), then this patch
will cause git to only look at one branch, thereby avoiding
duplicates and reducing the chance of conflicts.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---
 builtin-log.c              |    1 +
 git-rebase--interactive.sh |    2 +-
 git-rebase.sh              |    2 +-
 revision.c                 |    7 ++++++-
 revision.h                 |    1 +
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1766349..efc2f40 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -960,6 +960,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
+	rev.prune_tree = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0bd3bf7..e5c134b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -703,7 +703,7 @@ first and then run 'git rebase --continue' again."
 		fi
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse --left-right --topo-order \
-			$REVISIONS | \
+			$REVISIONS -- . | \
 			sed -n "s/^>//p" | while read shortsha1 rest
 		do
 			if test t != "$PRESERVE_MERGES"
diff --git a/git-rebase.sh b/git-rebase.sh
index b121f45..dab6949 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -539,7 +539,7 @@ echo "$head_name" > "$dotest/head-name"
 echo "$GIT_QUIET" > "$dotest/quiet"
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
+for cmt in `git rev-list --reverse --no-merges "$revisions" -- .`
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
diff --git a/revision.c b/revision.c
index a8a3c3a..b27b682 100644
--- a/revision.c
+++ b/revision.c
@@ -1408,8 +1408,13 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		}
 	}
 
-	if (prune_data)
+	if (prune_data) {
 		revs->prune_data = get_pathspec(revs->prefix, prune_data);
+	} else if (revs->prune_tree) {
+		/* limit whole tree (limits trivial merges to one side) */
+		static const char *whole_tree[2] = { "", NULL };
+		revs->prune_data = whole_tree;
+	}
 
 	if (revs->def == NULL)
 		revs->def = def;
diff --git a/revision.h b/revision.h
index d368003..d007aaa 100644
--- a/revision.h
+++ b/revision.h
@@ -38,6 +38,7 @@ struct rev_info {
 	/* Traversal flags */
 	unsigned int	dense:1,
 			prune:1,
+			prune_tree:1,
 			no_merges:1,
 			merges_only:1,
 			no_walk:1,
