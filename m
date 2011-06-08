From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] reset: Libify reset_index_file and print_new_head_line
Date: Wed,  8 Jun 2011 15:25:28 +0000
Message-ID: <1307546728-11202-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:25:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKdY-0006te-6n
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab1FHPZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 11:25:32 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51360 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab1FHPZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:25:31 -0400
Received: by vxi39 with SMTP id 39so436243vxi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=s1km4dC9n/iFOXa40ZBN3I7QvzFDYM/1guTjGTs0kqs=;
        b=XyUXy4tzwV8AB2HcTL4SmUOV2fazITDLSPBLRbF1RHpUsDka7i5UIPf8wdBE5/GFjU
         LeIaVpewb9/4aJHTN/JjLtVqNCua9xfjSWLHQTYf1eMQ1Kiesz6ZCtP98U0TcVA7Xcwv
         zA7Kng5KGadLw/nyNKkYsZa0eWSSDmLcJ+Vec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M3YxQMqvFC0kK9jXM5ytlhYyQ0L/cpJ0Y8P/2xs6mpO5DbSNsles8a7TMDji20x2Mt
         3zKTzr7fjt/UI7G7GeBrUuM55RiFe0ikRQfZLffhTAbwNVetD3+JGXzezQob6zILGt7n
         5JsPneUC7Th5AMmG+ps0kD+UPzHgauD3ZfYkE=
Received: by 10.52.75.170 with SMTP id d10mr1579198vdw.231.1307546730802;
        Wed, 08 Jun 2011 08:25:30 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id bh17sm156747vdc.27.2011.06.08.08.25.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 08:25:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175385>

Move the two methods from builtin/reset.c to reset.c, create a reset.h
to expose them, and notify the Makefile about these two new files.  No
behavior change has been introduced.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 This patch lays the foundation for libifying reset by starting with
 two "easy" methods.  I'll be using print_new_head_line in the
 sequencer series while implementing --abort.

 Makefile        |    2 +
 builtin/reset.c |   74 +-------------------------------------------------
 reset.c         |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 reset.h         |   11 +++++++
 4 files changed, 95 insertions(+), 73 deletions(-)
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
index 98bca04..08b3f9f 100644
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
diff --git a/reset.c b/reset.c
new file mode 100644
index 0000000..760cb15
--- /dev/null
+++ b/reset.c
@@ -0,0 +1,81 @@
+#include "builtin.h"
+#include "refs.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "tree.h"
+#include "branch.h"
+#include "tree.h"
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
+	case KEEP:
+	case MERGE:
+		opts.update = 1;
+		break;
+	case HARD:
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
+	if (reset_type == KEEP) {
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
index 0000000..308a627
--- /dev/null
+++ b/reset.h
@@ -0,0 +1,11 @@
+#ifndef RESET_H
+#define RESET_H
+
+#include "commit.h"
+
+enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP, NONE };
+
+int reset_index_file(const unsigned char *sha1, int reset_type, int quiet);
+void print_new_head_line(struct commit *commit);
+
+#endif
-- 
1.7.5.GIT
