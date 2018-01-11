Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7621E1F404
	for <e@80x24.org>; Thu, 11 Jan 2018 05:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeAKFkP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 00:40:15 -0500
Received: from elephants.elehost.com ([216.66.27.132]:59974 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbeAKFkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 00:40:13 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0B5eANG030048
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 00:40:11 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
Subject: [PATCH] Replaced read with xread in transport-helper.c to fix SSIZE_MAX overun in t5509
Date:   Thu, 11 Jan 2018 00:40:05 -0500
Message-ID: <010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdOKnmZ2Smi5Li2SSkyPPxL3xhEE+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fix was needed on HPE NonStop NSE where SSIZE_MAX is less than
BUFFERSIZE resulting in EINVAL. The call to read in transport-helper.c
was the only place outside of wrapper.c.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 3640804..68a4e30 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1202,7 +1202,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
                return 0;       /* No space for more. */

        transfer_debug("%s is readable", t->src_name);
-       bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
+       bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
        if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
                errno != EINTR) {
                error_errno("read(%s) failed", t->src_name);
--
2.8.5.23.g6fa7ec3


