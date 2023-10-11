Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4AACD6E63
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 12:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjJKMgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 08:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjJKMgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 08:36:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA87D91
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 05:36:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c16757987fso86346761fa.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697027762; x=1697632562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TvAmD9wBFcHz+UVN4L9/tv/2envo/OJflKXmcaSCQXY=;
        b=BdXL9tkBI1eXx8W5HM0PckHh9SOpmndxr9ovLYY/DkUFyAhL4xfUzoyIo1xPBVeX4F
         yvbRkQSrgG7L5M1nka1pmhP8x6r6Ctw5Bv0/w00uarmFy+J+eRfUlKKmnaXCpWtGoWay
         onP8Oiv5Q2N7nlNLb7wNEx+j9zISEwiG5vEifMNFXYkDciZ4ZE9xdqrI86sB6IixyAQj
         235XmuDeNfniGUxaK4kzB3of7Zh5OqYSQ/B42tGmKYgNdnCyHACZzhz7G4fe/oU2tftO
         ObX6DmttOBV1b/N0kKlgbH/y+aRv+qdZh+xzj/d0FNOh0Ry3J/HF7Wan9xACApj6d+Sb
         /5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697027762; x=1697632562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvAmD9wBFcHz+UVN4L9/tv/2envo/OJflKXmcaSCQXY=;
        b=mdnR/eGDICErTzyVINgXdlupdvk6RrKT4k/9A/UWhvu/9nMse3/MGxVL+bPxtc8qo8
         w15gaPPWqFWO0h5lfA/2FS36pBgtKHWCqfgTBQSmVocRQ+9/ryxOk0mzJ+nzOCWAOfmv
         4t8tl/pjpCICHAxiOKpgOGeSJ+i6w0l84OrfaLv/bM5kNC97/bUelfDkcnWzAr6J3CSI
         cVPrZu2Us8rYqfqnSoURvAdI0lfN07EfaJgpdk5W+ggkRb7Mm1UN/BMZmnq0NJejpx1M
         LqgPWeXcLgcJPM60uXvB1TIaF0cJn4gnjDTIzzzoOalBh8cnKhe1cnlCwNb1AQaPJmNB
         GHYg==
X-Gm-Message-State: AOJu0Yw9tkV32qCr9lpCLZH4XdZx/1zyHGRAkhlD81ywxX/z9WKeF9w/
        47O41SXA857s70/HmtKFBgMEtHzTN90=
X-Google-Smtp-Source: AGHT+IH0US9np7XqwGxQb5+D1BwQwQW3B2y5kvundylO9SDlUiUjhf9rGGnMAgWQCl7UBUGaelELFA==
X-Received: by 2002:a2e:97c3:0:b0:2bb:8eea:755a with SMTP id m3-20020a2e97c3000000b002bb8eea755amr18381795ljj.49.1697027761762;
        Wed, 11 Oct 2023 05:36:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:31ce:62cd:ac00:5307])
        by smtp.gmail.com with ESMTPSA id k7-20020a2e8887000000b002c0336f0f27sm2949586lji.119.2023.10.11.05.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:36:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] revision: Don't queue uninteresting commits
Date:   Wed, 11 Oct 2023 14:35:34 +0200
Message-Id: <20231011123534.119994-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently all given commits are added to the topo_queue during
init_topo_walk(). Later on in get_revision_1() the uninteresting ones
are skipped because simplify_commit() tells it to.

Let's not add them to the topo_queue in the first place.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---

I noticed this while trying to understand the generation based algorithm
introduced in b45424181e (revision.c: generation-based topo-order
algorithm, 2018-11-01) in an attempt to write a similar one for
gitoxide. Comparing my solution to git's output I fixed a mismatch by
essentially doing this, and it turns out it works in git too. I am not
extremely confident, but all the tests pass...

For fun I also tried removing the UNINTERESTING check from
get_commit_action() altogether but then a lot of tests fail. I expected
that because both the flag and function predate the new algorithm.

 revision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2f4c53ea20..deeab813c7 100644
--- a/revision.c
+++ b/revision.c
@@ -3681,7 +3681,8 @@ static void init_topo_walk(struct rev_info *revs)
 	for (list = revs->commits; list; list = list->next) {
 		struct commit *c = list->item;
 
-		if (*(indegree_slab_at(&info->indegree, c)) == 1)
+		if (*(indegree_slab_at(&info->indegree, c)) == 1 &&
+		    !(c->object.flags & UNINTERESTING))
 			prio_queue_put(&info->topo_queue, c);
 	}
 
-- 
2.34.1

