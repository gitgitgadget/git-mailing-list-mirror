Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A99AD1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeDQVQj (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:16:39 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56984 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeDQVQj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:16:39 -0400
Received: from trochilidae.lan (unknown [IPv6:2001:1620:c6e::127])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9919F5C0345;
        Tue, 17 Apr 2018 23:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1523999797; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=/iMZdUz9X8kxRuzEjdD2EMgWv8rnAjbvx4KIj3Z4AeU=;
        b=l9pQYNd3hBT/FexnZM9vvZp0vuFBuWB2fU90quFilAB6GQem/FB8nb+H0ySNgnEEEUhHUx
        39ZOGMRZYNdrvJqgMFiAeplV+sZPdW0HhqT1Nu44ijjdWejRT4ih2CWZcnLugQunvxC/I5
        bcNk0DVrymyuJLhXCHQq7Xs5H8jrP38=
From:   Stefan Agner <stefan@agner.ch>
To:     git@vger.kernel.org
Cc:     stefan@agner.ch
Subject: [PATCH] send-email: avoid duplicate In-Reply-To/References
Date:   Tue, 17 Apr 2018 23:16:30 +0200
Message-Id: <20180417211630.22873-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [0.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         ASN(0.00)[asn:13030, ipnet:2001:1620::/32, country:CH];
         FROM_EQ_ENVFROM(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MIME_GOOD(-0.10)[text/plain];
         ARC_NA(0.00)[];
         TO_DN_NONE(0.00)[]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case a patch already has In-Reply-To or References in the header
(e.g. when the patch has been created with format-patch --thread)
git-send-email should not add another pair of those headers.
This is also not allowed according to RFC 5322 Section 3.6:
https://tools.ietf.org/html/rfc5322#section-3.6

Avoid the second pair by reading the current headers into the
appropriate variables.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This addresses the issue reported here:
https://public-inbox.org/git/997160314bbafb3088a401f1c09ccb08@agner.ch/

 git-send-email.perl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2fa7818ca..7157397fd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1642,10 +1642,15 @@ foreach my $t (@files) {
 			elsif (/^Content-Transfer-Encoding: (.*)/i) {
 				$xfer_encoding = $1 if not defined $xfer_encoding;
 			}
+			elsif (/^In-Reply-To: (.*)/i) {
+				$in_reply_to = $1;
+			}
+			elsif (/^References: (.*)/i) {
+				$references = $1;
+			}
 			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
 				push @xh, $_;
 			}
-
 		} else {
 			# In the traditional
 			# "send lots of email" format,
-- 
2.17.0

