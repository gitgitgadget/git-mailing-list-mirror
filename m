Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311371F576
	for <e@80x24.org>; Sun, 21 Jan 2018 23:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeAUXmW (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 18:42:22 -0500
Received: from sonic307-7.consmr.mail.bf2.yahoo.com ([74.6.134.46]:45600 "EHLO
        sonic307-7.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751003AbeAUXmU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Jan 2018 18:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516578139; bh=J9387yjm1RqZV+hgTsg+UsPWUD9QnjmByY4kGH2072g=; h=From:To:Cc:Subject:Date:From:Subject; b=lOYC5d+JRZCUZLiibTBu88uoKdiAUiwwU9SDEkindDYW98tNb9j+WPwAJafllEy2y4+Hqb+06MNnsNXfVlchbg/kHshPxqFE7+6azkGQk9dcbmXXR9KInew8Q+Ei3sOtFZrpfDrqOIyoe26BMVqaD21rGBVkzcuWppoGDT1wgT5OauzpHUJSYtmcnqzNLr6M8C13iNu2owkHZF2P7RcLBylS9xcmiE5w7WlEqOM4N/lbnwSQZ6pINzdrhbRaUR4gb+K7BT9oqfJXNuCLLqLfeqwgZ1LxaQxmF8qn6MzlrmmQPSlc9lFLwUFnCrlHk2UgU7nnbF8a7wy0llCh/Ps3zQ==
X-YMail-OSG: e__2QAEVM1m7fsQ.8_9RTposFi_73EeFqP25boEJoADSak0MUKVxcTYmc5brvZw
 6lX0_xfKPgkqY3Ipu0yeo7e9Thef93UNJAXxo1al4o_hlAoibzz9aDAMhzNAhGm..vLKvmnpuCXb
 D0zN1xSPOYWfdaj51hqQ30HDopW1zjxyB9jjkeB_.oTQiFSWuyLhfCt6K8JL.jxk1NmjaW.EBGIU
 qacz6lmXn0NhaX1V5wiJ3Wa.RH8W.4i1_FfKsHzaNhIerWtm.ATe_1IvMRCKglAKkQITqfyobe2I
 zoRoPVM1FV298PRwS2LZDLn.1Dc5_YfdphEHKUUxWETJYanNApn9ZeOdUVhKq5JyI8LncwyMCXcU
 X06Gl85QZrqnUe40gSVQtT5TooIzFjKDx2v_dGi8rj0DFJxTrS3i_6WQegwxPgozbEqWd5PdMrq3
 kUEA71ShouJtHKMC6lqo8eIY5_0p1AUvZYVHJXV88eXttoYEk31KWwT9Q228WcM7sQyQNhCwJVel
 .YQzM6TLNLTwm48Dt0V63sUSpCzadDApE8qXP3azRUZmlF2KPbg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Sun, 21 Jan 2018 23:42:19 +0000
Received: from smtp106.rhel.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([98.139.231.40])
          by smtp404.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID 658003e76b47aa0b456f7039861b9699;
          Sun, 21 Jan 2018 23:42:16 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v4 0/4] Force pipes to flush immediately on NonStop platform
Date:   Sun, 21 Jan 2018 18:41:59 -0500
Message-Id: <20180121234203.13764-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Call setbuf(stream,NULL) to force pipe flushes not enabled by
default on the NonStop platform in wrapper.c. This may be extended
in future to a configure option.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 wrapper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/wrapper.c b/wrapper.c
index d20356a77..5b05a9162 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -403,6 +403,9 @@ FILE *xfdopen(int fd, const char *mode)
 	FILE *stream = fdopen(fd, mode);
 	if (stream == NULL)
 		die_errno("Out of memory? fdopen failed");
+#ifdef __TANDEM
+	setbuf(stream,NULL);
+#endif
 	return stream;
 }
 
-- 
2.16.0.31.gf1a482c

