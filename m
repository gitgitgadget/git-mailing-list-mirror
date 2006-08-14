From: David Rientjes <rientjes@google.com>
Subject: [PATCH 11/28] makes append_ref and show_indepedent void
Date: Mon, 14 Aug 2006 13:28:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141327130.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:28:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj31-0007tE-E4
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWHNU22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbWHNU22
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:28:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:11155 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932722AbWHNU21
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:28:27 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id k7EKSLx2024139
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:28:21 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=FJ+Xw1H7MJ5PGGQzLaG2CdR3qld1OIfl6uRrlxhYf8Sa6jnT1FwajZh+gbMUr/10N
	x6ZhyS1/iynL9nsOVZ3vQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps36.corp.google.com with ESMTP id k7EKSIke006890
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:28:18 -0700
Received: by localhost (Postfix, from userid 24081)
	id A7F3487D71; Mon, 14 Aug 2006 13:28:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id A593387D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:28:18 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25391>

Makes append_ref and show_independent void and cleans up function calls.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-show-branch.c |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 2a1b848..3ce1759 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -346,27 +346,26 @@ static void sort_ref_range(int bottom, i
 	      compare_ref_name);
 }
 
-static int append_ref(const char *refname, const unsigned char *sha1)
+static void append_ref(const char *refname, const unsigned char *sha1)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	int i;
 
 	if (!commit)
-		return 0;
+		return;
 	/* Avoid adding the same thing twice */
 	for (i = 0; i < ref_name_cnt; i++)
 		if (!strcmp(refname, ref_name[i]))
-			return 0;
+			return;
 
 	if (MAX_REVS <= ref_name_cnt) {
 		fprintf(stderr, "warning: ignoring %s; "
 			"cannot handle more than %d refs\n",
 			refname, MAX_REVS);
-		return 0;
+		return;
 	}
 	ref_name[ref_name_cnt++] = strdup(refname);
 	ref_name[ref_name_cnt] = NULL;
-	return 0;
 }
 
 static int append_head_ref(const char *refname, const unsigned char *sha1)
@@ -380,14 +379,16 @@ static int append_head_ref(const char *r
 	 */
 	if (get_sha1(refname + ofs, tmp) || memcmp(tmp, sha1, 20))
 		ofs = 5;
-	return append_ref(refname + ofs, sha1);
+	append_ref(refname + ofs, sha1);
+	return 0;
 }
 
 static int append_tag_ref(const char *refname, const unsigned char *sha1)
 {
 	if (strncmp(refname, "refs/tags/", 10))
 		return 0;
-	return append_ref(refname + 5, sha1);
+	append_ref(refname + 5, sha1);
+	return 0;
 }
 
 static const char *match_ref_pattern = NULL;
@@ -420,7 +421,8 @@ static int append_matching_ref(const cha
 		return append_head_ref(refname, sha1);
 	if (!strncmp("refs/tags/", refname, 10))
 		return append_tag_ref(refname, sha1);
-	return append_ref(refname, sha1);
+	append_ref(refname, sha1);
+	return 0;
 }
 
 static void snarf_refs(int head, int tag)
@@ -473,10 +475,10 @@ static int show_merge_base(struct commit
 	return exit_status;
 }
 
-static int show_independent(struct commit **rev,
-			    int num_rev,
-			    char **ref_name,
-			    unsigned int *rev_mask)
+static void show_independent(struct commit **rev,
+			     int num_rev,
+			     char **ref_name,
+			     unsigned int *rev_mask)
 {
 	int i;
 
@@ -488,7 +490,6 @@ static int show_independent(struct commi
 			puts(sha1_to_hex(commit->object.sha1));
 		commit->object.flags |= UNINTERESTING;
 	}
-	return 0;
 }
 
 static void append_one_rev(const char *av)
@@ -706,8 +707,10 @@ int cmd_show_branch(int ac, const char *
 	if (merge_base)
 		return show_merge_base(seen, num_rev);
 
-	if (independent)
-		return show_independent(rev, num_rev, ref_name, rev_mask);
+	if (independent) {
+		show_independent(rev, num_rev, ref_name, rev_mask);
+		return 0;
+	}
 
 	/* Show list; --more=-1 means list-only */
 	if (1 < num_rev || extra < 0) {
-- 
1.4.2.g89bb-dirty
