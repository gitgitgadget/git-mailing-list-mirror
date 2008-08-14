From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2 3/3] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 18:18:28 -0400
Message-ID: <1218752308-3173-4-git-send-email-marcus@griep.us>
References: <1218752308-3173-1-git-send-email-marcus@griep.us>
 <1218752308-3173-2-git-send-email-marcus@griep.us>
 <1218752308-3173-3-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlAM-00017M-CX
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbYHNWSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYHNWSa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:18:30 -0400
Received: from boohaunt.net ([209.40.206.144]:40223 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbYHNWS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:18:29 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 8E7C01878CE8; Thu, 14 Aug 2008 18:18:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218752308-3173-3-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92420>

Adds a human readable size option to the verbose output
of count-objects for loose and pack object size totals.

Updates documentation to match.

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 Documentation/git-count-objects.txt |   13 +++++++++----
 builtin-count-objects.c             |   30 ++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 8 deletions(-)

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
index 249040b..4be9d7e 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "strbuf.h"
 
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
@@ -67,13 +68,13 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 }
 
 static char const * const count_objects_usage[] = {
-	"git count-objects [-v]",
+	"git count-objects [-v [-H]]",
 	NULL
 };
 
 int cmd_count_objects(int argc, const char **argv, const char *prefix)
 {
-	int i, verbose = 0;
+	int i, verbose = 0, human_readable = 0;
 	const char *objdir = get_object_directory();
 	int len = strlen(objdir);
 	char *path = xmalloc(len + 50);
@@ -81,6 +82,8 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	unsigned long loose_size = 0;
 	struct option opts[] = {
 		OPT__VERBOSE(&verbose),
+		OPT_BOOLEAN('H', "human-sizes", &human_readable,
+			"displays sizes in human readable format"),
 		OPT_END(),
 	};
 
@@ -117,15 +120,34 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			num_pack++;
 		}
 		printf("count: %lu\n", loose);
-		printf("size: %lu\n", loose_size / 2);
+		printf("size: ");
+		if (human_readable) {
+			struct strbuf sb;
+			strbuf_init(&sb, 0);
+			strbuf_append_human_readable(&sb, loose_size * 512,
+							0, 0, "", 0);
+			printf("%s\n", sb.buf);
+		}
+		else
+			printf("%lu\n", loose_size / 2);
 		printf("in-pack: %lu\n", packed);
 		printf("packs: %lu\n", num_pack);
-		printf("size-pack: %lu\n", size_pack / 1024);
+		printf("size-pack: ");
+		if (human_readable) {
+			struct strbuf sb;
+			strbuf_init(&sb, 0);
+			strbuf_append_human_readable(&sb, size_pack,
+							0, 0, "", 0);
+			printf("%s\n", sb.buf);
+		}
+		else
+			printf("%lu\n", size_pack / 1024);
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 	}
 	else
 		printf("%lu objects, %lu kilobytes\n",
 		       loose, loose_size / 2);
+
 	return 0;
 }
-- 
1.6.0.rc2.6.g8eda3
