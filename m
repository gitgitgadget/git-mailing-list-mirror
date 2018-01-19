Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437241F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeASRe3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:34:29 -0500
Received: from sonic307-6.consmr.mail.bf2.yahoo.com ([74.6.134.45]:45915 "EHLO
        sonic307-6.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932456AbeASReU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 12:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516383259; bh=fGX+hGittB6Jx+n3YPvAGaNzrxRhFXw9CT8nOrgxOLw=; h=From:To:Cc:Subject:Date:From:Subject; b=sAjcLHy5nBkGjtLppbFYkLVz5BuI2eVdrs6nJ0pyycORa9IkbfseZcs0tuOjl4fsu9lUS74Z6dtGyEsAiVCTWS8S/HGd4SmpQ5p7i3NmC/5/UQjk9LrDMJYX665IN2p6xMpSbVfRhvBpfqZ7LcQf6tVtalJq1hmuAtscCwLRwuj5dKNgxAR84wMNz9deiNVpb77/uZnqWPHI6c4scU9EkB05iDs8ipw4CRCBg9y8XKeQEAz76vMCaKhf+Qtt6m3RnkUKpmP/JYEzAMHJr2JC93LT1CqR6ULhI7h/ioH6O1IqhLynjKKiF5FmZfNZUuDbu4VqfDufXIfGf5I3YBwnFQ==
X-YMail-OSG: .wb00hcVM1l9jAo.UviQIu2U7d_okJMRjeRuaxtnB2H6vURX54K65Woex8KZjbC
 P6TAavym8NBPPbO0qlCTS_M6E8gZx6bfVo3xf63hoOCvQjn_.xipN1FGUD0ohhalmdxGHxaBNxy7
 TpUX6Rq4F93k87FanPhqIJJH.44yGC9cg.QJOpW5hc9H4YF09HDQ75XjkRQNKzhEvjNf9a.eIlGb
 lnjZx8E_pof_LigcbmtDDtrjXZ8WuVzu6VLWpRi2NJicEUN1wnk5q.bBRji49EsDY1s36FVcQCw9
 uhMI3B4C3_ScnV9u21T5kxNamAwFg5lX9LK_FAlQYoOL5PyXr8vYkCZtOdoMQac6OXyFRlFr0zd6
 TpAVQAeIfRFEJoF1OiYtg1sHmAk.ap6u4gum1Ss7nVGKyDviH_aICDikOHC3NPnreWj0f2JAsQM9
 INz28.Pny8iISI59USt9qcYxTjHGp_J43M54R4xA6B1.EYDaF41ncy7gykm09pAKAxSQlqTNMPxq
 CyN4n58ykEC.6fm2M7BoVbALOMCanKpGDkQwUTSk8HwmotBnkzg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jan 2018 17:34:19 +0000
Received: from smtpgate102.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([72.30.28.113])
          by smtp406.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID e78d06b6c08cf8709c5b5470ad5cf24d;
          Fri, 19 Jan 2018 17:34:18 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 0/6] Force pipes to flush immediately on NonStop platform
Date:   Fri, 19 Jan 2018 12:33:59 -0500
Message-Id: <20180119173406.13324-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* wrapper.c: called setbuf(stream,0) to force pipe flushes not enabled by
  default on the NonStop platform.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 wrapper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/wrapper.c b/wrapper.c
index d20356a77..671cbb4b4 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -403,6 +403,9 @@ FILE *xfdopen(int fd, const char *mode)
 	FILE *stream = fdopen(fd, mode);
 	if (stream == NULL)
 		die_errno("Out of memory? fdopen failed");
+#ifdef __TANDEM
+	setbuf(stream,0);
+#endif
 	return stream;
 }
 
-- 
2.16.0.31.gf1a482c

