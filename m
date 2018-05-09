Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D171F424
	for <e@80x24.org>; Wed,  9 May 2018 23:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965478AbeEIXlL (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 19:41:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44855 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965244AbeEIXlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 19:41:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id q22-v6so130113pff.11
        for <git@vger.kernel.org>; Wed, 09 May 2018 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TAJWJDK/IzpihnA7wWdGjbOZdfaClWZQLau/QLic540=;
        b=LfVYZ8V1XMKMXcOKUSVvMwlxWQ2iK9qDsjSvwlu2e1DXPWnga9XlrbE85Ig54ssrlg
         /Wk8spUoUnqkilhUT2W6ceD/sfeN6qfBaap1ZFFplodoLwJ4wI5fvWlc3/0JYASQzzQm
         va1Z1mkJsFzAVreBg/Za3IAtXMzsOlaeCvyysJpD280S0WUNsMLNLyVVxxrx6jLjEKE+
         HZiEj/5/ovhJ+2KrSm0vrSndTbHYhPI2K9WqGoYDtlfhCn3uhAr7rGgquEQJjB5NjHK1
         jT70/NXXbmClBbhcVU0ScPjgJFZlI8/l0w1Zzkvl45vGdvPb/q0WzEZNCzfsBQSw/2Rd
         ssNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TAJWJDK/IzpihnA7wWdGjbOZdfaClWZQLau/QLic540=;
        b=iJFBXOWWbS+UkN62/dgENKopc9Ty+LTtmzHqd9OncfBXiSSPLKUpG1MonvgcXfdENo
         ZsvmFyJ2PjCthHjTXqYnQqkaDGY4ViHEerp3fPA7I58Egf7QQrTQIiMgwp0rlrAxzm8n
         JhAlVjIGUa+akIIAQ5Tj3OifWaeljlFsb+OniMXSyqZ49S9TDlL/kXeUybz2Hg/cRwpX
         Iy7nwPSJI1/ohK99r1UKDXBkQsv9v+XLcBrUg60SfjjxEe5DEQ4A6DmQYlyON1H0dm/P
         37en4pu9hw3g1kbAdjr4igphTOt1oCnIJDo9YXHg5F3DRmgwMdy1+/xo91XqGUlSyH6D
         OcfQ==
X-Gm-Message-State: ALQs6tAFvRgumnFaOTdawypVqVtmTqcJfWNz+FcEBz//b565S8GsWCBU
        MLW2E1bCTHEd5NJsz0gYMYqlfg==
X-Google-Smtp-Source: AB8JxZoQ/38O4NdPfQCAKujsOqcjRkTlFGwWsOaQ46Nyn3sY2YBjct+2LjVR7DaHbw9yx9C5xFSK8w==
X-Received: by 2002:a63:a503:: with SMTP id n3-v6mr36740922pgf.19.1525909270076;
        Wed, 09 May 2018 16:41:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a195sm30439141pfa.143.2018.05.09.16.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 16:41:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] object.c: free replace map in raw_object_store_clear
Date:   Wed,  9 May 2018 16:40:58 -0700
Message-Id: <20180509234059.52156-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The replace map for objects was missed to free in the object store in
the conversion of 174774cd519 (Merge branch 'sb/object-store-replace',
2018-05-08)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/object.c b/object.c
index 9d5b10d5a20..ff28f90c5ef 100644
--- a/object.c
+++ b/object.c
@@ -497,6 +497,7 @@ void raw_object_store_clear(struct raw_object_store *o)
 {
 	FREE_AND_NULL(o->objectdir);
 	FREE_AND_NULL(o->alternate_db);
+	FREE_AND_NULL(o->replace_map);
 
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
-- 
2.17.0.255.g8bfb7c0704

