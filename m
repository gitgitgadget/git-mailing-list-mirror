From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 18:09:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604141808480.3701@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org> <7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141748070.3701@g5.osdl.org> <Pine.LNX.4.64.0604141751270.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 03:10:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUZIp-0004tA-PG
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 03:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWDOBJ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 21:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWDOBJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 21:09:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751459AbWDOBJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 21:09:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3F19LtH011182
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Apr 2006 18:09:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3F19Khj018802;
	Fri, 14 Apr 2006 18:09:20 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604141751270.3701@g5.osdl.org>
X-Spam-Status: No, hits=0.224 required=5 tests=REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18719>



Ok, fourth time lucky?

		Linus

----
diff --git a/revision.c b/revision.c
index 0f98960..2061ca8 100644
--- a/revision.c
+++ b/revision.c
@@ -246,7 +246,7 @@ int rev_compare_tree(struct rev_info *re
 		return REV_TREE_DIFFERENT;
 	tree_difference = REV_TREE_SAME;
 	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
-			   &revs->diffopt) < 0)
+			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
 	return tree_difference;
 }
@@ -269,7 +269,7 @@ int rev_same_tree_as_empty(struct rev_in
 	empty.size = 0;
 
 	tree_difference = 0;
-	retval = diff_tree(&empty, &real, "", &revs->diffopt);
+	retval = diff_tree(&empty, &real, "", &revs->pruning);
 	free(tree);
 
 	return retval >= 0 && !tree_difference;
@@ -476,9 +476,9 @@ static void handle_all(struct rev_info *
 void init_revisions(struct rev_info *revs)
 {
 	memset(revs, 0, sizeof(*revs));
-	revs->diffopt.recursive = 1;
-	revs->diffopt.add_remove = file_add_remove;
-	revs->diffopt.change = file_change;
+	revs->pruning.recursive = 1;
+	revs->pruning.add_remove = file_add_remove;
+	revs->pruning.change = file_change;
 	revs->lifo = 1;
 	revs->dense = 1;
 	revs->prefix = setup_git_directory();
@@ -780,8 +780,10 @@ int setup_revisions(int argc, const char
 		revs->limited = 1;
 
 	if (revs->prune_data) {
-		diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
+		diff_tree_setup_paths(revs->prune_data, &revs->pruning);
 		revs->prune_fn = try_to_simplify_commit;
+		if (!revs->full_diff)
+			diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
 	}
 	if (revs->combine_merges) {
 		revs->ignore_merges = 0;
@@ -790,8 +792,6 @@ int setup_revisions(int argc, const char
 	}
 	if (revs->diffopt.output_format == DIFF_FORMAT_PATCH)
 		revs->diffopt.recursive = 1;
-	if (!revs->full_diff && revs->prune_data)
-		diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
 	diff_setup_done(&revs->diffopt);
 
 	return left;
diff --git a/revision.h b/revision.h
index 9a45986..6eaa904 100644
--- a/revision.h
+++ b/revision.h
@@ -61,8 +61,9 @@ struct rev_info {
 	unsigned long max_age;
 	unsigned long min_age;
 
-	/* paths limiting */
+	/* diff info for patches and for paths limiting */
 	struct diff_options diffopt;
+	struct diff_options pruning;
 
 	topo_sort_set_fn_t topo_setter;
 	topo_sort_get_fn_t topo_getter;
