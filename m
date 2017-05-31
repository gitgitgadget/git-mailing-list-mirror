Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50F920D0A
	for <e@80x24.org>; Wed, 31 May 2017 10:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbdEaK0V (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 06:26:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36595 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdEaK0U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 06:26:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so2026924pfb.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B2Irkv6vEyIZCKkY3Y+I45BZMmav63R5L26KYHBQgCQ=;
        b=NxBZ288zvlbGKzGv8+yLvB4gEZPMHYuKyJGuso9lXU2RZAjPpsR5iNKXMjMeTfwhJz
         VAfOrNuC0tUnVrLPfxQHp57IdSytTeCBLuuVrNWe+yjvQgsp1eTQT35bVBg89NwLmq5n
         U8s1CoHqe6VxDtp4LlFUaWk+/aYijnCIUWvZPvZWOJbXfNYmjttOocKM8CdwhIQaPPNX
         vtVrCw1kiMn/KqFsX+FxmOHqdgoBMiakeiOoj2Cb4Ud1lEJPvsWwSWJy0+8yFwS6OK6S
         aCqxCMZKf6OHQKYXunbXHCUSUYA2ldIbWM54X8lxkIfhLBRGXtyzxb9ct9w3CY3sUrhN
         i1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B2Irkv6vEyIZCKkY3Y+I45BZMmav63R5L26KYHBQgCQ=;
        b=aXkT2Gm0EtnZknk7wJmzfWzjjEf7Na/mkmCaDJO18Dy9UZWeeanffgyG7gmIf6xvfi
         XFYuqTc2wpLmTwcxg/N5UqhhQnVH0tM3r4Ql0YpbdjIpPZ3GikxOzUgQpcrKoGSeOQQK
         E7GENkNMvQP+xUMwHV4Wygcdi5BBv+A/giJnN//0fRkvL9GlhzbCeZppkfVJ6by07iLl
         Qd2Fx4BV6l+H2L+Jp02Dc1+qX/8DyVkSqnJLajvEdk+vBqTjfrP8goOF2eOcoMsP/yau
         d5S+gLpXdGUvKOc3NHJC9fbQ5w0de3BjDHqQ4G3ME7iqGWRLu1M5+MRVKcSE6vTfs1e3
         +7ug==
X-Gm-Message-State: AODbwcC3NBIoM1B4C4ERylonjmnkw0m1nf+oXPzG+j8pttWvN1ajmdaz
        gqFVKNZ0GPPNGC9X
X-Received: by 10.84.215.213 with SMTP id g21mr1123069plj.47.1496226379390;
        Wed, 31 May 2017 03:26:19 -0700 (PDT)
Received: from localhost.localdomain ([2002:46b5:ad14:0:d550:bf38:c9e6:f9ba])
        by smtp.gmail.com with ESMTPSA id f1sm22442729pgc.8.2017.05.31.03.26.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 03:26:18 -0700 (PDT)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH] [BUG] test_expect_failure mailinfo -b fatals
Date:   Wed, 31 May 2017 03:26:10 -0700
Message-Id: <5139b7b6aa7735aefca283afef967d7@50ef27579de002095d3bc9134128513>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This subject line:

> Subject: [other] [PATCH] message

does not get along with the git mailinfo "-b" option.  In fact,
it triggers a fatal bug:

> fatal: `pos + len' is too far after the end of the buffer

While I did not do any exhaustive checking, I do happen to have
a few builds of various versions of Git lying around and it
fails at least as far back as v1.7.6.  (The -b option was
introduced in v1.6.6 I believe.)

At the very least this is now a "known breakage", so might
as well have the tests for it.

If someone comes along and fixes it it's a simple matter
to flip them to test_expect_success instead.

--Kyle

P.S. Oh yes, the real patch subject is below (love those >8).

-- 8< --
Subject: [PATCH] t5100: add some more mailinfo tests

Add some more simple mailinfo tests including a few that
produce:

  fatal: `pos + len' is too far after the end of the buffer

Mark those as 'test_expect_failure'.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

Notes:
    checking known breakage:
    	subj="$(echo "Subject: [other] [PATCH] message" |
    		git mailinfo -b /dev/null /dev/null)" &&
    	test z"$subj" = z"Subject: [other] message"
    
    fatal: `pos + len' is too far after the end of the buffer
    not ok 46 - mailinfo -b trailing [PATCH] # TODO known breakage
    
    checking known breakage:
    	subj="$(echo "Subject: [PATCH] [other] [PATCH] message" |
    		git mailinfo -b /dev/null /dev/null)" &&
    	test z"$subj" = z"Subject: [other] message"
    
    fatal: `pos + len' is too far after the end of the buffer
    not ok 47 - mailinfo -b separated double [PATCH] # TODO known breakage

 t/t5100-mailinfo.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 7171f675..333395c8 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -170,5 +170,46 @@ test_expect_success 'mailinfo with mailinfo.scissors config' '
 	test_cmp "$DATA/info0014--scissors" info0014.sc
 '
 
+test_expect_success 'mailinfo no options' '
+	subj="$(echo "Subject: [PATCH] [other] [PATCH] message" |
+		git mailinfo /dev/null /dev/null)" &&
+	test z"$subj" = z"Subject: message"
+'
+
+test_expect_success 'mailinfo -k' '
+	subj="$(echo "Subject: [PATCH] [other] [PATCH] message" |
+		git mailinfo -k /dev/null /dev/null)" &&
+	test z"$subj" = z"Subject: [PATCH] [other] [PATCH] message"
+'
+
+test_expect_success 'mailinfo -b no [PATCH]' '
+	subj="$(echo "Subject: [other] message" |
+		git mailinfo -b /dev/null /dev/null)" &&
+	test z"$subj" = z"Subject: [other] message"
+'
+
+test_expect_success 'mailinfo -b leading [PATCH]' '
+	subj="$(echo "Subject: [PATCH] [other] message" |
+		git mailinfo -b /dev/null /dev/null)" &&
+	test z"$subj" = z"Subject: [other] message"
+'
+
+test_expect_success 'mailinfo -b double [PATCH]' '
+	subj="$(echo "Subject: [PATCH] [PATCH] message" |
+		git mailinfo -b /dev/null /dev/null)" &&
+	test z"$subj" = z"Subject: message"
+'
+
+test_expect_failure 'mailinfo -b trailing [PATCH]' '
+	subj="$(echo "Subject: [other] [PATCH] message" |
+		git mailinfo -b /dev/null /dev/null)" &&
+	test z"$subj" = z"Subject: [other] message"
+'
+
+test_expect_failure 'mailinfo -b separated double [PATCH]' '
+	subj="$(echo "Subject: [PATCH] [other] [PATCH] message" |
+		git mailinfo -b /dev/null /dev/null)" &&
+	test z"$subj" = z"Subject: [other] message"
+'
 
 test_done
---
