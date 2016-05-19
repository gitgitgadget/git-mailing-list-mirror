From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 03/20] pkt-line: add gentle version of packet_write
Date: Thu, 19 May 2016 17:45:40 -0400
Message-ID: <1463694357-6503-4-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:46:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VmN-0006Zn-RY
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbcESVqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:46:45 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36155 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbcESVql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:41 -0400
Received: by mail-qk0-f169.google.com with SMTP id x7so56503249qkd.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T9Lh73IdNdzeANRfYFT6feEkhEPXFcqSSlAWjgC9a2c=;
        b=YipvfjT1OgRUDsDFrGVPYT98PpEkXTzW4HfPCq3EL4iB3Tff6H0dM7I7f7zICFVMaG
         fT02urIekWb6ndCBt4PKYVKyrX60CBpfXaUwYZmiDeZ+jZeamfMXDzdhTL2VCm8A/0Mi
         buZYrxgZ4/TCS2dmWPDnJw0LyUgThasANjzwktNDpadcMD3aDUfARezxHaCgtAYOXSDF
         uSYgQpMLkBNgEfL0v3UIE1iE77kWEpd1i7ISJBRHXzlxgvGOwExuwOrHnjdw49UxbcL0
         2vYVHIfEzKsaSHv5wl4mR3NBoAbowJktckEqIQKtdhZBOuJyfmCwk7hgQnwjLVVItXdV
         +k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T9Lh73IdNdzeANRfYFT6feEkhEPXFcqSSlAWjgC9a2c=;
        b=jP6/X2f9tSIc4ASssD0tGsrf7/xkblZXyd7SfbK/ZEprSpEdf3rF7Yn8SAYbnQEwu7
         crE0dIQCPmEVzm4F3If+mByNjrvZJVSVqojc+Z/uWbD/ZL+no9RGf8GAOedL51dmeBtJ
         mYSUH3v10p/fQ/cUWnBPnPxTD+FBjNIkpqu2j4+rEUVHxJMRzlY8BRi1pobtLmcDkv+X
         jnWsbGdbAyK3GHiHW4FDI1DMjWJiZWILNOrE0AwlqgwcoyNQdjwN6nCD5Fbbkcu2v9h8
         2UAM62H/p3n9DInHJSTaQV4VPLnog/My1oKGEIT8Da06RzHdMlSgd8ZKsINETcC6Ojub
         zewg==
X-Gm-Message-State: AOPr4FU7gGnClTfgICvA/kzbjxiA5s9Pwrs4Z0ipQDQ4gCHlj+Fxz+V/pSQG+q9UvcQLpw==
X-Received: by 10.55.165.11 with SMTP id o11mr17578872qke.196.1463694400647;
        Thu, 19 May 2016 14:46:40 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295107>

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
