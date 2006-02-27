From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Mon, 27 Feb 2006 08:54:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602270851560.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
 <7vpsl93395.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602261914270.22647@g5.osdl.org>
 <7vy7zx1j6u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602262119200.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 17:55:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDle8-0001a4-Gh
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 17:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWB0Qyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 11:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWB0Qyn
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 11:54:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbWB0Qyn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 11:54:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1RGscDZ028514
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 08:54:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1RGsbWp029699;
	Mon, 27 Feb 2006 08:54:38 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602262119200.22647@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16862>



On Sun, 26 Feb 2006, Linus Torvalds wrote:
> 
> I suspect that the simplest fix is to just move "limited" into the "revs" 
> structure, the way I did pretty much everything else. That way nothing 
> really changes: we'll have the exact same logic, the flag just moved 
> around.

Here's a cleanup patch that does that. It also moves "unpacked" (and the 
flag parsing) into rev_info, since that actually does affect the revision 
walker too, and thus logically belongs there.

If you prefer, I can generate a totally re-done patch that combines all 
the fixes so far.

		Linus

----
diff-tree d33c6e5017d52d36f8da44162c0d87899efd247c (from 4b0fd13e13f49fa73ddd03a69f7d2ad1109139d4)
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Mon Feb 27 08:50:26 2006 -0800

    Fix rev-list "limited" handling
    
    Also, move "unpacked" into the rev_info structure, where it logically belongs.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/rev-list.c b/rev-list.c
index e9e371c..2e80930 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -41,7 +41,6 @@ static const char rev_list_usage[] =
 
 struct rev_info revs;
 
-static int unpacked = 0;
 static int bisect_list = 0;
 static int verbose_header = 0;
 static int abbrev = DEFAULT_ABBREV;
@@ -572,7 +571,7 @@ static struct commit_list *limit_list(st
 
 		if (revs.max_age != -1 && (commit->date < revs.max_age))
 			obj->flags |= UNINTERESTING;
-		if (unpacked && has_sha1_pack(obj->sha1))
+		if (revs.unpacked && has_sha1_pack(obj->sha1))
 			obj->flags |= UNINTERESTING;
 		add_parents_to_list(commit, &list);
 		if (obj->flags & UNINTERESTING) {
@@ -595,7 +594,7 @@ static struct commit_list *limit_list(st
 int main(int argc, const char **argv)
 {
 	struct commit_list *list;
-	int i, limited = 0;
+	int i;
 
 	argc = setup_revisions(argc, argv, &revs);
 
@@ -655,11 +654,6 @@ int main(int argc, const char **argv)
 			bisect_list = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--unpacked")) {
-			unpacked = 1;
-			limited = 1;
-			continue;
-		}
 		if (!strcmp(arg, "--merge-order")) {
 		        merge_order = 1;
 			continue;
@@ -673,34 +667,25 @@ int main(int argc, const char **argv)
 	}
 
 	list = revs.commits;
-	if (list && list->next)
-		limited = 1;
-
-	if (revs.topo_order)
-		limited = 1;
 
 	if (!list &&
 	    (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) && !revs.pending_objects))
 		usage(rev_list_usage);
 
-	if (revs.paths) {
-		limited = 1;
+	if (revs.paths)
 		diff_tree_setup_paths(revs.paths);
-	}
-	if (revs.max_age || revs.min_age)
-		limited = 1;
 
 	save_commit_buffer = verbose_header;
 	track_object_refs = 0;
 
 	if (!merge_order) {		
 		sort_by_date(&list);
-		if (list && !limited && revs.max_count == 1 &&
+		if (list && !revs.limited && revs.max_count == 1 &&
 		    !revs.tag_objects && !revs.tree_objects && !revs.blob_objects) {
 			show_commit(list->item);
 			return 0;
 		}
-	        if (limited)
+	        if (revs.limited)
 			list = limit_list(list);
 		if (revs.topo_order)
 			sort_in_topological_order(&list, revs.lifo);
diff --git a/revision.c b/revision.c
index 17dbf9a..0422593 100644
--- a/revision.c
+++ b/revision.c
@@ -143,8 +143,10 @@ static struct commit *get_commit_referen
 		object->flags |= flags;
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
-		if (flags & UNINTERESTING)
+		if (flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
+			revs->limited = 1;
+		}
 		return commit;
 	}
 
@@ -255,10 +257,12 @@ int setup_revisions(int argc, const char
 			}
 			if (!strncmp(arg, "--max-age=", 10)) {
 				revs->max_age = atoi(arg + 10);
+				revs->limited = 1;
 				continue;
 			}
 			if (!strncmp(arg, "--min-age=", 10)) {
 				revs->min_age = atoi(arg + 10);
+				revs->limited = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
@@ -277,11 +281,13 @@ int setup_revisions(int argc, const char
 			}
 			if (!strcmp(arg, "--topo-order")) {
 				revs->topo_order = 1;
+				revs->limited = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--date-order")) {
 				revs->lifo = 0;
 				revs->topo_order = 1;
+				revs->limited = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--dense")) {
@@ -309,6 +315,11 @@ int setup_revisions(int argc, const char
 				revs->edge_hint = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--unpacked")) {
+				revs->unpacked = 1;
+				revs->limited = 1;
+				continue;
+			}
 			*unrecognized++ = arg;
 			left++;
 			continue;
@@ -365,6 +376,8 @@ int setup_revisions(int argc, const char
 		commit = get_commit_reference(revs, def, sha1, 0);
 		add_one_commit(commit, revs);
 	}
+	if (revs->paths)
+		revs->limited = 1;
 	*unrecognized = NULL;
 	return left;
 }
diff --git a/revision.h b/revision.h
index 5170ac4..a22f198 100644
--- a/revision.h
+++ b/revision.h
@@ -21,7 +21,9 @@ struct rev_info {
 			tag_objects:1,
 			tree_objects:1,
 			blob_objects:1,
-			edge_hint:1;
+			edge_hint:1,
+			limited:1,
+			unpacked:1;
 
 	/* special limits */
 	int max_count;
