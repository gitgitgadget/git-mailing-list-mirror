From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] git-apply: Don't barf when --stat'ing a diff with no line changes.
Date: Tue, 21 Jun 2005 17:14:30 +0200
Message-ID: <20050621151430.GA26628@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 17:17:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkkUf-0000mL-T7
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 17:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVFUPSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 11:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFUPRW
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 11:17:22 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:64676 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S262112AbVFUPOt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 11:14:49 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5LFEU6A010595;
	Tue, 21 Jun 2005 17:14:35 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 7564B6FE9; Tue, 21 Jun 2005 17:14:30 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Diffs with only mode changes didn't pass through git-apply --stat.
E.g.,

sh-3.00$ cg-diff -p | cat
diff --git a/autogen.sh b/autogen.sh
old mode 100644
new mode 100755
diff --git a/cdd2polylib.pl b/cdd2polylib.pl
old mode 100644
new mode 100755
sh-3.00$ cg-diff -p | git-apply --stat
Floating point exception
sh-3.00$ cg-diff -p | ~/src/git-linus/git-apply --stat
 autogen.sh     |    0 
 cdd2polylib.pl |    0 
 2 files changed, 0 insertions(+), 0 deletions(-)

skimo
--
git-apply: Don't barf when --stat'ing a diff with no line changes.

---
commit 2c796d01298b7e5bb5518927bf85aa461603a5c5
tree f80d68da66ee8c2ec1d491ef92c95e49db2016cd
parent 0795495388d703dc84110a9a7917dd6ec9516bb4
author Sven Verdoolaege <skimo@liacs.nl> Tue, 21 Jun 2005 17:09:27 +0200
committer Sven Verdoolaege <skimo@liacs.nl> Tue, 21 Jun 2005 17:09:27 +0200

 apply.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -751,9 +751,11 @@ static void show_stats(struct patch *pat
 	del = patch->lines_deleted;
 	total = add + del;
 
-	total = (total * max + max_change / 2) / max_change;
-	add = (add * max + max_change / 2) / max_change;
-	del = total - add;
+	if (max_change > 0) {
+		total = (total * max + max_change / 2) / max_change;
+		add = (add * max + max_change / 2) / max_change;
+		del = total - add;
+	}
 	printf(" %-*s |%5d %.*s%.*s\n",
 		len, name, patch->lines_added + patch->lines_deleted,
 		add, pluses, del, minuses);
