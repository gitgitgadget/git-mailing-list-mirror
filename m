Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6082D20285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbdH3Ru3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:29 -0400
Received: from mout.web.de ([212.227.17.11]:58259 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbdH3RuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:09 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLxs8-1dsam338w8-007k33 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:07 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 17/34] mailinfo: release strbuf on error return in handle_boundary()
Date:   Wed, 30 Aug 2017 19:49:48 +0200
Message-Id: <20170830175005.20756-18-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:li0rOYF/tzZ5XWbiY5CU7VOLKEE2VrzKyclDFXbuCzITIWO3jhX
 N4ZdUSRqvza2vKSVOTaZvv5CV0jngbzJNw0+VgH4MWh1QApWuImwGMseTadd6fxDRDivRCn
 tGr9b1bsYstSVGoSeqDPlSQUpCkeUWdmQu25IHNrtBu3paJsr7aCmdwnkUgK/xT817iWMtH
 brQQfXOB6msDAygLPAycg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z1HIhPu864c=:2zto3tZvns3syeLrrZVjRu
 jLYOqlauORzWgmlgAlOBzQ9eNoXt5V2GIvszE0Q4pMVRd5raXh7sC0gP0gYC4JdXPnzmRltsr
 9P780KmfZ2dc30Hxt3+pLkI6+pa7iENJ8RQb7P4BpL1l/J1QhFMHUR6iw0WgndFHhjqG+UZcM
 2Z3brUVpwvqtD+HSw4ia6IxkKIr89g5PUqswpsFH67QLXH3FwJoR8FIGxDNvYOHM4rHmXmUN9
 Qvxn3H/+1INJQEyk6skA6q2bngp5PMz+u75kJWL1Aw041agwnPBa4CUGMuglyqN3aCQY9cyWr
 TxrxE7tPTZQ+05bNpXgBNFCBe/AqgTUJKE7d1PUQ4lXv4B5g7RK/DiCYxYbT7zzKJDr33WVjN
 hbPSMQUIaLJnSg5AV7/OP0itXpghbFGqWEVZufVG+idHZe4lPGJ85wFKWVdYa/6NPSQj4hsSe
 QgP3i6osmhNFwxNnfveI0HrrMqoef19JhaHpTr+JuSwTz4UxQLM7h2G0nT+sHW67tqKrDeVHR
 0FVu5J14Sm8/qpY6yiQz4ubh3H6x1+uZmL1WrIjEDrefZJfrsxj5PI7raZk/SrFAwTlfyuyRu
 6aN+PJcqu/mxcpSaPAJWlEuHScKWSsivKPbeD2s/cu1A1XQ+5eTujzlH5L/6QRJs0hkABbq1b
 IzCbpv4Hc+XbDcpyIhOHVw/7I0smsF3QcotYEvXvMC+ceWHOK2tAKjVaCcKRXib7UyQgTflZW
 2n3IdIkfIMU4s6iCVWZVMunKDHbGU7jo6gkbh0i57ceIh7NyB6kLMF/xskF9f81PWCbmS/oeo
 93XbeSvXitaXFRcm9qTbe2olDHqEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 mailinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mailinfo.c b/mailinfo.c
index b1f5159546..f2387a3267 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -911,48 +911,49 @@ static int find_boundary(struct mailinfo *mi, struct strbuf *line)
 static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf newline = STRBUF_INIT;
 
 	strbuf_addch(&newline, '\n');
 again:
 	if (line->len >= (*(mi->content_top))->len + 2 &&
 	    !memcmp(line->buf + (*(mi->content_top))->len, "--", 2)) {
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
 		strbuf_release(*(mi->content_top));
 		FREE_AND_NULL(*(mi->content_top));
 
 		/* technically won't happen as is_multipart_boundary()
 		   will fail first.  But just in case..
 		 */
 		if (--mi->content_top < mi->content) {
 			error("Detected mismatched boundaries, can't recover");
 			mi->input_error = -1;
 			mi->content_top = mi->content;
+			strbuf_release(&newline);
 			return 0;
 		}
 		handle_filter(mi, &newline);
 		strbuf_release(&newline);
 		if (mi->input_error)
 			return 0;
 
 		/* skip to the next boundary */
 		if (!find_boundary(mi, line))
 			return 0;
 		goto again;
 	}
 
 	/* set some defaults */
 	mi->transfer_encoding = TE_DONTCARE;
 	strbuf_reset(&mi->charset);
 
 	/* slurp in this section's info */
 	while (read_one_header_line(line, mi->input))
 		check_header(mi, line, mi->p_hdr_data, 0);
 
 	strbuf_release(&newline);
 	/* replenish line */
 	if (strbuf_getline_lf(line, mi->input))
 		return 0;
 	strbuf_addch(line, '\n');
 	return 1;
 }
-- 
2.14.1

