From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 09/10] Introduce get_octopus_merge_bases() in commit.c
Date: Thu,  5 Jun 2008 22:44:35 +0200
Message-ID: <e13c0c2e9c8b0ebef84ac062bf05c05f729b3b20.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org>
 <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
 <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org>
 <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org>
 <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org>
 <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org>
 <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org>
 <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:46:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MLf-0006Hd-BS
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbYFEUoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbYFEUop
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:44:45 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46518 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbYFEUoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:44:34 -0400
Received: from vmobile.example.net (dsl5401CC68.pool.t-online.hu [84.1.204.104])
	by yugo.frugalware.org (Postfix) with ESMTP id 98F191DDC64
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 22:44:30 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D552418E2BE; Thu,  5 Jun 2008 22:44:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83975>

This is like get_merge_bases() but it works for multiple heads, like
show-branch --merge-base.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 commit.c |   32 ++++++++++++++++++++++++++++++++
 commit.h |    1 +
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 6ba5acb..c09b305 100644
--- a/commit.c
+++ b/commit.c
@@ -625,6 +625,38 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
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
index 5d9ac43..201782d 100644
--- a/commit.h
+++ b/commit.h
@@ -122,6 +122,7 @@ int read_graft_file(const char *graft_file);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
+extern struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup);
 
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
-- 
1.5.6.rc0.dirty
