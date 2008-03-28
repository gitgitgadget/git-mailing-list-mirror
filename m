From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] fsck --lost-found: refactor handling of dangling
 objects
Date: Fri, 28 Mar 2008 15:05:46 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803281505330.18259@racer.site>
References: <7vbq52gezo.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803281504591.18259@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 15:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfFDz-0005Px-Ex
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 15:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbYC1OFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 10:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbYC1OFr
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 10:05:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:49520 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752851AbYC1OFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 10:05:47 -0400
Received: (qmail invoked by alias); 28 Mar 2008 14:05:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 28 Mar 2008 15:05:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kBI04LKPktLw2F6HYYpKfGIODM/wsfKxjCqJo4v
	DbCLxRGn1/jGFp
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803281504591.18259@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78411>


From: Junio C Hamano <gitster@pobox.com>

This moves a deeply nested part of the function
check_unreachable_object() into a separate function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-fsck.c |   65 ++++++++++++++++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 78a6e1f..f01263a 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -145,6 +145,39 @@ static void check_reachable_object(struct object *obj)
 	}
 }
 
+static void dangling_object(struct object *obj)
+{
+	char *filename;
+	FILE *f;
+	printf("dangling %s %s\n", typename(obj->type),
+			sha1_to_hex(obj->sha1));
+	if (!write_lost_and_found)
+		return;
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
+	if (obj->type == OBJ_BLOB) {
+		enum object_type type;
+		unsigned long size;
+		char *buf = read_sha1_file(obj->sha1,
+				&type, &size);
+		if (buf) {
+			fwrite(buf, size, 1, f);
+			free(buf);
+		}
+	} else
+		fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
+	fclose(f);
+}
+
 /*
  * Check a single unreachable object
  */
@@ -180,36 +213,8 @@ static void check_unreachable_object(struct object *obj)
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
-- 
1.5.5.rc2.186.gbac51
