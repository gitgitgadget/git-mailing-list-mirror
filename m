From: Marcus Griep <marcus@griep.us>
Subject: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 00:21:24 -0400
Message-ID: <1218687684-11671-1-git-send-email-marcus@griep.us>
References: <1218657910-22096-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 06:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTUM0-00045W-06
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 06:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYHNEVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 00:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYHNEVZ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 00:21:25 -0400
Received: from boohaunt.net ([209.40.206.144]:53276 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbYHNEVY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 00:21:24 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 52D4D1878AD5; Thu, 14 Aug 2008 00:21:24 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218657910-22096-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92312>

Adds a human readable size option to the verbose output
of count-objects for loose and pack object size totals.

Updates documentation to match.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 I thought that this would be a nice addition to 'git count-objects'.
 This patch depends upon my earlier patch to count-objects, but this
 patch should be easily separable from its dependency should that one
 not be accepted.

 Documentation/git-count-objects.txt |   13 +++++++---
 builtin-count-objects.c             |   41 +++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 75a8da1..291bc5e 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -7,7 +7,7 @@ git-count-objects - Count unpacked number of objects and their disk consumption
 
 SYNOPSIS
 --------
-'git count-objects' [-v]
+'git count-objects' [-v [-H]]
 
 DESCRIPTION
 -----------
@@ -21,9 +21,14 @@ OPTIONS
 --verbose::
 	In addition to the number of loose objects and disk
 	space consumed, it reports the number of in-pack
-	objects, number of packs, and number of objects that can be
-	removed by running `git prune-packed`.
-
+	objects, number of packs, disk space consumed by those packs
+	and number of objects that can be removed by running
+	`git prune-packed`.
+
+-H::
+--human-sizes::
+	Displays sizes reported by `--verbose` in a more
+	human-readable format. (e.g. 22M or 1.5G)
 
 Author
 ------
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 249040b..1eb73be 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -67,13 +67,30 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 }
 
 static char const * const count_objects_usage[] = {
-	"git count-objects [-v]",
+	"git count-objects [-v [-H]]",
 	NULL
 };
 
+void human_readable_size(char *buf, int buf_size, double size /* in bytes */)
+{
+	char human_readable_prefixes[10] = "BKMGTPEZY";
+	if (buf_size < 5)
+		die("insufficient buffer size");
+	int i = 0;
+	for (; i < 8 && size >= 1000 ; ++i, size = size / 1024)
+		;
+	if (size >= 1000)
+		die("size greater than 999Y");
+	sprintf(buf, "%.*f%c",
+		size < 10 ? 1 : 0,
+		size,
+		human_readable_prefixes[i]
+		);
+}
+
 int cmd_count_objects(int argc, const char **argv, const char *prefix)
 {
-	int i, verbose = 0;
+	int i, verbose = 0, human_readable = 0;
 	const char *objdir = get_object_directory();
 	int len = strlen(objdir);
 	char *path = xmalloc(len + 50);
@@ -81,6 +98,8 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	unsigned long loose_size = 0;
 	struct option opts[] = {
 		OPT__VERBOSE(&verbose),
+		OPT_BOOLEAN('H', "--human-sizes", &human_readable,
+			"displays sizes in human readable format"),
 		OPT_END(),
 	};
 
@@ -117,10 +136,24 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			num_pack++;
 		}
 		printf("count: %lu\n", loose);
-		printf("size: %lu\n", loose_size / 2);
+		printf("size: ");
+		if (human_readable) {
+			char buf[sizeof("999Y")];
+			human_readable_size(buf, sizeof(buf), loose_size * 512);
+			printf("%s\n", buf);
+		}
+		else
+			printf("%lu\n", loose_size / 2);
 		printf("in-pack: %lu\n", packed);
 		printf("packs: %lu\n", num_pack);
-		printf("size-pack: %lu\n", size_pack / 1024);
+		printf("size-pack: ");
+		if (human_readable) {
+			char buf[sizeof("999Y")];
+			human_readable_size(buf, sizeof(buf), size_pack);
+			printf("%s\n", buf);
+		}
+		else
+			printf("%lu\n", size_pack / 1024);
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 	}
-- 
1.6.0.rc2.6.g8eda3
