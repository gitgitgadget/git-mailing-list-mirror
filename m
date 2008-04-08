From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add --only-merges flag to display only merge commits.
Date: Tue, 8 Apr 2008 22:36:48 +0200
Message-ID: <20080408203648.GS11574@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 22:37:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjKZT-00089K-Sb
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 22:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYDHUgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYDHUgw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 16:36:52 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48498 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039AbYDHUgv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 16:36:51 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5BAD21B2506;
	Tue,  8 Apr 2008 22:36:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 75D7644659;
	Tue,  8 Apr 2008 22:33:31 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A07CA1190A4E; Tue,  8 Apr 2008 22:36:48 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79027>

This is the opposite of git-rev-list --no-merges: It will hide commits
with single or no parent.

It is useful if a maintainer has a lot of commits between tags and
usually each feature is developed in its own topic branch.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I just wanted to see the list of merges since the last tag in a repo
where we have 1000+ commits and about 20 merges and found that there is
no easy way to do so.

As a side effect, git rev-list --no-merges --only-merges will list
nothing, but that's logical IMHO.

 Documentation/git-rev-list.txt     |    1 +
 Documentation/rev-list-options.txt |    4 ++++
 builtin-rev-list.c                 |    1 +
 builtin-rev-parse.c                |    1 +
 revision.c                         |    7 +++++++
 revision.h                         |    1 +
 6 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index d80cdf5..17c26bc 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [ \--min-age=timestamp ]
 	     [ \--sparse ]
 	     [ \--no-merges ]
+	     [ \--only-merges ]
 	     [ \--first-parent ]
 	     [ \--remove-empty ]
 	     [ \--full-history ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2648a55..fc1cf0f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -176,6 +176,10 @@ endif::git-rev-list[]
 
 	Do not print commits with more than one parent.
 
+--only-merges::
+
+	Do not print commits with less than two parents.
+
 --first-parent::
 	Follow only the first parent commit upon seeing a merge
 	commit.  This option can give a better overview when
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index edc0bd3..35c9422 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -23,6 +23,7 @@ static const char rev_list_usage[] =
 "    --min-age=epoch\n"
 "    --sparse\n"
 "    --no-merges\n"
+"    --only-merges\n"
 "    --remove-empty\n"
 "    --all\n"
 "    --branches\n"
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 0351d54..66a6b62 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -47,6 +47,7 @@ static int is_rev_argument(const char *arg)
 		"--max-count=",
 		"--min-age=",
 		"--no-merges",
+		"--only-merges",
 		"--objects",
 		"--objects-edge",
 		"--parents",
diff --git a/revision.c b/revision.c
index 196fedc..1f92a1a 100644
--- a/revision.c
+++ b/revision.c
@@ -1127,6 +1127,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->no_merges = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--only-merges")) {
+				revs->only_merges = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--boundary")) {
 				revs->boundary = 1;
 				continue;
@@ -1517,6 +1521,9 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 		return commit_ignore;
 	if (revs->no_merges && commit->parents && commit->parents->next)
 		return commit_ignore;
+	if (revs->only_merges && ((commit->parents && !commit->parents->next) ||
+			!commit->parents))
+		return commit_ignore;
 	if (!commit_match(commit, revs))
 		return commit_ignore;
 	if (revs->prune && revs->dense) {
diff --git a/revision.h b/revision.h
index c8b3b94..c40cf33 100644
--- a/revision.h
+++ b/revision.h
@@ -32,6 +32,7 @@ struct rev_info {
 	unsigned int	dense:1,
 			prune:1,
 			no_merges:1,
+			only_merges:1,
 			no_walk:1,
 			show_all:1,
 			remove_empty_trees:1,
-- 
1.5.4.5
