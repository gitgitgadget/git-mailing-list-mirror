From: Jeff King <peff@peff.net>
Subject: [PATCH 49/68] fetch-pack: use argv_array for index-pack /
 unpack-objects
Date: Thu, 24 Sep 2015 17:07:54 -0400
Message-ID: <20150924210753.GT30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDkR-00028o-9G
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbbIXVH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:36005 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754172AbbIXVH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:56 -0400
Received: (qmail 12094 invoked by uid 102); 24 Sep 2015 21:07:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:56 -0500
Received: (qmail 29398 invoked by uid 107); 24 Sep 2015 21:08:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:54 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278597>

This cleans up a magic number that must be kept in sync with
the rest of the code (the number of argv slots). It also
lets us drop some fixed buffers and an sprintf (since we
can now use argv_array_pushf).

We do still have to keep one fixed buffer for calling
gethostname, but at least now the size computations for it
are much simpler.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 56 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 820251a..2dabee9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -681,11 +681,10 @@ static int get_pack(struct fetch_pack_args *args,
 		    int xd[2], char **pack_lockfile)
 {
 	struct async demux;
-	const char *argv[22];
-	char keep_arg[256];
-	char hdr_arg[256];
-	const char **av, *cmd_name;
 	int do_keep = args->keep_pack;
+	const char *cmd_name;
+	struct pack_header header;
+	int pass_header = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int ret;
 
@@ -705,17 +704,11 @@ static int get_pack(struct fetch_pack_args *args,
 	else
 		demux.out = xd[0];
 
-	cmd.argv = argv;
-	av = argv;
-	*hdr_arg = 0;
 	if (!args->keep_pack && unpack_limit) {
-		struct pack_header header;
 
 		if (read_pack_header(demux.out, &header))
 			die("protocol error: bad pack header");
-		snprintf(hdr_arg, sizeof(hdr_arg),
-			 "--pack_header=%"PRIu32",%"PRIu32,
-			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
+		pass_header = 1;
 		if (ntohl(header.hdr_entries) < unpack_limit)
 			do_keep = 0;
 		else
@@ -723,44 +716,49 @@ static int get_pack(struct fetch_pack_args *args,
 	}
 
 	if (alternate_shallow_file) {
-		*av++ = "--shallow-file";
-		*av++ = alternate_shallow_file;
+		argv_array_push(&cmd.args, "--shallow-file");
+		argv_array_push(&cmd.args, alternate_shallow_file);
 	}
 
 	if (do_keep) {
 		if (pack_lockfile)
 			cmd.out = -1;
-		*av++ = cmd_name = "index-pack";
-		*av++ = "--stdin";
+		cmd_name = "index-pack";
+		argv_array_push(&cmd.args, cmd_name);
+		argv_array_push(&cmd.args, "--stdin");
 		if (!args->quiet && !args->no_progress)
-			*av++ = "-v";
+			argv_array_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
-			*av++ = "--fix-thin";
+			argv_array_push(&cmd.args, "--fix-thin");
 		if (args->lock_pack || unpack_limit) {
-			int s = sprintf(keep_arg,
-					"--keep=fetch-pack %"PRIuMAX " on ", (uintmax_t) getpid());
-			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
-				strcpy(keep_arg + s, "localhost");
-			*av++ = keep_arg;
+			char hostname[256];
+			if (gethostname(hostname, sizeof(hostname)))
+				xsnprintf(hostname, sizeof(hostname), "localhost");
+			argv_array_pushf(&cmd.args,
+					"--keep=fetch-pack %"PRIuMAX " on %s",
+					(uintmax_t)getpid(), hostname);
 		}
 		if (args->check_self_contained_and_connected)
-			*av++ = "--check-self-contained-and-connected";
+			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
 	}
 	else {
-		*av++ = cmd_name = "unpack-objects";
+		cmd_name = "unpack-objects";
+		argv_array_push(&cmd.args, cmd_name);
 		if (args->quiet || args->no_progress)
-			*av++ = "-q";
+			argv_array_push(&cmd.args, "-q");
 		args->check_self_contained_and_connected = 0;
 	}
-	if (*hdr_arg)
-		*av++ = hdr_arg;
+
+	if (pass_header)
+		argv_array_pushf(&cmd.args, "--pack_header=%"PRIu32",%"PRIu32,
+				 ntohl(header.hdr_version),
+				 ntohl(header.hdr_entries));
 	if (fetch_fsck_objects >= 0
 	    ? fetch_fsck_objects
 	    : transfer_fsck_objects >= 0
 	    ? transfer_fsck_objects
 	    : 0)
-		*av++ = "--strict";
-	*av++ = NULL;
+		argv_array_push(&cmd.args, "--strict");
 
 	cmd.in = demux.out;
 	cmd.git_cmd = 1;
-- 
2.6.0.rc3.454.g204ad51
