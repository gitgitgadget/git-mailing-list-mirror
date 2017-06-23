Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B2020282
	for <e@80x24.org>; Fri, 23 Jun 2017 15:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbdFWPQy (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 11:16:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33562 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754411AbdFWPQx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 11:16:53 -0400
Received: by mail-wr0-f194.google.com with SMTP id x23so13294840wrb.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tvW4XgxNgnTv54Wwbqf2ahw9+CwdtRjxX91Rt+cNkWk=;
        b=Sgxv4hNM9lWLCkcvZvF1lH6y4uBPoKi3P831GxgcNUTm0MGbS0WFgrGP7iadrSxRFC
         2QtCmphNQkpkC5AUcpqSUkAi8qn0az0iRFf7F5cUXXGcESnNrDT4H/srU9sBa2CbBZ+r
         xJ2NcQCTD4V1oYQgg8q9Q5mccQiNRUXxb9op0QAysphfxRrK6ibWxjZMTwnYxGfqslB3
         QIoofIkqA1jdgNd32v22Czmh8KjeGjIrt2VmEFsTyrEpky0jfuDrL1/Lf2IGfqdmXxo1
         5Mwm7V4YTKwfOeLWkib1+/DCSk02ns8h6sQXaWSFeT+NMQiw6iYWFQFUOB3bsX0VLDpR
         Aa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tvW4XgxNgnTv54Wwbqf2ahw9+CwdtRjxX91Rt+cNkWk=;
        b=nr98Kxizcl1NGDSHyxBqcof1I4Xoos/qg4zdbQCuIgDBTKLOXbiSBPjPkD2/IlSm3n
         FueNXpcwUsd7rSkqXEIcPSOpI4YmbN5hAB1ORMHHHXiFOI1sDLKYy/trOddXmjlxMsxh
         rchUrANQf6asgtGgiB6OBVKpoRRz9ItKMpzGw0cEVayCZ3JcaS80HFLZdTL2R6mK9v4Y
         4XxX/FhTQ4ESsmZH4hU4onhxwjPOtvMEhozg2KwtJD5EPBJjAp1LJnoQQRrZKsIOWpX6
         DrAu0BIhlGtnz/0XZqmg1al6fDHK2QFFjIw7jdSp/4mvGj3M56ws9kVUOmPyTtuXpsnR
         yg4w==
X-Gm-Message-State: AKS2vOxwBJfRWkBIpt9+zYj5WvW/pk3w/CTFgd09Ucsgpf55E4iGqOYS
        LIEvW089IUjROhGx
X-Received: by 10.223.136.116 with SMTP id e49mr6739496wre.14.1498231011499;
        Fri, 23 Jun 2017 08:16:51 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z75sm4405186wmz.8.2017.06.23.08.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 08:16:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] read-cache: use shared perms when writing shared index
Date:   Fri, 23 Jun 2017 17:16:38 +0200
Message-Id: <20170623151640.24082-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.519.g0a0746bea4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since f6ecc62dbf (write_shared_index(): use tempfile module, 2015-08-10)
write_shared_index() has been using mks_tempfile() to create the
temporary file that will become the shared index.

But even before that, it looks like the functions used to create this
file didn't call adjust_shared_perm(), which means that the shared
index file has always been created with 600 permissions regardless
of the shared permission settings.

Because of that, on repositories created with `git init --shared=all`
and using the split index feature, one gets an error like:

fatal: .git/sharedindex.a52f910b489bc462f187ab572ba0086f7b5157de: index file open failed: Permission denied

when another user performs any operation that reads the shared index.

We could use create_tempfile() that calls adjust_shared_perm(), but
unfortunately create_tempfile() doesn't replace the XXXXXX at the end
of the path it is passed. So let's just call adjust_shared_perm() by
ourselves.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index bc156a133e..66f85f8d58 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2425,6 +2425,14 @@ static int write_shared_index(struct index_state *istate,
 		delete_tempfile(&temporary_sharedindex);
 		return ret;
 	}
+	ret = adjust_shared_perm(temporary_sharedindex.filename.buf);
+	if (ret) {
+		int save_errno = errno;
+		error("cannot fix permission bits on %s", temporary_sharedindex.filename.buf);
+		delete_tempfile(&temporary_sharedindex);
+		errno = save_errno;
+		return ret;
+	}
 	ret = rename_tempfile(&temporary_sharedindex,
 			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
 	if (!ret) {
-- 
2.13.1.519.g0a0746bea4

