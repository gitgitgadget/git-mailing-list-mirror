From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Teach "git-read-tree -u" to check out submodules as a
 directory
Date: Thu, 12 Apr 2007 21:08:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704122104030.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704122102320.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 06:09:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcD5w-0006tR-AM
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 06:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbXDMEI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 00:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbXDMEI5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 00:08:57 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46263 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbXDMEI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 00:08:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3D48rIs003325
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 21:08:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3D48r3S024209;
	Thu, 12 Apr 2007 21:08:53 -0700
In-Reply-To: <Pine.LNX.4.64.0704122102320.4061@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44381>


This actually allows us to check out a supermodule after cloning, although 
the submodules will obviously not be checked out, and will just be an 
empty subdirectory.

[ Side note: this also shows that we currently don't correctly handle
  such subprojects that aren't checked out correctly yet.  They should
  always show up as not being modified, but failing to resolve the
  gitlink HEAD does not properly trigger the "not modified" logic in all 
  places it needs to..

  So more work to be done, but that's a separate issue, unrelated to
  the action of checking out the superproject. ]

The bulk of this patch is simply because we need to check the type of the 
index entry *before* we try to read the object it points to, and that 
meant that the code needed some re-organization. So I moved some of the 
code in common to both symlinks and files to be a trivial helper function.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 entry.c |   42 +++++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/entry.c b/entry.c
index d72f811..9545e89 100644
--- a/entry.c
+++ b/entry.c
@@ -62,26 +62,33 @@ static int create_file(const char *path, unsigned int mode)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
+static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned long *size)
+{
+	enum object_type type;
+	void *new = read_sha1_file(ce->sha1, &type, size);
+
+	if (new) {
+		if (type == OBJ_BLOB)
+			return new;
+		free(new);
+	}
+	return NULL;
+}
+
 static int write_entry(struct cache_entry *ce, char *path, struct checkout *state, int to_tempfile)
 {
 	int fd;
-	void *new;
-	unsigned long size;
 	long wrote;
-	enum object_type type;
 
-	new = read_sha1_file(ce->sha1, &type, &size);
-	if (!new || type != OBJ_BLOB) {
-		if (new)
-			free(new);
-		return error("git-checkout-index: unable to read sha1 file of %s (%s)",
-			path, sha1_to_hex(ce->sha1));
-	}
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
-		char *buf;
-		unsigned long nsize;
+		char *buf, *new;
+		unsigned long size, nsize;
 
 	case S_IFREG:
+		new = read_blob_entry(ce, path, &size);
+		if (!new)
+			return error("git-checkout-index: unable to read sha1 file of %s (%s)",
+				path, sha1_to_hex(ce->sha1));
 		if (to_tempfile) {
 			strcpy(path, ".merge_file_XXXXXX");
 			fd = mkstemp(path);
@@ -111,6 +118,10 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 			return error("git-checkout-index: unable to write file %s", path);
 		break;
 	case S_IFLNK:
+		new = read_blob_entry(ce, path, &size);
+		if (!new)
+			return error("git-checkout-index: unable to read sha1 file of %s (%s)",
+				path, sha1_to_hex(ce->sha1));
 		if (to_tempfile || !has_symlinks) {
 			if (to_tempfile) {
 				strcpy(path, ".merge_link_XXXXXX");
@@ -136,8 +147,13 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 						 "symlink %s (%s)", path, strerror(errno));
 		}
 		break;
+	case S_IFDIRLNK:
+		if (to_tempfile)
+			return error("git-checkout-index: cannot create temporary subproject %s", path);
+		if (mkdir(path, 0777) < 0)
+			return error("git-checkout-index: cannot create subproject directory %s", path);
+		break;
 	default:
-		free(new);
 		return error("git-checkout-index: unknown file mode for %s", path);
 	}
 
