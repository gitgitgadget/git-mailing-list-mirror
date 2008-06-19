From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 08/11] Introduce get_octopus_merge_bases() in commit.c
Date: Fri, 20 Jun 2008 01:22:33 +0200
Message-ID: <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
 <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
 <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
 <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org>
 <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org>
 <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org>
 <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org>
 <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TUU-0006Vg-MX
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbYFSXXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbYFSXXB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:23:01 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46955 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbYFSXWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:22:54 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 339F71DDC5E
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:53 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B8E2718E0ED; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85570>

This is like get_merge_bases() but it works for multiple heads, like
show-branch --merge-base.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 commit.c |   27 +++++++++++++++++++++++++++
 commit.h |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index bbf9c75..6052ca3 100644
--- a/commit.c
+++ b/commit.c
@@ -600,6 +600,33 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 	return result;
 }
 
+struct commit_list *get_octopus_merge_bases(struct commit_list *in)
+{
+	struct commit_list *i, *j, *k, *ret = NULL;
+	struct commit_list **pptr = &ret;
+
+	for (i = in; i; i = i->next) {
+		if (!ret)
+			pptr = &commit_list_insert(i->item, pptr)->next;
+		else {
+			struct commit_list *new = NULL, *end = NULL;
+
+			for (j = ret; j; j = j->next) {
+				struct commit_list *bases;
+				bases = get_merge_bases(i->item, j->item, 1);
+				if (!new)
+					new = bases;
+				else
+					end->next = bases;
+				for (k = bases; k; k = k->next)
+					end = k;
+			}
+			ret = new;
+		}
+	}
+	return ret;
+}
+
 struct commit_list *get_merge_bases(struct commit *one,
 					struct commit *two, int cleanup)
 {
diff --git a/commit.h b/commit.h
index 7f8c5ee..dcec7fb 100644
--- a/commit.h
+++ b/commit.h
@@ -121,6 +121,7 @@ int read_graft_file(const char *graft_file);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
+extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
-- 
1.5.6
