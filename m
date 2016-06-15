From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 6/8] Allow for having for_each_ref() list extra refs
Date: Sun, 27 Apr 2008 13:39:24 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804271259490.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:40:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqArJ-0007gU-FQ
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502AbYD0Rjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757560AbYD0Rjd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:39:33 -0400
Received: from iabervon.org ([66.92.72.58]:42195 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757119AbYD0Rjb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:39:31 -0400
Received: (qmail 12795 invoked by uid 1000); 27 Apr 2008 17:39:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Apr 2008 17:39:24 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80468>

These refs can be anything, but they are most likely useful as
pointing to objects that you know are in the object database but don't
have any regular refs for. For example, when cloning with --reference,
the refs in this repository should be listed as objects that we have,
even though we don't have refs in our newly-created repository for
them yet.

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
1.5.4.3.610.gea6cd
