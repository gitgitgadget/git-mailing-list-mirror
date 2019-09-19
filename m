Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641051F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfISVrl (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54722 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404917AbfISVrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so45091wmp.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hW6ImA9H7YnUgjcLu3OXNL6kCOlmbsy4RrZb9nK1Pc=;
        b=CbbhPH3hiDN3mv88mrxxlXGcqITGSn/iWQOUwbWzJac7mEtvmG46pIed88et75JK64
         Cb/0j7eh9V1i96zSFgZykb7dud2dN7ksyrPtmlt1jsyUv1wPNAcQohyGkhObnXGomYxJ
         Ry4tWLYQeae3sjAaoDiU8yyjTShuI3+AR80l8S7RTHmAtDX9NnWRl0bEtq94TZwxkOAe
         3gp935AAXw428COsRKX4w8bF44Ss1Nyz2lCpzP4OhyOb+39a/fX6HhVHMwrANzHBpkLf
         OE76iODLdemIVsS2qFjVcKA0nQ6etheQJSHznXcUmBV2uA+3BUj4s+05E6WegavW7rm5
         JVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hW6ImA9H7YnUgjcLu3OXNL6kCOlmbsy4RrZb9nK1Pc=;
        b=nDw42sGTf51oF5wSy6fGZvHEoqvLuXk3QVlRh/lYfXVYthp2hYTGUb31PdKCDmzjI7
         vLECVtcWCslcPwl0/KL5DWZVQUKF3kb3K0GgKcL7EtFlyjZJi1AXN5rBvtztwff6RkdH
         j82u3t8pC3/O3+dzcQXbutn5r7FM4Jqj3oEFVJ7irfYYKGXpJbHxBfPPC01tBDWXDpmj
         K+amD8WHtxx+iGPXLRTbJAboAebx/hlediB0LgXje+07W9KATQuMA8CThtwx0Sd/+r3i
         VLd2DKKyrMRp1PDaK5Wy99WpXvrRMaoRhITmZ3O8we09GTj0kBDlQ9yV86+IZcNzEpmw
         9PcA==
X-Gm-Message-State: APjAAAXvW0Xs1Sv2tTRZV2PNxC6sJCy3Wfz5RAjxZOnNSP+7IOG5ekZF
        5Ue1qTIFfE2dZ8PmXoA7ALg=
X-Google-Smtp-Source: APXvYqzPCOwqwQj5SA5cc2kMJ8cNwOLs+KY7vEVeU1M/F23TcEJfsCZ2kj2isH4LMJMsyUuP93BkpA==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr18113wme.103.1568929654291;
        Thu, 19 Sep 2019 14:47:34 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:33 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 14/15] name-rev: plug a memory leak in name_rev()
Date:   Thu, 19 Sep 2019 23:47:09 +0200
Message-Id: <20190919214712.7348-15-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The loop iterating over the parent commits in the name_rev() function
contains two xstrfmt() calls, and their result is leaked if the parent
commit is not processed further (because that parent has already been
visited before, and this further visit doesn't result in a better name
for its ancestors).

Make sure that the result of those xstrfmt() calls is free()d if the
parent commit is not processed further.

This results in slightly but measurably lower memory usage: the
avarage maximum resident size of 5 'git name-rev --all' invocations in
'linux.git' shrinks from 3256124kB to 319990kB, just about 2% less.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index e202835129..3331075aa4 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -135,6 +135,7 @@ static void name_rev(struct commit *start_commit,
 			struct commit *parent = parents->item;
 			const char *new_name;
 			int generation, distance;
+			const char *new_name_to_free = NULL;
 
 			parse_commit(parent);
 			if (parent->date < cutoff)
@@ -154,6 +155,7 @@ static void name_rev(struct commit *start_commit,
 					new_name = xstrfmt("%.*s^%d", (int)len,
 							   name->tip_name,
 							   parent_number);
+				new_name_to_free = new_name;
 				generation = 0;
 				distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
 			} else {
@@ -167,6 +169,8 @@ static void name_rev(struct commit *start_commit,
 						  from_tag))
 				last_new_parent = commit_list_append(parent,
 						  last_new_parent);
+			else
+				free((char*) new_name_to_free);
 		}
 
 		*last_new_parent = list;
-- 
2.23.0.331.g4e51dcdf11

