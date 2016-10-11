Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725E920989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbcJKAWG (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:06 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35999 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcJKAWE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:22:04 -0400
Received: by mail-pa0-f47.google.com with SMTP id ry6so3893252pac.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xPX2EvrUkRjElQBtuwR19HImFvE5O7sC+gBreCoFFzE=;
        b=ivkBwVWgrbE7DfTg4lSRpYqDkfrblZRjE17MLRUFkMebYTnp7r7+YRuAosiozNgJai
         xld6sw1dSgWxB22Yp2dIa/OIFzZ61t/oeS7t4Fd+1prgbFdtw4QQm6bs7RPIRBibWCGF
         kPH4D9GlkMJ6NmmTpt6A/Xj/lgTLm/GgmxQX1SMA4XfqbRsNwlN0UxvkKsVTtAzJd6NB
         KSAasTnLGWrpUOfYEGwxemvecsJyoZyA6O4MjzyfZTKSTeTwOQN/mIp89J62UTrex0ii
         ddODcEaI3W1cDXMAjvdxiv6d16lEJ5Enp/UHdSu+XC3vSnnIKIvdeqlF5v7mlowL5lsB
         kejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xPX2EvrUkRjElQBtuwR19HImFvE5O7sC+gBreCoFFzE=;
        b=HpMCWoqzGIEaUAxk7zdQGLXMr1UVGyNNyHG2U5HBaF9R3MycCT41MuNTqZTP9eGp1f
         fbGbOeofxOtj/ZFDnyYqjeK1rwBnZQJRv6eX3Tsa2ND5GQ4kvMwfqD9niWQQlYDiXN3F
         2KWSoWWsGxPsOZJZTWZO71QCjMnYdxJu3CjNu30xntbvOZP0MQ3h+kEdSkTBYgZvU+ct
         ZSg3C4WE4nVzxFoWnmdmovvhrpuXs0dJLz2v5uZlm5NmCpbqrlwesHJzGjOlIBT0rDLp
         Dq++AZ6XxYnSA0gzY0GzmjUUymrl8xJ476ZHn3kIqVr9HRZhCEOUi7IvTK9ZqzC4RrWt
         3ZUQ==
X-Gm-Message-State: AA6/9RlSx5QlF99E5MNgEouT5Pt/XVImm3JyhiUovkX8CekG7EXovbM08ldK4h7vDyKbg/Lc
X-Received: by 10.66.153.39 with SMTP id vd7mr1722550pab.184.1476145323908;
        Mon, 10 Oct 2016 17:22:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id v73sm509703pfd.63.2016.10.10.17.22.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:22:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 23/28] attr.c: introduce empty_attr_check_elems()
Date:   Mon, 10 Oct 2016 17:21:10 -0700
Message-Id: <20161011002115.23312-24-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
index 8d8df20..cb3b702 100644
--- a/attr.c
+++ b/attr.c
@@ -746,6 +746,14 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
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
@@ -912,12 +920,11 @@ struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *check,
 
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
2.10.1.382.ga23ca1b.dirty

