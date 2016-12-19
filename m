Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D7A1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbcLSX2s (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:28:48 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:34693 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932990AbcLSX2r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:28:47 -0500
Received: by mail-io0-f170.google.com with SMTP id p42so166234411ioo.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7YI8kWN/YAYlY2NrgjSn7ZgPojwgy/N0IjbpAT+7oM4=;
        b=dii8zB6QSnGlWwaBnKM1NdZwceAPQxFZiJTqNpZSYs2+H4zTPeAY3QnWziueFKx8a+
         wqfk21k1APSYp9sH/zYjqsWuUX/35jWLaPzs5aI1DH1b1T4/oYFYYqWVD/6k/MKNAOLZ
         Pw4A+GzT8a6wzqCPbyXOw8ws6eEse7Mj8qWqLXemyvMfeDCk54rgF2DCvPOKGveRc26v
         XGb+83QEb0uw/8ER+sy9Da+5Xoe5YvukLeXk5sZkdknjSaNVVnamO7/acXaVSfnO6aEG
         iSL1WfLGdkjVsdZ9RqZE16RxDyIVWXWLknH8PnSxMpSKXR8z3N/uzMtwgjCijfNHZ7B0
         UWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7YI8kWN/YAYlY2NrgjSn7ZgPojwgy/N0IjbpAT+7oM4=;
        b=L5Mfj5JQr1ufwmK7+uYfZ1YPZbu9ad9+5A/S2HQbowxt6WwerL77nBAenbTxkX1g+g
         IqXDHnBWLVUP23uMZTLmoJq+ZsiDlexatFCZPgn1AD5Np1GB+Iecd9jR4svtcyWze59Y
         N8vh6E9HTdZ+jatocQaoXV5wtZwFERQ4UP1rgYcMqwVTJ+H2cCE+rE9Z5/ULii5M146K
         SOt9YyuVQvvHcbu4k0AaEjpLrDLawjJSiB5GPf9bqoZ1n0B8NfUg8H4FGERQtXtVeWEW
         cSX0r1nO4XHcaipdrNAUfvnT/jYkwimOfuJBYu4LiH9h//XGVmtRwYisgLUQMaIUjQ5Y
         AbfA==
X-Gm-Message-State: AIkVDXKbiZ89iqr9xi7fPWwHz3jj65LhQriwYifMsLkRts0b/8iMkiteEMqGVV+EyyKTd94e
X-Received: by 10.107.178.148 with SMTP id b142mr18733586iof.69.1482190126773;
        Mon, 19 Dec 2016 15:28:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2c2e:3e21:f7c2:2ccc])
        by smtp.gmail.com with ESMTPSA id n3sm7865355itb.2.2016.12.19.15.28.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 15:28:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        sandals@crustytoothpaste.net, David.Turner@twosigma.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/5] submodule: modernize ok_to_remove_submodule to use argv_array
Date:   Mon, 19 Dec 2016 15:28:25 -0800
Message-Id: <20161219232828.5075-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161219232828.5075-1-sbeller@google.com>
References: <20161219232828.5075-1-sbeller@google.com>
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
2.11.0.rc2.53.gb7b3fba.dirty

