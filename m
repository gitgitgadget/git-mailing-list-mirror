From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] reset: Libify reset_index_file and print_new_head_line
Date: Sat, 11 Jun 2011 11:40:13 +0530
Message-ID: <1307772613-30775-1-git-send-email-artagnon@gmail.com>
References: <20110610103532.GA32119@elie>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 08:10:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVHOu-00071D-Az
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 08:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab1FKGKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2011 02:10:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42814 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1FKGKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 02:10:21 -0400
Received: by pwi15 with SMTP id 15so1510440pwi.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 23:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=+n668ElQ7d+35uRkoaBc+d7VbeslinGWrcxImeWfKQo=;
        b=xcH/Xti4GFDh6iZabeBuIsy7XjRBkJOZEF8NQ1hp4WmsxdgELdRHrUh45xJ9XB4hwB
         5I9IOGWQsXEP6wRI093c3DHErJFsmU49T1OCGPjgH8g1PM9Muavk924I2+7WAv1TY6qS
         x4XhYJEfWQeQnScpkxVpTXbW/tu10XgcuCqIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VINy26kQYcLeJvcza4FiVaK0/rS7HbeYn1tPlS0f319s58mXoVRpnKJSOt173V7m4D
         thaS4eWoJc41TpNBO7YDo7t3BwUMwSsPdmqNHyJgKdUd2X0MxQDHNKVFbFbLIcYK0KLG
         5MxgmnFxHTNa1OiGyve8nP6iFAZaOfJ035jlI=
Received: by 10.68.50.166 with SMTP id d6mr1218612pbo.333.1307772621111;
        Fri, 10 Jun 2011 23:10:21 -0700 (PDT)
Received: from localhost.localdomain ([122.174.121.147])
        by mx.google.com with ESMTPS id y2sm2911368pbi.35.2011.06.10.23.10.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 23:10:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <20110610103532.GA32119@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175637>

Move the two methods from builtin/reset.c to reset.c, create a reset.h
to expose them, and notify the Makefile about these two new files.  No
behavior change has been introduced.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile        |    2 +
 builtin/reset.c |  114 ++++++++++--------------------------------------------
 reset.c         |   76 ++++++++++++++++++++++++++++++++++++
 reset.h         |   11 +++++
 4 files changed, 110 insertions(+), 93 deletions(-)
 create mode 100644 reset.c
 create mode 100644 reset.h

diff --git a/Makefile b/Makefile
index e40ac0c..1f2b01c 100644
--- a/Makefile
+++ b/Makefile
@@ -548,6 +548,7 @@ LIB_H += reflog-walk.h
 LIB_H += refs.h
 LIB_H += remote.h
 LIB_H += rerere.h
+LIB_H += reset.h
 LIB_H += resolve-undo.h
 LIB_H += revision.h
 LIB_H += run-command.h
@@ -649,6 +650,7 @@ LIB_OBJS += refs.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
+LIB_OBJS += reset.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
diff --git a/builtin/reset.c b/builtin/reset.c
index 98bca04..3c41b39 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -20,6 +20,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "reset.h"
 
 static const char * const git_reset_usage[] = {
 	"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]",
@@ -28,7 +29,6 @@ static const char * const git_reset_usage[] = {
 	NULL
 };
 
-enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP, NONE };
 static const char *reset_type_names[] = {
 	N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("keep"), NULL
 };
@@ -57,78 +57,6 @@ static inline int is_merge(void)
 	return !access(git_path("MERGE_HEAD"), F_OK);
 }
 
