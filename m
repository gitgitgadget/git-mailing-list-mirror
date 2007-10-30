From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 7/5] add throughput display to git-push
Date: Tue, 30 Oct 2007 17:06:21 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710301648430.21255@xanadu.home>
References: <1193770655-20492-1-git-send-email-nico@cam.org>
 <1193770655-20492-2-git-send-email-nico@cam.org>
 <1193770655-20492-3-git-send-email-nico@cam.org>
 <1193770655-20492-4-git-send-email-nico@cam.org>
 <1193770655-20492-5-git-send-email-nico@cam.org>
 <1193770655-20492-6-git-send-email-nico@cam.org>
 <alpine.LFD.0.9999.0710301535160.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:06:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImyIL-0007pJ-2h
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 22:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbXJ3VG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 17:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbXJ3VG1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 17:06:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59925 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbXJ3VG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 17:06:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ00AMATALBFF1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 17:06:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0710301535160.21255@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62756>

This one triggers only when git-pack-objects is called with 
--all-progress and --stdout which is the combination used by
git-push.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    2 +-
 csum-file.c            |    8 ++++++++
 csum-file.h            |    4 ++++
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 52a26a2..25ec65d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -606,7 +606,7 @@ static void write_pack_file(void)
 		char *pack_tmp_name = NULL;
 
 		if (pack_to_stdout) {
-			f = sha1fd(1, "<stdout>");
+			f = sha1fd_throughput(1, "<stdout>", progress_state);
 		} else {
 			char tmpname[PATH_MAX];
 			int fd;
diff --git a/csum-file.c b/csum-file.c
index 9929991..3729e73 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -8,6 +8,7 @@
  * able to verify hasn't been messed with afterwards.
  */
 #include "cache.h"
+#include "progress.h"
 #include "csum-file.h"
 
 static void sha1flush(struct sha1file *f, unsigned int count)
@@ -17,6 +18,7 @@ static void sha1flush(struct sha1file *f, unsigned int count)
 	for (;;) {
 		int ret = xwrite(f->fd, buf, count);
 		if (ret > 0) {
+			display_throughput(f->tp, ret);
 			buf = (char *) buf + ret;
 			count -= ret;
 			if (count)
@@ -80,6 +82,11 @@ int sha1write(struct sha1file *f, void *buf, unsigned int count)
 
 struct sha1file *sha1fd(int fd, const char *name)
 {
+	return sha1fd_throughput(fd, name, NULL);
+}
+
+struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp)
+{
 	struct sha1file *f;
 	unsigned len;
 
@@ -94,6 +101,7 @@ struct sha1file *sha1fd(int fd, const char *name)
 	f->fd = fd;
 	f->error = 0;
 	f->offset = 0;
+	f->tp = tp;
 	f->do_crc = 0;
 	SHA1_Init(&f->ctx);
 	return f;
diff --git a/csum-file.h b/csum-file.h
index c3c792f..4d1b231 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,11 +1,14 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
+struct progress;
+
 /* A SHA1-protected file */
 struct sha1file {
 	int fd, error;
 	unsigned int offset, namelen;
 	SHA_CTX ctx;
+	struct progress *tp;
 	char name[PATH_MAX];
 	int do_crc;
 	uint32_t crc32;
@@ -13,6 +16,7 @@ struct sha1file {
 };
 
 extern struct sha1file *sha1fd(int fd, const char *name);
+extern struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp);
 extern int sha1close(struct sha1file *, unsigned char *, int);
 extern int sha1write(struct sha1file *, void *, unsigned int);
 extern void crc32_begin(struct sha1file *);
