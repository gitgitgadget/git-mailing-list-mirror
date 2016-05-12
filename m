From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 03/20] pkt-line: add gentle version of packet_write
Date: Thu, 12 May 2016 16:19:58 -0400
Message-ID: <1463084415-19826-4-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:20:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6B-0004k4-KA
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbcELUUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:20:34 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36145 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbcELUU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:27 -0400
Received: by mail-io0-f174.google.com with SMTP id i75so103982785ioa.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T9Lh73IdNdzeANRfYFT6feEkhEPXFcqSSlAWjgC9a2c=;
        b=utVes/nEf0aXHYtGSHip+XcuUFzjqskefTYuwP78OXutaJwjvqhxk15w8HEdjFD2Nt
         QMsZICgcma40uyW8HgkiKSbCtJshiBGQ3i/1ixDn6H5y9/1/F1cN36snwmB0qA7bvILt
         ssbP/64p8kTsTx49kNwvuD2VXOjRvF06CRnIKkC3O7QyS/tnD1cCUObQdLZwoHBftoec
         xGips6t5x7vqwEmJBZlEAmn/9yqKtHUtuCMkAtVji/lpdoC8nMX8PENjMgJl5c4Ck/vu
         ZxdPxuaGCr/EsDwiqsqbwg1zWgebETf5GJzEgP3DvJe2BI0oLrUr9S2YqBZ+W4cJNIc3
         6YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T9Lh73IdNdzeANRfYFT6feEkhEPXFcqSSlAWjgC9a2c=;
        b=JILYEPKBynCaOsJl7XwCdaIe1LWevqZTzwCrXntvQdkMFpHkJGXA1TQaX9z23MGWfE
         qrd6WwPyxA3AetOj7viXclD/GXJjZKncgP+bVp3t4wiGp5vL1xMmX8kPUyIG5Z9oRjse
         oe/cLrnA72GRDKO6hPxFUqeNhGU4LOpiLMG76K35y4O+evPlYwXTIcQZsnb44Vzn5yfC
         z1t9EHL2BxQUP+noEfmLJ9F/tRCLOKu2kaomx5+cz7+wHIXuRXTeb6JfVfwB4bl5pTbD
         SmjE9XYr+09cmw7n320B3gsvytziXtkqbkhHpICa+ds0+ORhctUN0XRmlpVZOFUMW/T3
         Tw+w==
X-Gm-Message-State: AOPr4FVMKMT8woBTs0EasotN25ksI44gNGaBVGH0JMnuSECVMdKM3o0lgASGNAwc1Zqxxw==
X-Received: by 10.107.167.206 with SMTP id q197mr9177009ioe.164.1463084426129;
        Thu, 12 May 2016 13:20:26 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294453>

packet_write calls write_or_die, which dies with a sigpipe even if
calling code has explicitly blocked that signal.

Add packet_write_gently and packet_flush_gently, which don't.  Soon,
we will use this for communication with git index-helper, which, being
merely an optimization, should be permitted to die without disrupting
clients.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 pkt-line.c | 18 ++++++++++++++++++
 pkt-line.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 62fdb37..f964446 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,12 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+int packet_flush_gently(int fd)
+{
+	packet_trace("0000", 4, 1);
+	return write_in_full(fd, "0000", 4) != 4;
+}
+
 void packet_buf_flush(struct strbuf *buf)
 {
 	packet_trace("0000", 4, 1);
@@ -130,6 +136,18 @@ void packet_write(int fd, const char *fmt, ...)
 	write_or_die(fd, buf.buf, buf.len);
 }
 
+int packet_write_gently(int fd, const char *fmt, ...)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	va_list args;
+
+	strbuf_reset(&buf);
+	va_start(args, fmt);
+	format_packet(&buf, fmt, args);
+	va_end(args);
+	return write_in_full(fd, buf.buf, buf.len) != buf.len;
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 3cb9d91..deffcb5 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -20,7 +20,9 @@
  * side can't, we stay with pure read/write interfaces.
  */
 void packet_flush(int fd);
+int packet_flush_gently(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_write_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
-- 
2.4.2.767.g62658d5-twtrsrc
