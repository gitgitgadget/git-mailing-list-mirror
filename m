From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/8] vcs-svn: Read delta preimage from file descriptor
Date: Sat, 20 Nov 2010 13:27:13 -0600
Message-ID: <20101120192713.GF17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:27:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt5r-0002Je-7A
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab0KTT1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:27:22 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53165 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab0KTT1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:27:21 -0500
Received: by gyb11 with SMTP id 11so599011gyb.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xBvo899egW8hD3xKsY6wiFU9xZD1byZDPswVxNzi7k0=;
        b=Cjfth1E2mJ9fyDdxh9QLV28l+SFGv6ChYkGHxwBIpvWBdm6Zcs0ZfbfWqLfz99HeC0
         fouko2VRxZXa6rbWePgCEx3DPOXsMR++YwZ7t+ZrpbdPjRSGiQIxwSztm/QOoPjIwtsg
         geawZDsqY7NlUU7mvhUrkC20vvxAe0w+9W5Po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Imo5i9MrysQmzjTs6PMZtbt80vApDmQGT6xldRMLWtwXbN17Tahk0KWZyDzOWZPiBX
         dkdq9Km9CAV8opGGPiaizAHPMKoQ9ppnlL7Zrj6cdTaVQ5/G4z2BAwUlVOzY1rlvrCcJ
         sTCe6r2aPRsdWcMDORWDBAHoC7RVf2CrxbHs0=
Received: by 10.90.3.15 with SMTP id 15mr4724700agc.101.1290281240729;
        Sat, 20 Nov 2010 11:27:20 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id n28sm1986869yha.16.2010.11.20.11.27.19
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:27:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192153.GA17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161835>

Teach the svndiff routines to read the preimage for a delta from a
file descriptor without reading ahead.  This way, the delta applier
can stream its input directly from fast-import's cat-blob-fd pipe.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 test-svn-fe.c            |   10 +++++-----
 vcs-svn/sliding_window.c |   21 +++++++++------------
 vcs-svn/sliding_window.h |    2 +-
 vcs-svn/svndiff.c        |    6 +++---
 vcs-svn/svndiff.h        |    2 +-
 5 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/test-svn-fe.c b/test-svn-fe.c
index 4799e4c..4ea0cd6 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -22,20 +22,20 @@ int main(int argc, char *argv[])
 		return 0;
 	}
 	if (argc == 5 && !strcmp(argv[1], "-d")) {
-		struct line_buffer preimage = LINE_BUFFER_INIT;
+		int preimage_fd = -1;
 		struct line_buffer delta = LINE_BUFFER_INIT;
-		if (buffer_init(&preimage, argv[2]))
+		preimage_fd = open(argv[2], O_RDONLY);
+		if (preimage_fd < 0)
 			die_errno("cannot open preimage");
 		if (buffer_init(&delta, argv[3]))
 			die_errno("cannot open delta");
 		if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
-				   &preimage, stdout))
+				   preimage_fd, stdout))
 			return 1;
-		if (buffer_deinit(&preimage))
+		if (close(preimage_fd))
 			die_errno("cannot close preimage");
 		if (buffer_deinit(&delta))
 			die_errno("cannot close delta");
-		buffer_reset(&preimage);
 		buffer_reset(&delta);
 		return 0;
 	}
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index 5c08828..6d4261a 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -5,7 +5,7 @@
 
 #include "git-compat-util.h"
 #include "sliding_window.h"
-#include "line_buffer.h"
+#include "fd_buffer.h"
 #include "strbuf.h"
 
 static void strbuf_remove_from_left(struct strbuf *sb, size_t nbytes)
@@ -30,7 +30,7 @@ static int check_overflow(off_t a, size_t b)
 int move_window(struct view *view, off_t off, size_t len)
 {
 	off_t file_offset;
-	assert(view && view->file);
+	assert(view && view->fd >= 0);
 	assert(!check_overflow(view->off, view->buf.len));
 
 	if (check_overflow(off, len))
@@ -47,21 +47,18 @@ int move_window(struct view *view, off_t off, size_t len)
 	if (off > file_offset) {
 		/* Seek ahead to skip the gap. */
 		const off_t gap = off - file_offset;
-		const off_t nread = buffer_skip_bytes(view->file, gap);
+		const off_t nread = fd_skip_bytes(view->fd, gap);
 		if (nread != gap) {
-			if (!buffer_ferror(view->file))
+			if (!nread)
 				return error("Preimage ends early");
-			return error("Cannot seek forward in input: %s",
-				     strerror(errno));
+			return error("Cannot seek forward in input");
 		}
 		file_offset += gap;
 	}
-	buffer_read_binary(&view->buf, len - view->buf.len, view->file);
-	if (view->buf.len != len) {
-		if (!buffer_ferror(view->file))
-			return error("Preimage ends early");
-		return error("Cannot read preimage: %s", strerror(errno));
-	}
+	if (fd_read_binary(&view->buf, len - view->buf.len, view->fd))
+		return error("Cannot read preimage");
+	if (view->buf.len != len)
+		return error("Preimage ends early");
 	view->off = off;
 	return 0;
 }
diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
index b9f0552..532dc93 100644
--- a/vcs-svn/sliding_window.h
+++ b/vcs-svn/sliding_window.h
@@ -4,7 +4,7 @@
 #include "strbuf.h"
 
 struct view {
-	struct line_buffer *file;
+	int fd;
 	off_t off;
 	struct strbuf buf;
 };
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 9ee7411..ef3a921 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -283,10 +283,10 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 }
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-		   struct line_buffer *preimage, FILE *postimage)
+		   int preimage_fd, FILE *postimage)
 {
-	struct view preimage_view = {preimage, 0, STRBUF_INIT};
-	assert(delta && preimage && postimage);
+	struct view preimage_view = {preimage_fd, 0, STRBUF_INIT};
+	assert(delta && preimage_fd >= 0 && postimage);
 
 	if (read_magic(delta, &delta_len))
 		goto fail;
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
index a986099..9003d6e 100644
--- a/vcs-svn/svndiff.h
+++ b/vcs-svn/svndiff.h
@@ -4,6 +4,6 @@
 #include "line_buffer.h"
 
 extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-			  struct line_buffer *preimage, FILE *postimage);
+				int preimage_fd, FILE *postimage);
 
 #endif
-- 
1.7.2.3
