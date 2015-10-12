From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 4/8] strbuf: add strbuf_read_once to read without blocking
Date: Mon, 12 Oct 2015 11:47:17 -0700
Message-ID: <1444675641-14866-5-git-send-email-sbeller@google.com>
References: <1444675641-14866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 20:47:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli8Y-0006Ox-QM
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbbJLSrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:47:52 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34717 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbbJLSrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:47:31 -0400
Received: by padhy16 with SMTP id hy16so160546056pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UCvrp32jCnbalAYlwSiCdEhpXBl/+3kWMwAt/SFGKcc=;
        b=pMOpS/DEAjMO0CFakRrpFuSFt3D8s6wqHIYmJIEc38IwsGljbnh62+CNBbUZJ902n7
         3jjQig0+WOO75VOs1n9BPb8/kwTokTpr4WxyWH/WV8nSFHYnK/rD5S6MHhI30pRhuPQ8
         sMFK9u8cspFlTzCYHvtjhwKLNwiXbpPNsAhVvjwOKsMV2NSw8Yp87xDsPuujp66G1Xty
         R1ogV80lK4FddzC+k1THxSWMsIcjAWlBCw5CjyJvSCkI/iwmfojfeTS9sOMW8Khddaoh
         OIRQLrnFHYeibABEGR5RkRj+G6iyEUDsOLVatnswiUJI1GQJhdrz5YU+xqp4Sr2YgQcD
         MU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UCvrp32jCnbalAYlwSiCdEhpXBl/+3kWMwAt/SFGKcc=;
        b=MH8mjECK2lSlBBV1VdyQ2FLhMyjft5jk8QLJcyd3pbeDtEZkwEsspUV5Xv7FNnRTQa
         y1+Qs/M04VAh0Icr037n5IdeQ+HgiQjFI5ZzyDwBW1icj1pIzSihD6OrSOqiAiGr1MKd
         z6njfStl63XQSbe1c/1F2DrETq0T+C/7cMoRiBY3n/wnZ/dmH5Cdf0SLpkHlG3cRZ8gY
         b/uaC+uXQijuxdz5W1EpiZExCDX9Jy2Q3VCLOP/3n6ZJKGRwuDleq9AYzz29wcbHMcQ1
         x+acbvlxOOep0LamfcvdpFoZIBoqNze6zP5Hy12asXhq1jd/gcnxNX9Rq3BnDelatZZt
         /WCg==
X-Gm-Message-State: ALoCoQnowPSwc8bx+YlIKi556Ku2tKLBNsinCpYkLYd27N0XORA+aeRZ19N6y1/zKhY82WiBnQBU
X-Received: by 10.66.250.197 with SMTP id ze5mr36291808pac.50.1444675650986;
        Mon, 12 Oct 2015 11:47:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id qy5sm19712315pbb.16.2015.10.12.11.47.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 11:47:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
In-Reply-To: <1444675641-14866-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279397>

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
2.5.0.268.g453a26a
