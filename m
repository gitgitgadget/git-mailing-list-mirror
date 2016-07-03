Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5697220FCF
	for <e@80x24.org>; Sun,  3 Jul 2016 07:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbcGCH6b (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 03:58:31 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55374 "EHLO
	homiemail-a21.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849AbcGCH63 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2016 03:58:29 -0400
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id 496A9300074;
	Sun,  3 Jul 2016 00:58:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=novalis.org;
	 bh=mZEFoge9BJ2/pSK2u0oyrhQ+Q6A=; b=LKoxMMvVO2YwkzprABf9Oh2UXGLv
	x484+o8hV0MiWTR0yVqaoF9NUuvh8mZX5poIktH6lVkVbz88T8jotOwgyOdwr7N9
	I0dZ/DLLyp6bf3554V/0kXVQWyNiziy08ClckwwVDNtEj+aNCFmCJJmm7/pXYCR6
	HQCorwI3VAUn7s8=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 8F997300061;
	Sun,  3 Jul 2016 00:58:28 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v14 02/21] pkt-line: add gentle version of packet_write
Date:	Sun,  3 Jul 2016 03:57:54 -0400
Message-Id: <1467532693-20017-3-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

packet_write calls write_or_die, which dies with a sigpipe even if
calling code has explicitly blocked that signal.

Add packet_write_gently and packet_flush_gently, which don't.  Soon,
we will use this for communication with git index-helper, which, being
merely an optimization, should be permitted to die without disrupting
clients.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.9.1

