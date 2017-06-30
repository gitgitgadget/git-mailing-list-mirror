Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F5F201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbdF3Ulu (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:41:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33113 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbdF3Uls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:41:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id x23so40059850wrb.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bHS5Pdb8SI4GGUnimmXY+CMapm19oZUoxjTZFCeoQJg=;
        b=o8rRj0xxVZFb+JfbqxjyAC/IE3h7unfqo+z1cv+crJYHxaOaE2Ol7XZxkBe/wdiid5
         sbxj0ttMd72/Qt70NaxfMnj3nbpA00eN5EN+H1H+yrvXwoKLjpoS9D9lq6ok7VBAIzEI
         Td/Wew7Nw494wXW8A8C2dUNT47FGqhTouTPguHPmdordLOW4oAKJbxIPb0Yusqcyoa/u
         rKQrw3sgvv3tvaIj6GRrv4NVMcmhhNPIlBuo8GPrzGW622fsqLDlupQFf76qSoMcd5fy
         2EGhxA2bUdS8ZnJtstcVT8pj5eEmhP7YuLdwzvExYgKFwjfJU516Umf6rmbm5WbUQMyd
         4iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bHS5Pdb8SI4GGUnimmXY+CMapm19oZUoxjTZFCeoQJg=;
        b=Ha/14jTNRbZi0XeCPiSLW17nrr3D5+5lEQWKE1yUlxuviA2hbGsuQksdUz0SjwCfCt
         bk0NIVvdjWXv9NCedu9s6eTKIC4zIupAm8Lo0k0Z5CvELIQD9DsbJWgVg6N0PD2Ft7mU
         5go3ql6kdY+8neqMfPUM5y77E8ruYmdBUbYbt6pZQ5KcMIj4gm3T140JzuB8I0g58iSo
         beprx4N+Ub5mCyIq0bTPqdJTf0Zt/LgKvB7WXnMmmS5PGmT6bdzQQiiSCc5GAoUfWHSn
         uxX77yImrTpcONKFtc1DW1KylotCLN585t46Cj+ns67gH/H2wHmxTWgAE/FzaHZUjPMw
         BIew==
X-Gm-Message-State: AKS2vOzMHi/dPm2LstMOoWw5eH1QWat3ZD+QdQorU4U4VUwPR5BtqDj9
        2K7bkSZdDr4qDyYY
X-Received: by 10.223.128.177 with SMTP id 46mr16111251wrl.150.1498855297096;
        Fri, 30 Jun 2017 13:41:37 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4C89.dip0.t-ipconnect.de. [93.219.76.137])
        by smtp.gmail.com with ESMTPSA id v144sm10648239wmv.27.2017.06.30.13.41.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:41:36 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v9 6/7] convert: refactor capabilities negotiation
Date:   Fri, 30 Jun 2017 22:41:27 +0200
Message-Id: <20170630204128.48708-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170630204128.48708-1-larsxschneider@gmail.com>
References: <20170630204128.48708-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code to negotiate long running filter capabilities was very
repetitive for new capabilities. Replace the repetitive conditional
statements with a table-driven approach. This is useful for the
subsequent patch 'convert: add "status=delayed" to filter process
protocol'.

Suggested-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/convert.c b/convert.c
index e55c034d86..d13e505dfb 100644
--- a/convert.c
+++ b/convert.c
@@ -507,7 +507,7 @@ static struct hashmap subprocess_map;
 
 static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
-	int err;
+	int err, i;
 	struct cmd2process *entry = (struct cmd2process *)subprocess;
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
@@ -515,6 +515,14 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 	struct child_process *process = &subprocess->process;
 	const char *cmd = subprocess->cmd;
 
+	static const struct {
+		const char *name;
+		unsigned int cap;
+	} known_caps[] = {
+		{ "clean",  CAP_CLEAN  },
+		{ "smudge", CAP_SMUDGE },
+	};
+
 	sigchain_push(SIGPIPE, SIG_IGN);
 
 	err = packet_writel(process->in, "git-filter-client", "version=2", NULL);
@@ -533,7 +541,15 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 	if (err)
 		goto done;
 
-	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
+	for (i = 0; i < ARRAY_SIZE(known_caps); ++i) {
+		err = packet_write_fmt_gently(
+			process->in, "capability=%s\n", known_caps[i].name);
+		if (err)
+			goto done;
+	}
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
 
 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
@@ -545,16 +561,15 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 			continue;
 
 		cap_name = cap_list.items[1].string;
-		if (!strcmp(cap_name, "clean")) {
-			entry->supported_capabilities |= CAP_CLEAN;
-		} else if (!strcmp(cap_name, "smudge")) {
-			entry->supported_capabilities |= CAP_SMUDGE;
-		} else {
-			warning(
-				"external filter '%s' requested unsupported filter capability '%s'",
-				cmd, cap_name
-			);
-		}
+		i = ARRAY_SIZE(known_caps) - 1;
+		while (i >= 0 && strcmp(cap_name, known_caps[i].name))
+			i--;
+
+		if (i >= 0)
+			entry->supported_capabilities |= known_caps[i].cap;
+		else
+			warning("external filter '%s' requested unsupported filter capability '%s'",
+			cmd, cap_name);
 
 		string_list_clear(&cap_list, 0);
 	}
-- 
2.13.2

