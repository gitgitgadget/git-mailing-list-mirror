From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 08/11] Allow for having for_each_ref() list some refs that
 aren't local
Date: Sat, 8 Mar 2008 18:04:18 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081804170.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY86x-0008Dx-B7
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYCHXEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYCHXEW
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:04:22 -0500
Received: from iabervon.org ([66.92.72.58]:42233 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbYCHXET (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:04:19 -0500
Received: (qmail 18602 invoked by uid 1000); 8 Mar 2008 23:04:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:04:18 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76608>

This is useful, for example, for listing the refs in a reference
repository during clone, when you don't have your own refs that cover
the objects that are in your alternate repository.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 refs.c |   18 ++++++++++++++++++
 refs.h |    9 +++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 1b0050e..356396d 100644
--- a/refs.c
+++ b/refs.c
@@ -159,6 +159,8 @@ static struct cached_refs {
 } cached_refs;
 static struct ref_list *current_ref;
 
+static struct ref_list *extra_refs;
+
 static void free_ref_list(struct ref_list *list)
 {
 	struct ref_list *next;
@@ -215,6 +217,17 @@ static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 	cached_refs->packed = sort_ref_list(list);
 }
 
+void add_extra_ref(const char *name, const unsigned char *sha1, int flag)
+{
+	extra_refs = add_ref(name, sha1, flag, extra_refs, NULL);
+}
+
+void clear_extra_refs(void)
+{
+	free_ref_list(extra_refs);
+	extra_refs = NULL;
+}
+
 static struct ref_list *get_packed_refs(void)
 {
 	if (!cached_refs.did_packed) {
@@ -535,6 +548,11 @@ static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
 	struct ref_list *packed = get_packed_refs();
 	struct ref_list *loose = get_loose_refs();
 
+	struct ref_list *extra;
+
+	for (extra = extra_refs; extra; extra = extra->next)
+		retval = do_one_ref(base, fn, trim, cb_data, extra);
+
 	while (packed && loose) {
 		struct ref_list *entry;
 		int cmp = strcmp(packed->name, loose->name);
diff --git a/refs.h b/refs.h
index 06abee1..06ad260 100644
--- a/refs.h
+++ b/refs.h
@@ -24,6 +24,15 @@ extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 
+/*
+ * Extra refs will be listed by for_each_ref() before any actual refs
+ * for the duration of this process or until clear_extra_refs() is
+ * called. Only extra refs added before for_each_ref() is called will
+ * be listed on a given call of for_each_ref().
+ */
+extern void add_extra_ref(const char *refname, const unsigned char *sha1, int flags);
+extern void clear_extra_refs(void);
+
 extern int peel_ref(const char *, unsigned char *);
 
 /** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
-- 
1.5.4.3.327.g614d7.dirty

