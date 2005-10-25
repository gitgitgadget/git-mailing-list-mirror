From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: add "--dense" flag
Date: Tue, 25 Oct 2005 11:23:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510251110050.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
 <20051025180707.GA7463@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 20:29:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUTT5-0003Ff-7e
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 20:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVJYSYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 14:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVJYSYF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 14:24:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932294AbVJYSYE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 14:24:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9PINpFC011648
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Oct 2005 11:23:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9PINo3e022425;
	Tue, 25 Oct 2005 11:23:50 -0700
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20051025180707.GA7463@diku.dk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10606>



On Tue, 25 Oct 2005, Jonas Fonseca wrote:
> 
> Is the initial commit supposed to be listed when the file has been added
> later?

Right now --dense will _always_ show the root commit. I didn't do the 
logic that does the diff against an empty tree. I was lazy.

This patch does that, and may or may not work.

Does this match what you expected?

		Linus

----
diff --git a/rev-list.c b/rev-list.c
index 5f125fd..038dae2 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -439,6 +439,30 @@ static int same_tree(struct tree *t1, st
 	return !is_different;
 }
 
+static int same_tree_as_empty(struct tree *t1)
+{
+	int retval;
+	void *tree;
+	struct tree_desc empty, real;
+
+	if (!t1)
+		return 0;
+
+	tree = read_object_with_reference(t1->object.sha1, "tree", &real.size, NULL);
+	if (!tree)
+		return 0;
+	real.buf = tree;
+
+	empty.buf = "";
+	empty.size = 0;
+
+	is_different = 0;
+	retval = diff_tree(&empty, &real, "", &diff_opt);
+	free(tree);
+
+	return !retval && !is_different;
+}
+
 static struct commit *try_to_simplify_merge(struct commit *commit, struct commit_list *parent)
 {
 	if (!commit->tree)
@@ -523,11 +547,17 @@ static void compress_list(struct commit_
 		struct commit_list *parent = commit->parents;
 		list = list->next;
 
+		if (!parent) {
+			if (!same_tree_as_empty(commit->tree))
+				commit->object.flags |= TREECHANGE;
+			continue;
+		}
+
 		/*
 		 * Exactly one parent? Check if it leaves the tree
 		 * unchanged
 		 */
-		if (parent && !parent->next) {
+		if (!parent->next) {
 			struct tree *t1 = commit->tree;
 			struct tree *t2 = parent->item->tree;
 			if (!t1 || !t2 || same_tree(t1, t2))
