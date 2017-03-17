Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83E720951
	for <e@80x24.org>; Fri, 17 Mar 2017 18:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdCQSnV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 14:43:21 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35032 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdCQSnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 14:43:20 -0400
Received: by mail-pg0-f47.google.com with SMTP id b129so47306424pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gnF9zLFYJbKOCdIj40XSXVxjpe1DbYGeE0wTHLY1cdA=;
        b=Sb/V9xPG0dUpqugMbejQ8ZdjTBlk4EcRm/MSfNN88VEeaUZhBGXcpBP9AvraSffAp7
         /vTQxHhU49y6K7SzGNtabHFXThtPUL9FKtovOZhlhUMDa8wRv9TGBBr/EXZEPl63VYCQ
         lBjJCb/+PTWrAKKgGTJcsK0o5h2W5SNlfN9Qt/vSPbm8QWRddraAbERZxZAvVsAK5ilV
         Q4ovbBBV0HJkpYrrJLZJsOzrTE/9GtfQ6McEoR2H14lF2MAquaJK5f77m/sZqX8UyW0H
         MjjeUK9UlbED6a1t9oBKpnecj2B5VotjEzATrDVcfkK/4Z7UVIUOhCwXIU0cWxrToSmj
         5bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gnF9zLFYJbKOCdIj40XSXVxjpe1DbYGeE0wTHLY1cdA=;
        b=nxMEoVf+AIcaafiIYlUUscnfAMlrGY6qjWcnJd7swc/Tb69QGc4rZi1CExDl6A2ozW
         DGomcqzc/htCCpTRIwGOrqsjrhioIVvaW2MPJw7fFF7hUqKy9B02aLt+xGuRsHU1OxXG
         VXsheQHrIPrJ5e510h1ExqrfMqDidBtIOijp168Bsjzt590mE5xRg+W2eiYl8RgVl0OV
         yE/XrNAfD1haFwhci8U4YpVzzQdFQT8jCpOyvoDgFtpEb2f/UShcV3K5nVjh4A/+iO0H
         RFYQUo5xCZApxqk3z1RUgf3lPUB7MTGMUK2lb6nLErNgqegXOapDhjPg9gSYRUHPPWMm
         mNtQ==
X-Gm-Message-State: AFeK/H3NJDqJnzV0guO1GASDGOcbnCVk5PAiRLx+kYG+OJ5SyNN6OkJxzxARY0kBLa3otBLb
X-Received: by 10.98.30.199 with SMTP id e190mr18747057pfe.205.1489776123069;
        Fri, 17 Mar 2017 11:42:03 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 73sm18209216pfh.56.2017.03.17.11.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 11:42:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        rahul.bedarkar@imgtec.com
Subject: [PATCH 2/2] grep: fix builds with with no thread support
Date:   Fri, 17 Mar 2017 11:41:55 -0700
Message-Id: <20170317184155.128674-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317184155.128674-1-bmwill@google.com>
References: <20170317182403.GA110341@google.com>
 <20170317184155.128674-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0281e487fd91 ("grep: optionally recurse into submodules")
added functions grep_submodule() and grep_submodule_launch() which
uses "struct work_item" which is defined only when thread support
is available.

The original implementation of grep_submodule() used the "struct
work_item" in order to gain access to a strbuf to store its output which
was to be printed at a later point in time.  This differs from how both
grep_file() and grep_sha1() handle their output.  This patch eliminates
the reliance on the "struct work_item" and instead opts to use the
output function stored in the output field of the "struct grep_opt"
object directly, making it behave similarly to both grep_file() and
grep_sha1().

Reported-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9304c33e7..3f1251bab 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -538,7 +538,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	int status, i;
 	const char *end_of_base;
 	const char *name;
-	struct work_item *w = opt->output_priv;
+	struct strbuf child_output = STRBUF_INIT;
 
 	end_of_base = strchr(gs->name, ':');
 	if (gs->identifier && end_of_base)
@@ -593,14 +593,16 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	 * child process.  A '0' indicates a hit, a '1' indicates no hit and
 	 * anything else is an error.
 	 */
-	status = capture_command(&cp, &w->out, 0);
+	status = capture_command(&cp, &child_output, 0);
 	if (status && (status != 1)) {
 		/* flush the buffer */
-		write_or_die(1, w->out.buf, w->out.len);
+		write_or_die(1, child_output.buf, child_output.len);
 		die("process for submodule '%s' failed with exit code: %d",
 		    gs->name, status);
 	}
 
+	opt->output(opt, child_output.buf, child_output.len);
+	strbuf_release(&child_output);
 	/* invert the return code to make a hit equal to 1 */
 	return !status;
 }
@@ -641,19 +643,14 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 	} else
 #endif
 	{
-		struct work_item w;
+		struct grep_source gs;
 		int hit;
 
-		grep_source_init(&w.source, GREP_SOURCE_SUBMODULE,
+		grep_source_init(&gs, GREP_SOURCE_SUBMODULE,
 				 filename, path, sha1);
-		strbuf_init(&w.out, 0);
-		opt->output_priv = &w;
-		hit = grep_submodule_launch(opt, &w.source);
+		hit = grep_submodule_launch(opt, &gs);
 
-		write_or_die(1, w.out.buf, w.out.len);
-
-		grep_source_clear(&w.source);
-		strbuf_release(&w.out);
+		grep_source_clear(&gs);
 		return hit;
 	}
 }
-- 
2.12.0.367.g23dc2f6d3c-goog

