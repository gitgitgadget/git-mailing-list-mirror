Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B4F1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 03:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbeG0FJB (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 01:09:01 -0400
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net ([68.178.252.231]:60337
        "EHLO p3plsmtpa12-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbeG0FJB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Jul 2018 01:09:01 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id itkTfU4KgK5J2itkaflkuY; Thu, 26 Jul 2018 20:49:10 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v9 1/3] http-backend: cleanup writing to child process
Date:   Fri, 27 Jul 2018 06:48:57 +0300
Message-Id: <20180727034859.15769-2-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-Reply-To: <20180727034859.15769-1-max@max630.net>
References: <20180727034859.15769-1-max@max630.net>
X-CMAE-Envelope: MS4wfOH/pmyXlUmYh2mlgfNGEntV8Xp7o7fEGGwY6pWRVOiJaYreJT0/qd0KPFkXu3NzCOgreRN8JtWiRer18GLuY4woun81UHwP3UTJm8mPcO6/vQ+Gjt9l
 JcgnrTCQgIZEJ+W/Yf6EvVY+IkZAEsj/k6OK5srjKA0R8eA7xtLKKeKsXla1r+zy0Tgzqg058CEwLWNsTCl8KFKJMjbHkz2J6whvmy1fMycPOdP2L8HXyPso
 0WPDZnship4rpNs+Fz8Gw0T9J9El+sPaHCTyYwvNbWkGVRCYWDF4qsiuJ6/5Gxot/3Y4vVzcaOGxffqpuAP0q2eBwX2crXQ7MGK/zloG4W9sX5ov9mevqkRj
 bodsXYXx7kTxMTsWpm2DDj0aQulsBpDjWn2xEmZ+CfQoTgKY5WUO4jU6ceL/aKnvaCGbwNnOAgszb5BCDQhLHOtL9Y7jxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As explained in [1], we should not assume the reason why the writing has
failed, and even if the reason is that child has existed not the reason
why it have done so. So instead just say that writing has failed.

[1] https://public-inbox.org/git/20180604044408.GD14451@sigill.intra.peff.net/

Signed-off-by: Max Kirillov <max@max630.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http-backend.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index adaef16fad..cefdfd6fc6 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -279,6 +279,12 @@ static struct rpc_service *select_service(struct strbuf *hdr, const char *name)
 	return svc;
 }
 
+static void write_to_child(int out, const unsigned char *buf, ssize_t len, const char *prog_name)
+{
+	if (write_in_full(out, buf, len) < 0)
+		die("unable to write to '%s'", prog_name);
+}
+
 /*
  * This is basically strbuf_read(), except that if we
  * hit max_request_buffer we die (we'd rather reject a
@@ -361,9 +367,8 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
 				die("zlib error inflating request, result %d", ret);
 
 			n = stream.total_out - cnt;
-			if (write_in_full(out, out_buf, n) < 0)
-				die("%s aborted reading request", prog_name);
-			cnt += n;
+			write_to_child(out, out_buf, stream.total_out - cnt, prog_name);
+			cnt = stream.total_out;
 
 			if (ret == Z_STREAM_END)
 				goto done;
@@ -382,8 +387,7 @@ static void copy_request(const char *prog_name, int out)
 	ssize_t n = read_request(0, &buf);
 	if (n < 0)
 		die_errno("error reading request body");
-	if (write_in_full(out, buf, n) < 0)
-		die("%s aborted reading request", prog_name);
+	write_to_child(out, buf, n, prog_name);
 	close(out);
 	free(buf);
 }
-- 
2.17.0.1185.g782057d875

