Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B221F51C
	for <e@80x24.org>; Thu, 17 May 2018 18:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEQSaG (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 14:30:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36206 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeEQSaF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 14:30:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id w129-v6so2498084pfd.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tY8IRLe6ecHs0TSfKmjwSkPBPmjRhnrozbx/EoHx84w=;
        b=FCgWrqr9O/FSSy6bRE4pm73L5BKdtkbKkoGTQePTe5du18GKJZiSkdc7vfrerOJpGz
         e/9W5/NOiIhXdrIAGutpsX1Zh95cDBwyDw4cltHKDoBAeYKVhWZB+t2DZPRrygPphO/I
         tItz6LdzLfvxfP69WAEkN5EIxRvLTzGIockdhGpf5kJS10qr33ohVC080Cq3+TFndmPn
         Mnzc2XGM7GQ1Y5LO3fyQWK/UkTV9avFh9PwswXxPBhBSCWrSE0nZhZcE+oCeo/PZJIwX
         WpRZZ+/4YFTgQQYJLg8HxoViaXPXIufcsbkIvD5Z0QQC6RB2IW5g9BgwHHEP00jEsXVM
         vNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tY8IRLe6ecHs0TSfKmjwSkPBPmjRhnrozbx/EoHx84w=;
        b=m0XzRVergXRReynn6LxwaKomVlIogAV4glThJIerblvuMKHK9PpL0A7LKHxlihgs2K
         Wqru2EGk+E9FzsjLvlL5yXYNTipFDyJB/QDGLFGoTKZg/MQTmqWU3B0XkUXjVu6xyV83
         RJ2BRqgTIDkrkXKCv85fdnDMHZY8U3Nhv+0R9Vu/7LV1ZyN7rkjWhQogb8+xsvpJkXnb
         Cf9lHxx4vbH/5EW+utjVXpo2YQjmTF09gRM7xb5tedyCJ2nIkxSeYrzQGvZewNG9uApV
         WP9Y9sah09vM8dNA3b3XAIgdDzgWZ4/111kMjblUYomN+RHMVXeVBIo5LaOjWNCe8ce+
         W+Fg==
X-Gm-Message-State: ALKqPwflLl29CrWq5IhzunOOAsRUjpByalq6uHiBl4uilDt386fBhGqe
        3IDw4sLWkJX5pDZWvIfJfRZQDg==
X-Google-Smtp-Source: AB8JxZpjw6S7pHiJ4eDY3Ony5T/UQ4PIKO0/W4GdORRD5yPR2uCxEUCt1XWJolFoRJgls7oLqvzZCQ==
X-Received: by 2002:a65:628a:: with SMTP id f10-v6mr4915039pgv.6.1526581804366;
        Thu, 17 May 2018 11:30:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x88-v6sm15997629pfj.126.2018.05.17.11.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 11:30:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 1/2] object.c: free replace map in raw_object_store_clear
Date:   Thu, 17 May 2018 11:29:58 -0700
Message-Id: <20180517182959.22961-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517182959.22961-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517182959.22961-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The replace map for objects was missed to free in the object store in
the conversion of c1274495 ("replace-object: eliminate replace objects
prepared flag", 2018-04-11). We also missed to free the replaced objects
that are put into the replace map in that whole series.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/object.c b/object.c
index 66cffaf6e51..97245fdea25 100644
--- a/object.c
+++ b/object.c
@@ -481,6 +481,9 @@ void raw_object_store_clear(struct raw_object_store *o)
 	FREE_AND_NULL(o->objectdir);
 	FREE_AND_NULL(o->alternate_db);
 
+	oidmap_free(o->replace_map, 1);
+	FREE_AND_NULL(o->replace_map);
+
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
 
-- 
2.17.0.582.gccdcbd54c44.dirty

