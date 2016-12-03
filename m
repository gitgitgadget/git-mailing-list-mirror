Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102DA1FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757187AbcLCAbC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:02 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33672 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755366AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pf0-f173.google.com with SMTP id d2so55121973pfd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wk3/kuOjoMg/8Ev9mzKYxyR+QerjEAZHFK+Zb4JtZ4Q=;
        b=GnooQPqsLpaLCuTbgAsRHfI43NiKJzptDYVAo4EzdoxsxbLcYk+ncjn8wlOiUeYdeq
         jBKsDtL08n/EJGASqFAQeQY/F73Mwo7VqHKrmYBq6F6AOf0IIlsjTjOVw5DdFFuYbjFN
         4JV5aannHlLr8tcn/rs5BDWfIfLol9skRBn490hqzy0PMpjG/AoHExCvcsKo6Tm02ADd
         8zNjcFJ9rXlQmcLynfYZ7EyrngCpgaFCoEQkvvlvOFsYyk5NwpCkr85gOz1H13PaqwWZ
         HF3zUQ21aUuK9xaYq1gSQVKT12ujr+oStOPyIqAhgOcnrLxBnUHUcL2Cb9wKSDYecFwx
         vIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wk3/kuOjoMg/8Ev9mzKYxyR+QerjEAZHFK+Zb4JtZ4Q=;
        b=D2UNYJ+ytLtsq7TA8Ab20cqXlXiMhAtb2xrmHAXQuvaBJr4tHCbpuuupNs0znLmxdL
         3NTPKMhTlho5QKAphNvARur5nU8dTJOL3u2YMs7RIHBA4IqGvLG5IpgPVxLcfULD30Z3
         S9470lojwx6lMJnITdA3OpjPi6JJRN2vXTPPXmXyzMdd7X8NQyydc+WbieFozHzFzvdr
         JLLR2tjf28X7BfC2KPVD8dN7rt+Nlgij3h2mlYTf0QpQCIF3FqtnZ7p2j+N6noIb5Hx8
         +dhTKInyYqtnRQ5ILBHHS3QDeGG9rfK/TLKEvlWJtEFSc499CjiGs3nBRC0emkxindAv
         xyOA==
X-Gm-Message-State: AKaTC00eaYlFTKN2WELEPnAVNErS5CyR61gz9SZEwTfiH48+8qm2gYABweycNhJts9WbovGX
X-Received: by 10.99.158.18 with SMTP id s18mr25714343pgd.88.1480725044906;
        Fri, 02 Dec 2016 16:30:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id y89sm10150191pfk.83.2016.12.02.16.30.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 10/17] update submodules: is_submodule_checkout_safe
Date:   Fri,  2 Dec 2016 16:30:15 -0800
Message-Id: <20161203003022.29797-11-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
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
 submodule.c | 37 +++++++++++++++++++++++++++++++++++++
 submodule.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/submodule.c b/submodule.c
index 02c28ef56b..4253f7f044 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1155,6 +1155,43 @@ int ok_to_remove_submodule(const char *path)
 	return ok_to_remove;
 }
 
+/**
+ * Check if a submodule update to a given sha1 is safe.
+ * Return 1 if it is safe, 0 when it is not.
+ *
+ * If the submodule is not populated, we need to check
+ */
+int is_submodule_checkout_safe(const char *path,
+			       const struct object_id *new_hash)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	argv_array_pushl(&cp.args, "read-tree", "-n", "-m", "HEAD",
+			sha1_to_hex(new_hash->hash), NULL);
+
+	if (!is_submodule_populated(path)) {
+		const struct submodule *sub;
+
+		/* See if we have the submodule configured already: */
+		sub = submodule_from_path(null_sha1, path);
+
+		prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+		argv_array_pushf(&cp.env_array, "GIT_DIR=%s",
+				 sub ? sub->name : path);
+		argv_array_pushf(&cp.env_array, "GIT_WORK_TREE=%s", path);
+	} else {
+		prepare_submodule_repo_env(&cp.env_array);
+	}
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.no_stdout = 1;
+	cp.no_stderr = 1;
+	cp.dir = path;
+
+	return run_command(&cp) == 0;
+}
+
 static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
diff --git a/submodule.h b/submodule.h
index 74df8b93d5..1dfcd6939b 100644
--- a/submodule.h
+++ b/submodule.h
@@ -72,6 +72,8 @@ extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
 extern int is_submodule_populated(const char *path);
 extern int submodule_uses_gitfile(const char *path);
 extern int ok_to_remove_submodule(const char *path);
+extern int is_submodule_checkout_safe(const char *path,
+				      const struct object_id *new_hash);
 extern int merge_submodule(unsigned char result[20], const char *path,
 			   const unsigned char base[20],
 			   const unsigned char a[20],
-- 
2.11.0.rc2.28.g2673dad

