From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/7] strbuf: add strbuf_read_once to read without blocking
Date: Tue, 15 Dec 2015 16:04:08 -0800
Message-ID: <1450224252-16833-4-git-send-email-sbeller@google.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:04:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8za2-0005ka-Vw
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933785AbbLPAEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:04:25 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35439 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbbLPAEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:04:24 -0500
Received: by mail-pa0-f43.google.com with SMTP id hk6so13341395pad.2
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1MEpWJj1mqPr29qT8b+PM5D92GAPGDGIgjNavP9OW8E=;
        b=HtWgLfLJ8nq63ohh45EM8hl3fmLCvFkY31u1lJTIlIHCAucTRdguKDxcUHlOiMvBfD
         VY91obnUsS6c3JcUMCB71Se2Yn6kpm4h41tQC7Q/OxsHCnuFKbuYxkD6ZOx9ZdoOLyfd
         IeZLAwjjj6HG4zAlnAXN8/kLWj6ksrPrlMo5ojOW6Ga2JPhvfSqiogGrOhTkze7qlCOR
         HmxehN4DhYBclFCMHYXqG3mTb7GzU5pS63Av6LJKmzuRfELIsHz95gw15QgXCcmAs3Dh
         +UlzpFMAiTgc0+uVYZCiICGe5gQbqT0FbYGZfQ4CW/G8SIGMw4OD+spRz31ktmGm9g4B
         WSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1MEpWJj1mqPr29qT8b+PM5D92GAPGDGIgjNavP9OW8E=;
        b=IJLDUBlgfCOvxzOeAHb/IDVhXyyZoRLJbTPSqexUTHfm6DJTCgrMG1uudo1pG+VCuP
         ZYKkD55eW+M656XEjGU+XUkrxUMwJOnPgYAg3vE3Hme8KhVjnDtrypRJmGu+yERu9/+s
         U+nXzgMc3naa0Ad6KSZLKTM3+MXJ8l8KjoqGWXtimznFmbY5gdQEJZmgD2NfHqdeU1Iy
         IAwttlOhLEnmNjpi4TOwZZ1sFF85e1gvyFHZ77jv1Gw8iy0EVymjPBx2cvG4VKbvoPcE
         oCOjAUY1Ns72YusYgDqe9PYGdK3x2FJy1oxeMBrijEEhWKYmor+WBNgbp3/x7OYYqE5Y
         t/EA==
X-Gm-Message-State: ALoCoQnRFFGpFBsEixSVKyPMKQcS/63EZi8JNQi1Rw20Y7SE5gdjaAbsr2C2IQU4cVhUxdbJVRgl7wdlzNrjxWQKFsvzg74Fbw==
X-Received: by 10.66.158.97 with SMTP id wt1mr58482639pab.155.1450224263835;
        Tue, 15 Dec 2015 16:04:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a171:258:4778:14b4])
        by smtp.gmail.com with ESMTPSA id 2sm398903pfl.56.2015.12.15.16.04.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:04:23 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450224252-16833-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282515>

The new call will read from a file descriptor into a strbuf once. The
underlying call xread is just run once. xread only reattempts
reading in case of EINTR, which makes it suitable to use for a
nonblocking read.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strbuf.c | 11 +++++++++++
 strbuf.h |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index d76f0ae..38686ff 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -384,6 +384,17 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	return sb->len - oldlen;
 }
 
+ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
+{
+	ssize_t cnt;
+
+	strbuf_grow(sb, hint ? hint : 8192);
+	cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
+	if (cnt > 0)
+		strbuf_setlen(sb, sb->len + cnt);
+	return cnt;
+}
+
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index 7123fca..2bf90e7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,6 +367,14 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 
 /**
+ * Read the contents of a given file descriptor partially by using only one
+ * attempt of xread. The third argument can be used to give a hint about the
+ * file size, to avoid reallocs. Returns the number of new bytes appended to
+ * the sb.
+ */
+extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
+
+/**
  * Read the contents of a file, specified by its path. The third argument
  * can be used to give a hint about the file size, to avoid reallocs.
  */
-- 
2.6.4.443.ge094245.dirty