-static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet)
-{
-	int nr = 1;
-	int newfd;
-	struct tree_desc desc[2];
-	struct unpack_trees_options opts;
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-
-	memset(&opts, 0, sizeof(opts));
-	opts.head_idx = 1;
-	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
-	opts.fn = oneway_merge;
-	opts.merge = 1;
-	if (!quiet)
-		opts.verbose_update = 1;
-	switch (reset_type) {
-	case KEEP:
-	case MERGE:
-		opts.update = 1;
-		break;
-	case HARD:
-		opts.update = 1;
-		/* fallthrough */
-	default:
-		opts.reset = 1;
-	}
-
-	newfd = hold_locked_index(lock, 1);
-
-	read_cache_unmerged();
-
-	if (reset_type == KEEP) {
-		unsigned char head_sha1[20];
-		if (get_sha1("HEAD", head_sha1))
-			return error(_("You do not have a valid HEAD."));
-		if (!fill_tree_descriptor(desc, head_sha1))
-			return error(_("Failed to find tree of HEAD."));
-		nr++;
-		opts.fn = twoway_merge;
-	}
-
-	if (!fill_tree_descriptor(desc + nr - 1, sha1))
-		return error(_("Failed to find tree of %s."), sha1_to_hex(sha1));
-	if (unpack_trees(nr, desc, &opts))
-		return -1;
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_locked_index(lock))
-		return error(_("Could not write new index file."));
-
-	return 0;
-}
-
-static void print_new_head_line(struct commit *commit)
-{
-	const char *hex, *body;
-
-	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
-	printf(_("HEAD is now at %s"), hex);
-	body = strstr(commit->buffer, "\n\n");
-	if (body) {
-		const char *eol;
-		size_t len;
-		body += 2;
-		eol = strchr(body, '\n');
-		len = eol ? eol - body : strlen(body);
-		printf(" %.*s\n", (int) len, body);
-	}
-	else
-		printf("\n");
-}
-
 static int update_index_refresh(int fd, struct lock_file *index_lock, int flags)
 {
 	int result;
@@ -235,7 +163,7 @@ static void die_if_unmerged_cache(int reset_type)
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
-	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int i = 0, reset_type = RESET_NONE, update_ref_status = 0, quiet = 0;
 	int patch_mode = 0;
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
@@ -245,14 +173,14 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	const struct option options[] = {
 		OPT__QUIET(&quiet, "be quiet, only report errors"),
 		OPT_SET_INT(0, "mixed", &reset_type,
-						"reset HEAD and index", MIXED),
-		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
+						"reset HEAD and index", RESET_MIXED),
+		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", RESET_SOFT),
 		OPT_SET_INT(0, "hard", &reset_type,
-				"reset HEAD, index and working tree", HARD),
+				"reset HEAD, index and working tree", RESET_HARD),
 		OPT_SET_INT(0, "merge", &reset_type,
-				"reset HEAD, index and working tree", MERGE),
+				"reset HEAD, index and working tree", RESET_MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
-				"reset HEAD but keep local changes", KEEP),
+				"reset HEAD but keep local changes", RESET_KEEP),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
 		OPT_END()
 	};
