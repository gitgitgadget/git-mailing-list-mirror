From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/8] git-upload-pack: More efficient usage of the has_sha1
 array
Date: Fri, 28 Oct 2005 04:48:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280448110.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 04:49:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKIG-0000uB-EK
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVJ1Cse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVJ1Csd
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:48:33 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44495 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965067AbVJ1Csd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:48:33 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5A18413EFF3; Fri, 28 Oct 2005 04:48:32 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 39F239EFCF; Fri, 28 Oct 2005 04:48:32 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2497F9EFC9; Fri, 28 Oct 2005 04:48:32 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1D57513EFF3; Fri, 28 Oct 2005 04:48:32 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10748>


This patch is based on Junio's proposal. It marks parents of common revs
so that they do not clutter up the has_sha1 array.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 upload-pack.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

applies-to: fe38f9ff9bd88b9a98346d4a256416f29fdb3892
11905ac9b1eea9ac1dca5eae542b15fa28ec3242
diff --git a/upload-pack.c b/upload-pack.c
index 878254d..660d7c4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -3,9 +3,11 @@
 #include "pkt-line.h"
 #include "tag.h"
 #include "object.h"
+#include "commit.h"
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
+#define THEY_HAVE (1U << 0)
 #define OUR_REF (1U << 1)
 #define WANTED (1U << 2)
 #define MAX_HAS 256
@@ -89,15 +91,27 @@ static void create_pack_file(void)
 
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
+		if (!(o && o->parsed))
+			o = parse_object(sha1);
+		if (!o)
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
@@ -108,6 +122,9 @@ static int get_common_commits(void)
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
