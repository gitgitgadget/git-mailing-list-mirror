Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3977D20756
	for <e@80x24.org>; Thu, 12 Jan 2017 07:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdALHXU (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 02:23:20 -0500
Received: from p3plsmtps2ded03.prod.phx3.secureserver.net ([208.109.80.60]:47254
        "EHLO p3plsmtps2ded03.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdALHXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 02:23:19 -0500
Received: from linuxonhyperv.com ([72.167.245.219])
        by : HOSTING RELAY : with SMTP
        id RZiEcODWEsUr3RZiEcNHUG; Thu, 12 Jan 2017 00:22:18 -0700
x-originating-ip: 72.167.245.219
Received: by linuxonhyperv.com (Postfix, from userid 528)
        id DFC721900F6; Thu, 12 Jan 2017 01:20:48 -0800 (PST)
From:   Matthew Wilcox <mawilcox@linuxonhyperv.com>
To:     git@vger.kernel.org
Cc:     Matthew Wilcox <mawilcox@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/2] mailinfo: Understand forwarded patches
Date:   Thu, 12 Jan 2017 01:20:24 -0800
Message-Id: <1484212824-14108-2-git-send-email-mawilcox@linuxonhyperv.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1484212824-14108-1-git-send-email-mawilcox@linuxonhyperv.com>
References: <1484212824-14108-1-git-send-email-mawilcox@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfChg/n0gbqu3PgRGNaVA5TBE9KYaYNVC8TcumnkttHtUrCijh6NFf8LMpHYILfxJNve74XK/dDEB4ipjtSjuQRsu9fEsNAQaHI/OkCLpWOspiGAK8cDl
 NZKV1tNVJyM5uEotkifQW/5VxA2lnn1BuRZRMu8TJB3ss+xt+f61rJqv89JJhw08sbrWuSCZWB2ICzs6IPjxfV6FJ9XR+i6O18RnteV1M12NFrzTHvxztnY6
 BvUraHQvMMaqBrToY6z4yg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Extend the --scissors mechanism to strip off the preamble created by
forwarding a patch.  There are a couple of extra headers ("Sent" and
"To") added by forwarding, but other than that, the --scissors option
will now remove patches forwarded from Microsoft Outlook to a Linux
email account.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mailinfo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index 2059704a8..fc1275532 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -332,7 +332,7 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
 
 #define MAX_HDR_PARSED 10
 static const char *header[MAX_HDR_PARSED] = {
-	"From","Subject","Date",
+	"From","Subject","Date","Sent","To",
 };
 
 static inline int cmp_header(const struct strbuf *line, const char *hdr)
@@ -685,6 +685,13 @@ static int is_scissors_line(const char *line)
 			c++;
 			continue;
 		}
+		if (!memcmp(c, "Original Message", 16)) {
+			in_perforation = 1;
+			perforation += 16;
+			scissors += 16;
+			c += 15;
+			continue;
+		}
 		in_perforation = 0;
 	}
 
-- 
2.11.0

