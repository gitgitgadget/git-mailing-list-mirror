From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 4/8] strbuf: add strbuf_read_once to read without blocking
Date: Wed, 30 Sep 2015 18:54:12 -0700
Message-ID: <1443664456-1307-5-git-send-email-sbeller@google.com>
References: <1443664456-1307-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 03:55:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhT5S-0000Ih-PC
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 03:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167AbbJABzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 21:55:04 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34306 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbbJAByd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 21:54:33 -0400
Received: by padhy16 with SMTP id hy16so57627806pad.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 18:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5GH0Zv5Cd2gmga1xu6xx2i6ksJ7Br5BkBmVrD9pHPU=;
        b=Ec6p8sJ9D5oybnHWc4m2yOSxV4kJZ936Y0xE7zN6s19s9HGqbaNtMW7Kxhe8F9BIo3
         WES6wT8Ek0r+LfBFyP07QgdOUZolceUWQ0WYbZQlpjd469djfq9PB8jj1s9MXPpgN1KF
         9GjpE+x2GI4Am0QLV5rodon0xnRhDFNJmxaWXWvIhyR1v0MEkoiyJx3qyH1RXUhDcrcy
         Lo56FZdydbC7E9VUnluQS6u0867bUSBJy2OyxYzIN9zTA7C69GeCtbAQ485QKDw1WVXM
         XHse82V9Xa9b1Wm5TjUXivAsS+nJMM9arQq2BzqKBOy1W8JZ2H+ZYxWqCwT9tf7ovXMg
         mbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5GH0Zv5Cd2gmga1xu6xx2i6ksJ7Br5BkBmVrD9pHPU=;
        b=fIFD6Obb7BFmOm0Pmsl7rerHi8T09jt0xIp3D38Jlv7NU1Kz9DewF/9wLBM6XU8b1K
         XSGFzvwzRk9ookOtL1PdVbkFd2nP+gbWqTQKsmL8JwG//HpPtiSLTzaneQy8FZIvDXw6
         QbO9mkPOJ5Kevy7uzYRFHJ2JoJd9ieQphKLbQFlZ0sGZzb+/WMzUTu1RYRavl/+0sFao
         0IEDfmkexxPrxgxncPOefYJebO7sKbiJr162hL/dHHZmGnT4c5jAVci/F8liUBiS//e4
         hIPfkCE6G8yP2khFjlKJFmgjfa6f85Ntn+tLA3qyZJGNQJA8o1cueb9CZkcA6XokuUDy
         ruvA==
X-Gm-Message-State: ALoCoQk9tpMtHNlveYCTXeacVQqKNr613uHg/wY55OI6maSPrkXSjH47KPo8njkG5jNbaEdZvMGE
X-Received: by 10.67.5.66 with SMTP id ck2mr8713872pad.137.1443664473329;
        Wed, 30 Sep 2015 18:54:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8d91:1679:adb7:b916])
        by smtp.gmail.com with ESMTPSA id hh3sm3140421pbc.8.2015.09.30.18.54.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 18:54:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gf20166c.dirty
In-Reply-To: <1443664456-1307-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278874>

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
2.5.0.275.gf20166c.dirty
