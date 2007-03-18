From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Set up for better tree diff optimizations
Date: Sun, 18 Mar 2007 15:18:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703181506570.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 23:18:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3i1-0002og-2w
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 23:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933363AbXCRWSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 18:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933368AbXCRWSg
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 18:18:36 -0400
Received: from smtp.osdl.org ([65.172.181.24]:56832 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933363AbXCRWSf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 18:18:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2IMIVcD031085
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Mar 2007 15:18:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2IMIUkB031776;
	Sun, 18 Mar 2007 14:18:30 -0800
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42536>


This is mainly just a cleanup patch, and sets up for later changes where 
the tree-diff.c "interesting()" function can return more than just a 
yes/no value.

In particular, it should be quite possible to say "no subsequent entries 
in this tree can possibly be interesting any more", and thus allow the 
callers to short-circuit the tree entirely.

In fact, changing the callers to do so is trivial, and is really all this 
patch really does, because changing "interesting()" itself to say that 
nothing further is going to be interesting is definitely more complicated, 
considering that we may have arbitrary pathspecs.

But in cleaning up the callers, this actually fixes a potential small 
performance issue in diff_tree(): if the second tree has a lot of 
uninterestign crud in it, we would keep on doing the "is it interesting?" 
check on the first tree for each uninteresting entry in the second one. 

The answer is obviously not going to change, so that was just not helping. 
The new code is clearer and simpler and avoids this issue entirely.

I also renamed "interesting()" to "tree_entry_interesting()", because I 
got frustrated by the fact that 

 - we actually had *another* function called "interesting()" in another 
   file, and I couldn't tell from the profiles which one was the one that 
   mattered more.

 - when rewriting it to return a ternary value, you can't just do

	if (interesting(...))
		...

   any more, but want to assign the return value to a local variable. The 
   name of choice for that variable would normally be "interesting", so 
   I just wanted to make the function name be more specific, and avoid 
   that whole issue (even though I then didn't choose that name for either 
   of the users, just to avoid confusion in the patch itself ;)

In other words, this doesn't really change anything, but I think it's a 
good thing to do, and if somebody comes along and writes the logic for 
"yeah, none of the pathspecs you have are interesting", we now support 
that trivially.

It could easily be a meaningful optimization for things like "blame", 
where there's just one pathspec, and stopping when you've seen it would 
allow you to avoid about 50% of the tree traversals on average.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Junio, your decision.

 tree-diff.c |   44 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index f89b9d3..2e0a3ae 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -66,7 +66,15 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 	return 0;
 }
 
-static int interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
+/*
+ * Is a tree entry interesting given the pathspec we have?
+ *
+ * Return:
+ *  - positive for yes
+ *  - zero for no
+ *  - negative for "no, and no subsequent entries will be either"
+ */
+static int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
 {
 	const char *path;
 	const unsigned char *sha1;
@@ -123,7 +131,10 @@ static int interesting(struct tree_desc *desc, const char *base, int baselen, st
 static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base, int baselen)
 {
 	while (desc->size) {
-		if (interesting(desc, base, baselen, opt))
+		int show = tree_entry_interesting(desc, base, baselen, opt);
+		if (show < 0)
+			break;
+		if (show)
 			show_entry(opt, prefix, desc, base, baselen);
 		update_tree_entry(desc);
 	}
@@ -158,20 +169,33 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 	}
 }
 
+static void skip_uninteresting(struct tree_desc *t, const char *base, int baselen, struct diff_options *opt)
+{
+	while (t->size) {
+		int show = tree_entry_interesting(t, base, baselen, opt);
+		if (!show) {
+			update_tree_entry(t);
+			continue;
+		}
+		/* Skip it all? */
+		if (show < 0)
+			t->size = 0;
+		return;
+	}
+}
+
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
 	int baselen = strlen(base);
 
-	while (t1->size | t2->size) {
-		if (opt->nr_paths && t1->size && !interesting(t1, base, baselen, opt)) {
-			update_tree_entry(t1);
-			continue;
-		}
-		if (opt->nr_paths && t2->size && !interesting(t2, base, baselen, opt)) {
-			update_tree_entry(t2);
-			continue;
+	for (;;) {
+		if (opt->nr_paths) {
+			skip_uninteresting(t1, base, baselen, opt);
+			skip_uninteresting(t2, base, baselen, opt);
 		}
 		if (!t1->size) {
+			if (!t2->size)
+				break;
 			show_entry(opt, "+", t2, base, baselen);
 			update_tree_entry(t2);
 			continue;
