From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/8] strbuf: add strbuf_read_once to read without blocking
Date: Mon, 14 Dec 2015 11:37:14 -0800
Message-ID: <1450121838-7069-5-git-send-email-sbeller@google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 20:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YwI-0003Uc-W6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbbLNThh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:37:37 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36437 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbLNThe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:37:34 -0500
Received: by pfbu66 with SMTP id u66so66039145pfb.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 11:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EUuD1qmk9TIAu3WSg0qDBcFwCLCdNMQhLErfTaDd1Vo=;
        b=INTxZU9m6iMiy/RhR/xY8CIcQuOj9Npn3VXiZXI3Fsg4kRfEkZj7IY5atxkOetiFgR
         NYPCBTaIobFHuJqYdsRzsriQN8svwHyo2gQwasBJHeYHvVSgoUwKOfZSjykqVPSh0jpz
         p9+Qe0CQjMj6IE3IHKLYu2vMc19z2wvflCQ4htGLb7aWryfIxDnMtY9cpGjDrHafCcDc
         mkFoq8gv6GIHqGXqierZ4VtLnvwagJ0S6UE638jEMHiP7rJ8Egp5rIpcCquS2hYxuQkH
         GsbyOzRtjmKarfJ0/GvIHmvFxZ54xXoBhLlSaVk59QGSZ+pQ44BgcMTb3I1bSV+hn50k
         yweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EUuD1qmk9TIAu3WSg0qDBcFwCLCdNMQhLErfTaDd1Vo=;
        b=AqjO/eTmbnlryhmP4WBi+Heh1sy9lTytjiqw/ltdHb/WYsntbYd9A9fqZbFmAurViO
         mpc1bkv4CJ1NbmxFm4ibbPxBi1aefudYfYIWsPxCuAmZOH8y+zs92ih3Pkz+Y2YOW0yp
         paMahWFrjYQL3toJOZqCGYwbZHiASenmR9qN5OZoOh0Nrh0I8q5TS+0bWOzuRgewJQ4V
         KXy+is1Y6mAA3vfDoVyiv/UAdl4gVNEE+82UsoozqKCF7ayp4jVvZ8t1YQc4nKclUg0G
         jLKWALrwPxFBE8Onl7HSszA2y3rRbp2P6wPzlpSziZ0Md0vF0uOlfqRs/I526DOrf16P
         sawA==
X-Gm-Message-State: ALoCoQmZt+3Y9V4iJ2DIBBtUmtr5UElEyXOFznc6zTERpe0GKk4rC9QblYkBgZ0Pl02NVeGPCV4bjD1PVPGHalyYcbnmPdTdHA==
X-Received: by 10.98.72.14 with SMTP id v14mr26101796pfa.159.1450121853699;
        Mon, 14 Dec 2015 11:37:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a894:af1d:9081:95fb])
        by smtp.gmail.com with ESMTPSA id f67sm44112512pfd.9.2015.12.14.11.37.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 11:37:32 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450121838-7069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282390>

The new call will read from a file descriptor into a strbuf once. The
underlying call xread_nonblock is meant to execute without blocking if
the file descriptor is set to O_NONBLOCK. It is a bug to call
strbuf_read_once on a file descriptor which would block.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strbuf.c | 11 +++++++++++
 strbuf.h |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index d76f0ae..b552a13 100644
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
index 7123fca..c3e5980 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,6 +367,14 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 
 /**
+ * Returns the number of new bytes appended to the sb.
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
2.6.4.443.ge094245.dirty
