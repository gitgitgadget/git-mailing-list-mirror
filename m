Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240C61FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 19:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbdFHTxp (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 15:53:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:58247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbdFHTxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 15:53:44 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTMzb-1dTGUx3AM3-00SLmZ; Thu, 08
 Jun 2017 21:53:36 +0200
Date:   Thu, 8 Jun 2017 21:53:35 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/8] config: report correct line number upon error
In-Reply-To: <cover.1496951503.git.johannes.schindelin@gmx.de>
Message-ID: <291e8b643990aee04654b34c6f953387c3c030d4.1496951503.git.johannes.schindelin@gmx.de>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HZ8bmeC00VdJLbrkwnyhB5Hw3TSaO2Gz4du0WnjgVKFXMJpf03W
 pMAVjbI5DuX6EBM7PsgxweLwAbrN18zi6W9y4LnU6dWhtMvCpiODNyOevgeS50G4fuaWScU
 0k0DkrkWMpbc5H0VrQANzuG2Yvk6njLwDY2Q52E19DJyca1ja9rBUvI9ANVq5cymBeKYrYw
 Vm8xJGAVgBQ4bf2SPNirg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZMR9pOBFqBQ=:+4O8Twn0lfYqUXFlzcvPM9
 a/S86pFnqenKryogtFB619ot/0Q1f83ubozTawEDL/g+X+c+n+Z5rLhlPBKEKIqvpe/Q/jH+0
 wm1fCb6RcSFpoapRz08E2s2I6QaylRUifXGHfGUXX67rao5biYzMP17V9wrKZOZWDoay3FiBn
 GKNDRKYeFHRuy8G5tCP9CLK2J2qXJmU4ekoaKulAeVP+h47MO92yBsirdvIBBx+9srnRCc6kw
 QjJyk64HRiRksz4OkUR7JTH8n1FePPdB8WYdWnXaQ1PUWg+52SbycMsZfHcEcGhCacvJcVKCI
 MVlqcSaj2ytDHEduhQ3JrPS8Lg6MMhLm4aXnD4Cd0ZtkwBrm4o78SjJvHgOerZO40PDhHEzdJ
 pZjPWyodApqAFGI25oygbTH2+6G1Sz2/RnxwNV7PEbTyaOljlm41+LW7T0xWmij4bCt3lEMuK
 bDrWQ5W43eB0FvardiD0nta4wGVbYYSLPlvRdu4MX/OumfxryH67NRQe0vSGjWfABA0Nr8OM9
 9CmpdBqdVKExJ1NbR6tWJ2YXBMXq1eBOKe+SQbaLTQAgl5HLlmR2zBbShPWJCPhRTXnUGnBeO
 QpBX6ifT64cjf+Clurk7aWhd7ypctqt0lGAed4+5JP6+eoXrqz/VTbhD8aAeyMUMBqcKaDYNt
 qfkO2P1NnerFBTMnf68LTJKjqKFyEF2YJQ8Qm+H58XmIL/WEe6vvws1KuohpLgsIi2R66R9z3
 xSzmNAs5ysNDKX3SxS5KUHZC61D8Kb1Y+adyJJRPo8wfbY5VtW4X1fPC6x/iacLpOGi8rJbnK
 iRlA0y+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When get_value() parses a key/value pair, it is possible that the line
number is decreased (because the \n has been consumed already) before the
key/value pair is passed to the callback function, to allow for the
correct line to be attributed in case of an error.

However, when git_parse_source() asks get_value() to parse the key/value
pair, the error reporting is performed *after* get_value() returns.

Which means that we have to be careful not to increase the line number
in get_value() after the callback function returned an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 146cb3452ad..9b88531a70d 100644
--- a/config.c
+++ b/config.c
@@ -604,7 +604,8 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 	 */
 	cf->linenr--;
 	ret = fn(name->buf, value, data);
-	cf->linenr++;
+	if (!ret)
+		cf->linenr++;
 	return ret;
 }
 
-- 
2.13.0.windows.1.460.g13f583bedb5


