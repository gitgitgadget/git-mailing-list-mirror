Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A841FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764027AbdAITqz (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:46:55 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35657 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756644AbdAITqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:46:37 -0500
Received: by mail-pg0-f43.google.com with SMTP id 194so16691747pgd.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 11:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QkJnBQ/lEGyiTS8Z34kfWwOTLSN084GKG36i2/kDDU=;
        b=h99dGKH0fgm6/ZKwHd4poHIFtE4Gs+gnyw4s3sOc0tPJb5GNSQa4/pB4AVo3t5JonA
         aXmMrcjfPTQHJu5fD39NfoM15pujrfbhkSzG/vfh36Kh8Aj7rjOmospmeL487RYLglhA
         FbexRXSiXARTdmG0wW6aZL7LXCjSsAI7Q5pI5lXjlqnr+fJIYMskIswfGRGeTCvkELl0
         db8K2g0HYSmebEnuXIdWLnTjzl0OeSFv1p6pn7to+g6xMvn9nePnn1KRcrU5bEVIKhG3
         gAhBGo5uxetPIKUfRFWI+JVI1H7ucY6nF7ypXWnvoTdXNe9cebMtS5kDrfX2DoMq9r5D
         Ep+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QkJnBQ/lEGyiTS8Z34kfWwOTLSN084GKG36i2/kDDU=;
        b=ZdSke+TRqVPJu9hSj830edqeKJB8HH68WY5ZsbL5GtByEKExSrsnVR1RQdXc5WbChB
         KKf20SUmlV1pbyfHJKHiNd/KobaBZ/ASvL8RvBbnfC+WYC8COQyTt3pWAL5FLlbJzfkC
         bclbp3AXR3nmkksbpgeDKMnriAu05eRlvZmOgjE8I12OZKHWt3vSIws3AyR+wXkKSQdc
         tuse/dnnWB+SaVkS2LsOJeNmfKTOmW9kH3e7xnZS8X1okoDer/3vRpOVFzljpXiw1JTL
         I1vUvZGqYL99E1cdHbsTtTe55mpS0dBq8ltVYH+NsJsP2UDJMV0o4pOz45NQLOgtrrIV
         KPnw==
X-Gm-Message-State: AIkVDXIuMx6KicTPbvQOgOYA/t0DAEs3lQFV3eU8GPDtGbPZDD5Au6KHYKO3IbM7E4qkfjaS
X-Received: by 10.99.163.66 with SMTP id v2mr38579317pgn.15.1483991191693;
        Mon, 09 Jan 2017 11:46:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:45b6:2235:29e9:acb7])
        by smtp.gmail.com with ESMTPSA id e5sm181214251pfd.77.2017.01.09.11.46.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 11:46:31 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/5] refactor unpack-trees
Date:   Mon,  9 Jan 2017 11:46:16 -0800
Message-Id: <20170109194621.17013-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:

* Fixed the return type to be unsigned in patch 4.

This replaces origin/rs/unpack-trees-reduce-file-scope-global,
the first patch has the following diff to that branch
diff --git a/unpack-trees.c b/unpack-trees.c
index edf9fa2f6c..8e6768f283 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -221,10 +221,11 @@ static void unlink_entry(const struct cache_entry *ce)
 static int check_updates(struct unpack_trees_options *o)
 {
        unsigned cnt = 0, total = 0;
+       int i, errs = 0;
+
        struct progress *progress = NULL;
        struct index_state *index = &o->result;
        struct checkout state = CHECKOUT_INIT;
-       int i, errs = 0;
 
        state.force = 1;
        state.quiet = 1;
        
Thanks,
Stefan

v1:
unpack-trees is a central file needed for the understanding
of working tree manipulation. To help with the understanding
refactor the code to be more readable.

The first patch was a standalone patch 8 days ago;
now incorporated into this series as a v3,
reducing the scope of the checkout state.

The second patch removes a single continue statement;
it needed some digging to explain, but looks trivial.

The last 3 patches shorten the check_updates function by adding more
functions. If we ever want to parallelize file IO then these smaller
functions would be the scope to do it, keeping the check_updates as
a high level function guiding through the steps what is happening during
a working tree update.

Thanks,
Stefan

Stefan Beller (5):
  unpack-trees: move checkout state into check_updates
  unpack-trees: remove unneeded continue
  unpack-trees: factor progress setup out of check_updates
  unpack-trees: factor file removal out of check_updates
  unpack-trees: factor working tree update out of check_updates

 unpack-trees.c | 96 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 32 deletions(-)

-- 
2.11.0.31.g919a8d0.dirty

