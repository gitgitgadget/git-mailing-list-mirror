From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP PATCH 6/6] read-tree --debug-unpack
Date: Sat, 19 Sep 2009 22:06:15 -0700
Message-ID: <1253423175-6339-7-git-send-email-gitster@pobox.com>
References: <1253423175-6339-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 07:06:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpEdI-00044A-TK
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 07:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbZITFGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 01:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbZITFGc
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 01:06:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbZITFG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 01:06:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B22A857560
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1B/q
	1WCtcheex8gIWpCqDeWLRic=; b=C4dfvBVyDgtP36M1DrsEjxQWbnYmH7+a5f78
	lqc5VgTMD2h1+RJlGAseyyYZFG+aUlm1o65ipebK0bPnzNFCRadF28k+UsqDwyHJ
	2E0A2LNWe/NnHcI8xrSr5Syx30nAuKm/tVJBXKQbkYvy4EYhZxtqdWg2IlodTeq+
	kle3uNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Aa3mRG
	wY8/AAGkPGjbIHG1le0iYxGnR+dcRPy2FddCtySpm7cqMKkPoyXVd+JCP0es4KDY
	spIHiaNH2+ZsGWcmnKG8iQW7Zm75PKWBMTA+6IK5RrMqhau6/T+GME96onkm8rbS
	c7w7X/OAqvihV1mH9AMReDrbHZAc0RvLZ0KQM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE6FD5755F
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EB4F75755E for
 <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:30 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.90.ga3b1b
In-Reply-To: <1253423175-6339-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5C6E78B6-A5A3-11DE-A1FC-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128839>

Debugging patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-read-tree.c |   36 ++++++++++++++++++++++++++++++++++++
 unpack-trees.c      |   35 +++++++++++++++++++++++++++++++++++
 unpack-trees.h      |    1 +
 3 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 14c836b..a9788e5 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -64,6 +64,34 @@ static int exclude_per_directory_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static void debug_stage(const char *label, struct cache_entry *ce,
+			struct unpack_trees_options *o)
+{
+	printf("%s ", label);
+	if (!ce)
+		printf("(missing)\n");
+	else if (ce == o->df_conflict_entry)
+		printf("(conflict)\n");
+	else
+		printf("%06o #%d %s %.8s\n",
+		       ce->ce_mode, ce_stage(ce), ce->name,
+		       sha1_to_hex(ce->sha1));
+}
+
+static int debug_merge(struct cache_entry **stages, struct unpack_trees_options *o)
+{
+	int i;
+
+	printf("* %d-way merge\n", o->merge_size);
+	debug_stage("index", stages[0], o);
+	for (i = 1; i <= o->merge_size; i++) {
+		char buf[24];
+		sprintf(buf, "ent#%d", i);
+		debug_stage(buf, stages[i], o);
+	}
+	return 0;
+}
+
 static struct lock_file lock_file;
 
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
@@ -98,6 +126,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
 		OPT_SET_INT('i', NULL, &opts.index_only,
 			    "don't check the working tree after merging", 1),
+		OPT_SET_INT(0, "debug-unpack", &opts.debug_unpack,
+			    "debug unpack-trees", 1),
 		OPT_END()
 	};
 
@@ -165,6 +195,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			opts.head_idx = 1;
 	}
 
+	if (opts.debug_unpack)
+		opts.fn = debug_merge;
+
 	cache_tree_free(&active_cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
@@ -174,6 +207,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	if (unpack_trees(nr_trees, t, &opts))
 		return 128;
 
+	if (opts.debug_unpack)
+		return 0; /* do not write the index out */
+
 	/*
 	 * When reading only one tree (either the most basic form,
 	 * "-m ent" or "--reset ent" form), we can obtain a fully
diff --git a/unpack-trees.c b/unpack-trees.c
index a6f2187..b1ad2d9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -393,6 +393,38 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
 	return -1;
 }
 
+static void debug_path(struct traverse_info *info)
+{
+	if (info->prev) {
+		debug_path(info->prev);
+		if (*info->prev->name.path)
+			putchar('/');
+	}
+	printf("%s", info->name.path);
+}
+
+static void debug_name_entry(int i, struct name_entry *n)
+{
+	printf("ent#%d %06o %s\n", i,
+	       n->path ? n->mode : 0,
+	       n->path ? n->path : "(missing)");
+}
+
+static void debug_unpack_callback(int n,
+				  unsigned long mask,
+				  unsigned long dirmask,
+				  struct name_entry *names,
+				  struct traverse_info *info)
+{
+	int i;
+	printf("* unpack mask %lu, dirmask %lu, cnt %d ",
+	       mask, dirmask, n);
+	debug_path(info);
+	putchar('\n');
+	for (i = 0; i < n; i++)
+		debug_name_entry(i, names + i);
+}
+
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
@@ -403,6 +435,9 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	while (!p->mode)
 		p++;
 
+	if (o->debug_unpack)
+		debug_unpack_callback(n, mask, dirmask, names, info);
+
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
 		while (1) {
diff --git a/unpack-trees.h b/unpack-trees.h
index 9a0733e..701dca5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -28,6 +28,7 @@ struct unpack_trees_options {
 		     skip_unmerged,
 		     initial_checkout,
 		     diff_index_cached,
+		     debug_unpack,
 		     gently;
 	const char *prefix;
 	int cache_bottom;
-- 
1.6.5.rc1.90.ga3b1b
