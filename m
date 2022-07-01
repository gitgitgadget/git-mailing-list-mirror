Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB68C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbiGAKnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbiGAKnI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1858BD0
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j7so1054637wmp.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kPsOcxJikI2YETTrX4DOGrYi46/6nFg1Tn4TTy59vQ=;
        b=oWSnoL4FesMPKY5YBS/oFAcMyXev4zjs5xMbfSinC6Zebkj4fSvmxI+mOcRAszfPaR
         azyDE+tZ3tvwJkZYTHdEpmcL2I4bZ4fTyMC4ucxEVC/ZEyY2UnjijMAdRhRhAHbqVL7T
         v7jVdLz9fOZAoLWMA6KHodzm7f5aFiZxqH1RN8FK8CYAY0+JqB/V0L4MXprxOZ2gzo+M
         FB7vrHXgFjzC1cpCXb8EFMqdILBwpz5/gcfaDzUKOU0rXbF5e8nbpOl9elxp/0q+1h3x
         x0reW7AtbAafY0fRkSgL/SgGt8DzG+d2RTb/ujxzybxwZBpPyf67D637lseO/6/q6WsZ
         09+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kPsOcxJikI2YETTrX4DOGrYi46/6nFg1Tn4TTy59vQ=;
        b=mbbjUQSASMzekdff3emus2FHb6xclh168hqJjKz/YRRVzfpBkxMSagII1wq0qBtJOa
         ZLp+hXikwq2yakCFk2SOEft4oR8PtYqrQglMZfJxH3Yw2kW6l7/cUffHI9xYKmV5+1Xd
         hwFddBNXtgIYN4BB+3fqLh03ZnkD6hl1ERDV/lbAlvlyiDFCaqVi/mOOw5S1D7gpLloU
         6f18fcKPpf0NYLy3+UkrIMXuRr47pc29IDTPWHZjLiSamdiXjtaUtg2PmJ9iK5vv5VQJ
         Yc4CflRg/OWELLhTpIXOnaW7Ea7JICcZMQeCGt5EupRywP5cayHANEttvkYHvNJ/TUfA
         LUyA==
X-Gm-Message-State: AJIora8KhpwfnKodgGsMdQ2Z52HyKvvIfNM2J1/mPUgeCfkW/HuiyAx3
        wnHxR4v0IRY8nmRWSU5rx2pdV74xIhPdpA==
X-Google-Smtp-Source: AGRyM1v+LFpZjZO5N8LI0dvjwWRG+gwVnwXvgNnPq+VoOJlyIZ8UMSke45DrCq0Ds6cwRNstYAD6nw==
X-Received: by 2002:a05:600c:4ed0:b0:3a0:5263:cf09 with SMTP id g16-20020a05600c4ed000b003a05263cf09mr15809867wmq.6.1656672185031;
        Fri, 01 Jul 2022 03:43:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/11] clone: fix memory leak in wanted_peer_refs()
Date:   Fri,  1 Jul 2022 12:42:51 +0200
Message-Id: <patch-v2-02.11-24a1eaa51a3-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak added in 0ec4b1650cc (clone: fix ref selection in
--single-branch --branch=xxx, 2012-06-22).

Whether we get our "remote_head" from copy_ref() directly, or with a
call to guess_remote_head() it'll be the result of a copy_ref() in
either case, as guess_remote_head() is a wrapper for copy_ref() (or it
returns NULL).

We can't mark any tests passing passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
e.g. "t/t1500-rev-parse.sh" now gets closer to passing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 89a91b00177..c43c85dad07 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -494,6 +494,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 			/* if --branch=tag, pull the requested tag explicitly */
 			get_fetch_map(remote_head, tag_refspec, &tail, 0);
 		}
+		free_refs(remote_head);
 	} else {
 		int i;
 		for (i = 0; i < refspec->nr; i++)
-- 
2.37.0.900.g4d0de1cceb2

