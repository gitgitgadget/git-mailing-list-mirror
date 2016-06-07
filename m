From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 8/8] merge-recursive: convert merge_recursive_generic to object_id
Date: Tue,  7 Jun 2016 00:57:16 +0000
Message-ID: <20160607005716.69222-9-sandals@crustytoothpaste.net>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 02:57:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA5Kw-0003AM-7o
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 02:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbcFGA5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 20:57:37 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40782 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752856AbcFGA53 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 20:57:29 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C14D5282A9;
	Tue,  7 Jun 2016 00:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465261046;
	bh=9tH+D20fiPh4c3XRWZgzLu1Hnr+FlGyIsDrfCSuW3QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ph3eSlrCTFirznyzcW8AUCWmaeBI8liae13kYnawSKRfh4ua+QOVuBqfuAS5L1rd9
	 AJDa4IWvpPvD+kbWXteo8I2Bs/ld4mUpzYd8BDQcRgzy3I7jylLvMIbVMYO0kLodEi
	 ss0bdEU8WDsEg3Dkkt3lTFc6akUCr28Yi+wt7PL/1DvAZwTMLKXXca9Bp7e7tTQoyR
	 tXNZ6jnYf6ACMr3N6QAcMjbGuBDa8tt/8jxlzw4dtDSai6ANnytKvBAlKbd90orXRY
	 tIMKs0CXQ3FRfTpYMgn8mxoGjeSlT4e9hkuRyv8dy4ewg752q3Em+zkAcyxoE9q0Lr
	 ncVkrkiu+0rQ2n3v7iwY6quinvySeT16OSaOwD5j0Y1stM+qFoGKZg0IBcTczeNBdB
	 ddPmQBAQhz7fJQ+EaTukvcdiRCs5oDsWUFaxnkPzM+WqS9gQ59i1/iLQ8VfPxW8vYn
	 E/rweBDG8LYfJl5Vi5RR0h3NwG/45gxlCP1SBblgIxjvTFM56hB
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160607005716.69222-2-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296586>

Convert this function and the git merge-recursive subcommand to use
struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
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
