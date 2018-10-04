Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9296A1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 22:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeJEFsV (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:48:21 -0400
Received: from mx.sdf.org ([205.166.94.20]:63748 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeJEFsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:48:21 -0400
Received: from sdf.org (IDENT:aedifex@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id w94MqT20013615
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO)
        for <git@vger.kernel.org>; Thu, 4 Oct 2018 22:52:29 GMT
Received: (from aedifex@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id w94MqTgG000017
        for git@vger.kernel.org; Thu, 4 Oct 2018 22:52:29 GMT
Date:   Thu, 4 Oct 2018 22:52:29 +0000
From:   Tacitus Aedifex <aedifex@sdf.org>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2] gpg-interface.c: detect and reject multiple
 signatures on commits
Message-ID: <20181004225229.GA15236@SDF.ORG>
Mail-Followup-To: git@vger.kernel.org
References: <20180817073441.5247-1-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180817073441.5247-1-mgorny@gentoo.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think that there is a more simple way to catch multiple signatures see below.  
Other than that, I like this patch.

Signed-off-by: Tacitus Aedifex <aedifex@sdf.org>
---
 gpg-interface.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index db17d65f8..a4dba3361 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -93,6 +93,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
 	int i;
+	int multi_sig = 0;
 
 	/* Iterate over all search strings */
 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
@@ -115,6 +116,23 @@ static void parse_gpg_output(struct signature_check *sigc)
 				next = strchrnul(found, '\n');
 				sigc->signer = xmemdupz(found, next - found);
 			}
+		} else 
+			multi_sig++;
+
+		/*
+		 * GOODSIG, BADSIG, etc. can occure only once for each signature.
+		 * Therefore, if we had more than one then we're dealing with
+		 * multiple signatures. We don't support them currently and they are
+		 * rather hard to create, so something is likely probably not right
+		 * and we should reject them altogether.
+		 */
+		if (multi_sig > 1) {
+			sigc->result = 'E';
+			/* clear partial data to avoid confusion */
+			if (sigc->signer)
+				FREE_AND_NULL(sigc->signer);
+			if (sigc->key)
+				FREE_AND_NULL(sigc->key);
 		}
 	}
 }
--
2.18.0.129.ge333175
-- 
