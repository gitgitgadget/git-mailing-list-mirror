Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99C9207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdEBBC4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:02:56 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33866 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdEBBCx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:02:53 -0400
Received: by mail-pg0-f53.google.com with SMTP id v1so52294649pgv.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N6mm5WCtw66rGKsAy60J6uKrdZC3RZjIcfGyrxm7j4s=;
        b=DNJmRhlWlWbINffN5BbGzjxgt94KFuU5AbNslT/A4+YWmoIDoxYdS+kgLfpk0kzgcN
         nEIdkq+29tVxH5BphVWRIiyVnoZV3+y9k2zIrPtyMdNMUtxYH2TLL58BjKuPbwomvGnB
         /f7C04u8dszgEe3IJaJC4LanUfC5ITzoS+7cHytdeR+W7NI9lsKBU7cyxTxfv5cQZq7i
         4gO36/pnqkrqq0SJbukBw8FP8RZ6gvC2Eqw6Z+eUjjdGUNH9HsbttwDTYUXxKTrQcAbU
         oHrVSFMTLuzoE63d79XwL25Vyji1cp5Fhgud5VKnmKZCs7xfSbZJYf9WyBV8Ho6/kdyN
         Ystw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N6mm5WCtw66rGKsAy60J6uKrdZC3RZjIcfGyrxm7j4s=;
        b=IeC41P/msrm89I+HN5OCWiokFpgC5wcJDFoH6yYB8uX28YYupNxlgRPm6ke54+W5+S
         vnXqA2ET5J5/1Dk3FoI8z1JZsM+aVzMb4P9ee/f7rj2zSiXo1f5zKzIzYrSfhzXKFTmd
         7o604wyG1PfgCtTIGfPnI+dfSeYodCV2FDcBBfj7dU10ry4bXnfS9kuYR/G3syMCPmM0
         Cq8u4E0NxJx5PS668P9y27IGySkVryGrIGSbXnYPDs984FDSHjds9C5M43A/PP3f8bPY
         1rNkOWeaecQO/6TuDyw92n7FPjqOHEJRzzcRiGmc0bx3t12ILI04cBy9Q/sqOhUZDxFD
         g4Jg==
X-Gm-Message-State: AN3rC/63NZKXC+yYc3zlF8jxKe7l6aNCHCtLXhbJVt3mW49zoDrnGAWM
        HxW4GE2GcrZqWzxT
X-Received: by 10.84.174.197 with SMTP id r63mr37598845plb.67.1493686972110;
        Mon, 01 May 2017 18:02:52 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm13532526pfa.56.2017.05.01.18.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:02:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 5/6] submodule: improve submodule_has_commits
Date:   Mon,  1 May 2017 18:02:38 -0700
Message-Id: <20170502010239.179369-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170502010239.179369-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'submodule_has_commits()' to ensure that if a commit exists in a
submodule, that it is also reachable from a ref.

This is a preparatory step prior to merging the logic which checks for
changed submodules when fetching or pushing.

Change-Id: I4fed2acfa7e69a5fbbca534df165671e77a90f22
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/submodule.c b/submodule.c
index 3bcf44521..057695e64 100644
--- a/submodule.c
+++ b/submodule.c
@@ -644,10 +644,44 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
 {
 	int has_commit = 1;
 
+	/*
+	 * Perform a cheap, but incorrect check for the existance of 'commits'.
+	 * This is done by adding the submodule's object store to the in-core
+	 * object store, and then querying for each commit's existance.  If we
+	 * do not have the commit object anywhere, there is no chance we have
+	 * it in the object store of the correct submodule and have it
+	 * reachable from a ref, so we can fail early without spawning rev-list
+	 * which is expensive.
+	 */
 	if (add_submodule_odb(path))
 		return 0;
 
 	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
+
+	if (has_commit) {
+		/*
+		 * Even if the submodule is checked out and the commit is
+		 * present, make sure it exists in the submodule's object store
+		 * and that it is reachable from a ref.
+		 */
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+
+		argv_array_pushl(&cp.args, "rev-list", "-n", "1", NULL);
+		oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
+		argv_array_pushl(&cp.args, "--not", "--all", NULL);
+
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		cp.dir = path;
+
+		if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) || out.len)
+			has_commit = 0;
+
+		strbuf_release(&out);
+	}
+
 	return has_commit;
 }
 
-- 
2.13.0.rc1.294.g07d810a77f-goog

