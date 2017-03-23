Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C5620958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756725AbdCWVJg (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:09:36 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36619 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755618AbdCWVJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:09:34 -0400
Received: by mail-pf0-f176.google.com with SMTP id o126so110923757pfb.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CO0nwDrTTNI0n1OmKznCt53DPb4tROsneTx7ym5LkEA=;
        b=s9OcC6kmBYJhMV9453N9sWkewjbLsm5PIe4rr6y1VJZ1/iLihiO72LyeySyK6qrpn3
         F08QH06LPhWeAVKt6e+5BU4QLsgz0Sg3QstMsYk2REllI1Cg039tp7YdnXMYmL2ZmTRf
         HeogHVrQiA26PuHSnANZukK3J6WqR/QwwQhCfULTqEU0ArWC+fkyKr15dQ6knCg9xKs4
         5Z3p+AqwAgcUdkFeTf3gnzCPURrck27bSf+/SZGMivHKBxbcA+egcWafjK2rsSuvWktt
         Yd/hBaD8aDdBJqWlr3nAv2F09Vfm6+uCMEGVvUnmGeGW+Ta7B2dP9g9u+DmTRxjZt/Ji
         l7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CO0nwDrTTNI0n1OmKznCt53DPb4tROsneTx7ym5LkEA=;
        b=Db84r7+QsKsWbUJ0y0GNeuB9Rxob3EDcXBlNSPABaoebYQW0fMNvFh5qi+rVrxI19v
         TJ/VGNyekPxNJj6vwVYOUKJ3zvnDGBXZc7KiMJGE1Tz3R7mvyYVs2Y0Zd9f16CyEB46h
         GSCyye1Z+Q4gPOtgS8uAy78WzPoTpkCJeep03tAaAXRo1/HaFw7zIv2kpn5wkSw+V3vJ
         T9SNXquLyqoicroLkcbbJxJ+Bmby1i8rfc+5eBYQrkBnbOdhRqOuTyh5gI7BYpf5eOHp
         3+icvdvyzbOxVYYgFuRASLO2/7k/3wGNnBGEYMByCEHayiuvBsPIHBul3l8JEFXv/tur
         zUow==
X-Gm-Message-State: AFeK/H0PiWOcrAdnVpGXMtXw6tZmMDMANagamFbjmg2JhGdNbCo65zf+ME00qvBncb6ktSwU
X-Received: by 10.84.222.4 with SMTP id w4mr6253720pls.159.1490303368251;
        Thu, 23 Mar 2017 14:09:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id y64sm200527pfy.3.2017.03.23.14.09.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 14:09:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/8] submodule.c: port is_submodule_modified to use porcelain 2
Date:   Thu, 23 Mar 2017 14:09:17 -0700
Message-Id: <20170323210924.26818-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323210924.26818-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323210924.26818-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'is_submodule_modified' to the new porcelain format of
git-status.

As the old porcelain only reported ' M' for submodules, no
matter what happened inside the submodule (untracked files,
changes to tracked files or move of HEAD), the new API
properly reports the different scenarios.

In a followup patch we will make use of these finer grained
reporting for git-status.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 53 ++++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3200b7bb2b..d355ddb46b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1041,17 +1041,9 @@ int fetch_populated_submodules(const struct argv_array *options,
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
-	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *argv[] = {
-		"status",
-		"--porcelain",
-		NULL,
-		NULL,
-	};
 	struct strbuf buf = STRBUF_INIT;
 	unsigned dirty_submodule = 0;
-	const char *line, *next_line;
 	const char *git_dir;
 
 	strbuf_addf(&buf, "%s/.git", path);
@@ -1066,42 +1058,45 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	}
 	strbuf_reset(&buf);
 
+	argv_array_pushl(&cp.args, "status", "--porcelain=2", NULL);
 	if (ignore_untracked)
-		argv[2] = "-uno";
+		argv_array_push(&cp.args, "-uno");
 
-	cp.argv = argv;
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain' in submodule %s", path);
+		die("Could not run 'git status --porcelain=2' in submodule %s", path);
 
-	len = strbuf_read(&buf, cp.out, 1024);
-	line = buf.buf;
-	while (len > 2) {
-		if ((line[0] == '?') && (line[1] == '?')) {
+	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
+		/* regular untracked files */
+		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				break;
-		} else {
-			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-			if (ignore_untracked ||
-			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
-				break;
+
+		/* regular unmerged and renamed files */
+		if (buf.buf[0] == 'u' ||
+		    buf.buf[0] == '1' ||
+		    buf.buf[0] == '2') {
+			if (buf.buf[5] == 'S') {
+				/* nested submodule handling */
+				if (buf.buf[6] == 'C' || buf.buf[7] == 'M')
+					dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+				if (buf.buf[8] == 'U')
+					dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+			} else
+				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
-		next_line = strchr(line, '\n');
-		if (!next_line)
-			break;
-		next_line++;
-		len -= (next_line - line);
-		line = next_line;
+
+		if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED &&
+		    dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+				break;
 	}
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die("'git status --porcelain' failed in submodule %s", path);
+		die("'git status --porcelain=2' failed in submodule %s", path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.12.1.438.gb674c4c09c

