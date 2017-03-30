Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2F220958
	for <e@80x24.org>; Thu, 30 Mar 2017 06:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbdC3GW1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 02:22:27 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33155 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbdC3GWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 02:22:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18so8982862wrc.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 23:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6DaaUvWabmrRvxECO93VwgiLOo7pzYhHmkw81wlxWLg=;
        b=VRUP9r9TsaRZqBx9XEalqilMqVvUQ9U2X3aUt9KXRoWMiEAXPRt5u4U9cDOA67cmc6
         72RYHJOrH5JkiWG9gHfaUCCIszMgRj4KyPxJhetxOGy9hkU/rG/gGZRTnX15VmQtUqpX
         aSvGBLURexNbl4p9nIzcdsU5wyiWoyw7QepD4q85lVWCguIUjeRoIoj2TEJgMKqtzOBd
         pAJ/jjDrPguxdRCW/1T8h3GtgSDIJBP0f2TrlTILUp85t8e/ZgCbTy4L6uDj572ZA1F4
         gsfeCSvgMo1bEXSN//YDy1pHZDHe1rotmUgUMLqWZUFQFfOOhJ/os0sJk/V2KVtG5Pc0
         kJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6DaaUvWabmrRvxECO93VwgiLOo7pzYhHmkw81wlxWLg=;
        b=bz5aylyifsNyh0z3KWqjlY0UvRoU7zZJHBMAi8IwibuvQNcKkcfQEouw+RRrbEnCcG
         wc4RsHGfLH9hgxTZDkYTbEDWowZLP6Hvk+4lOiUxfcdny9P6lNAmG2qloShL59MSs9ZH
         lnnR+jEJR3Rc2GzSKWdgSswWsa9vTzDafWXfxNDyO7nUHBQ9aHaXuQCRx2guEv+KpjpW
         FNHpCtI0MuWXMEdtp6UJlQCruMVrx0PIAobK0oE/7eWBAPcRwqGAWgVGM1/K50ZXJCA4
         6z9H3+UoHXJ/oagEgoxtsutjosPARk6xSNPNWcdmFPjih8MZUgoI5a9zsTaTIu4NHue4
         L/Kg==
X-Gm-Message-State: AFeK/H07z1/LVTBACaRaIfGmOFZuG97obF9WkZKWdZU3KD9AnMGy99dy5ZtfNLoWPktGlA==
X-Received: by 10.223.130.102 with SMTP id 93mr3805812wrb.59.1490854943953;
        Wed, 29 Mar 2017 23:22:23 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k63sm10888815wmf.9.2017.03.29.23.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 23:22:22 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] update-index: fix xgetcwd() related memory leak
Date:   Thu, 30 Mar 2017 08:22:08 +0200
Message-Id: <20170330062208.29018-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.2.510.ge1104a5ee5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As xgetcwd() returns an allocated buffer, we should free this
buffer when we don't need it any more.

This was found by Coverity.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d74d72cc7f..ebfc09faa0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -125,12 +125,16 @@ static int test_if_untracked_cache_is_supported(void)
 	struct stat st;
 	struct stat_data base;
 	int fd, ret = 0;
+	char *cwd;
 
 	strbuf_addstr(&mtime_dir, "mtime-test-XXXXXX");
 	if (!mkdtemp(mtime_dir.buf))
 		die_errno("Could not make temporary directory");
 
-	fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
+	cwd = xgetcwd();
+	fprintf(stderr, _("Testing mtime in '%s' "), cwd);
+	free(cwd);
+
 	atexit(remove_test_directory);
 	xstat_mtime_dir(&st);
 	fill_stat_data(&base, &st);
-- 
2.12.2.510.ge1104a5ee5.dirty

