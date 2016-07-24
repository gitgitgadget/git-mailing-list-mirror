Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0E2203C1
	for <e@80x24.org>; Sun, 24 Jul 2016 03:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbcGXDPo (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 23:15:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33858 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbcGXDPo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 23:15:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9386C203C1;
	Sun, 24 Jul 2016 03:15:43 +0000 (UTC)
Date:	Sun, 24 Jul 2016 03:15:43 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] format-patch: escape "From " lines recognized by
 mailsplit
Message-ID: <20160724031543.GC32480@starla>
References: <20160722224739.GA22961@whir>
 <alpine.DEB.2.20.1607231056150.14111@virtualbox>
 <20160724031409.GA32480@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160724031409.GA32480@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Users have mistakenly copied "From " lines into commit messages
in the past, and will certainly make the same mistakes in the
future.  Since not everyone uses mboxrd, yet, we should at least
prevent miss-split mails by always escaping "From " lines based
on the check used by mailsplit.

mailsplit will not perform unescaping by default, yet, as it
could cause further invocations of format-patch from old
versions of git to generate bad output.  Propagating the mboxo
escaping is preferable to miss-split patches.  Unescaping may
still be performed via "--mboxrd".

ref: https://public-inbox.org/git/20160606230248.GA15906@dcvr.yhbt.net/T/#u

Signed-off-by: Eric Wong <e@80x24.org>
---
 pretty.c                | 16 +++++++++++++---
 t/t4014-format-patch.sh | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index 9fa42c2..898c0a3 100644
--- a/pretty.c
+++ b/pretty.c
@@ -10,6 +10,7 @@
 #include "color.h"
 #include "reflog-walk.h"
 #include "gpg-interface.h"
+#include "mailinfo.h"
 
 static char *user_format;
 static struct cmt_fmt_map {
@@ -1745,9 +1746,18 @@ void pp_remainder(struct pretty_print_context *pp,
 			strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
 					     line, linelen);
 		else {
-			if (pp->fmt == CMIT_FMT_MBOXRD &&
-					is_mboxrd_from(line, linelen))
-				strbuf_addch(sb, '>');
+			switch (pp->fmt) {
+			case CMIT_FMT_EMAIL:
+				if (is_from_line(line, linelen))
+					strbuf_addch(sb, '>');
+				break;
+			case CMIT_FMT_MBOXRD:
+				if (is_mboxrd_from(line, linelen))
+					strbuf_addch(sb, '>');
+				break;
+			default:
+				break;
+			}
 
 			strbuf_add(sb, line, linelen);
 		}
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 1206c48..8fa3982 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1606,4 +1606,18 @@ test_expect_success 'format-patch --pretty=mboxrd' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch From escaping' '
+	cat >msg <<-INPUT_END &&
+	somebody pasted format-patch output into a body
+
+	From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
+	INPUT_END
+
+	C=$(git commit-tree HEAD^^{tree} -p HEAD <msg) &&
+	git format-patch --stdout -1 $C~1..$C >patch &&
+	git grep -h --no-index \
+		">From 0000000000000000000000000000000000000000 " \
+		patch
+'
+
 test_done
-- 
EW
