From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/8] strbuf: add strbuf_read_once to read without blocking
Date: Mon, 28 Sep 2015 16:14:02 -0700
Message-ID: <1443482046-25569-5-git-send-email-sbeller@google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 01:14:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zghd4-0007Kf-7L
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbbI1XOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:14:32 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36494 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbbI1XO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:14:29 -0400
Received: by pablk4 with SMTP id lk4so89756507pab.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GH9txRb3DbeQDZH5Qtj6oHzO/Jm8xOKM5uTWKeU7Pxg=;
        b=prKxDuRC3FC5zevHTJTVFSNutyXMT1awo4G4N3s4YYzwm7+/9+wVmLjY6891ySwO9D
         LfAVsCBvmH9OXBrRoUwbjlhhL3PiD9sKdfsFNoGcetuHsvagRI0mNRoC5YyWfjQEZFwg
         QqkMoG9dj8sblddyRmKK26DM3Nnd2pnB4Qgihad08X+psFrsanMtS+g5HRdZlG1JatVq
         U+xG0RFL7DDplXLSK5jVYaag8hVhnvNtGynryz5TZ63/eX/BjtBtDEgYIewlRZcAqMA+
         HPiYvgf1z8g9i6bsW85L1ssa10imOYTgcLFGjToz3U1vjqf1wr93LWy4bkOJ7AsUcGFD
         /0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GH9txRb3DbeQDZH5Qtj6oHzO/Jm8xOKM5uTWKeU7Pxg=;
        b=VDIAJyqrievK6YEgVE1q6Zret2cnsFP0UA9H+hsUSVfAQcRHUWdfaVXrxhG070YP/F
         gNohEMZrp+bd05SSah8T6oPcyBCaVKFs0CVJKwvjg0OgjhhlsVD8BT28eNopDvPSbR3R
         HTBhknPDma23qXTFk57slcVNq1aQg86tr2HqA8BVz5WVOYbPTd640jk94rCtTidTMH/N
         AVyE9fsvV6NE+eJ0orbbVR75S7Jw72WXjZOZOuzzBrN4HGnIBkk6lTCIo7EZ3qnwMPhC
         Nd9udZhhDJPX2fx2RmBSQYKeFc+nxjMcyuHQnsAGqWS9gD6Hxwlr7BEIrL1OYRJXX1fw
         jaqQ==
X-Gm-Message-State: ALoCoQlapxWLSoS3H+cQRYAG5NSmkpyhANNF6Y0a8R+LpODWDKLQmFQiwyOmepcOUpKiEa31BGgV
X-Received: by 10.68.237.161 with SMTP id vd1mr28526850pbc.168.1443482066067;
        Mon, 28 Sep 2015 16:14:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:79ce:7412:e4be:3e39])
        by smtp.gmail.com with ESMTPSA id df2sm21588629pad.19.2015.09.28.16.14.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 16:14:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443482046-25569-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278807>

The new call will read from a file descriptor into a strbuf once. The
underlying call xread_nonblock is meant to execute without blocking if
the file descriptor is set to O_NONBLOCK. It is a bug to call
strbuf_read_once on a file descriptor which would block.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.5.0.273.g6fa2560.dirty
