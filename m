Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D42BE201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 12:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756749AbdKOMlQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 07:41:16 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:11583 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbdKOMlP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 07:41:15 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id Ewzze4wTmbjdZEx0Ce6U5b; Wed, 15 Nov 2017 12:41:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510749673;
        bh=y4U9mIWW9q3xBYuY44ZsIcqa5IEvNVUF1T2XTAV7kTo=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=MhhmskdiVblr+ax6NQpTIAJKyVbEtUjVi4jObg7ekLmK1PvN2Ou6d9MDNsioA1j7Y
         zLYEdMJop7A/kOzRjPdX4Xp11+2O7eBxGcgKgAhjioNVJotLnwvrS8xFvWYpW7ynS3
         Jqvpj0Nw8jNAYs1tEwbFXWgjQfEoPqxDkwfbu7V8=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=ZKv99eSElzivtxHZeo4A:9 a=3s7DeUTMT9qM5-8G:21 a=upZVyBtCIUG1uNwM:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] config: avoid "write_in_full(fd, buf, len) != len" pattern
Date:   Wed, 15 Nov 2017 12:40:43 +0000
Message-Id: <20171115124043.17147-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFxeLrol9GKZ0ulCcO3t91yeJtVu2nnVe+YPxsOSCAV6vopPCI0QhN1zLwuanJQ733ETwlWXWhYCanbeRbXCwCrSfG5lWzZh+QQWpAGvsOvTn6bBHE6w
 RMwMw188VfpknqMKPOQT3BF/Tjt0uqvvydiQdmnrQWZYkwsSfeWLEPgdWRtqmxeBApNNq9CAitZKU+/uMWHbUMErEzs1N3ykqzQBJZwUh8bLFVqq+/cldedW
 Rl8aYUCjDhCs3VuCRFCK0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As explained in commit 06f46f237 (avoid "write_in_full(fd, buf, len)
!= len" pattern, 2017–09–13) the return value of write_in_full() is
either -1 or the requested number of bytes. As such comparing the
return value to an unsigned value such as strbuf.len will fail to
catch errors. Change the code to use the preferred '< 0' check.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 903abf9533b188fd472c213c29a9f968eb90eb8b..d377161113009f394f118d81d27fa6117cde8e9f 100644
--- a/config.c
+++ b/config.c
@@ -2810,7 +2810,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 			 * multiple [branch "$name"] sections.
 			 */
 			if (copystr.len > 0) {
-				if (write_in_full(out_fd, copystr.buf, copystr.len) != copystr.len) {
+				if (write_in_full(out_fd, copystr.buf, copystr.len) < 0) {
 					ret = write_error(get_lock_file_path(&lock));
 					goto out;
 				}
@@ -2872,7 +2872,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	 * logic in the loop above.
 	 */
 	if (copystr.len > 0) {
-		if (write_in_full(out_fd, copystr.buf, copystr.len) != copystr.len) {
+		if (write_in_full(out_fd, copystr.buf, copystr.len) < 0) {
 			ret = write_error(get_lock_file_path(&lock));
 			goto out;
 		}
-- 
2.15.0

