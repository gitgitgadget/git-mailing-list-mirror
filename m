From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/8] xread_nonblock: add functionality to read from fds without blocking
Date: Mon, 28 Sep 2015 16:14:01 -0700
Message-ID: <1443482046-25569-4-git-send-email-sbeller@google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 01:14:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zghd4-0007Kf-R2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbbI1XOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:14:33 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35340 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbbI1XO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:14:28 -0400
Received: by pacfv12 with SMTP id fv12so190714476pac.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UHMpv3HtPwKUnDT2IBDVe/4VuySZk7COQEHekEYRS2c=;
        b=gUVna7XzawAgL1A4RQ5uAwR1z+OPAMPits2MtgA7eVLlTtNqU33TeLKl84pC3DJf6G
         uk4hiX5IWby45ScKrq/7ITRdRxCp4fh7ObsZb3xC865awquF6JLqqXDTtUd2NK+1tRCg
         JK88B5CMx/nzWVoDdjZOO4TkhQyR8Hl10zTC0Ax8Qd85fPVpdCwK96HPup55llf6IaPX
         WIvXJ4OyWO13ZcfTo4sOoNheINE4jFKrh3hHBRYrpTZim0VrE5FDY16Y0qhKpbA0thlB
         /4WTc/uHXDc7maDDxPV9QZN4G3g/eQ5II7VtJM1FR+c8I5fNyPFNOVpMXX+YFUQ7LljW
         LQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UHMpv3HtPwKUnDT2IBDVe/4VuySZk7COQEHekEYRS2c=;
        b=EqyqGo/zPLkaAI3k/lDDR7KLhvzgAgTB8DqFs8LSRClFTgonzUfsH8vrRSUvSIkJSw
         pCCSr/jiaTXxJ7+5i7iY1/uL+6J4QvC07b5SgoQqYruHV4KocyfQxyNbCBDXV9xNJTOf
         tz9Yv6Bw2sAom9zC2dowQ4IPXt1BPaDryjJiSCW+8zDnd7zD/66xSbdwWZAn8YpsNvMK
         OjOcFY60FfvUE9ALxoVjGi8tLdmikyr1cIyNQJNktrVRyZtkoTQ3XMl10L8xjW1PKRM8
         VAgU4CnRJLHZ4+6S3oEXj70zPbLVzPXNTnzjD2G+1hLtxkv6w1zyqo8sBUMq2DS75SgE
         /ZMA==
X-Gm-Message-State: ALoCoQlpbpKOMftplkIog1Z0otps/7l41E7PJuEzJLlHEStT4oeQS6OY76DB9GvH5MJHyLk3gny2
X-Received: by 10.68.202.66 with SMTP id kg2mr17050748pbc.81.1443482064913;
        Mon, 28 Sep 2015 16:14:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:79ce:7412:e4be:3e39])
        by smtp.gmail.com with ESMTPSA id su3sm21451679pbc.83.2015.09.28.16.14.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 16:14:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443482046-25569-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278803>

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
2.5.0.273.g6fa2560.dirty
