Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836B91F453
	for <e@80x24.org>; Mon, 21 Jan 2019 07:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfAUHNR (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 02:13:17 -0500
Received: from fed1rmfepi102.cox.net ([68.230.241.133]:43375 "EHLO
        fed1rmfepi102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfAUHNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:16 -0500
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190121051647.DROY4064.fed1rmfepo101.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Mon, 21 Jan 2019 00:16:47 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 2167FB82575;
        Sun, 20 Jan 2019 22:16:47 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090202.5C4555BF.004B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=QvfqIm6d c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8 a=PzJFpfYIsgoufMCHn0sA:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 2/5] Replace the proposed 'auto' mode with 'auto:'
Date:   Sun, 20 Jan 2019 22:16:43 -0700
Message-Id: <20190121051646.20991-3-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20190121051646.20991-1-ischis2@cox.net>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20190121051646.20991-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to adding the 'human' format, the patch added the auto
keyword which could be used in the config file as an alternate way to
specify the human format.  Removing 'auto' cleans up the 'human'
format interface.

Added the ability to specify mode 'foo' if the pager is being used by
using auto:foo syntax.  Therefore, 'auto:human' date mode defaults to
human if we're using the pager.  So you can do

	git config --add log.date auto:human

and your "git log" commands will show the human-legible format unless
you're scripting things.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 date.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/date.c b/date.c
index a8d50eb206..43c3a84e25 100644
--- a/date.c
+++ b/date.c
@@ -883,11 +883,6 @@ int parse_date(const char *date, struct strbuf *result)
 	return 0;
 }
 
-static int auto_date_style(void)
-{
-	return (isatty(1) || pager_in_use()) ? DATE_HUMAN : DATE_NORMAL;
-}
-
 static enum date_mode_type parse_date_type(const char *format, const char **end)
 {
 	if (skip_prefix(format, "relative", end))
@@ -907,8 +902,6 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
 		return DATE_NORMAL;
 	if (skip_prefix(format, "human", end))
 		return DATE_HUMAN;
-	if (skip_prefix(format, "auto", end))
-		return auto_date_style();
 	if (skip_prefix(format, "raw", end))
 		return DATE_RAW;
 	if (skip_prefix(format, "unix", end))
@@ -923,6 +916,14 @@ void parse_date_format(const char *format, struct date_mode *mode)
 {
 	const char *p;
 
+	/* "auto:foo" is "if tty/pager, then foo, otherwise normal" */
+	if (skip_prefix(format, "auto:", &p)) {
+		if (isatty(1) || pager_in_use())
+			format = p;
+		else
+			format = "default";
+	}
+
 	/* historical alias */
 	if (!strcmp(format, "local"))
 		format = "default-local";
-- 
2.20.1.2.gb21ebb671b

