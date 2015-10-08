From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] merge_recursive_options: introduce the "gentle" flag
Date: Thu, 08 Oct 2015 22:35:19 +0200
Organization: gmx
Message-ID: <fed6b32cff01f38196e3dd43025076a47f841a74.1444336120.git.johannes.schindelin@gmx.de>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Brendan Forster <shiftkey@github.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 08 22:35:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkHuU-0005Pj-4d
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 22:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758458AbbJHUf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 16:35:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:55603 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758369AbbJHUfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 16:35:25 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lz3nU-1afIM42Ki8-014ERQ; Thu, 08 Oct 2015 22:35:20
 +0200
In-Reply-To: <cover.1444336120.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:F/yzuy8QbBW45tAI3sihxw7Qr8xHyCcSM5uO/zYPmFQTYsrufNa
 H0mQ4chnYCna13hFja6YfGIpdqaKXe5nuo3F9lHP/sgc+yTvnkWAXA2D1WDWL8HtcO8abUq
 jE01vb7wuSgSex1Am0pBujpfdDljYunJe8YGQ7L0fCueoXXak9+XvjnHhcfstcqJ0ewMoY3
 C9P9QW0pOsgNEZxjvFOgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TnHXqsk6YHo=:Yr0YQL+lgFZhsOcu8+0fe6
 YyKnIJsFzuCP2Yu6V5IErRXgrGf52rvWRoHQP4uh6iS/W622+gra1M3F9ROX2MUvbRRSkj+0/
 oN5anTkgcDDaTlMJe18QnHmm+9R8RyMG+j1CsBvNcIjNKdBdQlmrEOEzwI6Gxiat1XxH/iuG/
 Aky8I3mfNFxizIYG7N24e7PZeot1ozHi14nKNfO4lgr2mHzlHPgIj3LeOI4BZ6jqm2iZ1igxs
 iMh7Yu+9GyvDeEq0V9RwjWQYpbH5XWnVOYrmA4GrdyViY3L97ElqkNyWNl5TrWAWaeOdb0zKq
 RifpXpcIh/CXlLPByxOkNyr295gpnTn2reWFo5NdxofOqZg1QZtE+x1eGnQsHOlRbbTLt64Pd
 yRVJtYNedYMNTkjf+6vGUKDO1nXnSLHjHvi2u3ODRSPf+x0wXrMaf15GLAjjtWkNntdeaxvfM
 RNzXod//t/A9gJKVU5xx8oPRzWbzMnd1/9r0986hJ2shmNtCI+LOOem//T0bYka2YDqRW5Ivs
 6WY72TaxMi1bpb3s2f69lJHFAiD3470ZpgeTOtdauHa7Go7I7hzpYWjqmL6p29RLCP6+MOgho
 iJPEq/3Ms1qWhAbhHeRDLXoIH5875GFkiNhN8MjUAASsQEOboqP/DxDPT8FQr0FldhzWTN6uH
 4COXmnfsY9F8ETUftEdEuqkrkJYJUUfj7GI0UwCCCrvhvYlSjVOvCcJ7z/kRc6QHK0dTYEA3v
 yMizNsIddkDtJXCSyUY7dw4dIxen5OV0io4RDi1Bt6VxU/9JgvC5M5y22hUwHSYLDwjgFhVn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279276>

Traditionally, all of Git's operations were intended as single
executables to be run once and exit, not as library functions with
careful error code paths. Therefore, it was okay for those operations
to simply die() with an error.

However, this assumption no longer holds true: builtin `am` calls
merge_recursive_generic() as a regular library function whose return
value indicates whether there was a problem.

Throughout Git's source code, that paradigm (to return an error instead
of die()ing) is called "gentle".

Let's introduce this flag and heed it in as many places as is easily
done.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 44 +++++++++++++++++++++++++++++++++++---------
 merge-recursive.h |  1 +
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 44d85be..37528c9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -266,8 +266,12 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		active_cache_tree = cache_tree();
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
-	    cache_tree_update(&the_index, 0) < 0)
-		die(_("error building trees"));
+	    cache_tree_update(&the_index, 0) < 0) {
+		if (!o->gentle)
+			die(_("error building trees"));
+		error(_("error building trees"));
+		return NULL;
+	}
 
 	result = lookup_tree(active_cache_tree->sha1);
 
