From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] write_file(): introduce an explicit WRITE_FILE_GENTLY request
Date: Mon, 24 Aug 2015 10:09:44 -0700
Message-ID: <1440436186-7894-4-git-send-email-gitster@pobox.com>
References: <20150824065033.GA4124@sigill.intra.peff.net>
 <1440436186-7894-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 19:10:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvG9-0005OO-18
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbbHXRKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:10:01 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35494 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879AbbHXRJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:09:50 -0400
Received: by pacdd16 with SMTP id dd16so101313291pac.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=lNidBKX1LmdTva/cvYnVc71XkrCYzxBNJ/cmMWH1ps0=;
        b=bpiOha0EzHF5OCObEpiC9vCribVuixHduH5oVVhhADMKDy3AgCrtWBmWMR32juSM/b
         4eBLqH/+L3TfCgl1Y4y9n6k7ypUJi3y/Rp/9q6aGHhEyl2vFQDYu3Z6V/05uUYFfw0sk
         SR3FbdlMFQz/Ul5e0Dhzc/j9/gotYvsuy7ZGFnyaJT2C0iIWEt37Dc2VtHYM8yKu1U2A
         NglpM0dO0qrmY59VTh9iMKuDJfaQYGQlL7QB8Ut7CKAC+d6c5gyS+JqvtisdbVhZQdsJ
         elLTIGvJ3moCjCP66t/2gGP8S/hQPsuBRFQIkfTg4z1x07w5gR9zjvVjqH/mH0xAqYOp
         0reA==
X-Received: by 10.68.98.194 with SMTP id ek2mr46997295pbb.152.1440436190470;
        Mon, 24 Aug 2015 10:09:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id an10sm18098667pad.5.2015.08.24.10.09.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:09:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440436186-7894-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276464>

All callers except for two ask this function to die upon error by
passing fatal=1; turn the parameter to a more generic "unsigned flag"
bag of bits, introduce an explicit WRITE_FILE_GENTLY bit and change
these two callers to pass that bit.

This is in preparation to add one more bit to this flag word.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     | 15 ++++++++++++++-
 setup.c     |  2 +-
 transport.c |  2 +-
 wrapper.c   |  3 ++-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 6bb7119..f105235 100644
--- a/cache.h
+++ b/cache.h
@@ -1539,8 +1539,21 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
 }
+
+/*
+ * Create a new file by specifying its full contents via fmt and the
+ * remainder of args that are used like 'printf()' args.  Die upon
+ * an error unless WRITE_FILE_GENTLY flag is set, in which case return
+ * a negative number to signal an error.
+ *
+ * For historical reasons, the LSB of flags word is set by many
+ * callers to explicitly ask the function to die upon error, but now
+ * it is the default.
+ */
+#define WRITE_FILE_UNUSED_0 (1<<0)
+#define WRITE_FILE_GENTLY (1<<1)
 __attribute__((format (printf, 3, 4)))
-extern int write_file(const char *path, int fatal, const char *fmt, ...);
+extern int write_file(const char *path, unsigned flags, const char *fmt, ...);
 
 /* pager.c */
 extern void setup_pager(void);
diff --git a/setup.c b/setup.c
index 5f9f07d..718f4e1 100644
--- a/setup.c
+++ b/setup.c
@@ -404,7 +404,7 @@ static void update_linked_gitdir(const char *gitfile, const char *gitdir)
 
 	strbuf_addf(&path, "%s/gitfile", gitdir);
 	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
-		write_file(path.buf, 0, "%s\n", gitfile);
+		write_file(path.buf, WRITE_FILE_GENTLY, "%s\n", gitfile);
 	strbuf_release(&path);
 }
 
diff --git a/transport.c b/transport.c
index 40692f8..e1821a4 100644
--- a/transport.c
+++ b/transport.c
@@ -291,7 +291,7 @@ static int write_one_ref(const char *name, const struct object_id *oid,
 
 	strbuf_addstr(buf, name);
 	if (safe_create_leading_directories(buf->buf) ||
-	    write_file(buf->buf, 0, "%s\n", oid_to_hex(oid)))
+	    write_file(buf->buf, WRITE_FILE_GENTLY, "%s\n", oid_to_hex(oid)))
 		return error("problems writing temporary file %s: %s",
 			     buf->buf, strerror(errno));
 	strbuf_setlen(buf, len);
diff --git a/wrapper.c b/wrapper.c
index e451463..68d45b6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -621,8 +621,9 @@ char *xgetcwd(void)
 	return strbuf_detach(&sb, NULL);
 }
 
-int write_file(const char *path, int fatal, const char *fmt, ...)
+int write_file(const char *path, unsigned flags, const char *fmt, ...)
 {
+	int fatal = !(flags & WRITE_FILE_GENTLY);
 	struct strbuf sb = STRBUF_INIT;
 	va_list params;
 	int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
-- 
2.5.0-568-g53a3e28
