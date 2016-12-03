Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494401FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756435AbcLCAav (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:30:51 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34007 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pg0-f46.google.com with SMTP id x23so112892631pgx.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XkhP12AZUjGt0G6yXauPeaMmedpUYe12NYADUQgjIT4=;
        b=V/XvqPPQyJHfXTXx2MVnh7rDZD8aYBlKrV+ymfikzwIzZ8wAErUbtM7C2rbjf0vIAE
         9ZTkZP0lCyrKTAp8Szrq+z34jLlr9rffaprqDpo0pBgxrZ/FtWldtuZeHqD3vi6p9fx5
         M62Q3MKsQl688iJAk5C8IErzLbvllF336Ifg61dwToZop3MLrM7ce/5EJR0fc9lMleqV
         n4Er9oa7/u5jTfLueGM7F3+8KBQccdXVuLsw4OQ7om7feY8sJ6rhnncvus1+D80nkTfB
         buqBrGaSX9uwG4vqSs+a+cbXLkUpEK70RnMoQ46UtdwOWfpuutVnmWz0V4em3mI0UR8G
         3OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XkhP12AZUjGt0G6yXauPeaMmedpUYe12NYADUQgjIT4=;
        b=DauPwd5ExQBv4HvDqWxuJJ49qcTNvMJxfM16kE3Nv6fjJpoSn2UJ8m2FKN3q+gq8A6
         XyJrCPVmhWJLGCGUxj8mdz0m44t3sSaOvMl3uFkPo5XSgU3JQS+r9U7a7BpN4Xlpv0Vp
         Q8tv8FF9L60CjraXdhxEIGsf2eMoaoaBJfPC7cMPOenQ/Pk4YnEzaJnUB/d7Pmwxn5m6
         N1bNOkgIHXHO1gKkxmBm4MdxRw8GWReYMp+UhAQz5kot9t4ZDncrEPqDXXkJotoNtIlz
         d3EByoJD+QAtXhhU/jVLIZOJColMo11cIOvgGiKAs59lF75NyRyDcoHxpMnVUuDrCpu3
         8U9A==
X-Gm-Message-State: AKaTC00s4qtVaRcR0RUlAoTIMXGnifTrS4QIhzFr3o6wK7X5oRIHCyGx+9XmntBVVypVICQG
X-Received: by 10.84.136.164 with SMTP id 33mr101619503pll.148.1480725036249;
        Fri, 02 Dec 2016 16:30:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id l69sm10260929pfk.34.2016.12.02.16.30.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 02/17] submodule: modernize ok_to_remove_submodule to use argv_array
Date:   Fri,  2 Dec 2016 16:30:07 -0800
Message-Id: <20161203003022.29797-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of constructing the NULL terminated array ourselves, we
should make use of the argv_array infrastructure.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 66c5ce5a24..eb80b0c5ad 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1022,13 +1022,6 @@ int ok_to_remove_submodule(const char *path)
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
 
@@ -1038,14 +1031,15 @@ int ok_to_remove_submodule(const char *path)
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
+		die("Could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s", path);
 
 	len = strbuf_read(&buf, cp.out, 1024);
 	if (len > 2)
@@ -1053,7 +1047,7 @@ int ok_to_remove_submodule(const char *path)
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die("'git status --porcelain -uall --ignore-submodules=none' failed in submodule %s", path);
+		die("'git status --porcelain -u --ignore-submodules=none' failed in submodule %s", path);
 
 	strbuf_release(&buf);
 	return ok_to_remove;
-- 
2.11.0.rc2.28.g2673dad

