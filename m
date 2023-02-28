Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E8C64ED6
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 14:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjB1OCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1OCp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 09:02:45 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA252B638
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:02:41 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bg11so8072164oib.5
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx77h0ntxuJ9VrTDF4MKERSfu3v0Y0ZQCleHb2qq+dg=;
        b=mlS9dMQ1y1gz8xTqIRD0Uen/6GW4B9YgWCeW8y+8i4nnt/gnFdrB6iE7t/Z2D9Enhq
         mdRVg6MaPXhs4OoKyJZC33oT1zyYC8qdAapTWNq5gshWbI+uNLMP1Jm7M/t/bh/bz15v
         aijTDocw3bsrvZLp1XFHciZCUCfI7EuzjW4HeiUjwAFtMCxUo7OFOdqzy9XJoZaLpdz2
         +HAHbYMPk8vIsIGX/2bp9gqWbUtFvB++dI1PoCN0foshQkVcmz/GYQVsFV8pUkLjv0Mx
         7o71j/ukPuCM6YEymxVDJ063p00krXujX7Th9WdKRcXucjPsEtvIsujLYgKNOg7O6Q+P
         +CVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx77h0ntxuJ9VrTDF4MKERSfu3v0Y0ZQCleHb2qq+dg=;
        b=FKS6AMHmYb3emn2mvDSsYmVrYYq2bKUqcI1afsYMeH6nTIIHrQlM0ckW000ufewKZz
         qzGW9WVGdI9ZMNEO7YgKTuzRAExizbFCBInZGBfslzvu+pi/Nj8w6usC5aj0T8B0lH2E
         U5L7H0fj2LTw65gy4V3Ncg+S9C+m8/PJGeVk5hg4ohEi1ldo13R1yMj74a2xd4j7LVdN
         6oQeNgHfWj0Lf2GsTmsmmyoUvPcCpMy4vz2JBqNE+PiWFiCn/EKy2o/8YtUZIbi6SxjT
         gFoVLYNx8MTRTnkeSq7+AVua2WDF+vKzNKjCMYf6nF2DcWibIK7hVMGjSaoE532bsiRN
         c5Bw==
X-Gm-Message-State: AO0yUKUZuSTnxRU+7r14om9uVXbZ2r5UaAjuwmzlsS0Q/tOkK3AAzENu
        iNu/xVotfZ4EYItxdoh7qGyiFGoyN+A=
X-Google-Smtp-Source: AK7set/NPBy6BE1Vk8e4ixPBAzIFzuIitZl3EfsAWrUJrO+Dam2HFPXVxFTn5yQ1MUiu3Xh6f1dbkQ==
X-Received: by 2002:a05:6808:148:b0:384:1e0c:fbbf with SMTP id h8-20020a056808014800b003841e0cfbbfmr1256492oie.40.1677592960585;
        Tue, 28 Feb 2023 06:02:40 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm4394601oif.44.2023.02.28.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:02:40 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 2/2] pull: improve --rebase and pull.rebase interaction
Date:   Tue, 28 Feb 2023 08:02:36 -0600
Message-Id: <20230228140236.4175835-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228140236.4175835-1-felipe.contreras@gmail.com>
References: <20230228140236.4175835-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently --rebase without argument overrides pull.rebase:

  git config pull.rebase merges
  git pull --rebase

Up until now this hasn't been a big issue, since user has not been
forced to specify a merge, or a rebase. But with the introduction of
--merge and pull.mode, the user could in theory have the following
configuration:

  git config pull.mode merge
  git config pull.rebase merges

In such case, the user would expect:

  git pull --rebase

To be the same as:

  git pull --rebase=merges

If the user wants to override the configuration, she can do:

  git pull --rebase=true

Cc: Tao Klerks <tao@klerks.biz>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 0531328e2f..3c9e7f0861 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -68,8 +68,14 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
 
 	if (arg)
 		*value = parse_config_rebase("--rebase", arg, 0);
-	else
-		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+	else {
+		if (!unset) {
+			/* --rebase shouldn't override pull.rebase=merges (and others) */
+			if (*value < REBASE_TRUE)
+				*value = REBASE_TRUE;
+		} else
+			*value = REBASE_FALSE;
+	}
 
 	if (*value > 0)
 		mode = *value >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
-- 
2.39.2

