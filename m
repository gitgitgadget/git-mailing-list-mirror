Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650901F453
	for <e@80x24.org>; Mon, 22 Oct 2018 16:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeJWA5n (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 20:57:43 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58468 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJWA5n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 20:57:43 -0400
Received: from localhost.localdomain (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id C0B6C335CFD;
        Mon, 22 Oct 2018 16:38:28 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH 1/3] gpg-interface.c: use flags to determine key/signer info presence
Date:   Mon, 22 Oct 2018 18:38:19 +0200
Message-Id: <20181022163821.23523-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the logic used to determine whether key and signer information
is present to use explicit flags in sigcheck_gpg_status[] array.  This
is more future-proof, since it makes it possible to add additional
statuses without having to explicitly update the conditions.

Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 gpg-interface.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index d72a43b77..c7cd24ec0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -77,20 +77,27 @@ void signature_check_clear(struct signature_check *sigc)
 
 /* An exclusive status -- only one of them can appear in output */
 #define GPG_STATUS_EXCLUSIVE	(1<<0)
+/* The status includes key identifier */
+#define GPG_STATUS_KEYID	(1<<1)
+/* The status includes user identifier */
+#define GPG_STATUS_UID		(1<<2)
+
+/* Short-hand for standard exclusive *SIG status with keyid & UID */
+#define GPG_STATUS_STDSIG	(GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID|GPG_STATUS_UID)
 
 static struct {
 	char result;
 	const char *check;
 	unsigned int flags;
 } sigcheck_gpg_status[] = {
-	{ 'G', "GOODSIG ", GPG_STATUS_EXCLUSIVE },
-	{ 'B', "BADSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'G', "GOODSIG ", GPG_STATUS_STDSIG },
+	{ 'B', "BADSIG ", GPG_STATUS_STDSIG },
 	{ 'U', "TRUST_NEVER", 0 },
 	{ 'U', "TRUST_UNDEFINED", 0 },
-	{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE },
-	{ 'X', "EXPSIG ", GPG_STATUS_EXCLUSIVE },
-	{ 'Y', "EXPKEYSIG ", GPG_STATUS_EXCLUSIVE },
-	{ 'R', "REVKEYSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID },
+	{ 'X', "EXPSIG ", GPG_STATUS_STDSIG },
+	{ 'Y', "EXPKEYSIG ", GPG_STATUS_STDSIG },
+	{ 'R', "REVKEYSIG ", GPG_STATUS_STDSIG },
 };
 
 static void parse_gpg_output(struct signature_check *sigc)
@@ -117,13 +124,13 @@ static void parse_gpg_output(struct signature_check *sigc)
 				}
 
 				sigc->result = sigcheck_gpg_status[i].result;
-				/* The trust messages are not followed by key/signer information */
-				if (sigc->result != 'U') {
+				/* Do we have key information? */
+				if (sigcheck_gpg_status[i].flags & GPG_STATUS_KEYID) {
 					next = strchrnul(line, ' ');
 					free(sigc->key);
 					sigc->key = xmemdupz(line, next - line);
-					/* The ERRSIG message is not followed by signer information */
-					if (*next && sigc->result != 'E') {
+					/* Do we have signer information? */
+					if (*next && (sigcheck_gpg_status[i].flags & GPG_STATUS_UID)) {
 						line = next + 1;
 						next = strchrnul(line, '\n');
 						free(sigc->signer);
-- 
2.19.1

