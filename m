From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-archive: don't die when repository uses subprojects
Date: Fri, 11 May 2007 18:55:21 +0200
Message-ID: <11789025212823-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 18:53:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmYNP-0000IM-Cu
	for gcvg-git@gmane.org; Fri, 11 May 2007 18:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbXEKQxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 12:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759966AbXEKQxa
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 12:53:30 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:62916 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384AbXEKQxa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 12:53:30 -0400
Received: from localhost.localdomain (ti231210a080-10429.bb.online.no [80.212.184.195])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l4BGrOTx010301;
	Fri, 11 May 2007 18:53:24 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.rc3-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46964>

Both archive-tar and archive-zip needed to be taught about subprojects.
The tar function died when trying to read the subproject commit object,
while the zip function reported "unsupported file mode".

This fixes both by representing the subproject as an empty directory.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 archive-tar.c |    4 ++--
 archive-zip.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index d9c30d3..56ff356 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -166,7 +166,7 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 	} else {
 		if (verbose)
 			fprintf(stderr, "%.*s\n", path->len, path->buf);
-		if (S_ISDIR(mode)) {
+		if (S_ISDIR(mode) || S_ISDIRLNK(mode)) {
 			*header.typeflag = TYPEFLAG_DIR;
 			mode = (mode | 0777) & ~tar_umask;
 		} else if (S_ISLNK(mode)) {
@@ -278,7 +278,7 @@ static int write_tar_entry(const unsigned char *sha1,
 	memcpy(path.buf, base, baselen);
 	memcpy(path.buf + baselen, filename, filenamelen);
 	path.len = baselen + filenamelen;
-	if (S_ISDIR(mode)) {
+	if (S_ISDIR(mode) || S_ISDIRLNK(mode)) {
 		strbuf_append_string(&path, "/");
 		buffer = NULL;
 		size = 0;
diff --git a/archive-zip.c b/archive-zip.c
index 7c49848..1eaf262 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -182,10 +182,10 @@ static int write_zip_entry(const unsigned char *sha1,
 		goto out;
 	}
 
-	if (S_ISDIR(mode)) {
+	if (S_ISDIR(mode) || S_ISDIRLNK(mode)) {
 		method = 0;
 		attr2 = 16;
-		result = READ_TREE_RECURSIVE;
+		result = (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 		out = NULL;
 		uncompressed_size = 0;
 		compressed_size = 0;
-- 
1.5.2.rc3-dirty
