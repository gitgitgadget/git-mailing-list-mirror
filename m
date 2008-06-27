From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 07/15] Introduce get_octopus_merge_bases() in commit.c
Date: Fri, 27 Jun 2008 18:22:00 +0200
Message-ID: <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
 <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk2-0004E3-OC
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760037AbYF0QWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760704AbYF0QWM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:12 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45333 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759720AbYF0QWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:09 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id D45D61DDC60;
	Fri, 27 Jun 2008 18:22:05 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 1A1DF18E827; Fri, 27 Jun 2008 18:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86585>

This is like get_merge_bases() but it works for multiple heads, like
show-branch --merge-base.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
