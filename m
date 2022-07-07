Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A514C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 01:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiGGBye (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 21:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiGGByd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 21:54:33 -0400
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDE72F012
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 18:54:31 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 9GisoJnxoGjO89GitovRPb; Thu, 07 Jul 2022 02:54:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657158871; bh=weVoQ8xYmF26OYZ2WinXeVcf/rgKBBt7r9RzqmtZVEY=;
        h=Date:To:Cc:From:Subject;
        b=NevlJtLxIsdNnTAEVM1+3OIFfyTRKKmp6wURbF8iYc7U+TGaSQstIaJU9zsLtXtd3
         2VZnEiNn6n3SY09b26zt/LQlQbE17T+Lefbciayd3WxIahvepEP5YzVvVvssQ3OLvH
         QsMOrA92crg6OmFdcYLIQ2F1AnBUkjGyew1g22HJIJeao4ub+mHOxMyiqOSWRj60MK
         9p/kxXPNkxt9Naj4iV6tC1VZ9ojh5rj4p8UaoSL1tIQ7a/PQpGSRpJqC5Zv/rHwYfh
         yPU0J8X189CFAT9pohVEc7g4gSChHIA6ml/yePsA55al/oMG8vet10ftHIA8x37hrD
         A3MzcuyEzIMSg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HttlpmfS c=1 sm=1 tr=0 ts=62c63cd7
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=ElGjbW56Ok66dxgLdzkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <2b7bb2ed-26ae-b599-d78c-e7706b153190@ramsayjones.plus.com>
Date:   Thu, 7 Jul 2022 02:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-GB
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 1C] credential-cache--daemon: make exit action follow
 timeout exit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGEVORoFsRBkR/7R9sDS1bDZhMmRmE0YxZ7429JdGNBz8zLMR6YxGQC14EovtJnuCE9Cv6ydgxfG6nAWBMtGCVmINHaW1T5RSUFCyOW7JAyAizOIcNoN
 +MYeraJQ8ReQrL7bfpvQTOs/KR1U5C7N4CDCAot7HOFLoEtVrO22qTF4ssixxjKKIQ7331Gf8GibVdRadDXgnTahuQQ8LPwuyHA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/credential-cache--daemon.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 4c6c89ab0d..fb9b1e04a6 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -114,11 +114,12 @@ static int read_request(FILE *fh, struct credential *c,
 	return 0;
 }
 
-static void serve_one_client(FILE *in, FILE *out)
+static int serve_one_client(FILE *in, FILE *out)
 {
 	struct credential c = CREDENTIAL_INIT;
 	struct strbuf action = STRBUF_INIT;
 	int timeout = -1;
+	int serve = 1; /* ie continue to serve clients */
 
 	if (read_request(in, &c, &action, &timeout) < 0)
 		/* ignore error */ ;
@@ -130,15 +131,8 @@ static void serve_one_client(FILE *in, FILE *out)
 		}
 	}
 	else if (!strcmp(action.buf, "exit")) {
-		/*
-		 * It's important that we clean up our socket first, and then
-		 * signal the client only once we have finished the cleanup.
-		 * Calling exit() directly does this, because we clean up in
-		 * our atexit() handler, and then signal the client when our
-		 * process actually ends, which closes the socket and gives
-		 * them EOF.
-		 */
-		exit(0);
+		/* stop serving clients */
+		serve = 0;
 	}
 	else if (!strcmp(action.buf, "erase"))
 		remove_credential(&c);
@@ -157,6 +151,7 @@ static void serve_one_client(FILE *in, FILE *out)
 
 	credential_clear(&c);
 	strbuf_release(&action);
+	return serve;
 }
 
 static int serve_cache_loop(int fd)
@@ -179,6 +174,7 @@ static int serve_cache_loop(int fd)
 	if (pfd.revents & POLLIN) {
 		int client, client2;
 		FILE *in, *out;
+		int serve;
 
 		client = accept(fd, NULL, NULL);
 		if (client < 0) {
@@ -194,9 +190,10 @@ static int serve_cache_loop(int fd)
 
 		in = xfdopen(client, "r");
 		out = xfdopen(client2, "w");
-		serve_one_client(in, out);
+		serve = serve_one_client(in, out);
 		fclose(in);
 		fclose(out);
+		return serve;
 	}
 	return 1;
 }
-- 
2.37.0
