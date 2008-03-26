From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fsck --lost-found: show found commits human readably
Date: Tue, 25 Mar 2008 23:45:47 -0700
Message-ID: <7vbq52gezo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 07:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JePPM-0006Ic-Fc
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbYCZGqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 02:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbYCZGqG
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:46:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYCZGqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 02:46:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC8B2193F;
	Wed, 26 Mar 2008 02:46:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DFCCE193E; Wed, 26 Mar 2008 02:45:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78267>

An earlier commit fc8b5f0 (Deprecate git-lost-found, 2007-11-08) declared
"lost-found" deprecated, because "fsck" learned "--lost-found" option that
drops the found objects in $GIT_DIR/lost-found.

But the output from the lost-found program has been much more informative
than the plain vanilla "git fsck" (or "git fsck --lost-found") output.  In
that sense, forcing users to use "fsck --lost-found" when they want to use
"lost-found" is a regression.

This patch slightly enhances the output from "fsck --lost-found" to add
oneline description at the end of the usual "dangling <type> <sha-1>"
message for commit objects it found.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Is it just me, or were we very sloppy during 1.5.4 cycle that we are
   getting hit by regressions left and right today from that period?

   This looks bigger than it really is because most of it is about
   moving a deeply nested part of another function into a separate
   function.

   This is _not_ a 1.5.5 material, as we are not removing git-lost-found
   yet.  We might however want to revert fc8b5f0, though, until an
   enhancement along this line is in the mainline.

 builtin-fsck.c |   94 ++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 78a6e1f..b57cc78 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -145,6 +145,68 @@ static void check_reachable_object(struct object *obj)
 	}
 }
 
+static void dangling_object(struct object *obj)
+{
+	char *filename;
+	FILE *f;
+	enum object_type type;
+	unsigned long size;
+	char *buf = NULL;
+
+	if (!write_lost_and_found)
+		goto report_and_exit;
+
+	filename = git_path("lost-found/%s/%s",
+			    obj->type == OBJ_COMMIT ? "commit" : "other",
+			    sha1_to_hex(obj->sha1));
+
+	if (safe_create_leading_directories(filename)) {
+		error("Could not create lost-found");
+		return;
+	}
+	if (!(f = fopen(filename, "w")))
+		die("Could not open %s", filename);
+	if (obj->type == OBJ_BLOB || obj->type == OBJ_COMMIT)
+		buf = read_sha1_file(obj->sha1, &type, &size);
+
+	if (obj->type == OBJ_BLOB) {
+		if (buf) {
+			fwrite(buf, size, 1, f);
+			free(buf);
+		}
+	} else
+		fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
+	fclose(f);
+
+	if (obj->type == OBJ_COMMIT) {
+		struct strbuf sb = STRBUF_INIT;
+		struct commit *commit = lookup_commit(obj->sha1);
+		int reported = 0;
+
+		if (!commit->buffer)
+			commit->buffer = buf;
+		if (commit->buffer) {
+			parse_commit(commit);
+			pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb,
+					    0, NULL, NULL, 0, 0);
+			printf("dangling commit %s (%s)\n",
+			       sha1_to_hex(obj->sha1), sb.buf);
+			reported = 1;
+		}
+		strbuf_release(&sb);
+		free(commit->buffer);
+		if (buf && commit->buffer != buf)
+			free(buf);
+		commit->buffer = NULL;
+		if (reported)
+			return;
+	}
+
+ report_and_exit:
+	printf("dangling %s %s\n", typename(obj->type),
+	       sha1_to_hex(obj->sha1));
+}
+
 /*
  * Check a single unreachable object
  */
@@ -180,36 +242,8 @@ static void check_unreachable_object(struct object *obj)
 	 * deleted a branch by mistake, this is a prime candidate to
 	 * start looking at, for example.
 	 */
-	if (!obj->used) {
-		printf("dangling %s %s\n", typename(obj->type),
-		       sha1_to_hex(obj->sha1));
-		if (write_lost_and_found) {
-			char *filename = git_path("lost-found/%s/%s",
-				obj->type == OBJ_COMMIT ? "commit" : "other",
-				sha1_to_hex(obj->sha1));
-			FILE *f;
-
-			if (safe_create_leading_directories(filename)) {
-				error("Could not create lost-found");
-				return;
-			}
-			if (!(f = fopen(filename, "w")))
-				die("Could not open %s", filename);
-			if (obj->type == OBJ_BLOB) {
-				enum object_type type;
-				unsigned long size;
-				char *buf = read_sha1_file(obj->sha1,
-						&type, &size);
-				if (buf) {
-					fwrite(buf, size, 1, f);
-					free(buf);
-				}
-			} else
-				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
-			fclose(f);
-		}
-		return;
-	}
+	if (!obj->used)
+		dangling_object(obj);
 
 	/*
 	 * Otherwise? It's there, it's unreachable, and some other unreachable
