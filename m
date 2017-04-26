Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E475207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967212AbdDZUTr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:19:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:55240 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967211AbdDZUTq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:19:46 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyB6P-1e8YZ92g5d-015cQN; Wed, 26
 Apr 2017 22:19:42 +0200
Date:   Wed, 26 Apr 2017 22:19:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/26] get_mail_commit_oid(): avoid resource leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <1a12ba40a2db3925534bd2192ed8e9ab9a87215e.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iyiiAk0UIs91ZuzmQAUa9jAgrrdHsZfk54O/T3/tTxpboH8ML90
 l5gg4DuXNVjd/Jk3j77FsWQ2m39b7WfCKZxZKdOlq/Vg+4pAHw0JPRoKGpXNqXeYhnpF/cJ
 gJ9zmpAoGibDUFPbN/jX/SLPNKrR2E/ygLQ5Zo/5VrYjoUCO1AvszCFkeVVsgV+R1NJU4zT
 00/yN9OmJfcaAf7ZdO9zQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e/AjOmx1NPU=:uiV8D9b2OR8MRiFaeLrGK0
 AG8z96peVdkjJhGHvRgAVFLspaLzP6hlc6oamFDWGztMGRFfRtEM8iy6LGccQKlwzJ9xqLzX+
 m59RrhC9ZtceD9k8/CCUqmu4wbF4efHXXT62wuBbQtCT7Oh/Z5z5OLk3OopehDGuJDot/LhGN
 5hPl1S3ADNUdgIt+OsvuBIe9zUpGQ3gbXqdHHZoEnhvzCGYrz33mS6aEgUF457rY3lUJKGUdC
 HcByEuAJY7r73gjKDheJEsuKy9YxZFf1fRrqMDQKLgrpJFyx/KmU6xwx3XIREC4ncx/gIy8DU
 ExAIz6yYB8JM7kyJGxjVHGzZiTRcJDWsy6Kh6EfDxFz4Ub2L35Ks+4c8Bk2cofyO7er130Isf
 DKSWvQhzKHYHA6ztLuRzL0rLUlnsoEOmFRxuj94q1naimTcns37md6JVHplbom3HNYgBylD5/
 uquCHpc0Wkeu6okn2tp961s5R9x1xSXwu6kIfgFbuiA3LPln8WbwVRK5WPzudodGxb3KEBkmr
 GPfvb4aC7qf2Yd/2ZrWkCSVB+5pZHmADpfWt/qDgrWrbx/bGmi6r+7hamTX7TQecZ+d6vepgZ
 atpd82Isw2ApWk7B6nLEl7EJ0fX8kpFxFf/kjhDhS/zgiHIPCKeBDjx1/PpnWuaYOf2J1erkl
 h76OGyX3PUcrGlQd1JHUH2fgdjF03L9xeqW4QogCaS/qxHzc1Xe7SJWt8+lAIJBqblUefXM9a
 OkqjqrX9dHgnH5FiwjLEEci4jbLhmsM8a7yMgtaUpI2idjvgpRAzw5aMXSjrAIoaA90IgyqYJ
 vyHSBem
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we fail to read, or parse, the file, we still want to close the file
descriptor and release the strbuf.

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 805f56cec2f..01b700e5e74 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1359,15 +1359,16 @@ static int get_mail_commit_oid(struct object_id *commit_id, const char *mail)
 	struct strbuf sb = STRBUF_INIT;
 	FILE *fp = xfopen(mail, "r");
 	const char *x;
+	int ret = 0;
 
 	if (strbuf_getline_lf(&sb, fp))
-		return -1;
+		ret = -1;
 
-	if (!skip_prefix(sb.buf, "From ", &x))
-		return -1;
+	if (!ret && !skip_prefix(sb.buf, "From ", &x))
+		ret = -1;
 
-	if (get_oid_hex(x, commit_id) < 0)
-		return -1;
+	if (!ret && get_oid_hex(x, commit_id) < 0)
+		ret = -1;
 
 	strbuf_release(&sb);
 	fclose(fp);
-- 
2.12.2.windows.2.800.gede8f145e06


