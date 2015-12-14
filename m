From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/8] xread_nonblock: add functionality to read from fds without blocking
Date: Mon, 14 Dec 2015 11:37:13 -0800
Message-ID: <1450121838-7069-4-git-send-email-sbeller@google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 20:38:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YwS-0003jc-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbbLNThk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:37:40 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36534 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbbLNThc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:37:32 -0500
Received: by pacdm15 with SMTP id dm15so108440911pac.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 11:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EV3upUm0x0/JIJngQ28EisYBhtprsSZVgWz18WY2MvA=;
        b=aJhEmISt0nwR/+pEMfijCqitj1FOhJYdZNGt8D5qyeN0Q7OkjxHmZCC7slk1KnR4GQ
         7H4LrwwNyV0sQued1qmGmgrbsee18udkR0c8g0UN3oEHCh7V2f3OkDdSlbuexbWNyl4K
         KW5WFEBMyWCobsyKJljTi2cwVnNibRvC0gobr/fhJAjsfI7V5/BvLGLE4kgec2yuyq1A
         /orSf3Okea3oNJv4vVInKqpHjKhODyvJt1GNvAtZzj5SQNJE/p7/UlrkX3NKCTS+md1W
         t0d3rlzvdg88HG15Cx68/UO9HLtZSMwRkUysbTvLiOA7hRAygLgTK7w27es0oabnLuGc
         H/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EV3upUm0x0/JIJngQ28EisYBhtprsSZVgWz18WY2MvA=;
        b=S4LT55bSNANjycW/U95pfvDbzGUEk8GZ1QZEsGsXMKSRGv+51PZFDsIH25cUSDg0oD
         4HSm5TlxDTp6XpFLJs1B7bsTvshWtA4xGwYYS0JkG4oMP00CyBf/hbBKPumNRCWKQ22w
         bVjVyEFFvF7eWSnI/RV+urbmhgX3//vZf1edGUy4j/wh8iIdDBCLd8IA02vOTJbODDpx
         seBP7CLd2oykZ6iqod0zl33uUjCAUPg6VR+3Xg2ew7w3JmlaOfH4ziKFfIi7zABZkC2e
         rCRKjVITExFXv6MVU54kTz5kbmHpNnLpRYTiJKPMvkHut2BzRvSz1LEKchURhK//X4hp
         GR4w==
X-Gm-Message-State: ALoCoQnU+xlt0NtO4xltQRCE9YAlK9TLbuX56V9jq797CrIuNvhLFN2Yq7UPYraHMvgN3LrEhSx8ke/Imtv9tyMye9+iJo41yw==
X-Received: by 10.66.180.48 with SMTP id dl16mr47709794pac.39.1450121852229;
        Mon, 14 Dec 2015 11:37:32 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a894:af1d:9081:95fb])
        by smtp.gmail.com with ESMTPSA id f63sm5810808pfj.35.2015.12.14.11.37.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 11:37:31 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450121838-7069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282391>

Provide a wrapper to read(), similar to xread(), that restarts on
EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
handle polling itself, possibly polling multiple sockets or performing
some other action.

Helped-by: Jacob Keller <jacob.keller@gmail.com>
Helped-by: Jeff King <peff@peff.net>,
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8e39867..87456a3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -723,6 +723,7 @@ extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_
 extern void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern int xopen(const char *path, int flags, ...);
 extern ssize_t xread(int fd, void *buf, size_t len);
+extern ssize_t xread_nonblock(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
diff --git a/wrapper.c b/wrapper.c
index 4f720fe..f71237c 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -252,6 +252,28 @@ ssize_t xread(int fd, void *buf, size_t len)
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
2.6.4.443.ge094245.dirty
