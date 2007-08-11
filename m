From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] builtin-bundle - use buffered reads for bundle header
Date: Fri, 10 Aug 2007 20:27:24 -0400
Message-ID: <11867920441883-git-send-email-mdl123@verizon.net>
References: <7vvebnq9nv.fsf@assigned-by-dhcp.cox.net>
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 11 02:27:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJepI-0001gO-Fq
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 02:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937AbXHKA12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 20:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbXHKA12
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 20:27:28 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:35489 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbXHKA11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 20:27:27 -0400
Received: from fal-l07294-lp.us.ray.com ([71.246.233.117])
 by vms048.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JML009S62LQO6Q1@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 10 Aug 2007 19:27:27 -0500 (CDT)
In-reply-to: <7vvebnq9nv.fsf@assigned-by-dhcp.cox.net>
X-Mailer: git-send-email 1.5.3.rc4.54.gbe00
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55579>

This eliminates all use of byte-at-a-time reading of data in this
function: as Junio noted, a bundle file is seekable so we can
reset the file position to the first part of the pack-file using lseek
after reading the header.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 builtin-bundle.c |   37 +++++++++++++------------------------
 1 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index b954213..6651c51 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -44,38 +44,21 @@ struct bundle_header {
 	struct ref_list references;
 };
 
-/* this function returns the length of the string */
-static int read_string(int fd, char *buffer, int size)
-{
-	int i;
-	for (i = 0; i < size - 1; i++) {
-		ssize_t count = xread(fd, buffer + i, 1);
-		if (count < 0)
-			return error("Read error: %s", strerror(errno));
-		if (count == 0) {
-			i--;
-			break;
-		}
-		if (buffer[i] == '\n')
-			break;
-	}
-	buffer[i + 1] = '\0';
-	return i + 1;
-}
-
 /* returns an fd */
 static int read_header(const char *path, struct bundle_header *header) {
 	char buffer[1024];
-	int fd = open(path, O_RDONLY);
+	int fd;
+    long fpos;
+    FILE *ffd = fopen(path, "r");
 
-	if (fd < 0)
+	if (!ffd)
 		return error("could not open '%s'", path);
-	if (read_string(fd, buffer, sizeof(buffer)) < 0 ||
+    if (!fgets(buffer, sizeof(buffer), ffd) ||
 			strcmp(buffer, bundle_signature)) {
-		close(fd);
+        fclose(ffd);
 		return error("'%s' does not look like a v2 bundle file", path);
 	}
-	while (read_string(fd, buffer, sizeof(buffer)) > 0
+    while (fgets(buffer, sizeof(buffer), ffd)
 			&& buffer[0] != '\n') {
 		int is_prereq = buffer[0] == '-';
 		int offset = is_prereq ? 1 : 0;
@@ -97,6 +80,12 @@ static int read_header(const char *path, struct bundle_header *header) {
 		add_to_ref_list(sha1, isspace(delim) ?
 				buffer + 41 + offset : "", list);
 	}
+    fpos = ftell(ffd);
+    fclose(ffd);
+    fd = open(path, O_RDONLY);
+    if (fd < 0)
+        return error("could not open '%s'", path);
+    lseek(fd, fpos, SEEK_SET);
 	return fd;
 }
 
-- 
1.5.3.rc4.54.gbe00
