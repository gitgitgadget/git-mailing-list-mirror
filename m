From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH v2] Submodule merge support
Date: Sun, 20 May 2007 17:42:27 +0200
Message-ID: <20070520154227.GG5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 17:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpnYJ-0000fk-CI
	for gcvg-git@gmane.org; Sun, 20 May 2007 17:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbXETPm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 11:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756927AbXETPm3
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 11:42:29 -0400
Received: from mail.admingilde.org ([213.95.32.147]:52653 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882AbXETPm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 11:42:29 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HpnYB-00017b-PO
	for git@vger.kernel.org; Sun, 20 May 2007 17:42:27 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47843>

When merge-recursive gets to a dirlink, it starts an automatic submodule
merge and then uses the resulting merge commit for the top-level tree.
The submodule merge is done in another process to decouple object databases.

Submodule merges are done solely in the submodules' history, without taking
the supermodule (and it's merge base) into account.  If the submodule merge
is successful then the new submodule version will be used in the merged
supermodule.

If one side of the merge removed any submodule commits (e.g. by switching to
a different branch) then the automatic merge is stopped so that the user can
take a closer look on what happened.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---

This patch is based on my previous submodule checkout patch and the
start-commands-in-submodule patch.

This version takes index_only into account and does not need a new
helper script as all code is done in C now.

The entire ll_merge code in merge-recursive still should be moved to
some generic place, but that is for another patch.

 merge-recursive.c |  122 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8f72b2c..72562a8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -11,6 +11,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "run-command.h"
+#include "refs.h"
 #include "tag.h"
 #include "unpack-trees.h"
 #include "path-list.h"
@@ -574,6 +575,21 @@ static void update_file_flags(const unsigned char *sha,
 		void *buf;
 		unsigned long size;
 
+		if (S_ISDIRLNK(mode)) {
+			/* defer dirlinks to another process, don't try to */
+			/* read the object "sha" here */
+			const char *dirlink_checkout[] = {
+				"dirlink-checkout", path, sha1_to_hex(sha), NULL
+			};
+			struct child_process cmd = {
+				.argv = dirlink_checkout,
+				.git_cmd = 1,
+			};
+
+			run_command(&cmd);
+			goto update_index;
+		}
+
 		buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
 			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
@@ -1025,6 +1041,105 @@ static int ll_merge(mmbuffer_t *result_buf,
 	return merge_status;
 }
 
+
+static int ll_dirlink_merge_base(const char *path,
+                            const unsigned char *a,
+                            const unsigned char *b,
+                            unsigned char *result)
+{
+	const char *merge_base[] = {
+		"merge-base",
+		sha1_to_hex(a),
+		sha1_to_hex(b),
+		NULL
+	};
+	struct child_process cmd = {
+		.argv = merge_base,
+		.submodule = path,
+		.git_cmd = 1,
+		.out = -1,
+	};
+	char hex[40];
+	int status;
+
+	status = start_command(&cmd);
+	if (status) return status;
+
+	status = read(cmd.out, hex, sizeof(hex));
+	if (status != 40) return status;
+
+	status = finish_command(&cmd);
+	if (status) return status;
+
+	status = get_sha1_hex(hex, result);
+
+	return status;
+}
+
+static int ll_dirlink_merge(const char *path,
+                            const unsigned char *o,
+                            const unsigned char *a,
+                            const unsigned char *b,
+                            unsigned char *result)
+{
+	char b_hex[40+1];
+	const char *merge[] = {
+		"merge", b_hex, NULL
+	};
+	struct child_process cmd = {
+		.argv = merge,
+		.submodule = path,
+		.git_cmd = 1,
+	};
+	int status;
+	unsigned char base[20];
+	unsigned char test[20];
+
+	if (index_only)  {
+		/* as submodules have their own history we don't have to   */
+		/* try to do the index_only intermediate merges.           */
+		/* however we still want to get a submodule version        */
+		/* which is suitable as merge-base, just to make sure that */
+		/* all merge parents contain this base.                    */
+		/* The real merge (below) aborts if this check fails       */
+		return ll_dirlink_merge_base(path, a, b, result);
+	}
+
+	strcpy(b_hex, sha1_to_hex(b));
+	output(3, "merging submodule %s:", path);
+	output(3, " o=%s", sha1_to_hex(o));
+	output(3, " a=%s", sha1_to_hex(a));
+	output(3, " b=%s", sha1_to_hex(b));
+
+	/* first check that the submodule is in the current state  */
+	/* so that it can be merged.                               */
+	status = resolve_gitlink_ref(path, "HEAD", test);
+	if (hashcmp(test, a)) {
+		return error("can't merge submodule %s: not up to date.", path);
+	}
+
+	/* check that both sides of the superproject only did a    */
+	/* fast forward of the subproject so that it can be merged */
+	/* automatically.                                          */
+	status = ll_dirlink_merge_base(path, a, b, base);
+	if (status) return status;
+	status = ll_dirlink_merge_base(path, o, base, test);
+	if (status) return status;
+	if (hashcmp(test, o)) {
+		return error("can't merge submodule %s: conflicting history",
+		             path);
+	}
+
+	/* now start another merge process for the submodule */
+	status = run_command(&cmd);
+	if (status) return status;
+
+	/* get the new merged version */
+	status = resolve_gitlink_ref(path, "HEAD", result);
+
+	return status;
+}
+
 static struct merge_file_info merge_file(struct diff_filespec *o,
 		struct diff_filespec *a, struct diff_filespec *b,
 		const char *branch1, const char *branch2)
@@ -1069,6 +1184,13 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 
 			free(result_buf.ptr);
 			result.clean = (merge_status == 0);
+		} else if (S_ISDIRLNK(a->mode)) {
+			int merge_status;
+
+			merge_status = ll_dirlink_merge(a->path,
+				o->sha1, a->sha1, b->sha1, result.sha);
+
+			result.clean = (merge_status == 0);
 		} else {
 			if (!(S_ISLNK(a->mode) || S_ISLNK(b->mode)))
 				die("cannot merge modes?");
-- 
1.5.2.2.g081e


-- 
Martin Waitz
