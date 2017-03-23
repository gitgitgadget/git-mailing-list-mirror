Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECCA920958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933871AbdCWWeW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:34:22 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:34763 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933401AbdCWWeU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:34:20 -0400
Received: by mail-it0-f48.google.com with SMTP id y18so3317597itc.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LNJZtYU6qjAr2kvtQGSj0NVVC5guRiOXq4R3EtkD8/Q=;
        b=ecoe1tO4RN1DqRxoWHSPTFBaGDzEd7ZuVWw1hnADaOkWdMCB92JDNTiJqtATPMZvpC
         ooeZT+7enHskHnD9u+wlvtdR4I/GpMOEr7vfRoa9e7PXYWZdPTr2X8KXlxFMLRgKRLte
         HJBteMHonCHBvhCPBvvexF+E0zFwMJYxPc32Bkkgk0H4jU85SGd+SbF5KR3k/smAOiyy
         Orx+7RAq4J+pXWiHYAUJp2+ZnIK+Muy2BACtxjvGc6iBJ/bL48Pn+OfsmBuclT6Qqwi7
         lmtVJoY+y/tGOOfieL94PdalMwS40cdenH/0SeGdqU/Nv7T8NPs7KtDXEMN324Uuzd9m
         J+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LNJZtYU6qjAr2kvtQGSj0NVVC5guRiOXq4R3EtkD8/Q=;
        b=f/klUCi1QFieu3xAGbr/eaQELePdevE1/z3qocTb4ieUk/iMMLqC5uFMTmnGx6+AGf
         qXye3NT5D9fTjZpCpTtHDkepC4r6mVmVu0TV5oeebLBFxDFLBhdsAhgsSdrYdoFmSYDL
         saAGscJ5sl17hcJsrOn1l9qUl7ZT7b/yYoI0F8ZjsqaDMaAeweF6K1M6uONF6qpPjOgU
         h2126X8bX7ZbczdTfQbog5qKfbKszn8sGHxp1Xd9STO/8zdPw6qsd6DpP4rQk0Dw1547
         sbi19hLOBGP930yYEITgG+82F//F5wYj/S/RWhcYOiY1dGROTZbAkTUxNtxXxUX09EBT
         73rw==
X-Gm-Message-State: AFeK/H1sXUOQoLCXViAf/kPLHLWohQ1K3kyMiYe0F8Wd2bAKsY92sV1Cn5yYkFbDk9zwc1X6
X-Received: by 10.36.208.134 with SMTP id m128mr148268itg.44.1490308454040;
        Thu, 23 Mar 2017 15:34:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id r30sm265486ioi.56.2017.03.23.15.34.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:34:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] submodule.c: convert is_submodule_modified to use strbuf_getwholeline_fd
Date:   Thu, 23 Mar 2017 15:33:33 -0700
Message-Id: <20170323223338.32274-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323223338.32274-1-sbeller@google.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of implementing line reading yet again, make use of our beautiful
library functions.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2c667ac95a..c1b7b78260 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1041,11 +1041,9 @@ int fetch_populated_submodules(const struct argv_array *options,
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
-	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	unsigned dirty_submodule = 0;
-	const char *line, *next_line;
 	const char *git_dir;
 
 	strbuf_addf(&buf, "%s/.git", path);
@@ -1072,10 +1070,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	if (start_command(&cp))
 		die("Could not run 'git status --porcelain' in submodule %s", path);
 
-	len = strbuf_read(&buf, cp.out, 1024);
-	line = buf.buf;
-	while (len > 2) {
-		if ((line[0] == '?') && (line[1] == '?')) {
+	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
+		if ((buf.buf[0] == '?') && (buf.buf[1] == '?')) {
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
 				break;
@@ -1085,12 +1081,6 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
 				break;
 		}
-		next_line = strchr(line, '\n');
-		if (!next_line)
-			break;
-		next_line++;
-		len -= (next_line - line);
-		line = next_line;
 	}
 	close(cp.out);
 
-- 
2.12.1.438.gb674c4c09c

