From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v3/GSoC 1/5] path.c: implement strbuf_mkpath()
Date: Wed, 23 Mar 2016 18:13:21 +0800
Message-ID: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Cc: peff@peff.net, pickfire@riseup.net, Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 11:16:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifnH-0001wb-0h
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbcCWKNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:13:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34217 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbcCWKNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:13:33 -0400
Received: by mail-pf0-f195.google.com with SMTP id n5so2390051pfn.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NOWDTdGAGEkWX18APZG6nUF5LtPQjuzU26grqjNTeu0=;
        b=yYBYbdzCV6t54xbZQhUgtRqDlQG11iuYweNtUIyb9JzTvB2JsqVgYkB19aGN8n7MEm
         y22LoWToLC0jsXrUA/tNHGaUAu36lT+yhr0Ze6qV7xuBMV47r+qoJRs0FJrlvylZbcXL
         f5MgfMH7w/t/tJBkIEdNAeq3W3dYkdXZawL8JCv1ScarDbjgS+dSABzl/alotbdVwD8c
         mtQq5lL46a0mCNiy0ZhR0Dxh6Jg0vpm9TPGBJsjOie2oVerNngD4/DI9MElyYvnV5MXy
         t0ElKoO4z90tlAVmsLJBtmY+aXOhMndO90QoH4ewoLdm7RMusoUPi6RwhQQJmwMx2zQ2
         KflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NOWDTdGAGEkWX18APZG6nUF5LtPQjuzU26grqjNTeu0=;
        b=hS1iQhcjZyZwqNwYW367LrLcKGnCV1Yza1qHU4reiuhT4LlHp+bMsxBmDLNyozBEMK
         L3GWtDJ2kZ19ELtxjuPT/SkiQ/W9pZgtFGF7RsMrp+91JD8r+WNWEhWBeJFsmwIv9z54
         6aLVP6097OlQ/U9WFHADWCY4aAzMfAwHCGYr8EXffD8BFtpQ/whCd7BjhEkPIwP/K0CB
         VLyU8EzFEYMDD+mBsJCEYn3gphl71eeJP+2iuUyCHJQwkvmxrhd9CJi5/siDRzltjTKT
         MgvpN+IP7w4K7GBRkkxUPj/0lbAiUeNTRY7bQwSs5mu9dfCbhSKZLQnwPf9kr6uxDhWn
         qnlQ==
X-Gm-Message-State: AD7BkJKFmu3gU9ECeHg1lBnS7F9yNzRWQey/xyND/2X+Gv2KTLLZu8BeLLAt1hJhNqnyLQ==
X-Received: by 10.98.71.210 with SMTP id p79mr2894703pfi.4.1458728012909;
        Wed, 23 Mar 2016 03:13:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:ae9e:17ff:fe87:5adb])
        by smtp.gmail.com with ESMTPSA id x18sm3232325pfi.42.2016.03.23.03.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 03:13:32 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289631>

There were already `mkpath`, `mkpathdup` and `mksnpath` for build
filename, but lacked a version of `strbuf_` just like `strbuf_git_path`.

It is convenient to build a path and manipulate the result later with
strbuf.

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
2.7.4
