From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/4] Add support for 'namespace' history simplification
Date: Mon, 3 Nov 2008 11:43:00 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811031139520.3419@nehalem.linux-foundation.org>
References: <200811031439.12111.brian.foster@innova-card.com> <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031132520.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031133590.3419@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811031135410.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:45:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx5MX-00046n-6N
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 20:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbYKCToG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 14:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbYKCToF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:44:05 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57778 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753958AbYKCToD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 14:44:03 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3Jh0Dv023171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 11:43:01 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3Jh0sT027156;
	Mon, 3 Nov 2008 11:43:00 -0800
In-Reply-To: <alpine.LFD.2.00.0811031135410.3419@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99986>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Nov 2008 11:25:46 -0800
Subject: [PATCH 4/4] Add support for 'namespace' history simplification

Maybe this is mis-named, but what it does is to simplify history not by
the contents of the tree, but whether a commit has been named (ie it's
referred to by some branch or tag) or not.

This makes it possible to see the relationship between different named
commits, without actually seeing any of the details.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is the actual real meat of the logic, and it's really trivial. The 
actual code is really just a simple

    if (simplify-by-namespace)
        return lookup_decoration(..) ? REV_TREE_DIFFERENT : REV_TREE_SAME;

but it's a few more lines of addition than that because of parsing the 
argument and setting the appropriate flags, and writing the above 
two-liner as five lines with a comment in order to make it more readable.

No docs. I don't do docs. But you can use it like so:

	gitk --simplify-namespace

and you're all done. 

Ta-daa!


 revision.c |   20 ++++++++++++++++++++
 revision.h |    1 +
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 56b09eb..b48e626 100644
--- a/revision.c
+++ b/revision.c
@@ -11,6 +11,7 @@
 #include "reflog-walk.h"
 #include "patch-ids.h"
 #include "decorate.h"
+#include "log-tree.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -301,6 +302,17 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 
 	if (!t1)
 		return REV_TREE_NEW;
+
+	/*
+	 * If we do history simplification by _name_, ignore the
+	 * actual tree contents, and just check if we have a
+	 * decoration
+	 */
+	if (revs->simplify_namespace) {
+		struct name_decoration *name;
+		name = lookup_decoration(&name_decoration, &commit->object);
+		return name ? REV_TREE_DIFFERENT : REV_TREE_SAME;
+	}
 	if (!t2)
 		return REV_TREE_DIFFERENT;
 	tree_difference = REV_TREE_SAME;
@@ -1041,6 +1053,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->rewrite_parents = 1;
 		revs->simplify_history = 0;
 		revs->limited = 1;
+	} else if (!strcmp(arg, "--simplify-namespace")) {
+		revs->simplify_merges = 1;
+		revs->rewrite_parents = 1;
+		revs->simplify_history = 0;
+		revs->simplify_namespace = 1;
+		revs->limited = 1;
+		revs->prune = 1;
+		load_ref_decorations();
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->lifo = 0;
 		revs->topo_order = 1;
diff --git a/revision.h b/revision.h
index 0a1806a..bd1ec0d 100644
--- a/revision.h
+++ b/revision.h
@@ -43,6 +43,7 @@ struct rev_info {
 			lifo:1,
 			topo_order:1,
 			simplify_merges:1,
+			simplify_namespace:1,
 			tag_objects:1,
 			tree_objects:1,
 			blob_objects:1,
-- 
1.6.0.3.616.gf1239d6.dirty