@@ -712,6 +716,8 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 			error(msg, path, _(": perhaps a D/F conflict?"));
 			return -1;
 		}
+		if (o->gentle)
+			return error(msg, path, "");
 		die(msg, path, "");
 	}
 
@@ -1340,8 +1346,11 @@ static int process_renames(struct merge_options *o,
 			const char *ren2_src = ren2->pair->one->path;
 			const char *ren2_dst = ren2->pair->two->path;
 			enum rename_type rename_type;
-			if (strcmp(ren1_src, ren2_src) != 0)
+			if (strcmp(ren1_src, ren2_src) != 0) {
+				if (o->gentle)
+					return error("ren1_src != ren2_src");
 				die("ren1_src != ren2_src");
+			}
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
@@ -1374,8 +1383,11 @@ static int process_renames(struct merge_options *o,
 			char *ren2_dst;
 			ren2 = lookup->util;
 			ren2_dst = ren2->pair->two->path;
-			if (strcmp(ren1_dst, ren2_dst) != 0)
+			if (strcmp(ren1_dst, ren2_dst) != 0) {
+				if (o->gentle)
+					return error("ren1_dst != ren2_dst");
 				die("ren1_dst != ren2_dst");
+			}
 
 			clean_merge = 0;
 			ren2->processed = 1;
@@ -1818,6 +1830,11 @@ int merge_trees(struct merge_options *o,
 	code = git_merge_trees(o->call_depth, common, head, merge);
 
 	if (code != 0) {
+		if (o->gentle)
+			return error(_("merging of trees %s and %s failed"),
+			    sha1_to_hex(head->object.sha1),
+			    sha1_to_hex(merge->object.sha1));
+
 		if (show(o, 4) || o->call_depth)
 			die(_("merging of trees %s and %s failed"),
 			    sha1_to_hex(head->object.sha1),
@@ -1864,8 +1881,8 @@ int merge_trees(struct merge_options *o,
 	else
 		clean = 1;
 
-	if (o->call_depth)
-		*result = write_tree_from_memory(o);
+	if (o->call_depth && !(*result = write_tree_from_memory(o)))
+		return -1;
 
 	return clean;
 }
@@ -1940,14 +1957,18 @@ int merge_recursive(struct merge_options *o,
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
 		o->branch2 = "Temporary merge branch 2";
-		merge_recursive(o, merged_common_ancestors, iter->item,
-				NULL, &merged_common_ancestors);
+		if (merge_recursive(o, merged_common_ancestors, iter->item,
+				NULL, &merged_common_ancestors) < 0)
+			return -1;
 		o->branch1 = saved_b1;
 		o->branch2 = saved_b2;
 		o->call_depth--;
 
-		if (!merged_common_ancestors)
+		if (!merged_common_ancestors) {
+			if (o->gentle)
+				return error(_("merge returned no commit"));
 			die(_("merge returned no commit"));
+		}
 	}
 
 	discard_cache();
@@ -1957,6 +1978,8 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	if (clean < 0)
+		return clean;
 
 	if (o->call_depth) {
 		*result = make_virtual_commit(mrtree, "merged tree");
@@ -2013,6 +2036,9 @@ int merge_recursive_generic(struct merge_options *o,
 	hold_locked_index(lock, 1);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
+	if (clean < 0)
+		return clean;
+
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
diff --git a/merge-recursive.h b/merge-recursive.h
index 9e090a3..06f9b7e 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -15,6 +15,7 @@ struct merge_options {
 	const char *subtree_shift;
 	unsigned buffer_output : 1;
 	unsigned renormalize : 1;
+	unsigned gentle : 1;
 	long xdl_opts;
 	int verbosity;
 	int diff_rename_limit;
-- 
2.6.1.windows.1
