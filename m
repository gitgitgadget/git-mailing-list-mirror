Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4182018B
	for <e@80x24.org>; Mon, 18 Jul 2016 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbcGRShU (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 14:37:20 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35697 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcGRShS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 14:37:18 -0400
Received: by mail-pa0-f53.google.com with SMTP id iw10so897951pac.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 11:37:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eUVUdop6rWcEwsT5fM2m25SkXRsEJ+Y9NbjhXIZXlt4=;
        b=QmouHbEDPQrZVZHzzcCCot7P3Vv3IkJX7bInukqHbFkB+aVPg8DPSd+jta7X4eM15Y
         aPJHTuGC5dIiQmwmPL6ikWoto4qzNZQOY+fhjQr97qOgXRBfk7OK9keJeItSyrCm8AnT
         I2+YTkiD35yVrfvdj/n//tiiJx8Az4DEI+ndf8WXUXQY0pvG30xTp8WO+VfrHaGJGoZ/
         HaDZl3IDX7EVSk9Hb1Ja9H9KDwtiy9/7ZeHLEzvkJAUTSyrCDJxauu50btHr5FEjwll/
         GYDgNCLEJLUtoCBCup8Vtf8k0/aywdpmFSpcgWNBY1Mbo0iFIxadC3eLJBY7T2j3mAB+
         OfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eUVUdop6rWcEwsT5fM2m25SkXRsEJ+Y9NbjhXIZXlt4=;
        b=kfkM9YmkLH8xtqd+E3FWMgCQFMGJN3UmTz9HD6xmueHgQxFJxooKnC4EMNbHNBWV0h
         q1vo2ATzSw/IIFvLta7AvEE1+kLNi2OyuAfsZYEbuSFlquu76lV3WIBZQj7qXXgKD+Nn
         6YdcvX+BYyZUSAe4rnSWIL32VP6rQ9u4IVm6LHMDVGdIkSsRxdJ5gf66Pr5uO/AWhxLf
         S7SiTuUcS5vO4fQ4WhDPTqz+xToLtzhVTF4CuTZKKx+WJx6opSsPqaIkUMzD18KCh7Rc
         dxmJ1eVPq40oGTx0NwaDf5Id+/ro51hPTBMQU0+U3sRZCPE15yr0HazRD6HTE8HNTN8O
         IROQ==
X-Gm-Message-State: ALyK8tLwW1+DS14V0etiB22l1cZ3loEe6Yc/MFXnp+JonIHZYxEktjJP9/C5/tGDFx206JjO
X-Received: by 10.67.8.69 with SMTP id di5mr57939620pad.123.1468867037159;
        Mon, 18 Jul 2016 11:37:17 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([172.17.54.68])
        by smtp.gmail.com with ESMTPSA id h66sm6671700pfe.58.2016.07.18.11.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 11:37:15 -0700 (PDT)
From:	Jonathan Tan <jonathantanmy@google.com>
To:	git@vger.kernel.org
Cc:	Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
	sbeller@google.com
Subject: [PATCH] fetch-pack: grow stateless RPC windows exponentially
Date:	Mon, 18 Jul 2016 11:36:59 -0700
Message-Id: <1468867019-13086-1-git-send-email-jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When updating large repositories, the LARGE_FLUSH limit (that is, the
limit at which the window growth strategy switches from exponential to
linear) is reached quite quickly. Use a conservative exponential growth
strategy when that limit is reached instead.

This optimization is only applied during stateless RPCs to avoid the
issue raised and fixed in commit
44d8dc54e73e8010c4bdf57a422fc8d5ce709029.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index b501d5c..3fcbda2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -251,6 +251,8 @@ static int next_flush(struct fetch_pack_args *args, int count)
 
 	if (count < flush_limit)
 		count <<= 1;
+	else if (args->stateless_rpc && count >= flush_limit * 10)
+		count = count * 11 / 10;
 	else
 		count += flush_limit;
 	return count;
-- 
2.8.0.rc3.226.g39d4020

