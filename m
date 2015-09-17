From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Wed, 16 Sep 2015 18:38:59 -0700
Message-ID: <1442453948-9885-2-git-send-email-sbeller@google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAS-0005uk-1O
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbbIQBjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:16 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34359 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbIQBjO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:14 -0400
Received: by padhy16 with SMTP id hy16so4687635pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKxXJmyPgeMbSX8TrSbBiw4UcfsOOn8N4UbxKbBwYVE=;
        b=IRXDHyBg4bJFAOZZY6l2uvua8B9YjT5/Pk9XfYFS3odDg7heQlEUeA1qOgCWrmB+fi
         3I2KOrY3slXT7AMG9rq+qpXhu9DVUY//lqrOS88rsC8TsLz2oFEufSYATpdgiw/ZVyBN
         hiNB6DUxkIsAKVPog689+HNSzPAOCmLJpS9PJM6Ubnbyo3vO2kCp/ZKJC52/CKJ6jjea
         Sbqqq3/C0YGwPhqouPq3laWnBFtisJDUAuHXfWAeaB+swsGb4yusWNUdD0MiCGtoxLgn
         mBzDWIo/f9yAzuqB1aLTqGHdYrf/iuuh64Z2bSHFuNL3JiV6PmUXkn55XqxvXgzzE2Y0
         jedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iKxXJmyPgeMbSX8TrSbBiw4UcfsOOn8N4UbxKbBwYVE=;
        b=V10e4/JgCSisMW4NfhS/rAuKOVjR5SgJvWLVXIIrUEK76nr0zaq6P6eIllKqoGqevq
         2QR8RCu+rrIWOkYPnnlR8+UdjK0eJqePhiyaKP996/rIs963YqdSDVHq452mA/cx1/M8
         Rp/RTC6Wnqy3kw+gz+NO9Tb7iwDc8PCVkU5kITWxSkn34u4tZCJvYeHmw5HurPPiC5gj
         kmA3pALAGmxwQHbI5IjNcZS4vHQDvoTw9FwlggRUaUOG8r/0q1USnvDGFjhWcTluAHsR
         QO/tCDsrR/nmvG3yax6WAu/ZcXDIGNlzO9Cm28E2RUdGg4kwbpvP7tooJtbng+KfRt79
         /1JA==
X-Gm-Message-State: ALoCoQmgNcihr7OHYKyZIsGW97N8ps3kcT2jQlXY4gCLnadjrNuWj0K9Lv/mqmj07stWv8ZP958F
X-Received: by 10.66.144.165 with SMTP id sn5mr67815033pab.122.1442453954108;
        Wed, 16 Sep 2015 18:39:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id qy5sm581741pbb.16.2015.09.16.18.39.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:13 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278091>

We need to read from pipes without blocking in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 strbuf.c | 25 +++++++++++++++++++++++--
 strbuf.h |  6 ++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index cce5eed..4130ee2 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -357,7 +357,10 @@ size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 	return res;
 }
 
-ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
+#define IGNORE_EAGAIN (1)
+
+static ssize_t strbuf_read_internal(struct strbuf *sb, int fd,
+				    size_t hint, int flags)
 {
 	size_t oldlen = sb->len;
 	size_t oldalloc = sb->alloc;
@@ -366,8 +369,16 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	for (;;) {
 		ssize_t cnt;
 
-		cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
+		cnt = read(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
 		if (cnt < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EAGAIN) {
+				if (flags & IGNORE_EAGAIN)
+					break;
+				else
+					continue;
+			}
 			if (oldalloc == 0)
 				strbuf_release(sb);
 			else
@@ -384,6 +395,16 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	return sb->len - oldlen;
 }
 
+ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
+{
+	return strbuf_read_internal(sb, fd, hint, 0);
+}
+
+ssize_t strbuf_read_noblock(struct strbuf *sb, int fd, size_t hint)
+{
+	return strbuf_read_internal(sb, fd, hint, IGNORE_EAGAIN);
+}
+
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index aef2794..23ca7aa 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,6 +367,12 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 
 /**
+ * Same as strbuf_read, just returns non-blockingly by ignoring EAGAIN.
+ * The fd must have set O_NONBLOCK.
+ */
+extern ssize_t strbuf_read_noblock(struct strbuf *, int fd, size_t hint);
+
+/**
  * Read the contents of a file, specified by its path. The third argument
  * can be used to give a hint about the file size, to avoid reallocs.
  */
-- 
2.6.0.rc0.131.gf624c3d
