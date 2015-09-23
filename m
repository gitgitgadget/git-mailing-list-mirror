From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 03/14] xread_nonblock: add functionality to read from fds without blocking
Date: Tue, 22 Sep 2015 18:45:21 -0700
Message-ID: <1442972732-12118-4-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:45:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ7y-0006pK-IJ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759980AbbIWBpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:45:44 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35639 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758805AbbIWBpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:40 -0400
Received: by pacfv12 with SMTP id fv12so25537754pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I2lPIKw15EcIzCQjp0MgznLBe5PdMlM9aNQr63kb55U=;
        b=OJ2JzSGk5wiBVI7tzioZGuJ2Kz8l/D6PsGjQRQaENMSuuYI7j/9Of4k+iGPk/uShhK
         +YWYAwroYo2yX6IRFkPVgfJhL4f1z3abYDQ5tRtaUGl0GIyK82LSWr9PByHuetI3YHfq
         YOdAzo2mfTMLXY0c9QFf3giVtj2jv9rcX+jL1Dax88foW+lwNpwLDvncH49UtbXlfOjK
         f0wIhmifWFyHLc9GmLT0A5YazXjfedRi4YpHwqhgd4+HJ4IPslIvNfIuB9L34wu+4Lxd
         rgPzZYLQsrx59X/FxRUpGf1ZkLDDhvf+jvxZlf1edUA7+mk8QZ9Ar3rJwUDm7yDwSYE6
         +j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I2lPIKw15EcIzCQjp0MgznLBe5PdMlM9aNQr63kb55U=;
        b=Qb+ODG8OqSE82NLiDwOabyB3O8UejZR4VmeOtgVRWL2PAJbSoyumI0ANO5GzpgtOfK
         EFi8B6RxOS98cfTpuyPEkie4aIwzeNFWb7tJC5JGyqIBsl3OHSaXgL7ui2Uf1K78xT4I
         F5cWP9MVCdNXtLzgHbSTCRP4y3en9V7ZSh1F7b3yM1+WuBpDW2GkYU2YSrYBfi/oA5KT
         JMrouQ/TYmR1spvHnuLFFK8D+Kvz2igJMwv1y1WZff87dTCyifGCi5SccY1js9AkAIpf
         BkBPbDJJIgHTfEHk/Cek2+svR5IhmZLbudWKeZM+Xa38lendx3CGiDlsvKYMMPyDBU8S
         JF9Q==
X-Gm-Message-State: ALoCoQnfVCXQYaxjBDDnasTFbGZfUSDdYTjqky2x5DhO1GlMoNPFQQoRxo1PYCXzHhLobh4SJMmJ
X-Received: by 10.66.236.10 with SMTP id uq10mr11793924pac.55.1442972739631;
        Tue, 22 Sep 2015 18:45:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id lg7sm4656116pbc.1.2015.09.22.18.45.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278453>

Provide a wrapper to read(), similar to xread(), that restarts on
EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
handle polling itself, possibly polling multiple sockets or performing
some other action.

Helped-by: Jacob Keller <jacob.keller@gmail.com>
Helped-by: Jeff King <peff@peff.net>,
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index c6d391f..9ccea85 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -718,6 +718,7 @@ extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
+extern ssize_t xread_nonblock(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
diff --git a/wrapper.c b/wrapper.c
index 5517928..41a21e1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -217,6 +217,28 @@ ssize_t xread(int fd, void *buf, size_t len)
 }
 
 /*
+ * xread_nonblock() is the same a read(), but it automatically restarts read()
+ * interrupted operations (EINTR). xread_nonblock() DOES NOT GUARANTEE that
+ * "len" bytes is read. EWOULDBLOCK is turned into EAGAIN.
+ */
+ssize_t xread_nonblock(int fd, void *buf, size_t len)
+{
+	ssize_t nr;
+	if (len > MAX_IO_SIZE)
+		len = MAX_IO_SIZE;
+	while (1) {
+		nr = read(fd, buf, len);
+		if (nr < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EWOULDBLOCK)
+				errno = EAGAIN;
+		}
+		return nr;
+	}
+}
+
+/*
  * xwrite() is the same a write(), but it automatically restarts write()
  * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
  * GUARANTEE that "len" bytes is written even if the operation is successful.
-- 
2.5.0.272.ga84127c.dirty
