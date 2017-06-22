Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2AA1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbdFVTCS (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:02:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34946 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbdFVTCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:02:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id z45so6872002wrb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u3dZdwnELLAgyMsFcK8IcclEFjEv1sXYCcaxVmcaLXk=;
        b=MYS/0fsKF7Kjr2jOZ07RcKfuujxfWkX0dEiEXKhf0s3B6DNIEdc1croxgFns3iquZM
         7gScfFPiGnwwhpa5+aZ8TsqQ8l2mGg7XjhPVLCDkumN316zr9l4EjuH9kqzLS/8JmkxG
         5yYgBCWHX54bwebI4SuppB2UjuBZFf5/E+5h7QHKOher7uyaJAs47I5gzwp58Tx9CTf4
         761gub7gJtobQMix5RJMGVIKkiyWvnRcxTjQSqqfmVRYdNAnPeYJ2m/5fXBTfIG+GBF1
         NLi1TkcXWbsjj1ct3AVGnMt+tua8hP75mykY9XgPV0CYyoaH+d9TR3QQsv0gW3aaIn7t
         9HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u3dZdwnELLAgyMsFcK8IcclEFjEv1sXYCcaxVmcaLXk=;
        b=ake2Dovs5DSSUYAjt+kWd/+M5KyTknDaserTkUXc0WV4FumZKeyEF5Ml7eIHvZ+zfu
         LnEHEYjv8db1CAAEN2Pn1LHy3Yjb21LfTG2cSwwi0xPkrjKFHsQmiPdMlPj1OcC5LpUG
         oD8YVA6jYrSFCwfeUcURV1OlFc+srelcnYxtF2+aF8ydbRvfYKDiFcA7aKgIZuTYYShX
         tE+SnF4RYXTc/Mxxuq6CwZAvfixkQG8aPSqiaeNI2EGurr0wNfh3sctG6JetTgVzLqIV
         lIzMZlml993JZ7syGY9ZFcZRxK77Ol/Vk7IYuqd6X77bK+L101mOOvsOHPN3RD8Kdksb
         wxaw==
X-Gm-Message-State: AKS2vOyevknkcm0cD+nQySuMpglLB+Ld/t3qW9671OLYqQf+DB+CXFvl
        DbadkP0pLVr7eWvY
X-Received: by 10.223.174.194 with SMTP id y60mr3239796wrc.19.1498158132225;
        Thu, 22 Jun 2017 12:02:12 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 32sm2771112wry.31.2017.06.22.12.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:02:09 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] read-cache: use shared perms when writing shared index
Date:   Thu, 22 Jun 2017 21:01:56 +0200
Message-Id: <20170622190158.13265-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.516.g05ec6e13aa
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

This means that on repositories created with `git init --shared=all`
and using the split index feature one gets an error like:

fatal: .git/sharedindex.a52f910b489bc462f187ab572ba0086f7b5157de: index file open failed: Permission denied

when another user performs any operation that reads the shared index.

Let's fix that by using create_tempfile() instead of mks_tempfile()
to create the shared index file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index bc156a133e..eb71e93aa4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2414,7 +2414,7 @@ static int write_shared_index(struct index_state *istate,
 	struct split_index *si = istate->split_index;
 	int fd, ret;
 
-	fd = mks_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
+	fd = create_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
 	if (fd < 0) {
 		hashclr(si->base_sha1);
 		return do_write_locked_index(istate, lock, flags);
-- 
2.13.1.516.g05ec6e13aa

