Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE002021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030205AbcKOXOZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:14:25 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34856 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964793AbcKOXOX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:14:23 -0500
Received: by mail-pg0-f42.google.com with SMTP id p66so71596683pga.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mg142RcL53K2DTy8nRis0Ti1/CHCSVTWYWarLrDtGkE=;
        b=LOImsHVUYjugDhA99s5bUVUhHqxatDjZjUpinu0k3OfgwRClUss3gSfa0+XvBpQE3Y
         BtmzbvNAB4mCUUm7G7Uut2Zux5dfRTF4ueL5iQ1GWfDuzhXnFAmtzvoE1JZhDhouxKQI
         5vsBlJiRjVJku5h8J8XpLt4IcxrAb9lt2YhGI8KOs3F3hluRs0ZYbPZgKaGg9QogHlo4
         TiJQXr2bw65qbCtqLbB9UcjVxXT7g5qqjFMy/ex8O66g9EfK3dc4DyBTmf7kULx6kcrQ
         Zkqz1VSjbDAOE8Tua8I+wX5k24UMKRIN9trmo1IfTLn+PxVvXXRE+tOD6Mv5mIn/340W
         GUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mg142RcL53K2DTy8nRis0Ti1/CHCSVTWYWarLrDtGkE=;
        b=ZQYuZEX7L9N4Nu/IaufQJ1wYsak3GgOrWTdm62MbJ8248nrACcpYGoR9DNGd1MerVR
         ZWcOrEF7m6yPOGYUMOTI/GQM6cjYGnzHCEoOG8Y2W3D2hjYRskhepaC0rUgDChOjhROy
         1dxNeFZnnoRswOCGvtZ3Ko9s6cMIlhIhhthmD0H/4PHVN2WyxAE1t8qeV4V2NQfRYjAT
         MBWI1m2xtgaAJRco0/PyhmK29mql7ilLL3xLFaClyeq0xRenuBMhic4lOktG8GjANB5A
         iEaWtryWzqq11/s4513Gb35uMhL49AdGVIVjIJVXIvsgkifQLIeMxOcs1h3gUg49Jdj8
         XaFA==
X-Gm-Message-State: ABUngveajL2KT/yWaWyGnTbb/VDJUpdGB/yS5+tctLh/3rWG8gsvH7jJ2eTIS4r2BWWc2RrB
X-Received: by 10.99.251.5 with SMTP id o5mr1142862pgh.160.1479251226684;
        Tue, 15 Nov 2016 15:07:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id 16sm46358598pfy.4.2016.11.15.15.07.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/16] update submodules: is_submodule_checkout_safe
Date:   Tue, 15 Nov 2016 15:06:45 -0800
Message-Id: <20161115230651.23953-11-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we introduce the options and flag for commands
that modify the working directory, e.g. git-checkout.

This piece of code will answer the question:
"Is it safe to change the submodule to this new state?"
e.g. is it overwriting untracked files or are there local
changes that would be overwritten?

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 22 ++++++++++++++++++++++
 submodule.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/submodule.c b/submodule.c
index 2773151..2149ef7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1201,6 +1201,28 @@ int ok_to_remove_submodule(const char *path)
 	return ok_to_remove;
 }
 
+int is_submodule_checkout_safe(const char *path, const struct object_id *oid)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	if (!is_submodule_populated(path))
+		/* The submodule is not populated, it's safe to check it out */
+		/*
+		 * TODO: When git learns to re-populate submodules, a check must be
+		 * added here to assert that no local files will be overwritten.
+		 */
+		return 1;
+
+	argv_array_pushl(&cp.args, "read-tree", "-n", "-m", "HEAD",
+			 sha1_to_hex(oid->hash), NULL);
+
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+	return run_command(&cp) == 0;
+}
+
 static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
diff --git a/submodule.h b/submodule.h
index f01f87c..a7fa634 100644
--- a/submodule.h
+++ b/submodule.h
@@ -74,6 +74,8 @@ extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
 extern int is_submodule_populated(const char *path);
 extern int submodule_uses_gitfile(const char *path);
 extern int ok_to_remove_submodule(const char *path);
+extern int is_submodule_checkout_safe(const char *path,
+				      const struct object_id *oid);
 extern int merge_submodule(unsigned char result[20], const char *path,
 			   const unsigned char base[20],
 			   const unsigned char a[20],
-- 
2.10.1.469.g00a8914

