Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83277209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 20:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941131AbcLMU4i (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:56:38 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36432 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934275AbcLMU4e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:56:34 -0500
Received: by mail-pf0-f171.google.com with SMTP id 189so19956655pfz.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rKw9UONt/QE8uZMa22IML9UyoCByngzmG2B+mb5DAfw=;
        b=lesYzDR0apUi/kDIOxmLA1pVDaKAQvc01lpb+wLidqCvK0xFN0gNIMFUucy00KibZR
         C1vtd1nyzUMzMFvOtuY9hxb7WAyKirSdY4gYuc8+unvUYaSQ42k6XcLCM7pUURxuie6/
         F/56OVbTz5CjjXakx3Vbn8eYXquaWHfyqTYhhjgah+rRZX8iLhOamHgX5PwQtwh1UlHK
         6j0gQ2r5U3P/mRccNzTSHv16vG5YF+BSPm/hYpPqlRmXd+KzY21pEXL5NsoIrx+/NPS6
         EBSFYBGOz31MYxn16EzlFlkRZxYcHxuqKq/QMSTtz9OyX5QFv4QmAMAXf2+dImFulF3S
         G2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rKw9UONt/QE8uZMa22IML9UyoCByngzmG2B+mb5DAfw=;
        b=C6zGJ3ZcL73dzzEncN5zg2bAvL2lr6qkd6gmBlAzgYm764Xso9qazoNcO/iHqXGt68
         +CjbyL2IXSzGXdMAbn4ZbYx7Hfea43q0UPm2QyTLjJ2JwcRgLcdfP2wC7wXIEIR4Nntc
         M9PfUcpIxVLz0P8yzhVP+BtXi3+OBFsECVoWUcuQbUvgjHqLY5VfyQd/fWgMC/qKJeTU
         DNJiU3PVheQ5cqpCOo+qK5v8dHr9hKwxUZtE5z5Ir1iu7H5MaODcOvRRztdz88C5wX/n
         8qfdJshdruixLIpQlT8Biuxukplw9hr3AkPxs76nlwyFPcOe/VMp1GTlIJ1xao+vIYaj
         Gtmw==
X-Gm-Message-State: AKaTC00ty8iIuXf91rNsip7R0gqd6Zosj0QJDhFlif7+DGcegnX2YqgbFOm6/rVPr8SeXGor
X-Received: by 10.84.167.168 with SMTP id d37mr46561434plb.71.1481662592508;
        Tue, 13 Dec 2016 12:56:32 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:5b5:8785:ab45:d22f])
        by smtp.gmail.com with ESMTPSA id c2sm81881480pfl.66.2016.12.13.12.56.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 12:56:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/5] submodule: modernize ok_to_remove_submodule to use argv_array
Date:   Tue, 13 Dec 2016 12:56:19 -0800
Message-Id: <20161213205622.841-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161213205622.841-1-sbeller@google.com>
References: <20161213205622.841-1-sbeller@google.com>
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
2.11.0.rc2.35.g26e18c9

