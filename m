From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] builtin-add.c: restructure the code for maintainability
Date: Wed, 23 Jul 2008 00:01:41 -0700
Message-ID: <1216796502-11227-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 09:02:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLYN5-0001pk-Ny
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 09:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbYGWHBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 03:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbYGWHBt
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 03:01:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbYGWHBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 03:01:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9D6C2FA00
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 03:01:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9BC392F9BF for <git@vger.kernel.org>; Wed, 23 Jul 2008 03:01:44
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc0.15.g0dda1
X-Pobox-Relay-ID: 365B145C-5885-11DD-A934-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89605>

A private function add_files_to_cache() in builtin-add.c was borrowed by
checkout and commit re-implementors without getting properly refactored to
more library-ish place.  This does the refactoring.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is just code movement.

 builtin-add.c |   57 -----------------------------------------------------
 cache.h       |    1 +
 read-cache.c  |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index fc3f96e..0de516a 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -8,10 +8,6 @@
 #include "dir.h"
 #include "exec_cmd.h"
 #include "cache-tree.h"
-#include "diff.h"
-#include "diffcore.h"
-#include "commit.h"
-#include "revision.h"
 #include "run-command.h"
 #include "parse-options.h"
 
@@ -79,59 +75,6 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 		prune_directory(dir, pathspec, baselen);
 }
 
-struct update_callback_data
-{
-	int flags;
-	int add_errors;
-};
-
-static void update_callback(struct diff_queue_struct *q,
-			    struct diff_options *opt, void *cbdata)
-{
-	int i;
-	struct update_callback_data *data = cbdata;
-
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		const char *path = p->one->path;
-		switch (p->status) {
-		default:
-			die("unexpected diff status %c", p->status);
-		case DIFF_STATUS_UNMERGED:
-		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_cache(path, data->flags)) {
-				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
-					die("updating files failed");
-				data->add_errors++;
-			}
-			break;
-		case DIFF_STATUS_DELETED:
-			if (!(data->flags & ADD_CACHE_PRETEND))
-				remove_file_from_cache(path);
-			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
-				printf("remove '%s'\n", path);
-			break;
-		}
-	}
-}
-
-int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
-{
-	struct update_callback_data data;
-	struct rev_info rev;
-	init_revisions(&rev, prefix);
-	setup_revisions(0, NULL, &rev, NULL);
-	rev.prune_data = pathspec;
-	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = update_callback;
-	data.flags = flags;
-	data.add_errors = 0;
-	rev.diffopt.format_callback_data = &data;
-	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	return !!data.add_errors;
-}
-
 static void refresh(int verbose, const char **pathspec)
 {
 	char *seen;
diff --git a/cache.h b/cache.h
index 38985aa..6f374ad 100644
--- a/cache.h
+++ b/cache.h
@@ -375,6 +375,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
 #define ADD_CACHE_IGNORE_ERRORS	4
+#define ADD_CACHE_IGNORE_REMOVAL 8
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
diff --git a/read-cache.c b/read-cache.c
index a50a851..6833af6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -8,6 +8,11 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
+#include "tree.h"
+#include "commit.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
 
 /* Index extensions.
  *
@@ -1444,3 +1449,59 @@ int read_index_unmerged(struct index_state *istate)
 	istate->cache_nr = dst - istate->cache;
 	return !!last;
 }
+
+struct update_callback_data
+{
+	int flags;
+	int add_errors;
+};
+
+static void update_callback(struct diff_queue_struct *q,
+			    struct diff_options *opt, void *cbdata)
+{
+	int i;
+	struct update_callback_data *data = cbdata;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *path = p->one->path;
+		switch (p->status) {
+		default:
+			die("unexpected diff status %c", p->status);
+		case DIFF_STATUS_UNMERGED:
+		case DIFF_STATUS_MODIFIED:
+		case DIFF_STATUS_TYPE_CHANGED:
+			if (add_file_to_index(&the_index, path, data->flags)) {
+				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
+					die("updating files failed");
+				data->add_errors++;
+			}
+			break;
+		case DIFF_STATUS_DELETED:
+			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
+				break;
+			if (!(data->flags & ADD_CACHE_PRETEND))
+				remove_file_from_index(&the_index, path);
+			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
+				printf("remove '%s'\n", path);
+			break;
+		}
+	}
+}
+
+int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
+{
+	struct update_callback_data data;
+	struct rev_info rev;
+	init_revisions(&rev, prefix);
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.prune_data = pathspec;
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = update_callback;
+	data.flags = flags;
+	data.add_errors = 0;
+	rev.diffopt.format_callback_data = &data;
+	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	return !!data.add_errors;
+}
+
-- 
1.6.0.rc0.15.g0dda1
