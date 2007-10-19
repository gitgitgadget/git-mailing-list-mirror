From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Teach prune-packed to use the standard progress meter
Date: Fri, 19 Oct 2007 00:11:47 -0400
Message-ID: <20071019041147.GA16408@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 06:12:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IijDX-0006FH-KW
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 06:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXJSEL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 00:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965861AbXJSEL5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 00:11:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45867 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964813AbXJSEL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 00:11:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IijCv-0004AU-Ks; Fri, 19 Oct 2007 00:11:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3F79120FBAE; Fri, 19 Oct 2007 00:11:48 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61645>

Rather than reimplementing the progress meter logic and always
showing 100 lines of output while pruning already packed objects
we now use a delayed progress meter and only show it if there are
enough objects to make us take a little while.

Most users won't see the message anymore as it usually doesn't take
very long to delete the already packed loose objects.  This neatens
the output of a git-gc or git-repack execution, which is especially
important for a `git gc --auto` triggered from within another
command.

We perform the display_progress() call from within the very innermost
loop in case we spend more than 1 second within any single object
directory.  This ensures that a progress_update event from the
timer will still trigger in a timely fashion and allow the user to
see the progress meter.

While I'm in here I changed the message to be more descriptive of
its actual task.  "Deleting unused objects" is a little scary for
new users as they wonder where these unused objects came from and
how they should avoid them.  Truth is these objects aren't unused
in the sense of what git-prune would call a dangling object, these
are used but are just duplicates of things we have already stored
in a packfile.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 On top of np/progress topic.  I kicked around a few different
 changes for the progress title but finally settled on this one.
 Improvement suggestions welcome.

 builtin-prune-packed.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 9777300..015c8bb 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "progress.h"
 
 static const char prune_packed_usage[] =
 "git-prune-packed [-n] [-q]";
@@ -7,6 +8,8 @@ static const char prune_packed_usage[] =
 #define DRY_RUN 01
 #define VERBOSE 02
 
+static struct progress progress;
+
 static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 {
 	struct dirent *de;
@@ -23,6 +26,8 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 		if (!has_sha1_pack(sha1, NULL))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
+		if (opts == VERBOSE)
+			display_progress(&progress, i + 1);
 		if (opts & DRY_RUN)
 			printf("rm -f %s\n", pathname);
 		else if (unlink(pathname) < 0)
@@ -39,6 +44,11 @@ void prune_packed_objects(int opts)
 	const char *dir = get_object_directory();
 	int len = strlen(dir);
 
+	if (opts == VERBOSE)
+		start_progress_delay(&progress,
+			"Removing duplicate objects",
+			256, 95, 2);
+
 	if (len > PATH_MAX - 42)
 		die("impossible object directory");
 	memcpy(pathname, dir, len);
@@ -49,16 +59,13 @@ void prune_packed_objects(int opts)
 
 		sprintf(pathname + len, "%02x/", i);
 		d = opendir(pathname);
-		if (opts == VERBOSE && (d || i == 255))
-			fprintf(stderr, "Removing unused objects %d%%...\015",
-				((i+1) * 100) / 256);
 		if (!d)
 			continue;
 		prune_dir(i, d, pathname, len + 3, opts);
 		closedir(d);
 	}
 	if (opts == VERBOSE)
-		fprintf(stderr, "\nDone.\n");
+		stop_progress(&progress);
 }
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
-- 
1.5.3.4.1249.g895be
