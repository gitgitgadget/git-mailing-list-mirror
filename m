Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9F21FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 23:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935481AbcLTXU2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 18:20:28 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34154 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbcLTXUV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 18:20:21 -0500
Received: by mail-pg0-f51.google.com with SMTP id y62so25699854pgy.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 15:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7YI8kWN/YAYlY2NrgjSn7ZgPojwgy/N0IjbpAT+7oM4=;
        b=HhNT182FsXYTPbQPTHTjhrgtgEb9LINVU9G48jg2gAEs7AbZWLhx01XndtdFnS7NLo
         bFQaTGnreseWbhlHOXJJGTPlgdwt6A2VbSptQHrSDkAZCK0VHAHEDIQOLD4WOrWk0rDv
         PEpGfwHHQ5r2QzkBlf/6s6cSMJH18zvDF1FC26rwur3eYQdcz3Eg1l+LVaF94U+xYp3s
         6IDpAYv7f/gE1llmHgKlxR1fiI8t2tKlC6a5zbQJ8XCRSCRO0nTLkbRWLHMfOIfL6IPX
         Yr4l8ed2+PoB3WRZD74JBSp+/TejzjT4BGXiySQ+/2f2crINLCj+wCZ0p3hV9qjjgK2F
         pr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7YI8kWN/YAYlY2NrgjSn7ZgPojwgy/N0IjbpAT+7oM4=;
        b=aPDxyI0FSSchEsOqXPrMR5TzQSYqJIPkPqq1omKPNh625XsqD5jVrnyCtRDOLGSTIs
         YEI8OIdKOf6zuzn/LZB5JDAcX/QeHNUuk1Djr0JfFULj+JvsfcK1iWKzkBbefc/nSVmc
         DRNSOdbw/TTawvDZypYcmzbLC1pk0ZYdZ9LCIsWxLVgA03OEPY91sSIlysIf2xqrum5i
         cids8SwWMqCtszuBzxE1V8dE97uJoaundLov3TwTlyJdvvWhmMKlX4zIoOYt30LuPik+
         sFEuaklXlIA2Wb87YBq2wqs3UKkQICQ0nJSoEgFfDz6Rd7RdPhVg0MT8QKGTXVIWTurr
         GoDw==
X-Gm-Message-State: AIkVDXJAU9mKt/nsuodUyoySlSblvEKe9Y6QWl8adgAtgu8DaG6k0ERwCkMzA93tCq55Enuk
X-Received: by 10.99.0.194 with SMTP id 185mr2670485pga.111.1482276020411;
        Tue, 20 Dec 2016 15:20:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6c5b:c771:3806:a807])
        by smtp.gmail.com with ESMTPSA id 24sm41530455pfh.41.2016.12.20.15.20.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Dec 2016 15:20:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, David.Turner@twosigma.com,
        sandals@crustytoothpaste.net, j6t@kdbg.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 2/4] submodule: modernize ok_to_remove_submodule to use argv_array
Date:   Tue, 20 Dec 2016 15:20:10 -0800
Message-Id: <20161220232012.15997-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161220232012.15997-1-sbeller@google.com>
References: <20161220232012.15997-1-sbeller@google.com>
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

