Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31499207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966944AbdDZUVP (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:53459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936401AbdDZUVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:21:13 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mb8MV-1dNcsw46gd-00KkWq; Wed, 26
 Apr 2017 22:21:10 +0200
Date:   Wed, 26 Apr 2017 22:20:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/26] pack-redundant: plug memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <0a2500c748db356be5a5aa2829f2e37c40cefef8.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rbilQ8Q54ZGZoGQf1Jifb047T1s2Nu9gPUEkmPPmY7bv6XAxkr9
 WstB0lqfA7kOVrUB07As37HeoNWZgjA9ymZPivzrWx+ATvX5hPxODRQlEIB9XFVFvImMIvC
 5LiW4SXOl09+fKoLln+/oBZFnu3D30GH3PMLqWR8Vx4j6yeuWdczOsrA3NOtJdxBiep41CY
 +4VnQoHyMyfYkQpsYE/cA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rp1ZygvjFuU=:7C4gbNrzO74zh9a81uFszt
 d36ks16iiVB9B/mb/vIw3C+8DQKyn0pu6d+r7b7lvVxj+Hjkmg0F7n9eUJp/N9k6rclQzxP71
 fApaLsg8eRXLdnZgAtZXWU9TUiZp+lubI6IdGcXEO9PQqqbeC5dYlERbesASD9uiVaLclYVw0
 gqgYMUTTS2HHaJjYSa5Xuyxi5wW+OdR+a744az8KMKPuxiXrM+apD0TXBuCz+5Km+ZT+62Ccs
 ZaOIKfRMm+qUO8bctmyZWNrS35NwR2bmP38incBGB1gMLzY2Z7YfRy0ydwQIIZr605sdt+Ch9
 Aser0KsSaSWOtcjco/pzkhPI8EX2nMZI384I5rjDrEPCz29EeqNwVxYbj8xCj0yBZ67tlU+N7
 R66sK3IcMuBQZ5FgFKMRzHZVD9b4fNQqC6woaBY8ff1rrLeVDyPAptlcRc9tL2KcW4QFiB1hV
 sWgjAl3i/0S9XOa2xN0KQw3NWIPifmS25tTfk2XsVTB28GsjD6nTN2VNYjMw6Guqt57bg2nlp
 RWOLhsr3CtptxwiZY1qwQljlAGB+W1f+w4VZYRmuodrGpAXo5IwobKFMteZaqGskLMouOL2fH
 NPugzXYuATgRRLXreLtcvwTaj/0PhIob+blL1Kyp+B3x8rXZ8yAsxT1m/0hTaYlncngPu01yn
 gJHTCU+DKhJ8mvFDFBwK8kBUmyFMma4LJc0yL4LhpdrWpgdovEBMWi/6fWY6eZJ4aKegaD9fQ
 /+BG56IBdrtb+rZ0+r5JViPLqrjuJeU7Pjqaxc6ILbBd21UpDKnSfuoLnJkLVzMLZJEOGK75y
 vPICx2M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Identified via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-redundant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 72c815844dd..cb1df1c7614 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -442,6 +442,7 @@ static void minimize(struct pack_list **min)
 	/* return if there are no objects missing from the unique set */
 	if (missing->size == 0) {
 		*min = unique;
+		free(missing);
 		return;
 	}
 
-- 
2.12.2.windows.2.800.gede8f145e06


