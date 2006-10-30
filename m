X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/5] add tests for shallow stuff
Date: Mon, 30 Oct 2006 20:10:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610302010040.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 30 Oct 2006 19:23:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30512>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecWx-0006IP-O8 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161464AbWJ3TK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161469AbWJ3TK3
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:10:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:8588 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161464AbWJ3TK2 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:10:28 -0500
Received: (qmail invoked by alias); 30 Oct 2006 19:10:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 30 Oct 2006 20:10:20 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5500-fetch-pack.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f7625a6..fa10840 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -128,4 +128,49 @@ pull_to_client 2nd "B" $((64*3))
 
 pull_to_client 3rd "A" $((1*3)) # old fails
 
+test_expect_success "clone shallow" "git-clone --depth 2 . shallow"
+
+(cd shallow; git-count-objects -v) > count.shallow
+
+test_expect_success "clone shallow object count" \
+	"test \"in-pack: 18\" = \"$(grep in-pack count.shallow)\""
+
+test_expect_success "clone shallow object count (part 2)" \
+	"test -z \"$(grep -v in-pack count.shallow | sed "s/^.*: 0//")\""
+
+test_expect_success "fsck in shallow repo" \
+	"(cd shallow; git-fsck-objects --full)"
+
+#test_done; exit
+
+add B66 $B65
+add B67 $B66
+
+test_expect_success "pull in shallow repo" \
+	"(cd shallow; git pull .. B)"
+
+(cd shallow; git-count-objects -v) > count.shallow
+test_expect_success "clone shallow object count" \
+	"test \"count: 6\" = \"$(grep count count.shallow)\""
+
+add B68 $B67
+add B69 $B68
+
+test_expect_success "deepening pull in shallow repo" \
+	"(cd shallow; git pull --depth 4 .. B)"
+
+(cd shallow; git-count-objects -v) > count.shallow
+test_expect_success "clone shallow object count" \
+	"test \"count: 12\" = \"$(grep count count.shallow)\""
+
+test_expect_success "deepening fetch in shallow repo" \
+	"(cd shallow; git fetch --depth 4 .. A:A)"
+
+(cd shallow; git-count-objects -v) > count.shallow
+test_expect_success "clone shallow object count" \
+	"test \"count: 18\" = \"$(grep count count.shallow)\""
+
+test_expect_failure "pull in shallow repo with missing merge base" \
+	"(cd shallow; git pull --depth 4 .. A)"
+
 test_done
-- 
1.4.3.3.gca42
