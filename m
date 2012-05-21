From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/7] unpack-trees: record which unpack error messages should
 be freed
Date: Mon, 21 May 2012 16:56:08 +0200
Message-ID: <20120521145610.1911.60207.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWUG5-0003sk-CD
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 17:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab2EUPKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 11:10:48 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40117 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514Ab2EUPKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 11:10:47 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0FA5DA62D7;
	Mon, 21 May 2012 17:10:40 +0200 (CEST)
X-git-sha1: be5b36eb494a3d9d47b1f3e42b13981b256cf4bc 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198111>

"struct unpack_trees_options" has a "const char *msgs[]" field
that is setup with string values in setup_unpack_trees_porcelain().
Unfortunately this field is setup with strings that are sometimes
allocated on the stack, sometimes not.

The goal of this patch is to add some infrastructure to record which
of the string have been allocated on the stack so they can be
properly freed when not needed anymore.

We use a bitfield in struct unpack_trees_options to record that.
We add a function to both setup the error messages and record
wether they should be freed. And we add another function to
properly free all the messages that should be freed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 unpack-trees.c | 50 +++++++++++++++++++++++++++++++++++---------------
 unpack-trees.h |  3 +++
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index bcee99c..3537fea 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -50,11 +50,29 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	  ? ((o)->msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
+static void setup_unpack_error_msg(struct unpack_trees_options *opts,
+				   enum unpack_trees_error_types err_type,
+				   char *message, int to_free)
+{
+	/* Check that we can record which messages should be freed */
+	assert(NB_UNPACK_TREES_ERROR_TYPES <= 8 * sizeof(opts->msgs_to_be_freed));
+
+	opts->msgs[err_type] = message;
+	opts->msgs_to_be_freed |= (to_free ? 1u : 0) << err_type;
+}
+
+void free_unpack_error_msgs(struct unpack_trees_options *opts)
+{
+	int i;
+	for (i = 0; i < NB_UNPACK_TREES_ERROR_TYPES; i++)
+		if (opts->msgs_to_be_freed & 1u << i)
+			free((char *)opts->msgs[i]);
+}
+
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd)
 {
 	int i;
-	const char **msgs = opts->msgs;
 	const char *msg;
 	char *tmp;
 	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
@@ -65,11 +83,11 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
 	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 2);
 	sprintf(tmp, msg, cmd, cmd2);
-	msgs[ERROR_WOULD_OVERWRITE] = tmp;
-	msgs[ERROR_NOT_UPTODATE_FILE] = tmp;
+	setup_unpack_error_msg(opts, ERROR_WOULD_OVERWRITE, tmp, 1);
+	setup_unpack_error_msg(opts, ERROR_NOT_UPTODATE_FILE, tmp, 0);
 
-	msgs[ERROR_NOT_UPTODATE_DIR] =
-		"Updating the following directories would lose untracked files in it:\n%s";
+	tmp = "Updating the following directories would lose untracked files in it:\n%s";
+	setup_unpack_error_msg(opts, ERROR_NOT_UPTODATE_DIR, tmp, 0);
 
 	if (advice_commit_before_merge)
 		msg = "The following untracked working tree files would be %s by %s:\n%%s"
@@ -78,23 +96,25 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		msg = "The following untracked working tree files would be %s by %s:\n%%s";
 	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("removed") + strlen(cmd2) - 4);
 	sprintf(tmp, msg, "removed", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = tmp;
+	setup_unpack_error_msg(opts, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, tmp, 1);
 	tmp = xmalloc(strlen(msg) + strlen(cmd) + strlen("overwritten") + strlen(cmd2) - 4);
 	sprintf(tmp, msg, "overwritten", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = tmp;
+	setup_unpack_error_msg(opts, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, tmp, 1);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
 	 * cannot easily display it as a list.
 	 */
-	msgs[ERROR_BIND_OVERLAP] = "Entry '%s' overlaps with '%s'.  Cannot bind.";
-
-	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
-		"Cannot update sparse checkout: the following entries are not up-to-date:\n%s";
-	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
-		"The following Working tree files would be overwritten by sparse checkout update:\n%s";
-	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
-		"The following Working tree files would be removed by sparse checkout update:\n%s";
+	tmp = "Entry '%s' overlaps with '%s'.  Cannot bind.";
+	setup_unpack_error_msg(opts, ERROR_BIND_OVERLAP, tmp, 0);
+
+	tmp = "Cannot update sparse checkout: the following entries are not up-to-date:\n%s";
+	setup_unpack_error_msg(opts, ERROR_SPARSE_NOT_UPTODATE_FILE, tmp, 0);
+
+	tmp = "The following Working tree files would be overwritten by sparse checkout update:\n%s";
+	setup_unpack_error_msg(opts, ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN, tmp, 0);
+	tmp = "The following Working tree files would be removed by sparse checkout update:\n%s";
+	setup_unpack_error_msg(opts, ERROR_WOULD_LOSE_ORPHANED_REMOVED, tmp, 0);
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
diff --git a/unpack-trees.h b/unpack-trees.h
index 5e432f5..9b9d6ab 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -30,6 +30,7 @@ enum unpack_trees_error_types {
  */
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd);
+void free_unpack_error_msgs(struct unpack_trees_options *opts);
 
 struct unpack_trees_options {
 	unsigned int reset,
@@ -55,6 +56,8 @@ struct unpack_trees_options {
 	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
+	/* Bit array to know which msgs must be freed */
+	unsigned int msgs_to_be_freed;
 	/*
 	 * Store error messages in an array, each case
 	 * corresponding to a error message type
-- 
1.7.10.2.555.g6528037
