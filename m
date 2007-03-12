From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/4] Replace fork_with_pipe in bundle with run_command
Date: Mon, 12 Mar 2007 14:38:15 -0400
Message-ID: <20070312183815.GD15996@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQpPm-00008S-75
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 19:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbXCLSiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 14:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbXCLSiV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 14:38:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50676 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbXCLSiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 14:38:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQpPN-00062y-74; Mon, 12 Mar 2007 14:38:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B238720FBAE; Mon, 12 Mar 2007 14:38:15 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42056>

Now that the run_command family supports all of the redirection
modes needed by builtin-bundle, we can use those functions rather
than the underlying POSIX primitives.  This should help to make the
bundle command slightly more portable to other systems, like Windows.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-bundle.c |  126 ++++++++++++-----------------------------------------
 1 files changed, 29 insertions(+), 97 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 7868080..42d7176 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -4,7 +4,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
-#include "exec_cmd.h"
+#include "run-command.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
@@ -99,67 +99,6 @@ static int read_header(const char *path, struct bundle_header *header) {
 	return fd;
 }
 
-/* if in && *in >= 0, take that as input file descriptor instead */
-static int fork_with_pipe(const char **argv, int *in, int *out)
-{
-	int needs_in, needs_out;
-	int fdin[2], fdout[2], pid;
-
-	needs_in = in && *in < 0;
-	if (needs_in) {
-		if (pipe(fdin) < 0)
-			return error("could not setup pipe");
-		*in = fdin[1];
-	}
-
-	needs_out = out && *out < 0;
-	if (needs_out) {
-		if (pipe(fdout) < 0)
-			return error("could not setup pipe");
-		*out = fdout[0];
-	}
-
-	if ((pid = fork()) < 0) {
-		if (needs_in) {
-			close(fdin[0]);
-			close(fdin[1]);
-		}
-		if (needs_out) {
-			close(fdout[0]);
-			close(fdout[1]);
-		}
-		return error("could not fork");
-	}
-	if (!pid) {
-		if (needs_in) {
-			dup2(fdin[0], 0);
-			close(fdin[0]);
-			close(fdin[1]);
-		} else if (in) {
-			dup2(*in, 0);
-			close(*in);
-		}
-		if (needs_out) {
-			dup2(fdout[1], 1);
-			close(fdout[0]);
-			close(fdout[1]);
-		} else if (out) {
-			dup2(*out, 1);
-			close(*out);
-		}
-		exit(execv_git_cmd(argv));
-	}
-	if (needs_in)
-		close(fdin[0]);
-	else if (in)
-		close(*in);
-	if (needs_out)
-		close(fdout[1]);
-	else if (out)
-		close(*out);
-	return pid;
-}
-
 static int list_refs(struct ref_list *r, int argc, const char **argv)
 {
 	int i;
@@ -263,9 +202,10 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	int bundle_fd = -1;
 	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
 	const char **argv_pack = xmalloc(5 * sizeof(const char *));
-	int pid, in, out, i, status, ref_count = 0;
+	int i, status, ref_count = 0;
 	char buffer[1024];
 	struct rev_info revs;
+	struct child_process rls;
 
 	bundle_fd = (!strcmp(path, "-") ? 1 :
 			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
@@ -285,11 +225,13 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	argv_boundary[1] = "--boundary";
 	argv_boundary[2] = "--pretty=oneline";
 	argv_boundary[argc + 2] = NULL;
-	out = -1;
-	pid = fork_with_pipe(argv_boundary, NULL, &out);
-	if (pid < 0)
+	memset(&rls, 0, sizeof(rls));
+	rls.argv = argv_boundary;
+	rls.out = -1;
+	rls.git_cmd = 1;
+	if (start_command(&rls))
 		return -1;
-	while ((i = read_string(out, buffer, sizeof(buffer))) > 0) {
+	while ((i = read_string(rls.out, buffer, sizeof(buffer))) > 0) {
 		unsigned char sha1[20];
 		if (buffer[0] == '-') {
 			write_or_die(bundle_fd, buffer, i);
@@ -303,11 +245,8 @@ static int create_bundle(struct bundle_header *header, const char *path,
 			object->flags |= SHOWN;
 		}
 	}
-	while ((i = waitpid(pid, &status, 0)) < 0)
-		if (errno != EINTR)
-			return error("rev-list died");
-	if (!WIFEXITED(status) || WEXITSTATUS(status))
-		return error("rev-list died %d", WEXITSTATUS(status));
+	if (finish_command(&rls))
+		return error("rev-list died");
 
 	/* write references */
 	argc = setup_revisions(argc, argv, &revs, NULL);
@@ -352,23 +291,21 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	argv_pack[2] = "--stdout";
 	argv_pack[3] = "--thin";
 	argv_pack[4] = NULL;
-	in = -1;
-	out = bundle_fd;
-	pid = fork_with_pipe(argv_pack, &in, &out);
-	if (pid < 0)
+	memset(&rls, 0, sizeof(rls));
+	rls.argv = argv_pack;
+	rls.in = -1;
+	rls.out = bundle_fd;
+	rls.git_cmd = 1;
+	if (start_command(&rls))
 		return error("Could not spawn pack-objects");
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object *object = revs.pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
-			write(in, "^", 1);
-		write(in, sha1_to_hex(object->sha1), 40);
-		write(in, "\n", 1);
+			write(rls.in, "^", 1);
+		write(rls.in, sha1_to_hex(object->sha1), 40);
+		write(rls.in, "\n", 1);
 	}
-	close(in);
-	while (waitpid(pid, &status, 0) < 0)
-		if (errno != EINTR)
-			return -1;
-	if (!WIFEXITED(status) || WEXITSTATUS(status))
+	if (finish_command(&rls))
 		return error ("pack-objects died");
 
 	return status;
@@ -379,22 +316,17 @@ static int unbundle(struct bundle_header *header, int bundle_fd,
 {
 	const char *argv_index_pack[] = {"index-pack",
 		"--fix-thin", "--stdin", NULL};
-	int pid, status, dev_null;
+	struct child_process ip;
 
 	if (verify_bundle(header, 0))
 		return -1;
-	dev_null = open("/dev/null", O_WRONLY);
-	if (dev_null < 0)
-		return error("Could not open /dev/null");
-	pid = fork_with_pipe(argv_index_pack, &bundle_fd, &dev_null);
-	if (pid < 0)
-		return error("Could not spawn index-pack");
-	while (waitpid(pid, &status, 0) < 0)
-		if (errno != EINTR)
-			return error("index-pack died");
-	if (!WIFEXITED(status) || WEXITSTATUS(status))
-		return error("index-pack exited with status %d",
-				WEXITSTATUS(status));
+	memset(&ip, 0, sizeof(ip));
+	ip.argv = argv_index_pack;
+	ip.in = bundle_fd;
+	ip.no_stdout = 1;
+	ip.git_cmd = 1;
+	if (run_command(&ip))
+		return error("index-pack died");
 	return list_heads(header, argc, argv);
 }
 
-- 
1.5.0.3.985.gcf0b4
