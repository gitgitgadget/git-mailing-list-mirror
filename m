Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74742018B
	for <e@80x24.org>; Mon, 18 Jul 2016 22:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbcGRWWn (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 18:22:43 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36819 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbcGRWWl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 18:22:41 -0400
Received: by mail-pf0-f174.google.com with SMTP id h186so183816pfg.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 15:22:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/oEXmNhYvvgrjlcBFQ0vZAsrYjsiHgU4PmG4Du/ijIc=;
        b=XyxjnCZltqBwEaLzhOIpOtkFRkvNnpXUUutbBCoOQIRpxtw+1AkVFC1bDuGf3y0kjA
         0z/Id3AY7Ra5mhJO1nzPGCNF76hNUbjQpaopdNtAHVgJkF/Sdj+WjjX4RZxwqJ9FMXZu
         tP7HXKWJrJfZQg9LGdmBryGK+taVycOZDJR6lOZkS2fl6fMT1RzK8kC3sCDY3Z4/RcT5
         MJP+hhFERCzVABqY+0s7Xy9haB/0ws6b0CoDqCs3hA+NcXXCcTFiUkTSzBCzs86S3R8k
         hh1l++MU13x1cARPOsmH0IhRgihNvBnGKHLsDVYroDiIjJVBjj2vJu5Ng8R6J4AUdfsf
         Cc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/oEXmNhYvvgrjlcBFQ0vZAsrYjsiHgU4PmG4Du/ijIc=;
        b=eGaHpX77NmbZwOImEmscNq6NbkOmQePsuMlhtDVqyJB3u6E+GMTiV/5RrSGhLAwD8h
         eP2+48nd9w5d5Qh1EhsNhUnDBTLIfCYeCb9opWREJ6zcJ+/q5hqw5DsyRMCLi1+F3ZkU
         X6sA5apN4e8sGGzmc3/PT6L45prnQHDYYkTpSPUeVy/nEgnDH0Dhd5JW2YueKDlkFtTG
         ONeCs0ax83dFmveMPBg90m3deoqrudfA88JsCamulJhKAgt4Rl8rGWXlQQcyyUXL8SAA
         8EwSaeC1XmIcftX95rF4TjKEEhSRDi827r9mmIuiBYjlAGDPVlEkKcptqJ0iZb3DEUyP
         yleA==
X-Gm-Message-State: ALyK8tL9wJ3cvdj2N9weIISmN7xRqQgCOeESoPvTeWdz/KEKP8KkPIuKD36suzXEKNbGhK9f
X-Received: by 10.98.23.134 with SMTP id 128mr49555004pfx.96.1468880560866;
        Mon, 18 Jul 2016 15:22:40 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([172.17.54.68])
        by smtp.gmail.com with ESMTPSA id tt1sm6783928pac.35.2016.07.18.15.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 15:22:39 -0700 (PDT)
From:	Jonathan Tan <jonathantanmy@google.com>
To:	git@vger.kernel.org
Cc:	Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
	gitster@pobox.com, sbeller@google.com
Subject: [PATCH v2] fetch-pack: grow stateless RPC windows exponentially
Date:	Mon, 18 Jul 2016 15:21:38 -0700
Message-Id: <1468880498-30235-1-git-send-email-jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com>
References: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When updating large repositories, the LARGE_FLUSH limit (that is, the
limit at which the window growth strategy switches from exponential to
linear) is reached quite quickly. Use a conservative exponential growth
strategy when that limit is reached instead (and increase LARGE_FLUSH so
that there is no regression in window size).

This optimization is only applied during stateless RPCs to avoid the
issue raised and fixed in commit
44d8dc54e73e8010c4bdf57a422fc8d5ce709029.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b501d5c..85e77af 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -243,16 +243,21 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 
 #define INITIAL_FLUSH 16
 #define PIPESAFE_FLUSH 32
-#define LARGE_FLUSH 1024
+#define LARGE_FLUSH 16384
 
 static int next_flush(struct fetch_pack_args *args, int count)
 {
-	int flush_limit = args->stateless_rpc ? LARGE_FLUSH : PIPESAFE_FLUSH;
-
-	if (count < flush_limit)
-		count <<= 1;
-	else
-		count += flush_limit;
+	if (args->stateless_rpc) {
+		if (count < LARGE_FLUSH)
+			count <<= 1;
+		else
+			count = count * 11 / 10;
+	} else {
+		if (count < PIPESAFE_FLUSH)
+			count <<= 1;
+		else
+			count += PIPESAFE_FLUSH;
+	}
 	return count;
 }
 
-- 
2.8.0.rc3.226.g39d4020

