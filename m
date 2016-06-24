Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 141571FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbcFXXJr (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:09:47 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52558 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751508AbcFXXJp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 19:09:45 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5A889280A1;
	Fri, 24 Jun 2016 23:09:44 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466809784;
	bh=g0eo/Iv1TwepDe4ufHlOvM0veVc40YNmvD4XRXz2h64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xI8VnlF+oIhsAPRsDB0BYjO+0WcVjvtKIli7ynVCPUwZdkif2E4ERDrUoUahAmk5p
	 AEo7DYVM2uggc3+fO+x3XzDOWh0O22mIITxxtRJUiYr7eEBwDjf2j+tItxdaWtl++9
	 VZQeEc5PixJzclDb/ZcuS+0cpip0duGMZFqCf7ou6DO2ZK/lcVFSJ0L7ieBo0iFPGP
	 TNh7q6V9U6wMe7iFS4pYm7w9ZrYKjjoZI7kte30+oPob/zn+fkOXX8nIzNlBIpEbDa
	 0T3vZBz0puKdK+JpPEY+CoiiR0IDxS7niUw865p9pJlZ2aF5SN/0wy8F6alEYqfKlZ
	 TUW4Y5BH+4VFVq/4II5O7Yv+lUh9PxAJLOtKNqOnc6iep9HetfUnyNZ7ei6IMYmYEC
	 3pv1CBojW1tRgylgJPTiFUdAKY9goYG583oLdawxUzqoriL1JRXOaUPV3SLybgBw4j
	 5YIRTfaRFiILbhsqYYQS2q1NRVH2Ic81MRttrV+mxgSVAEafyN7
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 10/11] merge-recursive: convert merge_recursive_generic to object_id
Date:	Fri, 24 Jun 2016 23:09:28 +0000
Message-Id: <20160624230929.82222-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160624230929.82222-1-sandals@crustytoothpaste.net>
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Convert this function and the git merge-recursive subcommand to use
struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-recursive.c | 20 ++++++++++----------
 merge-recursive.c         | 14 +++++++-------
 merge-recursive.h         |  6 +++---
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 491efd55..fd2c4556 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -9,10 +9,10 @@ static const char builtin_merge_recursive_usage[] =
 
 static const char *better_branch_name(const char *branch)
 {
-	static char githead_env[8 + 40 + 1];
+	static char githead_env[8 + GIT_SHA1_HEXSZ + 1];
 	char *name;
 
-	if (strlen(branch) != 40)
+	if (strlen(branch) != GIT_SHA1_HEXSZ)
 		return branch;
 	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
 	name = getenv(githead_env);
@@ -21,10 +21,10 @@ static const char *better_branch_name(const char *branch)
 
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 {
-	const unsigned char *bases[21];
+	const struct object_id *bases[21];
 	unsigned bases_count = 0;
 	int i, failed;
-	unsigned char h1[20], h2[20];
+	struct object_id h1, h2;
 	struct merge_options o;
 	struct commit *result;
 
@@ -46,10 +46,10 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (bases_count < ARRAY_SIZE(bases)-1) {
-			unsigned char *sha = xmalloc(20);
-			if (get_sha1(argv[i], sha))
+			struct object_id *oid = xmalloc(sizeof(struct object_id));
+			if (get_oid(argv[i], oid))
 				die("Could not parse object '%s'", argv[i]);
-			bases[bases_count++] = sha;
+			bases[bases_count++] = oid;
 		}
 		else
 			warning("Cannot handle more than %d bases. "
@@ -62,9 +62,9 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	o.branch1 = argv[++i];
 	o.branch2 = argv[++i];
 
-	if (get_sha1(o.branch1, h1))
+	if (get_oid(o.branch1, &h1))
 		die("Could not resolve ref '%s'", o.branch1);
-	if (get_sha1(o.branch2, h2))
+	if (get_oid(o.branch2, &h2))
 		die("Could not resolve ref '%s'", o.branch2);
 
 	o.branch1 = better_branch_name(o.branch1);
@@ -73,7 +73,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (o.verbosity >= 3)
 		printf("Merging %s with %s\n", o.branch1, o.branch2);
 
-	failed = merge_recursive_generic(&o, h1, h2, bases_count, bases, &result);
+	failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
 	if (failed < 0)
 		return 128; /* die() error code */
 	return failed;
diff --git a/merge-recursive.c b/merge-recursive.c
index 7bbd4aea..48fe7e73 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1982,11 +1982,11 @@ int merge_recursive(struct merge_options *o,
 	return clean;
 }
 
-static struct commit *get_ref(const unsigned char *sha1, const char *name)
+static struct commit *get_ref(const struct object_id *oid, const char *name)
 {
 	struct object *object;
 
-	object = deref_tag(parse_object(sha1), name, strlen(name));
+	object = deref_tag(parse_object(oid->hash), name, strlen(name));
 	if (!object)
 		return NULL;
 	if (object->type == OBJ_TREE)
@@ -1999,10 +1999,10 @@ static struct commit *get_ref(const unsigned char *sha1, const char *name)
 }
 
 int merge_recursive_generic(struct merge_options *o,
-			    const unsigned char *head,
-			    const unsigned char *merge,
+			    const struct object_id *head,
+			    const struct object_id *merge,
 			    int num_base_list,
-			    const unsigned char **base_list,
+			    const struct object_id **base_list,
 			    struct commit **result)
 {
 	int clean;
@@ -2015,9 +2015,9 @@ int merge_recursive_generic(struct merge_options *o,
 		int i;
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
-			if (!(base = get_ref(base_list[i], sha1_to_hex(base_list[i]))))
+			if (!(base = get_ref(base_list[i], oid_to_hex(base_list[i]))))
 				return error(_("Could not parse object '%s'"),
-					sha1_to_hex(base_list[i]));
+					oid_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
 		}
 	}
diff --git a/merge-recursive.h b/merge-recursive.h
index 52f0201f..d415724a 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -49,10 +49,10 @@ int merge_trees(struct merge_options *o,
  * virtual commits and call merge_recursive() proper.
  */
 int merge_recursive_generic(struct merge_options *o,
-			    const unsigned char *head,
-			    const unsigned char *merge,
+			    const struct object_id *head,
+			    const struct object_id *merge,
 			    int num_ca,
-			    const unsigned char **ca,
+			    const struct object_id **ca,
 			    struct commit **result);
 
 void init_merge_options(struct merge_options *o);
