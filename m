From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-log to go forward instead of reverse?
Date: Mon, 10 Jul 2006 12:01:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607101151470.5623@g5.osdl.org>
References: <86bqrxpai1.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 21:02:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G011D-0002wK-PX
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 21:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWGJTCE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 15:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbWGJTCE
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 15:02:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422761AbWGJTCD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 15:02:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6AJ1xnW030051
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Jul 2006 12:02:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6AJ1tNn014802;
	Mon, 10 Jul 2006 12:01:57 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86bqrxpai1.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23638>



On Mon, 10 Jul 2006, Randal L. Schwartz wrote:
> 
> Am I missing an option to have git-log go forward in time rather than
> backward?  I'd really like "git-log --pretty=short ORIG_HEAD..HEAD" to show me
> a story I can read. :)

Well, as long as you realize that that automatically means that you have 
to walk the whole commit list, and you won't be able to get the 
incremental output that git-log and friends normally are able to give?

But this patch should do it. With it,

	git log --reverse --pretty=short ORIG_HEAD..

should do what you want.

It is _not_ possible to reverse the "gitk" view with this patch, though, 
as this does _not_ reverse parenthood information.

The "--reverse" flag could possibly be renamed. 

		Linus

---
diff --git a/revision.c b/revision.c
index 7df9089..13a3e40 100644
--- a/revision.c
+++ b/revision.c
@@ -698,6 +698,10 @@ int setup_revisions(int argc, const char
 				revs->topo_order = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--reverse")) {
+				revs->reverse ^= 1;
+				continue;
+			}
 			if (!strcmp(arg, "--parents")) {
 				revs->parents = 1;
 				continue;
@@ -921,7 +925,7 @@ int setup_revisions(int argc, const char
 		add_pending_object(revs, object, def);
 	}
 
-	if (revs->topo_order || revs->unpacked)
+	if (revs->topo_order || revs->unpacked || revs->reverse)
 		revs->limited = 1;
 
 	if (revs->prune_data) {
@@ -941,6 +945,19 @@ int setup_revisions(int argc, const char
 	return left;
 }
 
+static struct commit_list *reverse_commit_list(struct commit_list *p)
+{
+	struct commit_list *result = NULL;
+
+	while (p) {
+		struct commit_list *next = p->next;
+		p->next = result;
+		result = p;
+		p = next;
+	}
+	return result;
+}
+
 void prepare_revision_walk(struct rev_info *revs)
 {
 	int nr = revs->pending.nr;
@@ -968,6 +985,8 @@ void prepare_revision_walk(struct rev_in
 		sort_in_topological_order_fn(&revs->commits, revs->lifo,
 					     revs->topo_setter,
 					     revs->topo_getter);
+	if (revs->reverse)
+		revs->commits = reverse_commit_list(revs->commits);
 }
 
 static int rewrite_one(struct rev_info *revs, struct commit **pp)
diff --git a/revision.h b/revision.h
index c010a08..ff6ce44 100644
--- a/revision.h
+++ b/revision.h
@@ -32,6 +32,7 @@ struct rev_info {
 			remove_empty_trees:1,
 			simplify_history:1,
 			lifo:1,
+			reverse:1,
 			topo_order:1,
 			tag_objects:1,
 			tree_objects:1,
