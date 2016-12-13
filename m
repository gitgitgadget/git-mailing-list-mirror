Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2595C203C1
	for <e@80x24.org>; Tue, 13 Dec 2016 01:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbcLMBlF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 20:41:05 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34524 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbcLMBlC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 20:41:02 -0500
Received: by mail-pf0-f172.google.com with SMTP id c4so15434784pfb.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 17:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/WSXSGZ9XpPNYomFXyojnWXtizyLbM8bS2vAHm0+Zbs=;
        b=TdeWNwyWvhkxUyLDgnca+1VRVvlsdnyIIiV4QjlYQg/KnMd3M/nibbDqQ+J+a5L1Qa
         I7aIKO0PV9i0Gkkwb3ac5PkSYyUQKV0dkgyazy/vx/3wkKvHSdwqr4okWhigmdEBUiX2
         nWvqY0IoIGCXsGSu9omHMzljh48tDvnKEVVMMWYzQ+i4r5YKJ/jcQbZfTG5IRDTEqiz7
         qCcaCU8NnEeuLpO0WeY3XtUUebvRqKnn3Ge3I2AJULBG2cQan/aXH7ysfCaEsdewzuMF
         zeA5rmpjEqqZmoGuB6u8Ju+KdeyIUw+ylfwOAUqtlhVNNpD4MLuE40w5zkvX03jMbKoI
         fBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/WSXSGZ9XpPNYomFXyojnWXtizyLbM8bS2vAHm0+Zbs=;
        b=MbNSXL+FEgDoMZkgECevwtCjh+qyuc/4F/Im4befQnsEL5Pj/s2kRQtrui4blpRChT
         WhMEOfkWSziocYtf9X1rtih6hRse8jgUtlTcn5LMZdNQ1g2jfRRsX0JlU8LDvnSXQNax
         h38oN2n/xIOkgcRTJXMy0pClE4/q8FI+SLykpiwP4bJxB0vlXoHvypQRVSByTkvSrN5Q
         a/iL+icu5634KOT00Jjl8c8PbQRBTus+tq2CPB6lIFnhLkMGPxRdBjveQv0yK6r8SH69
         F0fDt9+nGTT0SKgxv1kNz+hPVUfwDx4jMdgoG7Lp+z6JzAgRafHn6T5ZhtUx76gUoIH9
         gc5g==
X-Gm-Message-State: AKaTC03HIO31DkZfqfUYDken3fBIqwaH3EP11ikWEeU9OPwZIsRZ5zJIK+FhEjuDz80jVNts
X-Received: by 10.84.202.12 with SMTP id w12mr193227791pld.156.1481593261624;
        Mon, 12 Dec 2016 17:41:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id q9sm78199302pfg.47.2016.12.12.17.41.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 17:41:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] submodule: modernize ok_to_remove_submodule to use argv_array
Date:   Mon, 12 Dec 2016 17:40:51 -0800
Message-Id: <20161213014055.14268-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161213014055.14268-1-sbeller@google.com>
References: <20161213014055.14268-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of constructing the NULL terminated array ourselves, we
should make use of the argv_array infrastructure.

While at it, adapt the error messages to reflect the actual invocation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 45ccfb7ab4..9f0b544ebe 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1023,13 +1023,6 @@ int ok_to_remove_submodule(const char *path)
 {
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *argv[] = {
-		"status",
-		"--porcelain",
-		"-u",
-		"--ignore-submodules=none",
-		NULL,
-	};
 	struct strbuf buf = STRBUF_INIT;
 	int ok_to_remove = 1;
 
@@ -1039,14 +1032,15 @@ int ok_to_remove_submodule(const char *path)
 	if (!submodule_uses_gitfile(path))
 		return 0;
 
-	cp.argv = argv;
+	argv_array_pushl(&cp.args, "status", "--porcelain", "-u",
+				   "--ignore-submodules=none", NULL);
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain -uall --ignore-submodules=none' in submodule %s", path);
+		die(_("could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s"), path);
 
 	len = strbuf_read(&buf, cp.out, 1024);
 	if (len > 2)
@@ -1054,7 +1048,7 @@ int ok_to_remove_submodule(const char *path)
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die("'git status --porcelain -uall --ignore-submodules=none' failed in submodule %s", path);
+		die(_("'git status --porcelain -u --ignore-submodules=none' failed in submodule %s"), path);
 
 	strbuf_release(&buf);
 	return ok_to_remove;
-- 
2.11.0.rc2.35.g7af3268

