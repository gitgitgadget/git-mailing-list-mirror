From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 09/10] Introduce filter_independent() in commit.c
Date: Wed, 11 Jun 2008 22:50:33 +0200
Message-ID: <456e3b118a83f446e9dc85e5aa4a2c6686a91626.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
 <4818a0b71b7f6b44ef49621045a5871458ba5c38.1213217187.git.vmiklos@frugalware.org>
 <dedcc8309fed3282df455bec7fbc9d0f8275b74b.1213217187.git.vmiklos@frugalware.org>
 <9a5a141bd92756b529514579818a2c59a1a03899.1213217187.git.vmiklos@frugalware.org>
 <c72207b02d37f3d8c064534264219f4dd38c7559.1213217187.git.vmiklos@frugalware.org>
 <7b7cdd9349feee76ad97243df807f8f360484083.1213217187.git.vmiklos@frugalware.org>
 <50a291213098f6da9869354c5ede54c2695570a8.1213217187.git.vmiklos@frugalware.org>
 <276ad490f3730bf6bb061d7b3d84975ac902b0a7.1213217187.git.vmiklos@frugalware.org>
 <2acf029a4230f840e9f3f936e1949e01c774b4a2.1213217187.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 22:53:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XIr-0000Zk-Af
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbYFKUus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYFKUur
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:50:47 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:32880 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYFKUuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:50:37 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id ADEAC1DDC63
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 22:50:32 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id E286418DFE3; Wed, 11 Jun 2008 22:50:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <2acf029a4230f840e9f3f936e1949e01c774b4a2.1213217187.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84658>

This is similar to git-show-branch --independent: It filters out commits
which are reachable from any other item from the input list.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 commit.c |   16 ++++++++++++++++
 commit.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 13fa39d..54079df 100644
--- a/commit.c
+++ b/commit.c
@@ -710,3 +710,19 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	free_commit_list(bases);
 	return ret;
 }
+
+struct commit_list *filter_independent(unsigned char *head,
+	struct commit_list *heads)
+{
+	struct commit_list *i, *bases, *ret = NULL;
+	struct commit_list **pptr = &ret;
+
+	commit_list_insert(lookup_commit(head), &heads);
+
+	bases = get_octopus_merge_bases(heads, 0);
+
+	for (i = heads; i; i = i->next)
+		if (!(i->item->object.flags & RESULT))
+			pptr = &commit_list_insert(i->item, pptr)->next;
+	return ret;
+}
diff --git a/commit.h b/commit.h
index ca858ed..22839ac 100644
--- a/commit.h
+++ b/commit.h
@@ -131,6 +131,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 
 int in_merge_bases(struct commit *, struct commit **, int);
+struct commit_list *filter_independent(unsigned char *head, struct commit_list *heads);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix);
 extern int rerere(void);
-- 
1.5.6.rc2.dirty
