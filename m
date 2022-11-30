Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1293C4708A
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiK3ShB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiK3Sgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:36:38 -0500
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 10:36:36 PST
Received: from srv1.79p.de (srv1.79p.de [IPv6:2a01:4f8:222:1281::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BED93A6A
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:36:36 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPV6:2001:9e8:2bcc:ee00:a0a0:492e:fa7c:ddfd] (unknown [IPv6:2001:9e8:2bcc:ee00:a0a0:492e:fa7c:ddfd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id DE0B860009E;
        Wed, 30 Nov 2022 19:30:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2022; t=1669833043;
        bh=No6Ucdj9aTqUl1PtL2sXLGFd+L1Ycn+kC2BPoATvLO4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=1VqdZVFHj13K8Zm7jrVE1VoMgumCqcEWjjvtbqGDrNLYPOh+UtcjSJEiv7yWLPJB3
         1vLke3R3GOjOv+5zJPg7QdgPYt+/nmGLt73Ms7i9Cr5BhMQv2auXDfWCDQfZBgjqEx
         sZyAkNavzAH2s5kQlEXHvFaZw2hTmy0LFsX7bJO297sG91vAs+UjCpAmqeTG+grYh7
         jpGxEUiV9nFoZgGV103OSMZBXsskS/3xqYNQA6DQXj/5388lKu1AGeDPhgD5S5268R
         OBmxtpgHDEQwUxo72eURRO+4k54APX0PPmxtUH8Hkcg3/v5QsASI9aSoMRgDFyejRs
         QxN8ceqMmIwzA==
Message-ID: <cad05012-7bf9-5975-3add-253b11c7bcc8@cs-ware.de>
Date:   Wed, 30 Nov 2022 19:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH] Don't pass -v to submodule command
From:   Sven Strickroth <email@cs-ware.de>
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>
References: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
 <1ff185c5-4a9e-36e3-3141-8b149c1c7bb0@cs-ware.de>
In-Reply-To: <1ff185c5-4a9e-36e3-3141-8b149c1c7bb0@cs-ware.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git pull -v --recurse-submodules" propagates the "-v" to the submdoule
command which does not support "-v".

Commit a56771a668dd4963675914bc5da0e1e015952dae introduced this
regression.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
  builtin/pull.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1ab4de0005..b67320fa5f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -256,7 +256,7 @@ static struct option pull_options[] = {
  /**
   * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
   */
-static void argv_push_verbosity(struct strvec *arr)
+static void argv_push_verbosity(struct strvec *arr, int include_v)
  {
  	int verbosity;

@@ -520,7 +520,7 @@ static int run_fetch(const char *repo, const char **refspecs)
  	strvec_pushl(&cmd.args, "fetch", "--update-head-ok", NULL);

  	/* Shared options */
-	argv_push_verbosity(&cmd.args);
+	argv_push_verbosity(&cmd.args, 1);
  	if (opt_progress)
  		strvec_push(&cmd.args, opt_progress);

@@ -629,7 +629,7 @@ static int rebase_submodules(void)
  	cp.no_stdin = 1;
  	strvec_pushl(&cp.args, "submodule", "update",
  		     "--recursive", "--rebase", NULL);
-	argv_push_verbosity(&cp.args);
+	argv_push_verbosity(&cp.args, 0);

  	return run_command(&cp);
  }
@@ -642,7 +642,7 @@ static int update_submodules(void)
  	cp.no_stdin = 1;
  	strvec_pushl(&cp.args, "submodule", "update",
  		     "--recursive", "--checkout", NULL);
-	argv_push_verbosity(&cp.args);
+	argv_push_verbosity(&cp.args, 0);

  	return run_command(&cp);
  }
@@ -657,7 +657,7 @@ static int run_merge(void)
  	strvec_pushl(&cmd.args, "merge", NULL);

  	/* Shared options */
-	argv_push_verbosity(&cmd.args);
+	argv_push_verbosity(&cmd.args, 1);
  	if (opt_progress)
  		strvec_push(&cmd.args, opt_progress);

@@ -881,7 +881,7 @@ static int run_rebase(const struct object_id *newbase,
  	strvec_push(&cmd.args, "rebase");

  	/* Shared options */
-	argv_push_verbosity(&cmd.args);
+	argv_push_verbosity(&cmd.args, 1);

  	/* Options passed to git-rebase */
  	if (opt_rebase == REBASE_MERGES)
-- 
2.38.1.windows.1
