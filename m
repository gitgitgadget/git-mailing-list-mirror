From: Linus Torvalds <torvalds@osdl.org>
Subject: sha1_to_hex() usage cleanup
Date: Wed, 3 May 2006 17:21:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605031717190.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu May 04 02:21:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbRaw-0005lM-En
	for gcvg-git@gmane.org; Thu, 04 May 2006 02:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWEDAVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 20:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWEDAVO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 20:21:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750725AbWEDAVN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 20:21:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k440L9tH025387
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 17:21:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k440L8HF021505;
	Wed, 3 May 2006 17:21:08 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19535>


Somebody on the #git channel complained that the sha1_to_hex() thing uses 
a static buffer which caused an error message to show the same hex output 
twice instead of showing two different ones.

That's pretty easily rectified by making it uses a simple LRU of a few 
buffers, which also allows some other users (that were aware of the buffer 
re-use) to be written in a more straightforward manner.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is another throw-away patch of mine. Not a big deal, but since I 
tried it, I might as well try to submit it and see if Junio agrees..

diff --git a/diff.c b/diff.c
index 6762fce..c845c87 100644
--- a/diff.c
+++ b/diff.c
@@ -1018,14 +1018,12 @@ static void run_diff(struct diff_filepai
 	}
 
 	if (memcmp(one->sha1, two->sha1, 20)) {
-		char one_sha1[41];
 		int abbrev = o->full_index ? 40 : DEFAULT_ABBREV;
-		memcpy(one_sha1, sha1_to_hex(one->sha1), 41);
 
 		len += snprintf(msg + len, sizeof(msg) - len,
 				"index %.*s..%.*s",
-				abbrev, one_sha1, abbrev,
-				sha1_to_hex(two->sha1));
+				abbrev, sha1_to_hex(one->sha1),
+				abbrev, sha1_to_hex(two->sha1));
 		if (one->mode == two->mode)
 			len += snprintf(msg + len, sizeof(msg) - len,
 					" %06o", one->mode);
diff --git a/merge-tree.c b/merge-tree.c
index 50528d5..cc7b5bd 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -24,16 +24,14 @@ static const char *sha1_to_hex_zero(cons
 
 static void resolve(const char *base, struct name_entry *branch1, struct name_entry *result)
 {
-	char branch1_sha1[50];
-
 	/* If it's already branch1, don't bother showing it */
 	if (!branch1)
 		return;
-	memcpy(branch1_sha1, sha1_to_hex_zero(branch1->sha1), 41);
 
 	printf("0 %06o->%06o %s->%s %s%s\n",
 		branch1->mode, result->mode,
-		branch1_sha1, sha1_to_hex_zero(result->sha1),
+		sha1_to_hex_zero(branch1->sha1),
+		sha1_to_hex_zero(result->sha1),
 		base, result->path);
 }
 
diff --git a/sha1_file.c b/sha1_file.c
index f2d33af..5464828 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -108,9 +108,10 @@ int safe_create_leading_directories(char
 
 char * sha1_to_hex(const unsigned char *sha1)
 {
-	static char buffer[50];
+	static int bufno;
+	static char hexbuffer[4][50];
 	static const char hex[] = "0123456789abcdef";
-	char *buf = buffer;
+	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
 	int i;
 
 	for (i = 0; i < 20; i++) {
