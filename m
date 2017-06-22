Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28E0F1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753778AbdFVTwv (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:52:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33211 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753361AbdFVTwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:52:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id x23so7184105wrb.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NrNIZYoQhKWahsZEsh5CQfaLzMhGOfdbg3F/qaQMotE=;
        b=cTJ6X/euunZMkbqTyf5Erdm776/NjyDwNgtgQBG4intV3aGKYLIaNlcOPdkapB4p9I
         9KRTPePUJ4hBNfSDvAQCN2mXeA3gC7bXIFZPtjM6taO84WbZCOPE2myLeFCKbRSEUB3i
         IzQF0Misf6FflHiSQWKI+VPaX9cMejC7CxDOlldGSj3JIUNLphuZ/UDU+2Zp3pY3WhQ2
         T9Mx+5+0MhKzm9mv7vtiI9rvSRM15f7sE2DnErHooeVcX5GndfPsQQYYpQMLMiUxJh6m
         DmvQq8zashxRWP3UvVE0s4AB2ct5f6n9+kRtwExowA6VxAaqMbbVRzc85wu52XNLasqZ
         qWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NrNIZYoQhKWahsZEsh5CQfaLzMhGOfdbg3F/qaQMotE=;
        b=Dhd2PcnNRxyPrlN5DOEUq1LPnQjp5F+PTNTOPNnHk0hrk1SJE8mnOktVZnlbwoVZi8
         nLag70ExL/SeOVYKVg+3KBEn4KtEqKw99YBA0gDKw0UH+B+UtXnx1rO5xRjV8Cbx9MhU
         cd7SDlFW9QquMdiVEc9z0fmq+sLenVNMa5yWM3fbWCMa96QfyhgZwpjOoiRzJVpumZlr
         kbEQlZUb23itpN2uU8nu8Um5RZd+oaL8U2h5zQh2CqrfrBdhUxFYWoAoW+1Y7EYoXBMF
         ndtPFL773I/XAs3qCBLb9CteQgbZTXq2DdZ4csYrV2OjJ54LsCZwWjStV5jlVzf/nNE3
         z0Qg==
X-Gm-Message-State: AKS2vOzxMonGaLA6HQCNXZslUUBe8KYHOBKO5fOs7BAcfZc6sDCzCOhv
        xUjO/vyXwSWcbhveaQo=
X-Received: by 10.80.149.132 with SMTP id w4mr3840224eda.82.1498161169081;
        Thu, 22 Jun 2017 12:52:49 -0700 (PDT)
Received: from junior.corp.audiocodes.com ([95.86.125.251])
        by smtp.gmail.com with ESMTPSA id x13sm2242358eda.67.2017.06.22.12.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 12:52:47 -0700 (PDT)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] name-rev: Fix tag lookup on repository with mixed types of tags
Date:   Thu, 22 Jun 2017 22:52:45 +0300
Message-Id: <20170622195245.11252-1-orgads@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Commit 7550424804 (name-rev: include taggerdate in considering the best
name) introduced a bug in name-rev.

If a repository has both annotated and non-annotated tags, annotated
tag will always win, even if it was created decades after the commit.

Consider a repository that always used non-annotated tags, and at some
point started using annotated tags - name-rev --tags will return the
first annotated tags for all the old commits (in our repository it is
followed by ~5067 for one commit, or by ~120^2~21^2~88^2~87 for
another...). This is obviously not what the user expects.

The taggerdate should only be matched if *both tags* have it.
---
 builtin/name-rev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 92a5d8a5d2..8f77023482 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -46,11 +46,13 @@ static void name_rev(struct commit *commit,
 		commit->util = name;
 		goto copy_data;
 	} else if (name->taggerdate > taggerdate ||
-			(name->taggerdate == taggerdate &&
+			((taggerdate == ULONG_MAX || name->taggerdate == taggerdate) &&
 			 name->distance > distance)) {
 copy_data:
 		name->tip_name = tip_name;
-		name->taggerdate = taggerdate;
+		if (taggerdate != ULONG_MAX) {
+			name->taggerdate = taggerdate;
+		}
 		name->generation = generation;
 		name->distance = distance;
 	} else
-- 
2.13.1.windows.1.1.ga36e14b3aa

