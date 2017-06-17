Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3969D20401
	for <e@80x24.org>; Sat, 17 Jun 2017 10:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbdFQKZA (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 06:25:00 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35316 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdFQKY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 06:24:58 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so9619299pgc.2
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/wFXXbHr9/oeErS9rsGk+DnznZT2rMFykvJVnaas2fg=;
        b=KltFocXUxaTeasK1PH31puOb0t/TKk2WUQI8FzvoDplYlDFmvK0JzKm6l35px70W2I
         HKhAkPcI9zThfkF3BR5sd88QNunGw8KcxWQSuMKpw1U/28KUdyLRQx3R7LK8ttR4Jy30
         Do+WNbno3Nit36tF5HVcItrkCN0qVBOoxW29HjzYVPEzFzWXR13cnAkQyVtEsjZWBx7Y
         vmAqBJWcSQfDe8Zt6eDfK135ZCkcoTlcegI3kFZhLOvrIckypk21P60dPRKCP/6eVwTd
         omjYMgR3Bby8cG6eZvwE/Xa39VhUqDCJKKQIs3u59NQjl61a/mXHGr7pyZKuyRP4xVv6
         HTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/wFXXbHr9/oeErS9rsGk+DnznZT2rMFykvJVnaas2fg=;
        b=q/XJJIW91Ypi4GkB2rHSsBDJ76XWPcRLUHxaaEneui9lzYsq1G04Q7ILHYjzqpSCHQ
         j0a2NVLZCAyFxG2ga+YpFBB1fsAVLFG2b+SwSTtYtx3Y4j4GKNuUzd9iBPe2rHU0BSJk
         CnC2YXjpNGJA52sWGXwyj4YFDF+zzb0Ld0bV8pUPuEpTa3vIqA5bBD0akIwMA2cJ4aP/
         0m91Ed9bk/Wy7e3pzya5hJvCeU52nR61+ltuodrTaSBLsbKvnjFJkIsfT1y31iREKqGR
         HECO12VaLdkHkf+UId1pzsrQ5ZAolCoNqNEA9APUbtXLzIN1aW2INX0CbvuJDWFspF0d
         m5yw==
X-Gm-Message-State: AKS2vOzJZraxGG600pD/99a4TIrmQAd0TAEmdQJq0RcncUfZq4VSLyIv
        cbrhyUc2WQBzsA==
X-Received: by 10.84.236.10 with SMTP id q10mr17783366plk.163.1497695098151;
        Sat, 17 Jun 2017 03:24:58 -0700 (PDT)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id z66sm11583070pfl.13.2017.06.17.03.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2017 03:24:56 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matthew Groth <mgroth49@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH] mergetools/meld: improve backwards-compatibiilty when using "--output"
Date:   Sat, 17 Jun 2017 03:24:54 -0700
Message-Id: <20170617102454.2040-1-davvid@gmail.com>
X-Mailer: git-send-email 2.13.1.453.gc0395165f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Meld 3.16.0 requires a "=" in the --output argument, as it uses
a simple hand-rolled command-line parser.

Newer versions of Meld (3.16.4, and possibly earlier) use
optpaarse, which accepts either "--output <file>" or
"--output=<file>".

Use "--output=<file>" for better compatibility.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 mergetools/meld | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/meld b/mergetools/meld
index bc178e8882..7a08470f88 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -10,7 +10,7 @@ merge_cmd () {
 
 	if test "$meld_has_output_option" = true
 	then
-		"$merge_tool_path" --output "$MERGED" \
+		"$merge_tool_path" --output="$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
 		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
-- 
2.13.1.453.gc0395165f3

