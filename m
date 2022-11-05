Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230FC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 18:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKESpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKESpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 14:45:53 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3104140D3
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 11:45:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1667673951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNOLfsOXPZOB301H9NYdK2OtG+6b/husmHfcojc+Azg=;
        b=b4s9SwbuIxACTcmEQqiUAoHIq4aTCgrJ5zeusmguW7HKCQswGZkU7m1XFzSrdUgs9KVEvo
        BaqZAfUywZUR1bVMUvJG1sjLVDJGB+iQvq5CPuDSzB/8jpnSbxDWHRG1RgIOuOjFOTI4Wt
        4QHSz2XzJJtRbt7sg8oQWcQPT31/zVU=
From:   Ronan Pigott <ronan@rjp.ie>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Andrzej Hunt <ajrhunt@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: [PATCH 1/2] for-each-repo: interpolate repo path arguments
Date:   Sat,  5 Nov 2022 11:45:31 -0700
Message-Id: <20221105184532.457043-2-ronan@rjp.ie>
In-Reply-To: <20221105184532.457043-1-ronan@rjp.ie>
References: <20221105184532.457043-1-ronan@rjp.ie>
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
 builtin/for-each-repo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
 
-- 
2.38.1

