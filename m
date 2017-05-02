Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AED31F790
	for <e@80x24.org>; Tue,  2 May 2017 19:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbdEBTc2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 15:32:28 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33210 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdEBTc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 15:32:26 -0400
Received: by mail-pg0-f42.google.com with SMTP id y4so60919346pge.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hZzF3neLOV29HjZdIjCU6bHdOcY9NB6JWPsd1rsc0Uw=;
        b=VT/OrlHBYmaz6AFPVxT5OUDuIsvyFOeEU7TySEopj5bphGtUSgPZcUS3DST98+tbD7
         3RnRMfZ4xRRyFz8NCGLHoZMSuR+NUOLoNN/iGJ2lpmCEmI0rUPsMgensutmWBkd+kbnL
         VX4BXFP0TMJPiPOkMa4dbP7i2zBQ0g4uli4yr/iTHw2CTQgoAU3x/qMXddlqMZTnYXM7
         giK+mqQt0E953ion4eMGCF1VhApxwFLzLI7N8TZ/G3/G+bwMRAiFE/1ku6C+uwD4J0vf
         /O6PE6P2OUBpZar6u4dLPFAHfCVym2+u2AULG7hLQuOk0sTTilrZQIHs1SUmeT8LlZpH
         OBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hZzF3neLOV29HjZdIjCU6bHdOcY9NB6JWPsd1rsc0Uw=;
        b=W46FBEW6XOL7FMEuIa8u8eBnNBX1Mvgcspoy6AFQc20/YZkGpl1rH4/cmJEqL5SLki
         sITwIIo4GEda8mzYeE7hsC42KXmDvgHi+skmFOFjAbzu/MZbfHMeLcD7/s0prLjLnNrL
         9IcntTDLZJLsdug5Odw1LNDEkZ0I8gbnGgZtbWvIC2hEGQLGVnHJIkYQ1pYDSTxyGIhY
         6ajN2DIduEawqF49Uya9uPbLA15wzYo/8Rka7gOTtvi+vRH9NYeTJhG5LX/zOuEORH10
         HzGMlgJGRaP0r6VSJqhmrD2619FoQdxLPeO7clEK8u9LUN7foiy3wthR8U2Jp21JUpRa
         pWKQ==
X-Gm-Message-State: AN3rC/7CIZ2Dmp8bV+YcGmTZDP3QiKWj08Ncao2UyZMI5afmGNXMR4KU
        /7sh+Yegh9pe7MT8
X-Received: by 10.98.31.141 with SMTP id l13mr647023pfj.259.1493753545409;
        Tue, 02 May 2017 12:32:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id n5sm390068pfa.78.2017.05.02.12.32.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 12:32:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/3] submodule_move_head: reuse child_process structure for futher commands
Date:   Tue,  2 May 2017 12:32:12 -0700
Message-Id: <20170502193214.7121-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.18.g9ce9a66034
In-Reply-To: <20170502193214.7121-1-sbeller@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
 <20170502193214.7121-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not need to declare another struct child_process, but we can just
reuse the existing `cp` struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index d3299e29c0..a2377ce019 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1468,15 +1468,15 @@ int submodule_move_head(const char *path,
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (new) {
-			struct child_process cp1 = CHILD_PROCESS_INIT;
+			child_process_init(&cp);
 			/* also set the HEAD accordingly */
-			cp1.git_cmd = 1;
-			cp1.no_stdin = 1;
-			cp1.dir = path;
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.dir = path;
 
-			argv_array_pushl(&cp1.args, "update-ref", "HEAD", new, NULL);
+			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
 
-			if (run_command(&cp1)) {
+			if (run_command(&cp)) {
 				ret = -1;
 				goto out;
 			}
-- 
2.13.0.rc1.19.g083305f9b1

