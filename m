From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/4] git-upload-pack: More efficient usage of the has_sha1
 array
Date: Sun, 23 Oct 2005 03:36:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510230335280.21239@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Oct 23 03:37:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETUmd-0007G2-Du
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 03:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVJWBgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 21:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJWBgI
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 21:36:08 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64146 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751275AbVJWBgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 21:36:07 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DDCB313F0B6; Sun, 23 Oct 2005 03:36:06 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BF8FBB4E59; Sun, 23 Oct 2005 03:36:06 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 72B0E59505; Sun, 23 Oct 2005 03:36:06 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 62DA713F0B6; Sun, 23 Oct 2005 03:36:06 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10481>

This patch is based on Junio's proposal. It marks parents of common revs 
so that they do not clutter up the has_sha1 array.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 upload-pack.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

applies-to: ccef5ac580c68a9714f37dcd8ee433e9691b640a
69e13cda85a74200b25ed48ed81909d848a7b9cb
diff --git a/upload-pack.c b/upload-pack.c
index accdba6..ab1981c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -3,9 +3,11 @@
 #include "pkt-line.h"
 #include "tag.h"
 #include "object.h"
+#include "commit.h"
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
+#define THEY_HAVE (1U << 0)
 #define MAX_HAS 256
 #define MAX_NEEDS 256
 static int nr_has = 0, nr_needs = 0;
@@ -85,15 +87,25 @@ static void create_pack_file(void)
 
 static int got_sha1(char *hex, unsigned char *sha1)
 {
-	int nr;
 	if (get_sha1_hex(hex, sha1))
 		die("git-upload-pack: expected SHA1 object, got '%s'", hex);
 	if (!has_sha1_file(sha1))
 		return 0;
-	nr = nr_has;
-	if (nr < MAX_HAS) {
-		memcpy(has_sha1[nr], sha1, 20);
-		nr_has = nr+1;
+	if (nr_has < MAX_HAS) {
+		struct object *o = lookup_object(sha1);
+		if (!o || (!o->parsed && !parse_object(sha1)))
+			die("oops (%s)", sha1_to_hex(sha1));
+		if (o->type == commit_type) {
+			struct commit_list *parents;
+			if (o->flags & THEY_HAVE)
+				return 0;
+			o->flags |= THEY_HAVE;
+			for (parents = ((struct commit*)o)->parents;
+			     parents;
+			     parents = parents->next)
+				parents->item->object.flags |= THEY_HAVE;
+		}
+		memcpy(has_sha1[nr_has++], sha1, 20);
 	}
 	return 1;
 }
@@ -104,6 +116,9 @@ static int get_common_commits(void)
 	unsigned char sha1[20];
 	int len;
 
+	track_object_refs = 0;
+	save_commit_buffer = 0;
+
 	for(;;) {
 		len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
---
0.99.8.GIT
