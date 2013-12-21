From: Jeff King <peff@peff.net>
Subject: [PATCH] do not pretend sha1write returns errors
Date: Sat, 21 Dec 2013 09:13:25 -0500
Message-ID: <20131221141325.GA23828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:13:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuNJO-0006hB-A4
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab3LUON1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:13:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:48526 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753217Ab3LUON1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:13:27 -0500
Received: (qmail 8617 invoked by uid 102); 21 Dec 2013 14:13:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:13:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:13:25 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239619>

The sha1write function returns an int, but it will always be
"0". The failure-prone parts of the function happen in the
"flush" callback, which cannot pass an error back to us. So
we just end up calling die() during the flush.

Let's just drop the return value altogether, as it only
confuses callers into thinking that it might be useful.

Only one call site actually checked the return value. We can
drop that check, since it just led to a die() anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
This is kind of a step backwards if we ever wanted to actually make
sha1write's return code mean anything. But I just don't foresee that
happening.

 builtin/pack-objects.c | 2 --
 csum-file.c            | 3 +--
 csum-file.h            | 2 +-
 pack-write.c           | 3 +--
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dfb4d84..541667f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -737,8 +737,6 @@ static void write_pack_file(void)
 			f = create_tmp_packfile(&pack_tmp_name);
 
 		offset = write_pack_header(f, nr_remaining);
-		if (!offset)
-			die_errno("unable to write pack header");
 		nr_written = 0;
 		for (; i < nr_objects; i++) {
 			struct object_entry *e = write_order[i];
diff --git a/csum-file.c b/csum-file.c
index 53f5375..b30e4f2 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -86,7 +86,7 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 	return fd;
 }
 
-int sha1write(struct sha1file *f, void *buf, unsigned int count)
+void sha1write(struct sha1file *f, void *buf, unsigned int count)
 {
 	while (count) {
 		unsigned offset = f->offset;
@@ -116,7 +116,6 @@ int sha1write(struct sha1file *f, void *buf, unsigned int count)
 		}
 		f->offset = offset;
 	}
-	return 0;
 }
 
 struct sha1file *sha1fd(int fd, const char *name)
diff --git a/csum-file.h b/csum-file.h
index 3b540bd..6a55c7d 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -34,7 +34,7 @@ extern struct sha1file *sha1fd(int fd, const char *name);
 extern struct sha1file *sha1fd_check(const char *name);
 extern struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp);
 extern int sha1close(struct sha1file *, unsigned char *, unsigned int);
-extern int sha1write(struct sha1file *, void *, unsigned int);
+extern void sha1write(struct sha1file *, void *, unsigned int);
 extern void sha1flush(struct sha1file *f);
 extern void crc32_begin(struct sha1file *);
 extern uint32_t crc32_end(struct sha1file *);
diff --git a/pack-write.c b/pack-write.c
index ca9e63b..676ed4c 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -189,8 +189,7 @@ off_t write_pack_header(struct sha1file *f, uint32_t nr_entries)
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
 	hdr.hdr_version = htonl(PACK_VERSION);
 	hdr.hdr_entries = htonl(nr_entries);
-	if (sha1write(f, &hdr, sizeof(hdr)))
-		return 0;
+	sha1write(f, &hdr, sizeof(hdr));
 	return sizeof(hdr);
 }
 
-- 
1.8.5.1.399.g900e7cd
