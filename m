Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF04207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998186AbdD1Nuk (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:50:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:56555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998158AbdD1Nug (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:50:36 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfTC1-1dsbSg2CIz-00p5Ff; Fri, 28
 Apr 2017 15:50:23 +0200
Date:   Fri, 28 Apr 2017 15:50:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 06/25] get_mail_commit_oid(): avoid resource leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <498595a4ef9d56c0b42fcd0d8815a6fea598f9dd.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RkZrtzt4COuXDexeR7KPrMcJYpTqAXpxbszCNz2/NIF3Ou2WJcY
 q/5VrnN9POEvMe63JKNJR99rZLcgwFywRdfJa1XBPl1NM9p9WEEy/E+ii+QMH3zESeEL6TN
 tOA3Xoq0Mt5wemPUJFY8eot5YgmhUyV6gYd00ZnX6z4WtRJCjaplT1OXDi470OkNENQR2rf
 6CL0VRz4+v0SYoEgAEKDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kEhFUg/UFMY=:gvN4mBUx6sI6hJPYxZkB8a
 0rw+6mrRy1XRJLhEiU0QfqfGChsScgSfwRY5JXEEW3eoJTDOse6oOHKX0c+t9+In2Y6jSTXus
 sDzBJRVqf8ZS+EnbmaNY+aKTeBG9aEXrK8pApiO5IxFF9DxcZp9NJYZgNCOoPfxlV+qZSr++I
 +3EVPmV08wqGR/LQgwfoXHG+/fRWdwFMb7FPqBnZm6LUs7/flN+MokGA0+sHgNvskJsQ93UNx
 Zo+ywRpdpt+rnOPJOi/Ox76KHl7OjcXk9YxkOcqzPfMsaUl/5s9pls6Gmg2iJW7dP9fXoIZky
 4H1Q3OaU3Rf+DS+rXm6U51FesyZ3ky6d8pQ7hIarG1iKvZTgWAgpiHglAu+1+hn1HBFjVXVbN
 vVgY1YFphFTLhbztpK4vfJokhmSSiK2MaQqMrg27HkczpCQ7MDfpEC1pHT8t8xfF89EprX8vS
 HxJp+RAewgmVGJ8uxa7ibVg+h3deKJwtd2LBc2xRG0VvFqVNpF89TRcvfnDnxzp4D2RiqS6gV
 wq7xcH60/UhNTkdFxLn7h7oigXmBb1WOAcViHH4KrLsKL+mFt7I2RtlWOWXpH6CprBethjdP5
 tsRo/y1qD8Th7F+TFY4ADRG7qTU76VI9a9V8S28wV0GB1MsE1q4q7ERjT2FRlgKRhVeb4wVE1
 7EGTQHXwHCQHFzhqL/+jM2f4dJcVkT3YVzaLnxZ63Bo1CfNUcPxHfDLs6AMBw1a+WwbfSKtAE
 uWYb2flg2eILoVEq/M2MHm5VDN8mtWQ+9jTITdCTi9Kl77r5+FiIDzPIK7WZmZvE7G6aBm4ZP
 eVKSNWy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we fail to read, or parse, the file, we still want to close the file
descriptor and release the strbuf.

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e6c..9c5c2c778e2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1351,19 +1351,16 @@ static int get_mail_commit_oid(struct object_id *commit_id, const char *mail)
 	struct strbuf sb = STRBUF_INIT;
 	FILE *fp = xfopen(mail, "r");
 	const char *x;
+	int ret = 0;
 
-	if (strbuf_getline_lf(&sb, fp))
-		return -1;
-
-	if (!skip_prefix(sb.buf, "From ", &x))
-		return -1;
-
-	if (get_oid_hex(x, commit_id) < 0)
-		return -1;
+	if (strbuf_getline_lf(&sb, fp) ||
+	    !skip_prefix(sb.buf, "From ", &x) ||
+	    get_oid_hex(x, commit_id) < 0)
+		ret = -1;
 
 	strbuf_release(&sb);
 	fclose(fp);
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.12.2.windows.2.800.gede8f145e06


