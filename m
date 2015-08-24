From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] write_file(): do not leave incomplete line at the end
Date: Mon, 24 Aug 2015 10:09:45 -0700
Message-ID: <1440436186-7894-5-git-send-email-gitster@pobox.com>
References: <20150824065033.GA4124@sigill.intra.peff.net>
 <1440436186-7894-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 19:10:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvFw-000596-Ru
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbbHXRJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:09:54 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35477 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbbHXRJv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:09:51 -0400
Received: by pdob1 with SMTP id b1so55569809pdo.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=/9xSyXOZHFTlj0w4NNHfEfuUVCnvE3G8xlg9wuzvCG8=;
        b=zUrL538RLBH3BNTgPf5IrcAvNt2aV0uTwAdnqUPxb8bNihboLDs7qnzayd+Vt0AciG
         vqaTzt2/XtJJkYKSXsd2qpgceplK1T9bLpMLwtHRCWOrj5cyl2d8VmYiSlA9YBJJF20L
         9JVUZeAPm6iO+cW068r8ZBnfWg0oR/UKK+xhGQKk3m4GJa830cG4o1jb9J9EZz3fwvC+
         gTcYCpunnmWA/DwO5HO229UdLuzjATInpAtf957wNPr0h+3vMqPaGa91ZzKBn0QRKWS3
         1Vd8KNjCWhD2VjiPR84yKM00GlS42sPtpNP7RHoTRrMuryIU4VBLRGRpXDX9dOJp/57e
         uuIQ==
X-Received: by 10.70.88.2 with SMTP id bc2mr46708285pdb.52.1440436191315;
        Mon, 24 Aug 2015 10:09:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id rt6sm18027965pbb.62.2015.08.24.10.09.50
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:09:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440436186-7894-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276463>

All existing callers to this function use it to produce a text file
or an empty file, and a new callsite that mimick them must end their
payload with a LF.  If they forget to do so, the resulting file will
end with an incomplete line.

Introduce WRITE_FILE_BINARY flag bit, which no existing callers pass,
and unless that bit is set, make sure that write_file() adds an extra
LF at the end of an incomplete line as necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h   | 1 +
 wrapper.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/cache.h b/cache.h
index f105235..dbfa4fa 100644
--- a/cache.h
+++ b/cache.h
@@ -1552,6 +1552,7 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
  */
 #define WRITE_FILE_UNUSED_0 (1<<0)
 #define WRITE_FILE_GENTLY (1<<1)
+#define WRITE_FILE_BINARY (1<<2)
 __attribute__((format (printf, 3, 4)))
 extern int write_file(const char *path, unsigned flags, const char *fmt, ...);
 
diff --git a/wrapper.c b/wrapper.c
index 68d45b6..4cd2ca3 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -635,6 +635,9 @@ int write_file(const char *path, unsigned flags, const char *fmt, ...)
 	va_start(params, fmt);
 	strbuf_vaddf(&sb, fmt, params);
 	va_end(params);
+	if (!(flags & WRITE_FILE_BINARY))
+		strbuf_complete_line(&sb);
+
 	if (write_in_full(fd, sb.buf, sb.len) != sb.len) {
 		int err = errno;
 		close(fd);
-- 
2.5.0-568-g53a3e28