@@ -308,7 +236,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	hashcpy(sha1, commit->object.sha1);
 
 	if (patch_mode) {
-		if (reset_type != NONE)
+		if (reset_type != RESET_NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
 		return interactive_reset(rev, argv + i, prefix);
 	}
@@ -317,36 +245,36 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
 	if (i < argc) {
-		if (reset_type == MIXED)
+		if (reset_type == RESET_MIXED)
 			warning(_("--mixed with paths is deprecated; use 'git reset -- <paths>' instead."));
-		else if (reset_type != NONE)
+		else if (reset_type != RESET_NONE)
 			die(_("Cannot do %s reset with paths."),
 					_(reset_type_names[reset_type]));
 		return read_from_tree(prefix, argv + i, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
-	if (reset_type == NONE)
-		reset_type = MIXED; /* by default */
+	if (reset_type == RESET_NONE)
+		reset_type = RESET_MIXED; /* by default */
 
-	if (reset_type != SOFT && reset_type != MIXED)
+	if (reset_type != RESET_SOFT && reset_type != RESET_MIXED)
 		setup_work_tree();
 
-	if (reset_type == MIXED && is_bare_repository())
+	if (reset_type == RESET_MIXED && is_bare_repository())
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
 
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
-	if (reset_type == SOFT)
+	if (reset_type == RESET_SOFT)
 		die_if_unmerged_cache(reset_type);
 	else {
 		int err;
-		if (reset_type == KEEP)
+		if (reset_type == RESET_KEEP)
 			die_if_unmerged_cache(reset_type);
 		err = reset_index_file(sha1, reset_type, quiet);
-		if (reset_type == KEEP)
-			err = err || reset_index_file(sha1, MIXED, quiet);
+		if (reset_type == RESET_KEEP)
+			err = err || reset_index_file(sha1, RESET_MIXED, quiet);
 		if (err)
 			die(_("Could not reset index file to revision '%s'."), rev);
 	}
@@ -366,13 +294,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	update_ref_status = update_ref(msg, "HEAD", sha1, orig, 0, MSG_ON_ERR);
 
 	switch (reset_type) {
-	case HARD:
+	case RESET_HARD:
 		if (!update_ref_status && !quiet)
 			print_new_head_line(commit);
 		break;
-	case SOFT: /* Nothing else to do. */
+	case RESET_SOFT: /* Nothing else to do. */
 		break;
-	case MIXED: /* Report what has not been updated. */
+	case RESET_MIXED: /* Report what has not been updated. */
 		update_index_refresh(0, NULL,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 		break;
diff --git a/reset.c b/reset.c
new file mode 100644
index 0000000..3d9f1a3
--- /dev/null
+++ b/reset.c
@@ -0,0 +1,76 @@
+#include "builtin.h"
+#include "diff.h"
+#include "unpack-trees.h"
+#include "reset.h"
+
+int reset_index_file(const unsigned char *sha1, int reset_type, int quiet)
+{
+	int nr = 1;
+	int newfd;
+	struct tree_desc desc[2];
+	struct unpack_trees_options opts;
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.fn = oneway_merge;
+	opts.merge = 1;
+	if (!quiet)
+		opts.verbose_update = 1;
+	switch (reset_type) {
+	case RESET_KEEP:
+	case RESET_MERGE:
+		opts.update = 1;
+		break;
+	case RESET_HARD:
+		opts.update = 1;
+		/* fallthrough */
+	default:
+		opts.reset = 1;
+	}
+
+	newfd = hold_locked_index(lock, 1);
+
+	read_cache_unmerged();
+
+	if (reset_type == RESET_KEEP) {
+		unsigned char head_sha1[20];
+		if (get_sha1("HEAD", head_sha1))
+			return error(_("You do not have a valid HEAD."));
+		if (!fill_tree_descriptor(desc, head_sha1))
+			return error(_("Failed to find tree of HEAD."));
+		nr++;
+		opts.fn = twoway_merge;
+	}
+
+	if (!fill_tree_descriptor(desc + nr - 1, sha1))
+		return error(_("Failed to find tree of %s."), sha1_to_hex(sha1));
+	if (unpack_trees(nr, desc, &opts))
+		return -1;
+	if (write_cache(newfd, active_cache, active_nr) ||
+	    commit_locked_index(lock))
+		return error(_("Could not write new index file."));
+
+	return 0;
+}
+
+void print_new_head_line(struct commit *commit)
+{
+	const char *hex, *body;
+
+	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+	printf(_("HEAD is now at %s"), hex);
+	body = strstr(commit->buffer, "\n\n");
+	if (body) {
+		const char *eol;
+		size_t len;
+		body += 2;
+		eol = strchr(body, '\n');
+		len = eol ? eol - body : strlen(body);
+		printf(" %.*s\n", (int) len, body);
+	}
+	else
+		printf("\n");
+}
diff --git a/reset.h b/reset.h
new file mode 100644
index 0000000..0dafcd8
--- /dev/null
+++ b/reset.h
@@ -0,0 +1,11 @@
+#ifndef RESET_H
+#define RESET_H
+
+struct commit;
+enum reset_type { RESET_MIXED, RESET_SOFT, RESET_HARD, RESET_MERGE,
+		  RESET_KEEP, RESET_NONE };
+
+extern int reset_index_file(const unsigned char *sha1, int reset_type, int quiet);
+extern void print_new_head_line(struct commit *commit);
+
+#endif
-- 
1.7.4.1
