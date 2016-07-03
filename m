Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B999620179
	for <e@80x24.org>; Sun,  3 Jul 2016 07:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbcGCH6c (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 03:58:32 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55380 "EHLO
	homiemail-a21.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339AbcGCH6a convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2016 03:58:30 -0400
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id F08A1300080;
	Sun,  3 Jul 2016 00:58:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=novalis.org; bh=BaY4C
	ycrSQ7oafYjd795w+Q3VOA=; b=Oy+78WCgHmamKwOQ/aqp+lQzOCngsp845tD5Y
	Bjxc0M3yOEyisEv6mLlMg2kHz69aOPV6ibl+xG5XbRfBm2AYwUCUopOtetKPJTZ5
	pQ+pICbNENFn6cu06cp3lpP3eyOxGkZcm7O8z2OaSHsa+MB1YZrhTbDw57sA0EbX
	eu+OAE=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 7729F300061;
	Sun,  3 Jul 2016 00:58:29 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Subject: [PATCH v14 03/21] unix-socket.c: add stub implementation when unix sockets are not supported
Date:	Sun,  3 Jul 2016 03:57:55 -0400
Message-Id: <1467532693-20017-4-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

This keeps #ifdef at the callee instead of caller, it's less messier.

The caller in question is in read-cache.c which, unlike other
unix-socket callers so far, is always built regardless of unix socket
support. No extra handling (for ENOSYS) is needed because in this
build, index-helper does not exist, $GIT_DIR/index-helper.sock does
not exist, so no unix socket call is made by read-cache.c in the first
place.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile      |  2 ++
 unix-socket.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Makefile b/Makefile
index 2742a69..7920609 100644
--- a/Makefile
+++ b/Makefile
@@ -1341,6 +1341,8 @@ ifndef NO_UNIX_SOCKETS
 	LIB_OBJS += unix-socket.o
 	PROGRAM_OBJS += credential-cache.o
 	PROGRAM_OBJS += credential-cache--daemon.o
+else
+	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
 endif
 
 ifdef NO_ICONV
diff --git a/unix-socket.h b/unix-socket.h
index e271aee..f1cba70 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -1,7 +1,25 @@
 #ifndef UNIX_SOCKET_H
 #define UNIX_SOCKET_H
 
+#ifndef NO_UNIX_SOCKETS
+
 int unix_stream_connect(const char *path);
 int unix_stream_listen(const char *path);
 
+#else
+
+static inline int unix_stream_connect(const char *path)
+{
+	errno = ENOSYS;
+	return -1;
+}
+
+static inline int unix_stream_listen(const char *path)
+{
+	errno = ENOSYS;
+	return -1;
+}
+
+#endif
+
 #endif /* UNIX_SOCKET_H */
-- 
1.9.1

