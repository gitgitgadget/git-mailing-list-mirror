Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95476C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKITH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKITHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:07:25 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E371F615
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:07:24 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1668020843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6Hvm7X5QIupifwNe8wpL3+8klkqRQLSnMyneZdchfs=;
        b=lkN2Kc1aM8RRX3CvMfI5zsIIhu79jydG+vK2MyMB24Bf3vE+vHmt5CHC+8lYcekOy1gc8n
        5sO+HB2COKspYCJ95AkkhK+7UxdWApWawGdATiWJ/ECDdcPp3mp/dcXl4yWLJSSQHl0Md9
        tXm/+dra4fVdZEOD3xz3i119Sq7zxXk=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Cc:     me@ttaylor.com, derrickstolee@github.com
Subject: [PATCH v3 1/2] for-each-repo: interpolate repo path arguments
Date:   Wed,  9 Nov 2022 12:07:07 -0700
Message-Id: <20221109190708.22725-2-ronan@rjp.ie>
In-Reply-To: <20221109190708.22725-1-ronan@rjp.ie>
References: <20221109190708.22725-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a quality of life change for git-maintenance, so repos can be
recorded with the tilde syntax. The register subcommand will not record
repos in this format by default.

Signed-off-by: Ronan Pigott <ronan@rjp.ie>
---
 builtin/for-each-repo.c  | 5 ++++-
 t/t0068-for-each-repo.sh | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index d45d873f57..6aeac37148 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -14,13 +14,16 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 {
 	int i;
 	struct child_process child = CHILD_PROCESS_INIT;
+	char *abspath = interpolate_path(path, 0);
 
 	child.git_cmd = 1;
-	strvec_pushl(&child.args, "-C", path, NULL);
+	strvec_pushl(&child.args, "-C", abspath, NULL);
 
 	for (i = 0; i < argc; i++)
 		strvec_push(&child.args, argv[i]);
 
+	free(abspath);
+
 	return run_command(&child);
 }
 
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 4675e85251..c6e0d65563 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -8,9 +8,11 @@ test_expect_success 'run based on configured value' '
 	git init one &&
 	git init two &&
 	git init three &&
+	git init ~/four &&
 	git -C two commit --allow-empty -m "DID NOT RUN" &&
 	git config run.key "$TRASH_DIRECTORY/one" &&
 	git config --add run.key "$TRASH_DIRECTORY/three" &&
+	git config --add run.key "~/four" &&
 	git for-each-repo --config=run.key commit --allow-empty -m "ran" &&
 	git -C one log -1 --pretty=format:%s >message &&
 	grep ran message &&
@@ -18,12 +20,16 @@ test_expect_success 'run based on configured value' '
 	! grep ran message &&
 	git -C three log -1 --pretty=format:%s >message &&
 	grep ran message &&
+	git -C ~/four log -1 --pretty=format:%s >message &&
+	grep ran message &&
 	git for-each-repo --config=run.key -- commit --allow-empty -m "ran again" &&
 	git -C one log -1 --pretty=format:%s >message &&
 	grep again message &&
 	git -C two log -1 --pretty=format:%s >message &&
 	! grep again message &&
 	git -C three log -1 --pretty=format:%s >message &&
+	grep again message &&
+	git -C ~/four log -1 --pretty=format:%s >message &&
 	grep again message
 '
 
-- 
2.38.1

