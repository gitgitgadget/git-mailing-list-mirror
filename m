From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v2/GSoC 1/4] path.c: implement strbuf_mkpath()
Date: Fri, 18 Mar 2016 00:48:43 +0800
Message-ID: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 17:49:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agb6j-0007cU-ID
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 17:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935431AbcCQQtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 12:49:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36596 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbcCQQtE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 12:49:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id q129so12102565pfb.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oDdWe/LB3mfcrluyuSeIIeW7FQs5ya1IJrmlv0sGgYs=;
        b=khL6jL0bgarhjIYKjFlOg+RzU049TION0ZNEtK7iOhoQ9ns9ewIeXrcDb7LSqIiedF
         fTBgYi90Izvq9TluyDXz1Sla2ri1qPbk0eI1QowsYsgtdAbDFIt2hSpe7gnVTlPU+p7c
         /jWLoYpaM2tScy0Bo2rDOPKnd1DN261Wax3VAYvkrLr3qa8xzDFeC9D6N/HWgo+6FRkX
         TXVcpIpadmqTgEh18Y4eES4PbywN1YRcYzz5U1tHJXRsZJZrGtp7kzuNngWaw3avkLus
         cXbRT9YCeLsEBpIM4zn555r8j4NRTUmcvHkRGvJiPCj/BVsGTEGkFrSqs0GBcw7zM1jZ
         v8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oDdWe/LB3mfcrluyuSeIIeW7FQs5ya1IJrmlv0sGgYs=;
        b=T8OO2vFoJ4Tw/bnahfQvaffvMhaOjvtSZoXzU3HYsZt1HPY45VXr6EeGcew1fQ2cxL
         +Mr2xddrtRT5YxtYrk07q+lZRtxREMt93dglKfOcP9Fw/31SvCzs5oHJiiiYTmognzjF
         ELLBFiqgrH/vllxXA0jI7xLwQGzExNlpZwXfrlXGs+dfnnTTF/XJ+H/99BkEkO3K0P/c
         CGwJxRqX3IPB0Zcp7US6SR9sFp39f1D/2wpt36XVYtZsqG/3ZFD9SPtl77IVoI2wLKLh
         bZIIcI12wwFO1I16+mxhecHmFh0zWHx/ALoXPuQfEf6W1bMHUvvR/2GR+W4073tEfRxD
         wR2A==
X-Gm-Message-State: AD7BkJIN5EfquLniv+oeiABFz7Er9umGn8Ka0Szar2Ko5JdKH7sCI89JIWHn8JbGOQiu+Q==
X-Received: by 10.98.10.133 with SMTP id 5mr16368407pfk.75.1458233342523;
        Thu, 17 Mar 2016 09:49:02 -0700 (PDT)
Received: from localhost.localdomain (hashi.inv.dotkrnl.com. [133.130.122.94])
        by smtp.gmail.com with ESMTPSA id kw10sm14643290pab.0.2016.03.17.09.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 09:49:02 -0700 (PDT)
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289123>

Common logic of mkpath() and mkpathdup() are collected into a
new do_mkpath(). Then, based on do_mkpath(), strbuf_mkpath() is
implemented.

Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
---
 cache.h |  2 ++
 path.c  | 21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index b829410..ef843c1 100644
--- a/cache.h
+++ b/cache.h
@@ -781,6 +781,8 @@ extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 extern char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
+extern void strbuf_mkpath(struct strbuf *sb, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
 extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
diff --git a/path.c b/path.c
index 8b7e168..699af68 100644
--- a/path.c
+++ b/path.c
@@ -433,14 +433,19 @@ char *git_pathdup(const char *fmt, ...)
 	return strbuf_detach(&path, NULL);
 }
 
+static void do_mkpath(struct strbuf *buf, const char *fmt, va_list args)
+{
+	strbuf_vaddf(buf, fmt, args);
+	strbuf_cleanup_path(buf);
+}
+
 char *mkpathdup(const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	strbuf_vaddf(&sb, fmt, args);
+	do_mkpath(&sb, fmt, args);
 	va_end(args);
-	strbuf_cleanup_path(&sb);
 	return strbuf_detach(&sb, NULL);
 }
 
@@ -449,9 +454,17 @@ const char *mkpath(const char *fmt, ...)
 	va_list args;
 	struct strbuf *pathname = get_pathname();
 	va_start(args, fmt);
-	strbuf_vaddf(pathname, fmt, args);
+	do_mkpath(pathname, fmt, args);
+	va_end(args);
+	return pathname->buf;
+}
+
+void strbuf_mkpath(struct strbuf *buf, const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	do_mkpath(buf, fmt, args);
 	va_end(args);
-	return cleanup_path(pathname->buf);
 }
 
 static void do_submodule_path(struct strbuf *buf, const char *path,
-- 
2.7.3
