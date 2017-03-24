Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F871FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935077AbdCXS30 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:29:26 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36488 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965617AbdCXS3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:29:16 -0400
Received: by mail-pg0-f51.google.com with SMTP id g2so4874493pge.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lV+i54yhAY5jJeiE1kaJyiPJJ16YWNYC+Tqj4IBtI8Y=;
        b=u6dWo9xRmjLPyEPaELKv07bGIbmoS4QQRXgosfZadKg0r7/lpnDuwjx3SzWgO53dC+
         dJCTcZBA4DRQPvmNM/N9WKWBth6npXU85BoEzXFLne0Q7Y49CkthPNQYLgWlxXy/924g
         z5PHkTwVNQyaGto4WK9WcJYGqxcGHGR4xEEj5Yg2BMBCkQpFSxwyYgCOdD5lIbAfdxz6
         /k+ALpLF3Ldgspvd3TlxZipnHTd2H+QZaw97vuweFvZQAxWdhDBITf8mQLmijE8u25FQ
         31IA69b5zAkJnBXtkNVII1N/KPHfdVP2AwdKzQDXo2UdQeYqR1rJHRxb6FVWKtWyQ26e
         C/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lV+i54yhAY5jJeiE1kaJyiPJJ16YWNYC+Tqj4IBtI8Y=;
        b=iWKzOzwaqQbzlWjGsVkyaI/z9YM09xfCPUn/7EF4r/FltzEdYHfw4mc1RuWKYU/xtE
         iYyo45D+bNSuHhwIJBMEDOo4kbvouuBLQ6q+4T3O8QcRjl6BTLIfuTLx2adJJJCA8719
         OD2Z0+NBiMqP5WqSGHLhWbl8rEz7O3ZRpKqgtv06eGcaTYORWiRmoogbI2Y8ktNUI7rX
         aw3m8ZHTVlfPptH1j5mot/zO/LtjJVNXNlLP5a0Yh/bQoyljVYS9RX1EwlN1wc0tteWU
         lFH6LjqyfGaRnBVrXG8P3WfGaMysNVb50st27AcJBFTg7chaDurGmDSCyEFhx4PdIZf8
         0NkA==
X-Gm-Message-State: AFeK/H2AGxm9Rz+Xcs7ASPZHbt/ymx6CaMQl6fvdCjUlaIMiRb07hXrstQ6xOLGIb28S1S8F
X-Received: by 10.84.195.129 with SMTP id j1mr12844111pld.88.1490380149690;
        Fri, 24 Mar 2017 11:29:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id s3sm6031204pgn.55.2017.03.24.11.29.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 11:29:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] submodule.c: port is_submodule_modified to use porcelain 2
Date:   Fri, 24 Mar 2017 11:28:59 -0700
Message-Id: <20170324182902.19280-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.437.g2b7623d507
In-Reply-To: <20170324182902.19280-1-sbeller@google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'is_submodule_modified' to the new porcelain format of
git-status. This conversion attempts to convert faithfully, i.e.
the behavior ought to be exactly the same.

As the output in the parsing only distinguishes between untracked files
and the rest, this is easy to port to the new format, as we only
need to identify untracked files and the rest is handled in the "else"
case.

untracked files are indicated by only a single question mark instead of
two question marks, so the conversion is easy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0c43f9f2b1..256f15fde1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1060,7 +1060,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	}
 	strbuf_reset(&buf);
 
-	argv_array_pushl(&cp.args, "status", "--porcelain", NULL);
+	argv_array_pushl(&cp.args, "status", "--porcelain=2", NULL);
 	if (ignore_untracked)
 		argv_array_push(&cp.args, "-uno");
 
@@ -1070,11 +1070,12 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain' in submodule %s", path);
+		die("Could not run 'git status --porcelain=2' in submodule %s", path);
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
-		if ((buf.buf[0] == '?') && (buf.buf[1] == '?'))
+		/* regular untracked files */
+		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 		else
 			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
@@ -1093,7 +1094,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	fclose(fp);
 
 	if (finish_command(&cp) && !ignore_cp_exit_code)
-		die("'git status --porcelain' failed in submodule %s", path);
+		die("'git status --porcelain=2' failed in submodule %s", path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.12.1.437.g2b7623d507

