From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 09/11] Introduce filter_independent() in commit.c
Date: Fri, 20 Jun 2008 01:22:34 +0200
Message-ID: <0d95a099ad6e47c60894983ab7bfd94a3aeddce7.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
 <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
 <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
 <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org>
 <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org>
 <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org>
 <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org>
 <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org>
 <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:24:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TUR-0006Vg-0Q
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbYFSXWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbYFSXWr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:22:47 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46949 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbYFSXWl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:22:41 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 87DB61DDC5F
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:39 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id BE97918E0EE; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85569>

This is similar to git-show-branch --independent: It filters out commits
which are reachable from any other item from the input list.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 commit.c |   16 ++++++++++++++++
 commit.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 6052ca3..0dbf4b7 100644
--- a/commit.c
+++ b/commit.c
@@ -705,3 +705,19 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
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
+	bases = get_octopus_merge_bases(heads);
+
+	for (i = heads; i; i = i->next)
+		if (!(i->item->object.flags & RESULT))
+			pptr = &commit_list_insert(i->item, pptr)->next;
+	return ret;
+}
diff --git a/commit.h b/commit.h
index dcec7fb..0aef7e4 100644
--- a/commit.h
+++ b/commit.h
@@ -131,6 +131,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 
 int in_merge_bases(struct commit *, struct commit **, int);
+struct commit_list *filter_independent(unsigned char *head, struct commit_list *heads);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix);
 extern int rerere(void);
-- 
1.5.6
