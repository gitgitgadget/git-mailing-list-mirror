Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8EE1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755814AbdC1Tqz (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:46:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:53162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755796AbdC1Tqy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:46:54 -0400
Received: (qmail 11795 invoked by uid 109); 28 Mar 2017 19:46:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:39 +0000
Received: (qmail 6039 invoked by uid 111); 28 Mar 2017 19:46:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:46:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:36 -0400
Date:   Tue, 28 Mar 2017 15:46:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/18] create_branch: move msg setup closer to point of use
Message-ID: <20170328194636.fak7p7cvpk3zscgz@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In create_branch() we write the reflog msg into a buffer in
the main function, but then use it only inside a
conditional. If you carefully follow the logic, you can
confirm that we never use the buffer uninitialized nor write
when it would not be used. But we can make this a lot more
obvious by simply moving the write step inside the
conditional.

Signed-off-by: Jeff King <peff@peff.net>
---
 branch.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 5c12036b0..6d0ca94cc 100644
--- a/branch.c
+++ b/branch.c
@@ -234,7 +234,7 @@ void create_branch(const char *name, const char *start_name,
 {
 	struct commit *commit;
 	unsigned char sha1[20];
-	char *real_ref, msg[PATH_MAX + 20];
+	char *real_ref;
 	struct strbuf ref = STRBUF_INIT;
 	int forcing = 0;
 	int dont_change_ref = 0;
@@ -290,19 +290,20 @@ void create_branch(const char *name, const char *start_name,
 		die(_("Not a valid branch point: '%s'."), start_name);
 	hashcpy(sha1, commit->object.oid.hash);
 
-	if (forcing)
-		snprintf(msg, sizeof msg, "branch: Reset to %s",
-			 start_name);
-	else if (!dont_change_ref)
-		snprintf(msg, sizeof msg, "branch: Created from %s",
-			 start_name);
-
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
 
 	if (!dont_change_ref) {
 		struct ref_transaction *transaction;
 		struct strbuf err = STRBUF_INIT;
+		char msg[PATH_MAX + 20];
+
+		if (forcing)
+			snprintf(msg, sizeof msg, "branch: Reset to %s",
+				 start_name);
+		else
+			snprintf(msg, sizeof msg, "branch: Created from %s",
+				 start_name);
 
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
-- 
2.12.2.845.g55fcf8b10

