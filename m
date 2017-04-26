Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C22207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936435AbdDZUVu (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:51490 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935988AbdDZUVt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:21:49 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M93Jp-1dFLPw0zTp-00CSZd; Wed, 26
 Apr 2017 22:21:45 +0200
Date:   Wed, 26 Apr 2017 22:21:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 22/26] add_reflog_for_walk: avoid memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <aeb46b9436b1f5f54322cb818519db97801b9d7a.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JwDY8ciwAJBgwYmpl+73ZTEmJ50f9bbZvLjgkbNZr2WJz4lba2C
 KVHu/jRwHeZF0pgCs7cktYdYRUURofNv3I8AI3Q/M2qMRM58ECa3lTeNpPe3AmiBLS2q27H
 S8kN1nw5GJYw3UV6ZxBqMAYN7nMpAUkDELGWHIvHzBIR6OjdeIBAd1NECsPe1BGjJrAQs7g
 MzYmmKECWSpD1Y6AU1/dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H/XfpQ3AaKs=:W1IFCde0e5FdASMRrAhttq
 O+V3bhEXu+KgWttHq1PSd4T5Xot7n4yfNepWXsmI8l335yRmeJGHhav8AU0EyIHVOlRbI+AI5
 MQd7xTefgpbd+SyWTw4aS9aMzTYLZA80iLvSlrXV4KwXs/LmqJQAlA7SPsTUbt5FV82yj5fe1
 TBhC56/jWCM9BFCgFuvHC9NMwRFVo+vsnZb6jv2UmDsA63IdhOXqxPiTx6sm/UP4hI4ECEaAl
 X5Y7S2HvcvBV5FXs1dHuP23F9JflpwSvfcHkeEZDaq2a6evHC+SjlJIrHoGTvpnIG1ns0Y9vl
 ZhIBbTAO/11rHOEQ80A7cRZnI8U6p7XxiUkgL8owAYsB0Iz6j6+MYiTdgH4mwrx4mPTnp2PY6
 Z7UO68orp8KTI50SS2q6oDEypzgvNITzQH7k4VliREy6VQpnTS6CdVk80lYNlb47ynEYkZL/K
 frvoiP2lR4qoRVkVzzulrTixVfDbRsUHHdhcaL6hn0FpUC6cZQzodcYHyuWfHp5a4qrw96eZD
 wWQUAsiOmbRndEe7172HxdaE8B6E5kcNO/h/qlmAARaIjnEDmDsg07H14lEi8mLBsTifRgUhw
 FU7373/Y0NsvJ3OekuR4Z6LrWhlzZFgGVO2SdvRG99vGNTyt1GzSHLEv9nHcJ+h7ExciO+7GM
 g1yGSoH01HjvcHs1JUE7wWrcY5tdStbgo5/HQe6vqWo8VZhodntzRm850606SKTk7M1rChvUg
 Ah9crwcrZ+uD1ga0SnGHMPdRMa5ZGISVEljDT0J9Y2LTr1CmaNdaiwcot9b4bY+L9dxKRu/KN
 nk9gubP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We free()d the `log` buffer when dwim_log() returned 1, but not when it
returned a larger value (which meant that it still allocated the buffer
but we simply ignored it).

Identified by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reflog-walk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 99679f58255..ec66f2b16e6 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -183,7 +183,11 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		if (!reflogs || reflogs->nr == 0) {
 			struct object_id oid;
 			char *b;
-			if (dwim_log(branch, strlen(branch), oid.hash, &b) == 1) {
+			int ret = dwim_log(branch, strlen(branch),
+					   oid.hash, &b);
+			if (ret > 1)
+				free(b);
+			else if (ret == 1) {
 				if (reflogs) {
 					free(reflogs->ref);
 					free(reflogs);
-- 
2.12.2.windows.2.800.gede8f145e06


