Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240CD1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 23:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756537AbeASXA3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 18:00:29 -0500
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:33254
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752938AbeASXA2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 18:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516402827; bh=g0aCOlfP3kppAR0jLi6Vx2kStl0a3GEdlNRkoFHbF14=; h=From:To:Cc:Subject:Date:From:Subject; b=N/yD6YhES3mMLG7/2W89GyTDOG+eRAp+5VWofmFVpuo4gpZEe+fTpmBLZ9+ptKE2XUJJ0tJo0+c+54CifCpn8WKEf1rBDkacyTkagPXGJjoAsnMM9eQo6M2PvEgXCD9NFGcROjCFokzJczpNR6TtCR46YnL+xP7TBng6Qwg+uJTIHKPXj2roi5E3ADKXCjKuCbF3tQunrf7ezSGN2b1vdVVXHNG6PiXGcI4yc3p1TjhaJs0Zjttp32GgUpVw4vLqwVjpZsd5vtJCV/NMI8X0TmmpUpkWFq3F80pk+8qdiBMPeFj2FfXQ0AGtbc3+QY33OmVF94eiHyo5aD9cygRzvQ==
X-YMail-OSG: aUfgjlcVM1mIaRTu.MYlyrlTuIfPPqiee7COlZ4GC5Yia8jEo6cedkgl4cFAjlD
 uA.PSWE6fgInSXXxGZlhRYMDyx6r2ec37cq4hC2E.2Q96sWcB9tJK9.8Spurte.ADGMFZhXgknKE
 cZD6B.xaJO_oZ1rWx5xRZcg.vBkBMbQdxccMWGbTFTG.QM.R_ce.HbxdQqefz5Yzdgt3sKQtkGP3
 r.f8iG.iTAOYc3mkuM6xOIOKyyv8HO9ZC7SgCKZvEuDLGzUWDHmTUoyClf6nwPl2riU5a8l5yt_3
 tEJYH.A.lDqmD3c6z.G3_CA4DuHjF7FhJ1pGTZE1t3.HtHBbtnSMZzhVt9krDTVwEqr5YnM6zNHY
 RDDMWzj3PWpGTtNeiwoZRMq2kKpCKHPk0qhpPSKHmGySjPMsaN0nZ3x9sib3tKDAO_vpdup8aTBF
 O5vbrihfCN3qaz0qqMovSd8EX0G6d6Ay.CMZk8GWb4opGVJyCcYa5gxBJ_mrFRPjo6.3gj4fa2Gu
 dEDqhFqFf39QtRhZMaIxJFpPA7dW8J4PEXn_7kuQd3CbbkYLsGg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 19 Jan 2018 23:00:27 +0000
Received: from smtp228.mail.ne1.yahoo.com (EHLO localhost.localdomain) ([10.218.253.213])
          by smtp404.mail.ne1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID 8f691e444c84a3669be9d98fff64ebdb;
          Fri, 19 Jan 2018 23:00:22 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v3 0/6] Force pipes to flush immediately on NonStop platform
Date:   Fri, 19 Jan 2018 18:00:10 -0500
Message-Id: <20180119230010.8544-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* wrapper.c: called setbuf(stream,NULL) to force pipe flushes not
  enabled by default on the NonStop platform. This applies only
  to the NonStop platform guarded by #ifdef __TANDEM.

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
+	setbuf(stream,NULL);
+#endif
 	return stream;
 }
 
-- 
2.16.0.31.gf1a482c

