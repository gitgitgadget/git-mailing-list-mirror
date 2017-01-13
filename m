Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8023720756
	for <e@80x24.org>; Fri, 13 Jan 2017 19:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbdAMTDY (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 14:03:24 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36525 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdAMTDX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 14:03:23 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so35240133pfu.3
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SyTCFDXXSUqqt2S1LENFZsQegdjtbjoVdE4rISbqLCo=;
        b=KUMsYIx1eDC2BJU0sQWHwJeOzaio0RAErEdlDY0lK3ZFDYJ8R9+Vag2ur3yV+qef3i
         HvdPuDxKmmRz3ZK4h8jfgYRKfZnnZkjNRX4UaszmMQMnI1GjXafaS0ehSqHtE9Hn/Gr6
         UEEaOENSIsgImKeQYQyx2pLuC5O9qrzWGY/KnFxnhVXjQZc2a0HuZenKvOMJ3o6w8IVw
         vL+xmzCOxQGuxylvCyt1K4+h7Y62519L6EjGeL9GhMxW3I+8upwsC3qxooSp5TwSH+2i
         ppB+GZgg+k3cmEZCuZACgmGhIcb6VIfmwwIxmeBC6HBfnQ2hw9Rgq4Uhqybsi/h+RL1d
         da/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SyTCFDXXSUqqt2S1LENFZsQegdjtbjoVdE4rISbqLCo=;
        b=d1oJZgrBnFxi8own8rzMz3LTIyE53cnb835juE8DwEYO31+RBeJtH5YJlj41Z/qwtK
         C1tcXtj080yTxvS4r/5hj7tAcQI7+Jjso/8JVXcJgC9lkfOARu6HkgFsTQ/IwNO6ODpu
         Xp4b4Fl5M7FHTKlXGtAKJyFlSCvv7dzLc/1s+/N84fFt0V+TXmpSJlWXT6nYfdKjyF6F
         V3jhZY+bxqrgl8K2AXG1NVblxAqN1U04KeiNQM70j8XBguN5a9jqpb3k4Ci0kT0O+EeP
         34ODL9xRCB3GkQwAdldm4akmAZppuURXrrKMWPX2E3EQFjgVY18xsvKf1lvb3lnbgRSA
         411A==
X-Gm-Message-State: AIkVDXKMtCMKRq9jSvtq7JpcbY38IohPOesr3hmaUtzzfQf3zyi9JgiGhG+fxafLXaSw9PE1
X-Received: by 10.98.150.88 with SMTP id c85mr24378883pfe.68.1484334202879;
        Fri, 13 Jan 2017 11:03:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:5403:279a:3262:7e9c])
        by smtp.gmail.com with ESMTPSA id c22sm31171948pgn.12.2017.01.13.11.03.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 11:03:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] lib-submodule-update.sh: reduce use of subshell by using git -C <dir>
Date:   Fri, 13 Jan 2017 11:03:18 -0800
Message-Id: <20170113190318.18412-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.300.g08194d1431
In-Reply-To: <xmqqtw92hkgc.fsf@gitster.mtv.corp.google.com>
References: <xmqqtw92hkgc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In modern Git we prefer
    "git -C <cmd>"
over
    "(cd <somewhere && git <cmd>)"
as it doesn't need an extra shell.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 79cdd34a54..915eb4a7c6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -69,10 +69,7 @@ create_lib_submodule_repo () {
 
 		git checkout -b "replace_sub1_with_directory" "add_sub1" &&
 		git submodule update &&
-		(
-			cd sub1 &&
-			git checkout modifications
-		) &&
+		git -C sub1 checkout modifications &&
 		git rm --cached sub1 &&
 		rm sub1/.git* &&
 		git config -f .gitmodules --remove-section "submodule.sub1" &&
-- 
2.11.0.300.g08194d1431

