From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] repack: propagate pack-objects options as strings
Date: Wed, 22 Jan 2014 20:30:13 -0500
Message-ID: <20140123013008.GC19472@sigill.intra.peff.net>
References: <20140123012656.GC17254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 02:30:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W697e-00089X-O4
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 02:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbaAWBaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 20:30:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:37244 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752097AbaAWBaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 20:30:15 -0500
Received: (qmail 5813 invoked by uid 102); 23 Jan 2014 01:30:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jan 2014 19:30:15 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jan 2014 20:30:13 -0500
Content-Disposition: inline
In-Reply-To: <20140123012656.GC17254@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240891>

In the original shell version of git-repack, any options
destined for pack-objects were left as strings, and passed
as a whole. Since the C rewrite in commit a1bbc6c (repack:
rewrite the shell script in C, 2013-09-15), we now parse
these values to integers internally, then reformat the
integers when passing the option to pack-objects.

This has the advantage that we catch format errors earlier
(i.e., when repack is invoked, rather than when pack-objects
is invoked).

It has three disadvantages, though:

  1. Our internal data types may not be the right size. In
     the case of "--window-memory" and "--max-pack-size",
     these are "unsigned long" in pack-objects, but we can
     only represent a regular "int".

  2. Our parsing routines might not be the same as those of
     pack-objects. For the two options above, pack-objects
     understands "100m" to mean "100 megabytes", but repack
     does not.

  3. We have to keep a sentinel value to know whether it is
     worth passing the option along. In the case of
     "--window-memory", we currently do not pass it if the
     value is "0". But that is a meaningful value to
     pack-objects, where it overrides any configured value.

We can fix all of these by simply passing the strings from
the user along to pack-objects verbatim. This does not
actually fix anything for "--depth" or "--window", but these
are converted, too, for consistency.

Signed-off-by: Jeff King <peff@peff.net>
---
So we lose the advantage listed above. But I think the simplicity and
future-proofing is worth it (and in this case, we basically don't do
anything _except_ invoke pack-objects, so it is not like we do a bunch
of early work that has to be undone when we find out that the option is
bogus later on).

 builtin/repack.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 7f89c7c..6284846 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -130,9 +130,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int pack_everything = 0;
 	int delete_redundant = 0;
 	const char *unpack_unreachable = NULL;
-	int window = 0, window_memory = 0;
-	int depth = 0;
-	int max_pack_size = 0;
+	const char *window = NULL, *window_memory = NULL;
+	const char *depth = NULL;
+	const char *max_pack_size = NULL;
 	int no_reuse_delta = 0, no_reuse_object = 0;
 	int no_update_server_info = 0;
 	int quiet = 0;
@@ -157,13 +157,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --local to git-pack-objects")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
 				N_("with -A, do not loosen objects older than this")),
-		OPT_INTEGER(0, "window", &window,
+		OPT_STRING(0, "window", &window, N_("n"),
 				N_("size of the window used for delta compression")),
-		OPT_INTEGER(0, "window-memory", &window_memory,
+		OPT_STRING(0, "window-memory", &window_memory, N_("bytes"),
 				N_("same as the above, but limit memory size instead of entries count")),
-		OPT_INTEGER(0, "depth", &depth,
+		OPT_STRING(0, "depth", &depth, N_("n"),
 				N_("limits the maximum delta depth")),
-		OPT_INTEGER(0, "max-pack-size", &max_pack_size,
+		OPT_STRING(0, "max-pack-size", &max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
 		OPT_END()
 	};
@@ -185,13 +185,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd_args, "--all");
 	argv_array_push(&cmd_args, "--reflog");
 	if (window)
-		argv_array_pushf(&cmd_args, "--window=%u", window);
+		argv_array_pushf(&cmd_args, "--window=%s", window);
 	if (window_memory)
-		argv_array_pushf(&cmd_args, "--window-memory=%u", window_memory);
+		argv_array_pushf(&cmd_args, "--window-memory=%s", window_memory);
 	if (depth)
-		argv_array_pushf(&cmd_args, "--depth=%u", depth);
+		argv_array_pushf(&cmd_args, "--depth=%s", depth);
 	if (max_pack_size)
-		argv_array_pushf(&cmd_args, "--max-pack-size=%u", max_pack_size);
+		argv_array_pushf(&cmd_args, "--max-pack-size=%s", max_pack_size);
 	if (no_reuse_delta)
 		argv_array_pushf(&cmd_args, "--no-reuse-delta");
 	if (no_reuse_object)
-- 
1.8.5.2.500.g8060133
