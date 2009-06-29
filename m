From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: git log: add '--merges' flag to match '--no-merges'
Date: Mon, 29 Jun 2009 10:28:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906291015210.3605@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 29 19:34:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLKkn-0005qC-Dl
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 19:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbZF2ReP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 13:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZF2ReP
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 13:34:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43163 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116AbZF2ReO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 13:34:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5THSPSM002962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2009 10:28:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5THSPoj003552;
	Mon, 29 Jun 2009 10:28:25 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122450>


I do various statistics on git, and one of the things I look at is merges, 
because they are often interesting events to count ("how many merges vs 
how much 'real development'" kind of statistics). And you can do it with 
some fairly straightforward scripting, ie

	git rev-list --parents HEAD |
		grep ' .* ' |
		git diff-tree --always -s --pretty=oneline --stdin |
		less -S

will do it.

But I finally got irritated with the fact that we can skip merges with 
'--no-merges', but we can't do the trivial reverse operation.

So this just adds a '--merges' flag that _only_ shows merges. Now you can 
do the above with just a

	git log --merges --pretty=oneline

which is a lot simpler. It also means that we automatically get a lot of 
statistics for free, eg

	git shortlog -ns --merges

does exactly what you'd want it to do.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 revision.c |    4 ++++
 revision.h |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index bf58448..a31434b 100644
--- a/revision.c
+++ b/revision.c
@@ -1077,6 +1077,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_all = 1;
 	} else if (!strcmp(arg, "--remove-empty")) {
 		revs->remove_empty_trees = 1;
+	} else if (!strcmp(arg, "--merges")) {
+		revs->merges_only = 1;
 	} else if (!strcmp(arg, "--no-merges")) {
 		revs->no_merges = 1;
 	} else if (!strcmp(arg, "--boundary")) {
@@ -1676,6 +1678,8 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 		return commit_ignore;
 	if (revs->no_merges && commit->parents && commit->parents->next)
 		return commit_ignore;
+	if (revs->merges_only && !(commit->parents && commit->parents->next))
+		return commit_ignore;
 	if (!commit_match(commit, revs))
 		return commit_ignore;
 	if (revs->prune && revs->dense) {
diff --git a/revision.h b/revision.h
index 227164c..fb74492 100644
--- a/revision.h
+++ b/revision.h
@@ -36,6 +36,7 @@ struct rev_info {
 	unsigned int	dense:1,
 			prune:1,
 			no_merges:1,
+			merges_only:1,
 			no_walk:1,
 			show_all:1,
 			remove_empty_trees:1,
