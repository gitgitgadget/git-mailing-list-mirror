Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4E51F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 14:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbdKHOAc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 09:00:32 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45962 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbdKHOAc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 09:00:32 -0500
Received: by mail-wr0-f195.google.com with SMTP id y9so2520025wrb.2
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 06:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:subject:date:message-id;
        bh=sTLrovGSqUfDiC2+2dral+WPyir5igUBxvzMkwHAyjo=;
        b=uCYOY0XheKsKO4mlI/bC8GW5N1MgSW6QmbSaJG5eA3dhhcXs81cnjZEhPjkYFG+vNT
         qjCDORJ6Pf7Eq6RHSseE26KcSYLylEC0HR4hIi0rkIlMbFRYpixUv0CrmcxPaSJfvsRx
         Cvc15ePcccDnAvJSiXcUnfKHWbqHjEu2w3NFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=sTLrovGSqUfDiC2+2dral+WPyir5igUBxvzMkwHAyjo=;
        b=UlHFYTxzZOINgMXunhgKsN6EWF0MmXYfP6oj5qcSKk8pZFoIJeHSvK9B4E3KbyPsVn
         avWHuYTgO6yUNR78PNL7j6rbkqd1dKQYyZjHnlHTe2aHVHR3Gqk3AyOVTmZkJb238ZRs
         bnowSbUeVtvUQwrl691AzEKa5Zy3lQOYih4c7uOs65wRPEq9yviGwTkmh0uk2seEoKOJ
         kPjPoD3oL1jgDfH8XxAVxL0IkAFW7jkoABnZDgZYGv0Zg+OIhefQ7sze0onApurf+kSv
         aePJNoyP/kxT2FDb4ZC1ei30pukRPE5tMsbXRwSC05A4NGgiP+Qf7jyaG3juu1Kvy6ng
         qDKg==
X-Gm-Message-State: AJaThX7+j9TugcMh5c/+puV3+YWivd79Ea+C4S8Wr5vL5K5vXPG1z+Oq
        kbUAHx+O+D3MQkNK1F9PmQUqYvypAwM=
X-Google-Smtp-Source: ABhQp+R7WCJs7yOTc4TnK+zDCaFBD/Wtm0TS5sGtHghk/12EkPinOEylyXE9ShztQukiN1Xt/Liw0A==
X-Received: by 10.223.176.8 with SMTP id f8mr628554wra.80.1510149630548;
        Wed, 08 Nov 2017 06:00:30 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:a407:552d:75e4:4516])
        by smtp.gmail.com with ESMTPSA id g99sm6093199wrd.72.2017.11.08.06.00.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 06:00:29 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Subject: [RFC PATCH] rebisect: add script for easier bisect log editing
Date:   Wed,  8 Nov 2017 13:59:31 +0000
Message-Id: <20171108135931.166880-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a short script, vaguely inspired by `git rebase --interactive`, to
ease the process described in the `git bisect` documentation of saving
off a bisect log, editing it, then replaying it.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

When I'm bisecting, I find I need to semi-regularly go back and change
my good/bad/skip response for some commits.  The bisect documentation
describes doing this by saving `git bisect log` output, editing it, then
using `git bisect replay`.  Which is a perfectly fine technique, but
automation is A Good Thing(TM).  The below script is a short proof of
concept for changing this process to be a single command.

Ideally (at least from my perspective), this function would be rolled
into the main `git bisect` tool, as `git bisect edit` or similar.
Before I start working on that, however, I wanted to see what the list
thought of the idea.

 contrib/git-rebisect.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100755 contrib/git-rebisect.sh

diff --git a/contrib/git-rebisect.sh b/contrib/git-rebisect.sh
new file mode 100755
index 000000000..60f20b278
--- /dev/null
+++ b/contrib/git-rebisect.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+GIT_EDITOR="$(git var GIT_EDITOR)"
+GIT_DIR="$(git rev-parse --git-dir)"
+GIT_BISECT_LOG_TMP="${GIT_DIR}/BISECT_LOG_EDIT"
+
+git bisect log >"$GIT_BISECT_LOG_TMP"
+"$GIT_EDITOR" "$GIT_BISECT_LOG_TMP"
+git bisect reset HEAD
+git bisect start
+git bisect replay "$GIT_BISECT_LOG_TMP"
+rm -f "$GIT_BISECT_LOG_TMP"
-- 
2.14.3

