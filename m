Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7621FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934779AbcLNWlV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:41:21 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35833 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934162AbcLNWlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:41:11 -0500
Received: by mail-pf0-f172.google.com with SMTP id i88so5434457pfk.2
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rKw9UONt/QE8uZMa22IML9UyoCByngzmG2B+mb5DAfw=;
        b=egX55fiZj1x7t+MqwkLGgSDDRZkpIVumnOavK0aZGJtx0ZVSR2DuVbLuuSqw0w6XxU
         jUPM0f6Czozec05Ri9YVHg/OBhAqn+HIYpuPXazKKnvwmJeR9ktILqEQrmSBPkgqbUn+
         u87XBVn4wB2HY2Yk8yxep5U29G3vdwLwWyXEMWFiPVDXtKGxJaqmzpLXdVxcMO127RpH
         lzEnijfly5fgAfWE8uLvwkTmejhTeCk0R7oKJ4GSKdxoGv+AetwsFPdCqWZj8oEa+KRA
         9tCGH3Mrx7AjD8cqzL/p3YF7JTebldwDPbmEqECyaBRn65ssYAr52jMTCyyYOtA3oq04
         EMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rKw9UONt/QE8uZMa22IML9UyoCByngzmG2B+mb5DAfw=;
        b=OftW4psgTN1H5enDvW1omRbWpo81QAFz1+hulA8RJ6WymVMIWp5SvXBSnDqXrYb4nI
         KWbOt3YcCWk7kBgvSiXFvqO+iBiAi4Q66aHZRd2SzU7BZ5JBaif8SqTtYUPNChKXPMMC
         XjM1/wqR/5TP7Dw+N+P2JG8MzYOYS1tBJBokxhaxRC74sA9lWLKJY5XdFBjqBwDH7P1A
         PW2hOOgyMBg2Bf0hAWYDdTsGuyg/vmbZCgjC5mjfgfZK1FFvyh3rVQ6PT3uDBlM6AD+f
         QWGd/SswGjbiUwwmsnoObnnoAiB+IQiabceKCgAccbalY1UrL4hjBSLrzg2a4EPJiZAJ
         6ZTQ==
X-Gm-Message-State: AKaTC02ivgBa/sxXuX8lNa4kBS/D1auL/geeHsJAzAz7gsp9A99+tX4RjW3I6nccYugp16te
X-Received: by 10.84.128.195 with SMTP id a61mr212096263pla.55.1481755270962;
        Wed, 14 Dec 2016 14:41:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:8d0f:31e2:8611:d98a])
        by smtp.gmail.com with ESMTPSA id s4sm89430825pfb.55.2016.12.14.14.41.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:41:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/4] submodule: modernize ok_to_remove_submodule to use argv_array
Date:   Wed, 14 Dec 2016 14:40:59 -0800
Message-Id: <20161214224101.6211-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161214224101.6211-1-sbeller@google.com>
References: <20161214224101.6211-1-sbeller@google.com>
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

