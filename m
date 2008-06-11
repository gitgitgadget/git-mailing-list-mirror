From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Wed, 11 Jun 2008 23:17:19 +0200
Message-ID: <1213219039-1211-1-git-send-email-vmiklos@frugalware.org>
References: <2acf029a4230f840e9f3f936e1949e01c774b4a2.1213217187.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 23:18:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Xhv-0006SX-1F
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbYFKVRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbYFKVRT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:17:19 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:34251 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbYFKVRS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:17:18 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id 3AD6D1DDC5B
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 23:17:16 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 1462A18DFDC; Wed, 11 Jun 2008 23:17:20 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <2acf029a4230f840e9f3f936e1949e01c774b4a2.1213217187.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84663>

This is like get_merge_bases() but it works for multiple heads, like
show-branch --merge-base.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Jun 11, 2008 at 10:50:32PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> +                     commit_list_append(i->item, &ret);

Oops, sorry. When I cherry-picked the old get_octopus_merge_bases(), I
picked the version that did not use commit_list_insert() here yet.

Here is the correct version, which one I have in my working branch.

 commit.c |   27 +++++++++++++++++++++++++++
 commit.h |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index bbf9c75..f9410d8 100644
--- a/commit.c
+++ b/commit.c
@@ -600,6 +600,33 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 	return result;
 }
 
+struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup)
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
+				bases = get_merge_bases(i->item, j->item, cleanup);
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
index 7f8c5ee..ca858ed 100644
--- a/commit.h
+++ b/commit.h
@@ -121,6 +121,7 @@ int read_graft_file(const char *graft_file);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
+extern struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup);
 
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
-- 
1.5.6.rc2.dirty
