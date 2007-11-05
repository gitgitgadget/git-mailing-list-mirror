From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] remove dead code from the csum-file interface
Date: Sun, 04 Nov 2007 22:54:50 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711042244310.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 04:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iot3K-0000Wp-7G
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 04:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbXKEDyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 22:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbXKEDyw
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 22:54:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57814 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbXKEDyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 22:54:51 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR000CNULJEJGG0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 04 Nov 2007 22:54:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63481>

The provided name argument is always constant and valid in every 
caller's context, so no need to have an array of PATH_MAX chars to copy 
it into when a simple pointer will do.  Unfortunately that means getting 
rid of wascally wabbits too.

The 'error' field is also unused.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/csum-file.c b/csum-file.c
index b445e6a..9728a99 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -88,22 +88,12 @@ struct sha1file *sha1fd(int fd, const char *name)
 
 struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp)
 {
-	struct sha1file *f;
-	unsigned len;
-
-	f = xmalloc(sizeof(*f));
-
-	len = strlen(name);
-	if (len >= PATH_MAX)
-		die("you wascally wabbit, you");
-	f->namelen = len;
-	memcpy(f->name, name, len+1);
-
+	struct sha1file *f = xmalloc(sizeof(*f));
 	f->fd = fd;
-	f->error = 0;
 	f->offset = 0;
 	f->total = 0;
 	f->tp = tp;
+	f->name = name;
 	f->do_crc = 0;
 	SHA1_Init(&f->ctx);
 	return f;
diff --git a/csum-file.h b/csum-file.h
index a38cc3a..1af7656 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -5,12 +5,12 @@ struct progress;
 
 /* A SHA1-protected file */
 struct sha1file {
-	int fd, error;
-	unsigned int offset, namelen;
+	int fd;
+	unsigned int offset;
 	SHA_CTX ctx;
 	off_t total;
 	struct progress *tp;
-	char name[PATH_MAX];
+	const char *name;
 	int do_crc;
 	uint32_t crc32;
 	unsigned char buffer[8192];
