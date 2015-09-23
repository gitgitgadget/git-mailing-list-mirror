From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 04/14] strbuf: add strbuf_read_once to read without blocking
Date: Tue, 22 Sep 2015 18:45:22 -0700
Message-ID: <1442972732-12118-5-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:46:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ8H-0007Dx-Pg
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759984AbbIWBpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:45:45 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35658 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759957AbbIWBpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:41 -0400
Received: by pacfv12 with SMTP id fv12so25538232pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VD3MMNVfvVrEt13Eomv9uPbFCqugdu6/8CBBchAMlF4=;
        b=NI/Y2JtEbMAv4w7XOIh0PPZqR/wteZg0t+SC3MQedoCdlBDZiE4AfzWBMFujiIr8jK
         tc+OYFqzbwPaKN7B20vHwE2lvMYgmWB3Q0YcILfYJEDIbnJoiZUNzxAmeIA5THu7mg3K
         0OumTaav2oKCvZ/6MKTgq8S/yPy57C8NoLyCYju9ngmki9mTfar3dHYi5eLAOQw3l3cj
         nVDQFajP1uNXhT89r3YVO/RBzmZLlCNc4IeUDomWEhEz8kJK4rlxBr+PNuJ51ASeYSXj
         tOcNXPUBUjJaFWnCe+TMbeMneKLGOYsttvjNK16bY69tZ0hXW2S8ZGhfqc9mlnJ5Ym6U
         zvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VD3MMNVfvVrEt13Eomv9uPbFCqugdu6/8CBBchAMlF4=;
        b=Ylc5m2qv5qD2z+9jdX6OKmzxlGVAErsqsc/tNClktgg6Z/30/44hTUAHLYOoy4Xmtm
         3+4Pzyprre0fI61XTgN/65E/GE313NRHySP4xg0kVN2/+tZ4S0nG9zTxwKADU+FusghX
         yJdNASavgvriUWMLfgJ2Ecg5V5dQLHvbCXBe3dbrFdKWph1CqcW4nq4coPpZdHXlgpJW
         RwdgxzhxDlCmbI89rErM1EnoBivc5Vo8TKUg/r5uZCefYbdfu2YE29zfeWOg8ZW4hJuX
         mS9nHiITSi2vcz26984rMqwk0dPe3hq9s8MwOcLCQDttykIHonpWBf4lTFlk335rlLD+
         7Sag==
X-Gm-Message-State: ALoCoQnjOJ2ogtciTxRO+gKZ7LuDuY3/RllAAuk84cgz11/mVY1V4UwSagmZsEvWTRVq1teIbaCL
X-Received: by 10.66.139.165 with SMTP id qz5mr34033658pab.92.1442972740919;
        Tue, 22 Sep 2015 18:45:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id tk4sm4574840pab.45.2015.09.22.18.45.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278455>

The new call will read from a file descriptor into a strbuf once. The
underlying call xread_nonblock is meant to execute without blocking if
the file descriptor is set to O_NONBLOCK. It is a bug to call
strbuf_read_once on a file descriptor which would block.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 strbuf.c | 11 +++++++++++
 strbuf.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index cce5eed..35e71b8 100644
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
+	cnt = xread_nonblock(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
+	if (cnt > 0)
+		strbuf_setlen(sb, sb->len + cnt);
+	return cnt;
+}
+
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index aef2794..ea69665 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,6 +367,15 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 
 /**
+ * Read from a file descriptor that is marked as O_NONBLOCK without
+ * blocking.  Returns the number of new bytes appended to the sb.
+ * Negative return value signals there was an error returned from
+ * underlying read(2), in which case the caller should check errno.
+ * e.g. errno == EAGAIN when the read may have blocked.
+ */
+extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
+
+/**
  * Read the contents of a file, specified by its path. The third argument
  * can be used to give a hint about the file size, to avoid reallocs.
  */
-- 
2.5.0.272.ga84127c.dirty
