Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43BF1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 02:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbdBNCcv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 21:32:51 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50628 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751298AbdBNCcO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Feb 2017 21:32:14 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 42CB2280B4;
        Tue, 14 Feb 2017 02:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487039517;
        bh=HScHg5Pr4wKDj6iQBgn0ByY3R9AUuGvZNAneuu2D6xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqZYizNjO+US+zKu4b+II/4q4ohHXPDUfJRQ8kyPftR8R6osGUeq6mIpyuSCTO0rl
         rrhoM+WU+3B4cgLbspii0VCY4HdUthI2vzO7uPgo8nfiPCE/0vPo2cCQc0zY1Ccd+l
         0+qsOPqFy91Qd5go00ZdvcvhlxlkUdBbiHp7c+D2LWZytGEP5mdAIYNnZAT4i9a7+O
         k2UC6HO82KJaWKi8eC83RPfWrt9C8ZlLWxN/t5iSBUPGgZVvyQpoNuBJJVh89dOFa2
         JzymIJr/SVCCk4Z+NXy5eEHDrYJccnwIKjZKDtEEz5cy4dyONkYZO5yB1jdOwYsTyD
         z77ZV4E7gNeHQC8kicYd/2Ux8QV8X9tfuAAsAL/R0suBkUG0yDwgiB1VZU0ObgIgae
         nWDBB4zTBf6h7RPMcgJ28zybkv7Ph3hWxnZGX84SNekKojn4TbmCYGRIrNtpBPT/z0
         LFQFKYeyO3cW66rl4ph28ysaEpEZBZ7LyUwgxhg1IrE/U+HbuA7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/19] builtin/branch: convert to struct object_id
Date:   Tue, 14 Feb 2017 02:31:29 +0000
Message-Id: <20170214023141.842922-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170214023141.842922-1-sandals@crustytoothpaste.net>
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/branch.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9d30f55b0b..faf472ff8f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -32,7 +32,7 @@ static const char * const builtin_branch_usage[] = {
 };
 
 static const char *head;
-static unsigned char head_sha1[20];
+static struct object_id head_oid;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -117,13 +117,13 @@ static int branch_merged(int kind, const char *name,
 	if (kind == FILTER_REFS_BRANCHES) {
 		struct branch *branch = branch_get(name);
 		const char *upstream = branch_get_upstream(branch, NULL);
-		unsigned char sha1[20];
+		struct object_id oid;
 
 		if (upstream &&
 		    (reference_name = reference_name_to_free =
 		     resolve_refdup(upstream, RESOLVE_REF_READING,
-				    sha1, NULL)) != NULL)
-			reference_rev = lookup_commit_reference(sha1);
+				    oid.hash, NULL)) != NULL)
+			reference_rev = lookup_commit_reference(oid.hash);
 	}
 	if (!reference_rev)
 		reference_rev = head_rev;
@@ -153,10 +153,10 @@ static int branch_merged(int kind, const char *name,
 }
 
 static int check_branch_commit(const char *branchname, const char *refname,
-			       const unsigned char *sha1, struct commit *head_rev,
+			       const struct object_id *oid, struct commit *head_rev,
 			       int kinds, int force)
 {
-	struct commit *rev = lookup_commit_reference(sha1);
+	struct commit *rev = lookup_commit_reference(oid->hash);
 	if (!rev) {
 		error(_("Couldn't look up commit object for '%s'"), refname);
 		return -1;
@@ -183,7 +183,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			   int quiet)
 {
 	struct commit *head_rev = NULL;
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *name = NULL;
 	const char *fmt;
 	int i;
@@ -207,7 +207,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 
 	if (!force) {
-		head_rev = lookup_commit_reference(head_sha1);
+		head_rev = lookup_commit_reference(head_oid.hash);
 		if (!head_rev)
 			die(_("Couldn't look up commit object for HEAD"));
 	}
@@ -235,7 +235,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					RESOLVE_REF_READING
 					| RESOLVE_REF_NO_RECURSE
 					| RESOLVE_REF_ALLOW_BAD_NAME,
-					sha1, &flags);
+					oid.hash, &flags);
 		if (!target) {
 			error(remote_branch
 			      ? _("remote-tracking branch '%s' not found.")
@@ -245,13 +245,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		}
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
-		    check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
+		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					force)) {
 			ret = 1;
 			goto next;
 		}
 
-		if (delete_ref(name, is_null_sha1(sha1) ? NULL : sha1,
+		if (delete_ref(name, is_null_oid(&oid) ? NULL : oid.hash,
 			       REF_NODEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote-tracking branch '%s'")
@@ -267,7 +267,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			       bname.buf,
 			       (flags & REF_ISBROKEN) ? "broken"
 			       : (flags & REF_ISSYMREF) ? target
-			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			       : find_unique_abbrev(oid.hash, DEFAULT_ABBREV));
 		}
 		delete_branch_config(bname.buf);
 
@@ -693,7 +693,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	track = git_branch_track;
 
-	head = resolve_refdup("HEAD", 0, head_sha1, NULL);
+	head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD"))
-- 
2.11.0

