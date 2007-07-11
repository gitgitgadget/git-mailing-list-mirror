From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/4] Move add_name_decoration() and add_ref_decoration() to
 commit.[ch]
Date: Wed, 11 Jul 2007 02:28:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707110228470.4047@racer.site>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 11 03:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8R8G-0002DK-Er
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 03:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbXGKBgm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 21:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbXGKBgl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 21:36:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:55133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754504AbXGKBgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 21:36:41 -0400
Received: (qmail invoked by alias); 11 Jul 2007 01:36:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 11 Jul 2007 03:36:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ky4IicqskWz1+swwP92KhoFiItf7NlbdfJTQtxw
	R2PykXBpVmrRh3
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707110220340.4047@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52124>


The functions add_{name,ref}_decoration() should really be in
commit.[ch], since the struct they are modifying is there, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-log.c |   25 -------------------------
 commit.c      |   25 +++++++++++++++++++++++++
 commit.h      |    3 +++
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 13bae31..c14eea5 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -21,31 +21,6 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 /* this is in builtin-diff.c */
 void add_head(struct rev_info *revs);
 
-static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
-{
-	int plen = strlen(prefix);
-	int nlen = strlen(name);
-	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
-	memcpy(res->name, prefix, plen);
-	memcpy(res->name + plen, name, nlen + 1);
-	res->next = add_decoration(&name_decoration, obj, res);
-}
-
-static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
-{
-	struct object *obj = parse_object(sha1);
-	if (!obj)
-		return 0;
-	add_name_decoration("", refname, obj);
-	while (obj->type == OBJ_TAG) {
-		obj = ((struct tag *)obj)->tagged;
-		if (!obj)
-			break;
-		add_name_decoration("tag: ", refname, obj);
-	}
-	return 0;
-}
-
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
diff --git a/commit.c b/commit.c
index 03436b1..c0748ed 100644
--- a/commit.c
+++ b/commit.c
@@ -1553,3 +1553,28 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	free_commit_list(bases);
 	return ret;
 }
+
+void add_name_decoration(const char *prefix, const char *name, struct object *obj)
+{
+	int plen = strlen(prefix);
+	int nlen = strlen(name);
+	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
+	memcpy(res->name, prefix, plen);
+	memcpy(res->name + plen, name, nlen + 1);
+	res->next = add_decoration(&name_decoration, obj, res);
+}
+
+int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct object *obj = parse_object(sha1);
+	if (!obj)
+		return 0;
+	add_name_decoration("", refname, obj);
+	while (obj->type == OBJ_TAG) {
+		obj = ((struct tag *)obj)->tagged;
+		if (!obj)
+			break;
+		add_name_decoration("tag: ", refname, obj);
+	}
+	return 0;
+}
diff --git a/commit.h b/commit.h
index 467872e..787ae5e 100644
--- a/commit.h
+++ b/commit.h
@@ -29,6 +29,9 @@ struct name_decoration {
 	char name[1];
 };
 
+void add_name_decoration(const char *prefix, const char *name, struct object *obj);
+int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
+
 struct commit *lookup_commit(const unsigned char *sha1);
 struct commit *lookup_commit_reference(const unsigned char *sha1);
 struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
-- 
1.5.3.rc0.2783.gf3f7
