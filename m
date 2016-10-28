Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EDE62035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034314AbcJ1S4T (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:19 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35965 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030840AbcJ1S4J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:09 -0400
Received: by mail-pf0-f169.google.com with SMTP id e6so41419325pfk.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8inPNGd45CSwbWUcNEzdiFja5K68Cs/kfi/FVL6U2Iw=;
        b=b0aTlb2e/F3dKpknjcqbDSu+q69crJh8NvsMQvDjBe+RPhM1Sc2ZF+ytdGNkLOqbUv
         4zOyjeu4BMmn0wpyflJ67GNalUlW6JeOpmv1H8th0uQyIMcvWvbHyGCeDj2/66xAFVXz
         FQxX0HLrN6ececTgqqsF7gNw94DXMaGtmMbNPOjv0VyQdga99R8TvP0UVNYTThVck+c/
         7IKkFVEhZzG/F7t+JULaMOdcb6+jPXK1+f4j8mB1BZjiAj/EorKqauQUdmqwQLRESzY4
         GV298uArPcUCNHMea5633nEDbMTwkW8VZwsv1Wldpck8ecxg24IOUDDnS/DkwzAYjN8X
         0HdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8inPNGd45CSwbWUcNEzdiFja5K68Cs/kfi/FVL6U2Iw=;
        b=Z3ZlIOUKeOXR6RZCM4rQHfa5Sv+BxE2/OS+SiDROFXLWi/O9nKrwPCDC9gFJXpLl82
         2Y7xxqefcPB0SG/jLkh7Gt8CdePQYWifbffHRAA4fKpR8ZoQseJgG49EDzV2dAd58s55
         8O1lGM8lTktOYfl5Yjit6MYX8lf6Cfe45HMbP2wlDaYUZg1RqSz3EcQBoNAE8Nl6rhk1
         nqQAlKDaXg0yS/EHmDafepd7XvV6FpDiw+do75KCyGM91JDMO5XPDx9j8jg+seTSkoN3
         6F1HJqIWeQsDS4zxzZ0RBhjlsimxdx6SB0cD/gKsHgdsrWUQoLD/ee3hGOdm4MWwyX2J
         MNuQ==
X-Gm-Message-State: ABUngvdhjgpOLtoB7bJooiTG2Fhyqi9ffje3uRYsC/z+nuSyd5sdwBOjf40fpDWLax+/Y/fr
X-Received: by 10.98.66.77 with SMTP id p74mr27675069pfa.15.1477680963426;
        Fri, 28 Oct 2016 11:56:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id xs10sm20611927pac.24.2016.10.28.11.56.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 23/36] attr.c: introduce empty_attr_check_elems()
Date:   Fri, 28 Oct 2016 11:54:49 -0700
Message-Id: <20161028185502.8789-24-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

One codepath needs to just empty the git_attr_check_elem array in
the git_attr_check structure, without releasing the entire resource.
Introduce a helper to do so and rewrite git_attr_check_clear() using
it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 94476de3d2..1098300e54 100644
--- a/attr.c
+++ b/attr.c
@@ -750,6 +750,14 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
 	return (void *)(check->check) != (void *)(check + 1);
 }
 
+static void empty_attr_check_elems(struct git_attr_check *check)
+{
+	if (!attr_check_is_dynamic(check))
+		die("BUG: emptying a statically initialized git_attr_check");
+	check->check_nr = 0;
+	check->finalized = 0;
+}
+
 /*
  * Collect attributes for path into the array pointed to by
  * check_all_attr.  If check is not NULL, only attributes in
@@ -916,12 +924,11 @@ struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *check,
 
 void git_attr_check_clear(struct git_attr_check *check)
 {
+	empty_attr_check_elems(check);
 	if (!attr_check_is_dynamic(check))
 		die("BUG: clearing a statically initialized git_attr_check");
 	free(check->check);
-	check->check_nr = 0;
 	check->check_alloc = 0;
-	check->finalized = 0;
 }
 
 void git_attr_check_free(struct git_attr_check *check)
-- 
2.10.1.714.ge3da0db

