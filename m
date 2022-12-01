Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B0C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 08:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLAIfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 03:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLAIfL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 03:35:11 -0500
Received: from srv1.79p.de (srv1.79p.de [IPv6:2a01:4f8:222:1281::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710065984F
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 00:35:10 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPV6:2001:9e8:2bda:ce00:f124:c58c:ef9e:29c4] (unknown [IPv6:2001:9e8:2bda:ce00:f124:c58c:ef9e:29c4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id 3CFAC60009E;
        Thu,  1 Dec 2022 09:35:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2022; t=1669883707;
        bh=9pohhi42CtQjx+Cj4KnMv9P+DxMFc0rvvoSnWmABnco=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=iACgCAZQ/m59A8BOd6424UYjZOuBpIhpT+w7J8usf1SGDlvyBmDkvDGm2ka5pRnJV
         5hyTnZ8oFE+zxsg/vDw+Z80ynjYUq9JyU9UeQUArNGvR2P9+JZwHey2gA0UzzMohiL
         EpMNIUB8JdXgS/dBTHea0r0smMC6R/ApHsBaUb9cKNenKZAa3UNsAMr4tqgyjXb/y8
         SE3FK3CsCfl+Byp9tM9JXRZPLf0s4PCxGrQYyimu9RPYppbag5w4fqrMokgxRX+C2e
         ImjOI0U3P2kLAGofcCUI4OiOzl7uxTIm8jjp3kx8KdeY6vE1Sh7+0CMQW3TSIo5QYs
         Dd1tc1xXRlzcA==
Message-ID: <49a10767-8cdf-4c40-eb74-c7c61b80b7e7@cs-ware.de>
Date:   Thu, 1 Dec 2022 09:34:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Sven Strickroth <email@cs-ware.de>
Subject: [PATCH v2] Don't pass -v to submodule command
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
 <1ff185c5-4a9e-36e3-3141-8b149c1c7bb0@cs-ware.de>
 <cad05012-7bf9-5975-3add-253b11c7bcc8@cs-ware.de>
 <221130.868rjsi6bn.gmgdl@evledraar.gmail.com>
 <80d5eb7c-c668-d325-2aaa-cbee742d1f15@cs-ware.de>
In-Reply-To: <80d5eb7c-c668-d325-2aaa-cbee742d1f15@cs-ware.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git pull -v --recurse-submodules" propagates the "-v" to the submdoule
command which does not support "-v" yet.

Commit a56771a668d introduced this regression.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
  builtin/pull.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1ab4de0005..c7f65b39ec 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -256,11 +256,11 @@ static struct option pull_options[] = {
  /**
   * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
   */
-static void argv_push_verbosity(struct strvec *arr)
+static void argv_push_verbosity(struct strvec *arr, int include_v)
  {
  	int verbosity;

-	for (verbosity = opt_verbosity; verbosity > 0; verbosity--)
+	for (verbosity = opt_verbosity; include_v && verbosity > 0; verbosity--)
  		strvec_push(arr, "-v");

  	for (verbosity = opt_verbosity; verbosity < 0; verbosity++)
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


