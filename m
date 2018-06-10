Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6251F517
	for <e@80x24.org>; Sun, 10 Jun 2018 15:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeFJPNP (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 11:13:15 -0400
Received: from p3plsmtpa06-02.prod.phx3.secureserver.net ([173.201.192.103]:35040
        "EHLO p3plsmtpa06-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753375AbeFJPNO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 11:13:14 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2018 11:13:11 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id S1uNfeU0REJZQS1ujfyRGe; Sun, 10 Jun 2018 08:05:55 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v8 1/3] http-backend: cleanup writing to child process
Date:   Sun, 10 Jun 2018 18:05:19 +0300
Message-Id: <20180610150521.9714-2-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-Reply-To: <20180610150521.9714-1-max@max630.net>
References: <20180610150521.9714-1-max@max630.net>
X-CMAE-Envelope: MS4wfAuL4e9pFsY+V+fOoPKWqTWTd6FpKlyR4nE3O0d2tPEV7TP1G4mCJHyGYmrgWy98MihrNkNUn8KNuvdoT56RtDViI7iHn6tVQedq8mY7dOtmSBN05pCE
 FCuOGqKtvtYuN6emyselkF+WtI/rjnadem3eADB5ywdsr1iwbjDWYwe1u8nju1/RCUqtQLyfkPBuq1eS1Z4Yp2HWqBH2R+uF8ozzKe4dz3xGX1/tdKFPM3IU
 ILxYrusMAGGyrvWSbm4Zf7uRarA9FG9+faUKFdUFOjrxvpgCA+PfSHj6+z7fRayxKKk7xSJ8Rgm7VB3X2L8JUsAAuweOoukm+ltDkqG2XfAQAup4tw92Bo9W
 lNzu8AJfEro7eZwqK6rwJ+M4CZfbQmLoJxm1UkKWOoCIPoc/dhs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As explained in [1], we should not assume the reason why the writing has
failed, and even if the reason is that child has existed not the reason
why it have done so. So instead just say that writing has failed.

[1] https://public-inbox.org/git/20180604044408.GD14451@sigill.intra.peff.net/

Signed-off-by: Max Kirillov <max@max630.net>
---
 http-backend.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 88d2a9bc40..206dc28e07 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -278,6 +278,12 @@ static struct rpc_service *select_service(struct strbuf *hdr, const char *name)
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
@@ -360,9 +366,8 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
 				die("zlib error inflating request, result %d", ret);
 
 			n = stream.total_out - cnt;
-			if (write_in_full(out, out_buf, n) < 0)
-				die("%s aborted reading request", prog_name);
-			cnt += n;
+			write_to_child(out, out_buf, stream.total_out - cnt, prog_name);
+			cnt = stream.total_out;
 
 			if (ret == Z_STREAM_END)
 				goto done;
@@ -381,8 +386,7 @@ static void copy_request(const char *prog_name, int out)
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

