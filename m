Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9808F20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbcJDNAD (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:00:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36506 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbcJDNAC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:00:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so19580212wma.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zuYamZYVcFYMheUFntDThQ2ydbFA7XZFvo5NQqrUwt0=;
        b=HdPrfUdkspDhQPWSrMNF3qV0TD068FEwzvyntIK/GBaqRRQNX09ToHWeOEPfCzzVhQ
         PJdQXpZo78k+FkVoIutYjDLa21uSNa8VOI3OykhVjM3Sl6t4Nrb5vH8QDyU70fryuiJX
         +EMSOG00loyJrfJoiOG6drtB9x24xLOH/WNT9D3Xhj7oDGgmntJlArHS0VOjwWbQDl56
         zQsGa8qCCnismNmakErK8I6693YPdqXzvvcdgbMFKAsHR8Q69kIBJQHzH9gVRVlwTXiY
         fHVrJgsiXIQtl4D7sofqEYaamgjejMBg4rmGbn8mqSDvuEJLyqGOX+7X0bucGfuvVPdr
         A+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zuYamZYVcFYMheUFntDThQ2ydbFA7XZFvo5NQqrUwt0=;
        b=G+a41VfYEdo7KODZvMwqyNZxlhMYNWySAgc4thUBRuyOs+/GlxhGgH2v6U1x3INcLD
         BzjXp65TTuNdTiNwackEb0XG7ylUePrvaaw9NY7zVmbbQGbaP44pTlsIzVd7hhziwegh
         xfa1DjHRDS3jeLwp4IWVC62gVLFyoMSLGwAta+y0jN1v1chTy1OGXFEJFFXZUCows+DZ
         tUs73hu2tdbopJS1O3iwQOQ71rYa2LTcWBeFpheKAcWrzgbsC635BEhyNoIEr0SXucKt
         F9yjzHqEoYT1ko1a0jXMQ0cMsOpZY6HP9etnUvmSiaFcG6VlXHAVodX9B/oskFaGZ/Yo
         ECJQ==
X-Gm-Message-State: AA6/9RlQHvgLccK2NM+MZLZ9U9L7FQ42BkY5s1jwigrwGcbRJMtwObi4e70yidLi7BQYWQ==
X-Received: by 10.28.166.205 with SMTP id p196mr11630621wme.21.1475586000782;
        Tue, 04 Oct 2016 06:00:00 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.05.59.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 06:00:00 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 09/14] pkt-line: add packet_write_gently()
Date:   Tue,  4 Oct 2016 14:59:42 +0200
Message-Id: <20161004125947.67104-10-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write_fmt_gently() uses format_packet() which lets the caller
only send string data via "%s". That means it cannot be used for
arbitrary data that may contain NULs.

Add packet_write_gently() which writes arbitrary data and does not die
in case of an error. The function is used by other pkt-line functions in
a subsequent patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pkt-line.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 286eb09..3fd4dc0 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -171,6 +171,22 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
+static int packet_write_gently(const int fd_out, const char *buf, size_t size)
+{
+	static char packet_write_buffer[LARGE_PACKET_MAX];
+	const size_t packet_size = size + 4;
+
+	if (packet_size > sizeof(packet_write_buffer))
+		return error("packet write failed - data exceeds max packet size");
+
+	packet_trace(buf, size, 1);
+	set_packet_header(packet_write_buffer, packet_size);
+	memcpy(packet_write_buffer + 4, buf, size);
+	if (write_in_full(fd_out, packet_write_buffer, packet_size) == packet_size)
+		return 0;
+	return error("packet write failed");
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
-- 
2.10.0

