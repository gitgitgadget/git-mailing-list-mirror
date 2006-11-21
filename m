X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add support to git-branch to show local and remote branches
Date: Tue, 21 Nov 2006 19:31:24 +0000
Message-ID: <200611211931.24868.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 19:34:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=R9TNlPyz+v/kTfepDwj8jujQxaQvDTIZtzjKlStSra/TMrmTEUCpYClPz/dn6051yy1Yf/BOKwzhZ8Fog4+7ANkp62dQ26FtQBguxcdWHbIjYrryqcymLuvX+xhu4wqY44py+JO2lT3bCdkM1pzt5ZOosFqf2i6L9+3R8tGz4FE=
X-TUID: 9c4d6ea179dd7b99
X-UID: 166
X-Length: 5564
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32029>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmbNs-0006YO-0l for gcvg-git@gmane.org; Tue, 21 Nov
 2006 20:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031336AbWKUTeR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 14:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031335AbWKUTeR
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 14:34:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:47627 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1031336AbWKUTeP
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 14:34:15 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1626245ugc for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 11:34:13 -0800 (PST)
Received: by 10.67.27.3 with SMTP id e3mr1748195ugj.1164137652213; Tue, 21
 Nov 2006 11:34:12 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id u6sm10553395uge.2006.11.21.11.34.10; Tue, 21 Nov
 2006 11:34:11 -0800 (PST)
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
 builtin-branch.c |   97 +++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 368b68e..9e0be22 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -11,7 +11,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-"git-branch (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | [-r]";
+"git-branch (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | [-r] | [-a]";
 
 
 static const char *head;
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
+	unsigned int kind;
+};
+
+struct ref_list {
+	int index, alloc;
+	struct ref_item *list;
+	int kinds;
+};
 
 static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 		void *cb_data)
 {
-	if (ref_index >= ref_alloc) {
-		ref_alloc = alloc_nr(ref_alloc);
-		ref_list = xrealloc(ref_list, ref_alloc * sizeof(char *));
+	struct ref_list *ref_list = (struct ref_list*)(cb_data);
+	struct ref_item *newitem;
+	int kind = REF_UNKNOWN_TYPE;
+
+	/* Detect kind */
+	if (!strncmp(refname, "refs/heads/", 11)) {
+		kind = REF_LOCAL_BRANCH;
+		refname += 11;
+	} else if (!strncmp(refname, "refs/remotes/", 13)) {
+		kind = REF_REMOTE_BRANCH;
+		refname += 13;
+	} else if (!strncmp(refname, "refs/tags/", 10)) {
+		kind = REF_TAG;
+		refname += 10;
+	}
+
+	/* Don't add types the caller doesn't want */
+	if ((kind & ref_list->kinds) == 0)
+		return 0;
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
+	newitem->kind = kind;
 
 	return 0;
 }
 
+static void tidy_ref_list( struct ref_list *ref_list )
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
+	if( c1->kind != c2->kind )
+		return c1->kind - c2->kind;
 	return strcmp(*(char **)r1, *(char **)r2);
 }
 
-static void print_ref_list(int remote_only)
+static void print_ref_list( int kinds )
 {
 	int i;
 	char c;
+	struct ref_list ref_list;
 
-	if (remote_only)
-		for_each_remote_ref(append_ref, NULL);
-	else
-		for_each_branch_ref(append_ref, NULL);
+	memset( &ref_list, 0, sizeof( ref_list ) );
+	ref_list.kinds = kinds;
+	for_each_ref(append_ref, &ref_list);
 
-	qsort(ref_list, ref_index, sizeof(char *), ref_cmp);
+	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
-	for (i = 0; i < ref_index; i++) {
+	for (i = 0; i < ref_list.index; i++) {
 		c = ' ';
-		if (!strcmp(ref_list[i], head))
+		if (ref_list.list[i].kind == REF_LOCAL_BRANCH &&
+				!strcmp(ref_list.list[i].name, head))
 			c = '*';
 
-		printf("%c %s\n", c, ref_list[i]);
+		printf("%c %s\n", c, ref_list.list[i].name );
 	}
+
+	tidy_ref_list( &ref_list );
 }
 
 static void create_branch(const char *name, const char *start,
@@ -160,8 +214,9 @@ static void create_branch(const char *na
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, force_delete = 0, force_create = 0, remote_only = 0;
+	int delete = 0, force_delete = 0, force_create = 0;
 	int reflog = 0;
+	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
 	git_config(git_default_config);
@@ -189,7 +244,11 @@ int cmd_branch(int argc, const char **ar
 			continue;
 		}
 		if (!strcmp(arg, "-r")) {
-			remote_only = 1;
+			kinds = REF_REMOTE_BRANCH;
+			continue;
+		}
+		if (!strcmp(arg, "-a")) {
+			kinds = REF_REMOTE_BRANCH | REF_LOCAL_BRANCH;
 			continue;
 		}
 		if (!strcmp(arg, "-l")) {
@@ -209,7 +268,7 @@ int cmd_branch(int argc, const char **ar
 	if (delete)
 		delete_branches(argc - i, argv + i, force_delete);
 	else if (i == argc)
-		print_ref_list(remote_only);
+		print_ref_list(kinds);
 	else if (i == argc - 1)
 		create_branch(argv[i], head, force_create, reflog);
 	else if (i == argc - 2)
-- 
1.4.3.5
