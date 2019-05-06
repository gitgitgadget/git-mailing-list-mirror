Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E521B1F45F
	for <e@80x24.org>; Mon,  6 May 2019 21:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEFVhB (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 17:37:01 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:39915 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEFVhB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 17:37:01 -0400
Received: by mail-oi1-f201.google.com with SMTP id d198so4922489oih.6
        for <git@vger.kernel.org>; Mon, 06 May 2019 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yt5QuPR+1gO7GBfLEKs6fgJPV1rgjA3ZGgrYonUBptg=;
        b=uvdjpMo8P+mtBa5+Oxc/yag5/Mx9SKOczepuoaCYQYFyf9e9PN61OTP9/BNYhIZ9ao
         9fL/hx1Dwb62pqIcURkyRbsm1kkcsImnjK0oc6al/2RJ8vuOKfax+XDC0oijlJ2F3KP8
         /9EdgA4NYXTR74V13qztMwfEullxjY/Zy/B6UBLP3I5K5fCsiJN+y3IYMsIFhDidU0Vh
         MKyw0sWmwJEhYc/Psx+lufD6EtPw38g5ca/laiycgzqSrw0O1FUokI15K8VYdRKvVW8t
         Ebx9YCn5yMyujEjMibAdXX6ntJn7cCevJYCxF3dmNRVMoTdyPkk4THZbHs5wdjSBADCB
         HSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yt5QuPR+1gO7GBfLEKs6fgJPV1rgjA3ZGgrYonUBptg=;
        b=ipNvi7j7tg3fssWuB8ppu82IKBhTcRdo/RCV8xy6wNjnqECcDLZ6eZpLWtyXPnt6Qm
         U0tPaShTWaJReEFZDwyxTQCApRAooxWFWs2lrHB+8/Fg1QbRf6OnxMJydRS8mh3NJwgJ
         /TNu//fcwD8uttS0rr4a47guwXW00V3MpxbVoXjUz/zujbDO+UCP7N4cOI2Jqr9UkfN8
         UH+xF0NcrnDNGTpO4BkELAaf2smE2BwtK4b0vOw6zX0QiO1IopuYdL/ammEB5GGoDq/A
         tRPewQKwFrGkdBRJ9eTEQNneO+LHzvuInFvqQOq+oyokP5ON2Xe2jWv0KMvv9oKyeP/j
         sloA==
X-Gm-Message-State: APjAAAXgDz3TRRQen/iQyB3sKV/uIqMqc0ILX/YP2tVviiGJRWg4CbaC
        g2rlUFL5Xku8EYVyaTCYrwHYMO1NUkNUuFIZsYNrl8C1pQd0f7pN8RN04swKWJPlXLYm+aWCnkX
        lRgNOtewDwNOGanAvIHQA1b3wpTa/f8EfnAlwa9jq74GUgDvcVuR699LY8KBhxkE=
X-Google-Smtp-Source: APXvYqwCueUPUoAd8ZuBaD8X4ErAMW+NJoPJPU9f5ivZU+nxPQ1TuuvqWqZ5CZ3b3k6TI8+8pRWzY6Xir4UTMA==
X-Received: by 2002:aca:4942:: with SMTP id w63mr180132oia.33.1557178620768;
 Mon, 06 May 2019 14:37:00 -0700 (PDT)
Date:   Mon,  6 May 2019 14:36:58 -0700
Message-Id: <f4ab2a50873b2fd91926d7401f784479504d1b10.1557178485.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] commit-graph: fix memory leak
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free the commit graph when verify_commit_graph_lite() reports an error.
Credit to OSS-Fuzz for finding this leak.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 commit-graph.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 66865acbd7..4bce70d35c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -267,8 +267,10 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		last_chunk_offset = chunk_offset;
 	}
 
-	if (verify_commit_graph_lite(graph))
+	if (verify_commit_graph_lite(graph)) {
+		free(graph);
 		return NULL;
+	}
 
 	return graph;
 }
-- 
2.21.0.1020.gf2820cf01a-goog

