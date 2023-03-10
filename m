Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D8C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 21:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjCJVtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjCJVsp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 16:48:45 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C33D14DA15
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:45:51 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-17786581fe1so71280fac.10
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678484720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtI7nTfb8j3NoDb66xBksm0596lFjzWjajZdFZ7jANA=;
        b=TWVPlmvvlb8IqY7TZcq3cbBvT1aLJVTFOtK/TFgMIMubrdQ8u3BMl2OYp/Ij6v3ydt
         PpbplqJ5Vfz+h3vF1X8QaCtqCEZWrTvm8EXGjoas+dlHzNVwRKee+8tI0v4Kx8u1J6Nt
         imGPgUtE9MgCYM3Jxbk47tFZhrC+goF2wVROduAOzpKpWVV2lgjKujERBuBIlW4c935E
         EYnerArRzzVxK6aheMcquBR7hNdJop1ErzkEfnHSLpuOUfgeDb5yKbhzRVQSCxwiPhAX
         T4ODa4vZAGi7kMotRPqq7J+O0dcjcJZwmRguMyMdrNNC4H1HVJts3xS+pG0gxYi01KYe
         Ql2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtI7nTfb8j3NoDb66xBksm0596lFjzWjajZdFZ7jANA=;
        b=YkDjidw1snpQx2SYzNAXwaJ6nA+nwKgetRShk7S/3RXXnQrvbm/8SwvciD4cmDIpKj
         GyEEWAclSlXJLuw2mu+QGGvSHpsD0E7s9D7sh4su0eq8LNwPw4UrkHh/MvXZyCu56oJp
         bvJaSv8dWqlsL1cJlibWMDnlHu73Ri11iPCSxzBjk431usXkmgTfpwIPj8D15rZMLljj
         JEJHxaqw1mhooOeWDfWRxr9Da9f4jTlLqeK0r3CGrragSl4b47s4jbByOGdlraK5T2zy
         zeuVq0hil2N3Twk44EHLrcp7n5brl16CEL4LmAtW9eUyDQCjVvLqNmkxXYSzXjZLwXG8
         3jBA==
X-Gm-Message-State: AO0yUKUJ1pufQiLGWV9svI0UGuGzT7ouStHzhBcUk0WqykK5sO2xg091
        5APU1HrZho5+69/9QG24QEBHX882Ll8=
X-Google-Smtp-Source: AK7set+7vwrj6Dnytu0fF1EGADP7vF1bemoP9tar3tQoBf9NuYBxv3gdXNNpzHQpptuUuKIZ1Hlsxg==
X-Received: by 2002:a05:6870:eca8:b0:172:4d65:c883 with SMTP id eo40-20020a056870eca800b001724d65c883mr1785607oab.28.1678484720564;
        Fri, 10 Mar 2023 13:45:20 -0800 (PST)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e81-20020a4a5554000000b0051aa196ac82sm412405oob.14.2023.03.10.13.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:45:19 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 1/3] branch: add new 'tail' concept
Date:   Fri, 10 Mar 2023 15:45:13 -0600
Message-Id: <20230310214515.39154-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.1.gf652911b76.dirty
In-Reply-To: <20230310214515.39154-1-felipe.contreras@gmail.com>
References: <20230310214515.39154-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'tail' of a branch points to the first parent commit of the branch
when it was created.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 branch.c                  | 12 ++++++++++++
 branch.h                  |  1 +
 builtin/clone.c           |  1 +
 t/t1514-rev-parse-tail.sh | 23 +++++++++++++++++++++++
 4 files changed, 37 insertions(+)
 create mode 100755 t/t1514-rev-parse-tail.sh

diff --git a/branch.c b/branch.c
index e5614b53b3..e43a164ddb 100644
--- a/branch.c
+++ b/branch.c
@@ -234,6 +234,16 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 	return 0;
 }
 
+void install_branch_base(const char *local, const struct object_id *tail)
+{
+	struct strbuf ref = STRBUF_INIT;
+
+	strbuf_addf(&ref, "refs/tails/%s", local);
+	update_ref(NULL, ref.buf, tail, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+
+	strbuf_release(&ref);
+}
+
 /*
  * Used internally to set the branch.<new_ref>.{remote,merge} config
  * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
@@ -623,6 +633,8 @@ void create_branch(struct repository *r,
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
+	install_branch_base(ref.buf + 11, &oid);
+
 cleanup:
 	strbuf_release(&ref);
 	free(real_ref);
diff --git a/branch.h b/branch.h
index ef56103c05..f020d5be5d 100644
--- a/branch.h
+++ b/branch.h
@@ -142,6 +142,7 @@ void remove_branch_state(struct repository *r, int verbose);
  */
 #define BRANCH_CONFIG_VERBOSE 01
 int install_branch_config(int flag, const char *local, const char *origin, const char *remote);
+void install_branch_base(const char *local, const struct object_id *tail);
 
 /*
  * Read branch description
diff --git a/builtin/clone.c b/builtin/clone.c
index 65b5b7db6d..62afcff2ba 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -624,6 +624,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
 			install_branch_config(0, head, remote_name, our->name);
+			install_branch_base(head, &our->old_oid);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(the_repository,
diff --git a/t/t1514-rev-parse-tail.sh b/t/t1514-rev-parse-tail.sh
new file mode 100755
index 0000000000..da8e9ceef1
--- /dev/null
+++ b/t/t1514-rev-parse-tail.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='test <branch>@{upstream} syntax'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo one > content &&
+	git add content &&
+	git commit -m one &&
+	git checkout -b test master &&
+	echo two > new &&
+	git add new &&
+	git commit -a -m two
+'
+
+test_expect_success 'test tail creation' '
+	git rev-parse refs/tails/test > actual &&
+	git rev-parse master > expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.40.0.rc2.1.gf652911b76.dirty

