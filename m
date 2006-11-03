X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Rename remote_only to display_mode
Date: Thu, 02 Nov 2006 18:40:36 -0800
Message-ID: <7v64dxl0bf.fsf@assigned-by-dhcp.cox.net>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
	<200611021111.09434.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 03:03:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30776>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfp8T-0003wO-2o for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752979AbWKCCkm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbWKCCkl
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:40:41 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39087 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1752979AbWKCCkh
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:40:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103024036.WDFK6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:40:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2gF1V00R1kojtg0000000 Thu, 02 Nov 2006
 21:40:16 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> -static void print_ref_list(int remote_only)
> +static void print_ref_list(int display_mode)
>  {
>  	int i;
>  	char c;
>  
> -	if (remote_only)
> +	if (display_mode)
>  		for_each_remote_ref(append_ref, NULL);
>  	else
>  		for_each_branch_ref(append_ref, NULL);

If you make this a "mode", it probably is better to make 1 and 0
into symbolic constants.  This patch taken alone is regression
in readability.

By the way, it might make sense to make it bitfields; that would
allow you to show either one kind or both.

Something like this untested patch, that is...


diff --git a/builtin-branch.c b/builtin-branch.c
index 368b68e..182648c 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -79,45 +79,73 @@ static void delete_branches(int argc, co
 	}
 }
 
+#define REF_LOCAL_BRANCH	01
+#define REF_REMOTE_BRANCH	02
+
 static int ref_index, ref_alloc;
-static char **ref_list;
+static struct ref_list {
+	int kind;
+	char name[FLEX_ARRAY];
+} **ref_list;
 
-static int append_ref(const char *refname, const unsigned char *sha1, int flags,
-		void *cb_data)
+static int append_ref(const char *refname, const unsigned char *sha1,
+		      int flags, void *cb_data)
 {
+	int kinds = *((int*)cb_data);
+	int this_kind, strip;
+	struct ref_list *elem;
+
+	if (!strncmp(refname, "refs/heads/", 11)) {
+		this_kind = REF_LOCAL_BRANCH;
+		strip = 11;
+	}
+	else if (!strncmp(refname, "refs/remotes/", 13)) {
+		this_kind = REF_REMOTE_BRANCH;
+		strip = 13;
+	}
+	else
+		this_kind = 0;
+
+	if ((this_kind & kinds) == 0)
+		return 0;
+
 	if (ref_index >= ref_alloc) {
 		ref_alloc = alloc_nr(ref_alloc);
 		ref_list = xrealloc(ref_list, ref_alloc * sizeof(char *));
 	}
-
-	ref_list[ref_index++] = xstrdup(refname);
+	
+	elem = xcalloc(1, sizeof(*elem) + strlen(refname) - strip);
+	strcpy(elem->name, refname + strip); 
+	elem->kind = this_kind;
+	ref_list[ref_index++] = elem;
 
 	return 0;
 }
 
-static int ref_cmp(const void *r1, const void *r2)
+static int ref_cmp(const void *r1_, const void *r2_)
 {
-	return strcmp(*(char **)r1, *(char **)r2);
+	const struct ref_list *r1 = *((const struct ref_list **)r1_);
+	const struct ref_list *r2 = *((const struct ref_list **)r2_);
+
+	if (r1->kind != r2->kind)
+		return r1->kind - r2->kind;
+	return strcmp(r1->name, r2->name);
 }
 
-static void print_ref_list(int remote_only)
+static void print_ref_list(int kinds)
 {
 	int i;
 	char c;
 
-	if (remote_only)
-		for_each_remote_ref(append_ref, NULL);
-	else
-		for_each_branch_ref(append_ref, NULL);
-
+	for_each_ref(append_ref, &kinds);
 	qsort(ref_list, ref_index, sizeof(char *), ref_cmp);
 
 	for (i = 0; i < ref_index; i++) {
 		c = ' ';
-		if (!strcmp(ref_list[i], head))
+		if (ref_list[i]->kind == REF_LOCAL_BRANCH &&
+		    !strcmp(ref_list[i]->name, head))
 			c = '*';
-
-		printf("%c %s\n", c, ref_list[i]);
+		printf("%c %s\n", c, ref_list[i]->name);
 	}
 }
 
@@ -160,8 +188,9 @@ static void create_branch(const char *na
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, force_delete = 0, force_create = 0, remote_only = 0;
+	int delete = 0, force_delete = 0, force_create = 0;
 	int reflog = 0;
+	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
 	git_config(git_default_config);
@@ -189,7 +218,11 @@ int cmd_branch(int argc, const char **ar
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
@@ -209,7 +242,7 @@ int cmd_branch(int argc, const char **ar
 	if (delete)
 		delete_branches(argc - i, argv + i, force_delete);
 	else if (i == argc)
-		print_ref_list(remote_only);
+		print_ref_list(kinds);
 	else if (i == argc - 1)
 		create_branch(argv[i], head, force_create, reflog);
 	else if (i == argc - 2)
