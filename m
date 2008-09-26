From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Fri, 26 Sep 2008 02:35:59 +0200
Message-ID: <1222389359-22191-1-git-send-email-vmiklos@frugalware.org>
References: <20080925235029.GA15837@neumann>
Cc: git@vger.kernel.org
To: SZEDER Gabor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Sep 26 02:36:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj1KG-0002lR-Oy
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 02:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbYIZAfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 20:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbYIZAfo
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 20:35:44 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:48168 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbYIZAfn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 20:35:43 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id ECDB2149C60;
	Fri, 26 Sep 2008 02:35:40 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D2F1C19E7C3; Fri, 26 Sep 2008 02:35:59 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <20080925235029.GA15837@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96821>

reduce_heads() can filter "duplicated" parents, where "duplicated"
means: A is duplicated if both A and B are parent candidates and A is
reachable from B. Doing so in builtin-merge makes sense, but not in
builtin-commit, because this breaks git merge --no-commit --no-ff.

Test case by SZEDER Gabor <szeder@ira.uka.de>
---

Here is a patch that fixes the problem for me. In fact I think it would
be nice if somehow git-merge could tell git-commit that 'do not reduce
heads now' and in other cases it could still do so, but:

	1) This is not something git-commit did in the past, either.

	2) I have no idea what would be the right interface to do so
           (maybe a new MERGE_FOO file under .git?)

 builtin-commit.c |    1 -
 t/t7600-merge.sh |    9 +++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 55e1087..9daab0a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -988,7 +988,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		reflog_msg = "commit";
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 	}
-	parents = reduce_heads(parents);
 
 	/* Finally, get the commit message */
 	strbuf_init(&sb, 0);
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9516f54..98cfc53 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -511,4 +511,13 @@ test_expect_success 'in-index merge' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge --no-ff --no-commit && commit' '
+	git reset --hard c0 &&
+	git merge --no-ff --no-commit c1 &&
+	EDITOR=: git commit &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.6.0.2
