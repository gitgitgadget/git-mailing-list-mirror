From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 22/56] builtin/show-branch: rewrite functions to work with object_id
Date: Mon, 25 May 2015 18:38:48 +0000
Message-ID: <1432579162-411464-23-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKR-0001uq-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbbEYSmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:20 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50602 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388AbbEYSkP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 92F3328093;
	Mon, 25 May 2015 18:40:14 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269893>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-branch.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index b861e41..826d9fa 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -369,10 +369,10 @@ static void sort_ref_range(int bottom, int top)
 	      compare_ref_name);
 }
 
-static int append_ref(const char *refname, const unsigned char *sha1,
+static int append_ref(const char *refname, const struct object_id *oid,
 		      int allow_dups)
 {
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	struct commit *commit = lookup_commit_reference_gently(oid->hash, 1);
 	int i;
 
 	if (!commit)
@@ -406,7 +406,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 	 */
 	if (get_sha1(refname + ofs, tmp.hash) || oidcmp(&tmp, oid))
 		ofs = 5;
-	return append_ref(refname + ofs, oid->hash, 0);
+	return append_ref(refname + ofs, oid, 0);
 }
 
 static int append_remote_ref(const char *refname, const struct object_id *oid,
@@ -421,7 +421,7 @@ static int append_remote_ref(const char *refname, const struct object_id *oid,
 	 */
 	if (get_sha1(refname + ofs, tmp.hash) || oidcmp(&tmp, oid))
 		ofs = 5;
-	return append_ref(refname + ofs, oid->hash, 0);
+	return append_ref(refname + ofs, oid, 0);
 }
 
 static int append_tag_ref(const char *refname, const struct object_id *oid,
@@ -429,7 +429,7 @@ static int append_tag_ref(const char *refname, const struct object_id *oid,
 {
 	if (!starts_with(refname, "refs/tags/"))
 		return 0;
-	return append_ref(refname + 5, oid->hash, 0);
+	return append_ref(refname + 5, oid, 0);
 }
 
 static const char *match_ref_pattern = NULL;
@@ -463,7 +463,7 @@ static int append_matching_ref(const char *refname, const struct object_id *oid,
 		return append_head_ref(refname, oid, flag, cb_data);
 	if (starts_with(refname, "refs/tags/"))
 		return append_tag_ref(refname, oid, flag, cb_data);
-	return append_ref(refname, oid->hash, 0);
+	return append_ref(refname, oid, 0);
 }
 
 static void snarf_refs(int head, int remotes)
@@ -538,7 +538,7 @@ static void append_one_rev(const char *av)
 {
 	struct object_id revkey;
 	if (!get_sha1(av, revkey.hash)) {
-		append_ref(av, revkey.hash, 0);
+		append_ref(av, &revkey, 0);
 		return;
 	}
 	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
@@ -643,7 +643,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	char head[128];
 	const char *head_p;
 	int head_len;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	int merge_base = 0;
 	int independent = 0;
 	int no_name = 0;
@@ -729,7 +729,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		all_heads = 1;
 
 	if (reflog) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		char nth_desc[256];
 		char *ref;
 		int base = 0;
@@ -740,7 +740,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 
 			fake_av[0] = resolve_refdup("HEAD",
 						    RESOLVE_REF_READING,
-						    sha1, NULL);
+						    oid.hash, NULL);
 			fake_av[1] = NULL;
 			av = fake_av;
 			ac = 1;
@@ -751,7 +751,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (MAX_REVS < reflog)
 			die("Only %d entries can be shown at one time.",
 			    MAX_REVS);
-		if (!dwim_ref(*av, strlen(*av), sha1, &ref))
+		if (!dwim_ref(*av, strlen(*av), oid.hash, &ref))
 			die("No such ref %s", *av);
 
 		/* Has the base been specified? */
@@ -762,7 +762,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				/* Ah, that is a date spec... */
 				unsigned long at;
 				at = approxidate(reflog_base);
-				read_ref_at(ref, flags, at, -1, sha1, NULL,
+				read_ref_at(ref, flags, at, -1, oid.hash, NULL,
 					    NULL, NULL, &base);
 			}
 		}
@@ -773,7 +773,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			unsigned long timestamp;
 			int tz;
 
-			if (read_ref_at(ref, flags, 0, base+i, sha1, &logmsg,
+			if (read_ref_at(ref, flags, 0, base+i, oid.hash, &logmsg,
 					&timestamp, &tz, NULL)) {
 				reflog = i;
 				break;
@@ -788,7 +788,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 						msg);
 			free(logmsg);
 			sprintf(nth_desc, "%s@{%d}", *av, base+i);
-			append_ref(nth_desc, sha1, 1);
+			append_ref(nth_desc, &oid, 1);
 		}
 		free(ref);
 	}
@@ -802,7 +802,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	}
 
 	head_p = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-				    head_sha1, NULL);
+				    head_oid.hash, NULL);
 	if (head_p) {
 		head_len = strlen(head_p);
 		memcpy(head, head_p, head_len + 1);
@@ -821,7 +821,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			if (rev_is_head(head,
 					head_len,
 					ref_name[i],
-					head_sha1, NULL))
+					head_oid.hash, NULL))
 				has_head++;
 		}
 		if (!has_head) {
@@ -836,17 +836,17 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	}
 
 	for (num_rev = 0; ref_name[num_rev]; num_rev++) {
-		unsigned char revkey[20];
+		struct object_id revkey;
 		unsigned int flag = 1u << (num_rev + REV_SHIFT);
 
 		if (MAX_REVS <= num_rev)
 			die("cannot handle more than %d revs.", MAX_REVS);
-		if (get_sha1(ref_name[num_rev], revkey))
+		if (get_sha1(ref_name[num_rev], revkey.hash))
 			die("'%s' is not a valid ref.", ref_name[num_rev]);
-		commit = lookup_commit_reference(revkey);
+		commit = lookup_commit_reference(revkey.hash);
 		if (!commit)
 			die("cannot find commit %s (%s)",
-			    ref_name[num_rev], revkey);
+			    ref_name[num_rev], revkey.hash);
 		parse_commit(commit);
 		mark_seen(commit, &seen);
 
@@ -880,7 +880,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			int is_head = rev_is_head(head,
 						  head_len,
 						  ref_name[i],
-						  head_sha1,
+						  head_oid.hash,
 						  rev[i]->object.sha1);
 			if (extra < 0)
 				printf("%c [%s] ",
-- 
2.4.0
