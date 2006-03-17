From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/2] blame: Fix git-blame <directory>
Date: Fri, 17 Mar 2006 22:49:31 +0100
Message-ID: <20060317214931.23075.14431.stgit@c165>
References: <20060317214928.23075.76032.stgit@c165>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Mar 17 22:50:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKMpN-0008Bw-2g
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 22:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798AbWCQVti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 16:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbWCQVti
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 16:49:38 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:29333 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S932798AbWCQVth
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 16:49:37 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 33F5F40FF; Fri, 17 Mar 2006 23:05:35 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1FKMp9-00060c-00; Fri, 17 Mar 2006 22:49:31 +0100
To: git@vger.kernel.org
In-Reply-To: <20060317214928.23075.76032.stgit@c165>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17673>


Before this patch git-blame <directory> gave non-sensible output. (It
assigned blame to some random file in <directory>) Abort with an error
message instead.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 blame.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/blame.c b/blame.c
index 8af4b54..9c97aec 100644
--- a/blame.c
+++ b/blame.c
@@ -180,11 +180,13 @@ static int get_blob_sha1_internal(unsign
 				  unsigned mode, int stage);
 
 static unsigned char blob_sha1[20];
+static const char* blame_file;
 static int get_blob_sha1(struct tree *t, const char *pathname,
 			 unsigned char *sha1)
 {
 	int i;
 	const char *pathspec[2];
+	blame_file = pathname;
 	pathspec[0] = pathname;
 	pathspec[1] = NULL;
 	memset(blob_sha1, 0, sizeof(blob_sha1));
@@ -209,6 +211,10 @@ static int get_blob_sha1_internal(unsign
 	if (S_ISDIR(mode))
 		return READ_TREE_RECURSIVE;
 
+	if (strncmp(blame_file, base, baselen) ||
+	    strcmp(blame_file + baselen, pathname))
+		return -1;
+
 	memcpy(blob_sha1, sha1, 20);
 	return -1;
 }
