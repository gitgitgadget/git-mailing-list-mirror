Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E90B20209
	for <e@80x24.org>; Fri, 30 Jun 2017 09:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdF3Jtq (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 05:49:46 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:43502 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbdF3Jtp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 05:49:45 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id QsYKdOu0hQ527QsYUdIMsk; Fri, 30 Jun 2017 10:49:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498816178; bh=w649qbttzhuozNlpEIxCrlUN+SQdl0TIOBEwAzNhLl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=j2/CJ4ToM8yiG+GXDzlvuYctOLKmt7O9vmbQklu6+EsgqGE68nBqyL4QggA22aYO9
         xyXMTCgGKFTJidC5NjlyDYIwaFdt/OWKOwg+u43rFq7emhNkVFi6e5LLQD+qXGbBOi
         fKLQcVN5nfqRjOqhbo14925A9ocvhpPUHjsBqHsc=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=UfIPNLuakzglBe7AD4YA:9
 a=6pVivHccWpyHBqUO:21 a=ZZC-Zjf8zkUu619j:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/4] Git::unquote_path() Handle '\a'
Date:   Fri, 30 Jun 2017 10:49:10 +0100
Message-Id: <20170630094912.8653-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170630094912.8653-1-phillip.wood@talktalk.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
 <20170630094912.8653-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLhEq/Bb6X6SAINUTOJUpshm65L+1VYks6ohScTEfKR8Y8Di4PJZ/5JLC5HV9q2OI+JI4IvZisy4t2qp3CLSdT9VfZ6m9bRRZlRxEbVMRRvvr8Bh/ulj
 ZTF2oRcQW9faWzYVyxdTv+MYTMQrpsQhs06K5K5fbcHTeMdrnQU6ujp+qjxqPDJAo/iFt0vCpkvGcp+CRBNZkKKoDTv7DwEriTDFhg14eFtQVjLE+ZfLUFhV
 TGCM0DiINysm8DIg9VDdoVLa5Uu8XrR2y5+N6NONgSE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The version copied from git-add--interactive did not handle quoted
paths containing '\a'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 perl/Git.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 35188842ef82c67f83f6d72fd37e38edb895328b..f075b500c510d183074c0358fb24fefc72248125 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1461,6 +1461,7 @@ when not using -z or when parsing the output of diff -u.
 
 {
 	my %cquote_map = (
+		"a" => chr(7),
 		"b" => chr(8),
 		"t" => chr(9),
 		"n" => chr(10),
@@ -1487,7 +1488,7 @@ when not using -z or when parsing the output of diff -u.
 					$_ = $2;
 					last;
 				}
-				if (/^([\\\042btnvfr])(.*)$/) {
+				if (/^([\\\042abtnvfr])(.*)$/) {
 					$retval .= $cquote_map{$1};
 					$_ = $2;
 					last;
-- 
2.13.1

