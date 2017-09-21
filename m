Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UPPERCASE_50_75 shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D6A2047F
	for <e@80x24.org>; Thu, 21 Sep 2017 07:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdIUHti (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 03:49:38 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:43235 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751531AbdIUHth (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Sep 2017 03:49:37 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=celaeno.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ijc-relay-phiayoh8@benson.default.arb33.uk0.bigv.io>)
        id 1duwEp-0005OB-6O; Thu, 21 Sep 2017 08:49:35 +0100
Received: from dagon.hellion.org.uk ([192.168.1.7])
        by celaeno.hellion.org.uk with smtp (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1duwEn-0000hj-Kr; Thu, 21 Sep 2017 08:49:34 +0100
Received: by dagon.hellion.org.uk (sSMTP sendmail emulation); Thu, 21 Sep 2017 08:49:33 +0100
From:   Ian Campbell <ijc@hellion.org.uk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>
Subject: [PATCH v3 2/4] filter-branch: preserve and restore $GIT_AUTHOR_* and $GIT_COMMITTER_*
Date:   Thu, 21 Sep 2017 08:49:30 +0100
Message-Id: <20170921074932.5490-2-ijc@hellion.org.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1505980146.4636.9.camel@hellion.org.uk>
References: <1505980146.4636.9.camel@hellion.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are modified by set_ident() but a subsequent patch would like to operate
on their original values.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
---
 git-filter-branch.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3da281f8a..9edb94206 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -219,6 +219,13 @@ trap 'cd "$orig_dir"; rm -rf "$tempdir"' 0
 ORIG_GIT_DIR="$GIT_DIR"
 ORIG_GIT_WORK_TREE="$GIT_WORK_TREE"
 ORIG_GIT_INDEX_FILE="$GIT_INDEX_FILE"
+ORIG_GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME"
+ORIG_GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL"
+ORIG_GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE"
+ORIG_GIT_COMMITTER_NAME="$GIT_COMMITTER_NAME"
+ORIG_GIT_COMMITTER_EMAIL="$GIT_COMMITTER_EMAIL"
+ORIG_GIT_COMMITTER_DATE="$GIT_COMMITTER_DATE"
+
 GIT_WORK_TREE=.
 export GIT_DIR GIT_WORK_TREE
 
@@ -545,6 +552,8 @@ if [ "$filter_tag_name" ]; then
 fi
 
 unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
+unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE
 test -z "$ORIG_GIT_DIR" || {
 	GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
 }
@@ -556,6 +565,30 @@ test -z "$ORIG_GIT_INDEX_FILE" || {
 	GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
 	export GIT_INDEX_FILE
 }
+test -z "$ORIG_GIT_AUTHOR_NAME" || {
+	GIT_AUTHOR_NAME="$ORIG_GIT_AUTHOR_NAME" &&
+	export GIT_AUTHOR_NAME
+}
+test -z "$ORIG_GIT_AUTHOR_EMAIL" || {
+	GIT_AUTHOR_EMAIL="$ORIG_GIT_AUTHOR_EMAIL" &&
+	export GIT_AUTHOR_EMAIL
+}
+test -z "$ORIG_GIT_AUTHOR_DATE" || {
+	GIT_AUTHOR_DATE="$ORIG_GIT_AUTHOR_DATE" &&
+	export GIT_AUTHOR_DATE
+}
+test -z "$ORIG_GIT_COMMITTER_NAME" || {
+	GIT_COMMITTER_NAME="$ORIG_GIT_COMMITTER_NAME" &&
+	export GIT_COMMITTER_NAME
+}
+test -z "$ORIG_GIT_COMMITTER_EMAIL" || {
+	GIT_COMMITTER_EMAIL="$ORIG_GIT_COMMITTER_EMAIL" &&
+	export GIT_COMMITTER_EMAIL
+}
+test -z "$ORIG_GIT_COMMITTER_DATE" || {
+	GIT_COMMITTER_DATE="$ORIG_GIT_COMMITTER_DATE" &&
+	export GIT_COMMITTER_DATE
+}
 
 cd "$orig_dir"
 rm -rf "$tempdir"
-- 
2.11.0

