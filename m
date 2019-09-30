Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7751F463
	for <e@80x24.org>; Mon, 30 Sep 2019 23:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfI3XdQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 19:33:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38500 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbfI3XdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 19:33:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so8373791lfc.5
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wL5A4Cr1R61xmAYLH0HbhxoCelH3jozB0haooIeuBRk=;
        b=r/wOM0WDgzEzSbZwKSr5CB0KE8a4IzPApeSKvuthWpL9cxMpsYGnXemQGYUKF+aecI
         ArcRDPvEvNyUtsQh7jWzG6p/ZF1p7Hqk0j7GJ4YCAU/0zwFVgKZCU88hMFd5Qg6FNge0
         dSU6KGVErk8hMEi3vfXTNj7Txq5bBpeDZ/Jp0POBsgPkrVjXldDSwU6qy4BXZXP0l2IV
         vU64sztL/Hjqn27TbrzDuBUiOD+jpjhLBko76KUlALILQnIGTR9+dLQ2X4PguqEezPRX
         wKtYqSD6BX9QXqXbZg545WeiZa4Wc7rzDQIwTVWKbbbacMzsPOfwVQ5rHDHKPRvmNXcq
         zW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wL5A4Cr1R61xmAYLH0HbhxoCelH3jozB0haooIeuBRk=;
        b=hcYBQdsxxZz0nZsjOW69a+ZUdhlGqzYfW5CO85mJITqt+wJB+Wmw6vVDLEZtlaWUAY
         aAdwe0aUz9GCUbN+OMdUi70ofevDzcRfTeA1Rx3wHdNutpw/3GMorzzCoAs+erQwZOvh
         3E+1TYwKiJZrIz4YfIPNkA0T5x9fasHIWUT7QlcXcpEbUs+28FPqr1YPgjZ14wlhGd67
         PPdbtjYn37fsQ/YnJFLanQAcqcziLG/EiC62glkJCOxvYeV0PAwG4/9AgclR+7qr8Vj2
         FNnlUX1glJqagiKp5G/b7WaTAnE+j1d8gun8cMLuTT+EawqcGBwAJCmwUykAF7PrI/XI
         k20A==
X-Gm-Message-State: APjAAAWyzXF9cN7ciwyvYzACX1zZ/lFGKWyoI7k91wKm3zqY7YrdK2Pd
        TCr3EJJIOoEQiiCu42juKiIIMKSy
X-Google-Smtp-Source: APXvYqxoG6iY9KwwOTJ7ympGxDnswUVeaFdxn12uUi0PcSHvzOPpbXEpqUiurE+I3YkE92YOez42QA==
X-Received: by 2002:a19:c3d3:: with SMTP id t202mr13153117lff.48.1569886394184;
        Mon, 30 Sep 2019 16:33:14 -0700 (PDT)
Received: from DESKTOP-VIJHNRI.lan (c-82d3225c.06-345-6c756e10.bbcust.telenor.se. [92.34.211.130])
        by smtp.gmail.com with ESMTPSA id b19sm3714025lji.41.2019.09.30.16.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:33:13 -0700 (PDT)
From:   Ali Utku Selen <auselen@gmail.com>
To:     git@vger.kernel.org
Cc:     Ali Utku Selen <auselen@gmail.com>
Subject: [PATCH] shallow.c: Don't free unallocated slabs
Date:   Tue,  1 Oct 2019 01:33:10 +0200
Message-Id: <20190930233310.19287-1-auselen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix possible segfault when cloning a submodule shallow.

Signed-off-by: Ali Utku Selen <auselen@gmail.com>
---
It is possible to have unallocated slabs in shallow.c's commit_depth
for a shallow submodule with many commits.

Easiest way to reproduce this I found was changing COMMIT_SLAB_SIZE to
32 and run t7406-submodule-update.sh. Segfault happens in case 50:
"submodule update clone shallow submodule outside of depth"

 shallow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/shallow.c b/shallow.c
index 5fa2b15d37..c33ab94bd7 100644
--- a/shallow.c
+++ b/shallow.c
@@ -156,6 +156,8 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 	for (i = 0; i < depths.slab_count; i++) {
 		int j;
 
+		if (!depths.slab[i])
+			continue;
 		for (j = 0; j < depths.slab_size; j++)
 			free(depths.slab[i][j]);
 	}
-- 
2.17.1

