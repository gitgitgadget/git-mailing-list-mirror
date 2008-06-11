From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 08/10] Introduce get_octopus_merge_bases() in commit.c
Date: Wed, 11 Jun 2008 22:50:32 +0200
Message-ID: <2acf029a4230f840e9f3f936e1949e01c774b4a2.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
 <4818a0b71b7f6b44ef49621045a5871458ba5c38.1213217187.git.vmiklos@frugalware.org>
 <dedcc8309fed3282df455bec7fbc9d0f8275b74b.1213217187.git.vmiklos@frugalware.org>
 <9a5a141bd92756b529514579818a2c59a1a03899.1213217187.git.vmiklos@frugalware.org>
 <c72207b02d37f3d8c064534264219f4dd38c7559.1213217187.git.vmiklos@frugalware.org>
 <7b7cdd9349feee76ad97243df807f8f360484083.1213217187.git.vmiklos@frugalware.org>
 <50a291213098f6da9869354c5ede54c2695570a8.1213217187.git.vmiklos@frugalware.org>
 <276ad490f3730bf6bb061d7b3d84975ac902b0a7.1213217187.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 22:53:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XIt-0000Zk-4d
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbYFKUuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbYFKUuw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:50:52 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:32883 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbYFKUuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:50:37 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id 01C8A1DDC65
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 22:50:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id E661D18DFE5; Wed, 11 Jun 2008 22:50:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <276ad490f3730bf6bb061d7b3d84975ac902b0a7.1213217187.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84656>

This is like get_merge_bases() but it works for multiple heads, like
show-branch --merge-base.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 commit.c |   32 ++++++++++++++++++++++++++++++++
 commit.h |    1 +
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index bbf9c75..13fa39d 100644
--- a/commit.c
+++ b/commit.c
@@ -600,6 +600,38 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 	return result;
 }
 
+struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup)
+{
+	struct commit_list *i, *j, *k, *ret = NULL;
+
+	for (i = in; i; i = i->next) {
+		if (!ret)
+			commit_list_append(i->item, &ret);
+		else {
+			struct commit_list *new = NULL, *end = NULL;
+
+			for (j = ret; j; j = j->next) {
+				struct commit_list *bases;
+				bases = get_merge_bases(i->item, j->item, cleanup);
+				/*
+				 * Now we just append bases to new, but
+				 * calling commit_list_append() for each
+				 * item would be expensive, so do it by
+				 * hand.
+				 */
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
