X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add support to git-branch to show local and remote branches
Date: Fri, 3 Nov 2006 10:52:15 +0000
Message-ID: <200611031052.16095.andyparkins@gmail.com>
References: <7v64dxl0bf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 10:52:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v64dxl0bf.fsf@assigned-by-dhcp.cox.net>
X-TUID: 08a9c8cc7bf38e52
X-UID: 161
X-Length: 5381
Content-Disposition: inline
X-OriginalArrivalTime: 03 Nov 2006 10:53:23.0966 (UTC) FILETIME=[48B339E0:01C6FF36]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30821>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfwev-0006ia-Th for gcvg-git@gmane.org; Fri, 03 Nov
 2006 11:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753209AbWKCKwX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 05:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbWKCKwX
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 05:52:23 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:23737 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1753209AbWKCKwW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 05:52:22 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Fri, 3 Nov 2006 10:53:23 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gfwen-0004ki-00 for <git@vger.kernel.org>; Fri, 03 Nov
 2006 10:52:17 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Instead of storing a list of refnames in append_ref, a list of structures is
created.  Each of these stores the refname and a symbolic constant representing
its type.

The creation of the list is filtered based on a command line switch; no switch
means "local branches only", "-r" means "remote branches only" (as they always
did); but now "-a" means "local branches or remote branches".

As a side effect, the list is now not global, but allocated in print_ref_list()
where it used.

Also a memory leak is plugged, the memory allocated during the list creation
was never freed.  This is now done in the new function, tidy_ref_list()

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-branch.c |   95 +++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 368b68e..6dd33ee 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -79,46 +79,100 @@ static void delete_branches(int argc, co
 	}
 }
 
-static int ref_index, ref_alloc;
-static char **ref_list;
+#define REF_UNKNOWN_TYPE    0x00
+#define REF_LOCAL_BRANCH    0x01
+#define REF_REMOTE_BRANCH   0x02
+#define REF_TAG             0x04
+
+struct ref_item {
+	char *name;
+	unsigned int type;
+};
+
+struct ref_list {
+	int index, alloc;
+	struct ref_item *list;
+	int type_wanted;
+};
 
 static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 		void *cb_data)
 {
-	if (ref_index >= ref_alloc) {
-		ref_alloc = alloc_nr(ref_alloc);
-		ref_list = xrealloc(ref_list, ref_alloc * sizeof(char *));
+	struct ref_list *ref_list = (struct ref_list*)(cb_data);
+	struct ref_item *newitem;
+	int type = REF_UNKNOWN_TYPE;
+
+	/* Detect type */
+	if (!strncmp(refname, "refs/heads/", 11)) {
+		type = REF_LOCAL_BRANCH;
+		refname += 11;
+	} else if (!strncmp(refname, "refs/remotes/", 13)) {
+		type = REF_REMOTE_BRANCH;
+		refname += 13;
+	} else if (!strncmp(refname, "refs/tags/", 10)) {
+		type = REF_TAG;
+		refname += 10;
+	}
+
+	/* Don't add type the caller doesn't want */
+	if ((type & ref_list->type_wanted) == 0) {
+		return 0;
+	}
+
+	/* Resize buffer */
+	if (ref_list->index >= ref_list->alloc) {
+		ref_list->alloc = alloc_nr(ref_list->alloc);
+		ref_list->list = xrealloc(ref_list->list,
+				ref_list->alloc * sizeof(struct ref_item));
 	}
 
-	ref_list[ref_index++] = xstrdup(refname);
+	/* Record the new item */
+	newitem = &(ref_list->list[ref_list->index++]);
+	newitem->name = xstrdup(refname);
+	newitem->type = type;
 
 	return 0;
 }
 
+static int tidy_ref_list( struct ref_list *ref_list )
+{
+	int i;
+	for (i = 0; i < ref_list->index; i++) {
+		free( ref_list->list[i].name );
+	}
+	free( ref_list->list );
+}
+
 static int ref_cmp(const void *r1, const void *r2)
 {
+	struct ref_item *c1 = (struct ref_item*)(r1),
+					*c2 = (struct ref_item*)(r2);
+	if( c1->type != c2->type )
+		return c1->type - c2->type;
 	return strcmp(*(char **)r1, *(char **)r2);
 }
 
-static void print_ref_list(int remote_only)
+static void print_ref_list( int type_wanted )
 {
 	int i;
 	char c;
+	struct ref_list ref_list;
 
-	if (remote_only)
-		for_each_remote_ref(append_ref, NULL);
-	else
-		for_each_branch_ref(append_ref, NULL);
+	memset( &ref_list, 0, sizeof( ref_list ) );
+	ref_list.type_wanted = type_wanted;
+	for_each_ref(append_ref, &ref_list);
 
-	qsort(ref_list, ref_index, sizeof(char *), ref_cmp);
+	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
-	for (i = 0; i < ref_index; i++) {
+	for (i = 0; i < ref_list.index; i++) {
 		c = ' ';
-		if (!strcmp(ref_list[i], head))
+		if (!strcmp(ref_list.list[i].name, head))
 			c = '*';
 
-		printf("%c %s\n", c, ref_list[i]);
+		printf("%c %s\n", c, ref_list.list[i].name);
 	}
+
+	tidy_ref_list( &ref_list );
 }
 
 static void create_branch(const char *name, const char *start,
@@ -160,9 +214,10 @@ static void create_branch(const char *na
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, force_delete = 0, force_create = 0, remote_only = 0;
+	int delete = 0, force_delete = 0, force_create = 0;
 	int reflog = 0;
 	int i;
+	int type_wanted = REF_LOCAL_BRANCH;
 
 	git_config(git_default_config);
 
@@ -189,7 +244,11 @@ int cmd_branch(int argc, const char **ar
 			continue;
 		}
 		if (!strcmp(arg, "-r")) {
-			remote_only = 1;
+			type_wanted = REF_REMOTE_BRANCH;
+			continue;
+		}
+		if (!strcmp(arg, "-a")) {
+			type_wanted = REF_LOCAL_BRANCH | REF_REMOTE_BRANCH;
 			continue;
 		}
 		if (!strcmp(arg, "-l")) {
@@ -209,7 +268,7 @@ int cmd_branch(int argc, const char **ar
 	if (delete)
 		delete_branches(argc - i, argv + i, force_delete);
 	else if (i == argc)
-		print_ref_list(remote_only);
+		print_ref_list(type_wanted);
 	else if (i == argc - 1)
 		create_branch(argv[i], head, force_create, reflog);
 	else if (i == argc - 2)
-- 
1.4.3.2
