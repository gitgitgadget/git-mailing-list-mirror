Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C6820281
	for <e@80x24.org>; Wed, 28 Jun 2017 00:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbdF1A5M (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 20:57:12 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34334 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753496AbdF1A5E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 20:57:04 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so24650852pfs.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 17:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IMK/oxFIp4MV00e3HLcc5e20PZZgAWSpZODsOuXv2jE=;
        b=Q214Wn4FTzVklvcXI5O4JylnK2CqVgVdhlYflKPjCaDWu0N1FXfI0KHW/yuwyBhepN
         Ez1a8QVcmpZO2egby5cdac7sBRPURyLWv5USs8y6F7KEMBgyR1FZOswYZCVp7bLWeu12
         NtsC/RwQnM8/9fWBbd39BbbwgAdcGiLaSu1fBLF5I9FZaIE3fKoVIYfa6r2J7U7xXUKt
         qU1vlURdW+9O3e5q/Kpc6Op1HaqhNHj+xkn4duQPam7Q64CIbnUatYZgGUYqubSyqtQ7
         dATHJ0+YeIIDHw2FN+jMYyV1zyrpYyQgXcXrjzjctnJzSF+RFnZod4ajtgEy9TnqQplk
         YawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IMK/oxFIp4MV00e3HLcc5e20PZZgAWSpZODsOuXv2jE=;
        b=mAxQ8Q/2b7ioCl6jhS6Om0c0srCL6NfRp4i7AbFlPtFus5jT/JUa3VdFCft7WksUV8
         Bt4tEFsofec5FUZc4AYI/qpnKjbgnGX9m3PN/ykqJdhDox0A6fFUgLtVkYHce513o+WU
         FRfa36BRcLQsbrv3B8lmbG/SAGC+FWjZnu25G0411V3HoYdfWC4bxldcpe4OR6PgaPTR
         Z95DL68HLBdEkrj7ecUQo3s7B9AoU/KLBgNIG9oaodo4BGf1INmzElSM3PjdYhQ3cxzV
         h/VuUzaEPar/PBjT8pxmwPHKi32ZzpLeBSEEfSTFHiiaNjd+N6lVXCQLHMuARm7vNQ/U
         a2pA==
X-Gm-Message-State: AKS2vOyPq83XJbvZHwsvPoRZvWHPXmIgooi5NP6EyYl1QCUmvoJIJQ42
        wXzxY6qVR7LcAwTh
X-Received: by 10.84.215.212 with SMTP id g20mr8644913plj.124.1498611423916;
        Tue, 27 Jun 2017 17:57:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ac62:ae13:b066:f242])
        by smtp.gmail.com with ESMTPSA id a79sm846319pfj.5.2017.06.27.17.57.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 17:57:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] diff.c: omit uninteresting moved lines
Date:   Tue, 27 Jun 2017 17:56:50 -0700
Message-Id: <20170628005651.8110-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170628005651.8110-1-sbeller@google.com>
References: <20170628005651.8110-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is useful to have moved lines colored, but there are annoying corner
cases, such as a single line moved, that is very common. For example
in a typical patch of C code, we have closing braces that end statement
blocks or functions.

While it is technically true that these lines are moved as they show up
elsewhere, it is harmful for the review as the reviewers attention is
drawn to such a minor side annoyance.

One of the first solutions considered, started off by these hypothesis':
  (a) The more blocks of the same code we have, the less interesting it is.
  (b) The shorter a block of moved code is the less need of markup there
      is for review.

      Introduce a heuristic which drops any potential moved blocks if their
      length is shorter than the number of potential moved blocks.

      This heuristic was chosen as it is agnostic of the content (in other
      languages or contents to manage, we may have longer lines, e.g. in
      shell the closing of a condition is already 2 characters. Thinking
      about Latex documents tracked in Git, there can also be some
      boilerplate code with lots of characters) while taking both
      hypothesis' into account. An alternative considered was the number
      of non-whitespace characters in a line for example.

Thinking further about this, a linear relation between number of moved
blocks and number of lines of code seems like a bad idea to start with.
So let's start with a simpler solution of hardcoding the number of lines
to 3.

Note, that the length is applied across all blocks to find the 'lonely'
blocks that pollute new code, but do not interfere with a permutated
block where each permutation has less lines than 3.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 11 ++++++++++-
 diff.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 015c854530..1d93e98e3a 100644
--- a/diff.c
+++ b/diff.c
@@ -853,7 +853,8 @@ static void mark_color_as_moved(struct diff_options *o,
 {
 	struct moved_entry **pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
-	int n, flipped_block = 1;
+	int n, flipped_block = 1, block_length = 0;
+
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
 		struct hashmap *hm = NULL;
@@ -880,11 +881,19 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (!match) {
+			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH) {
+				for (i = 0; i < block_length + 1; i++) {
+					l = &o->emitted_symbols->buf[n - i];
+					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
+				}
+			}
 			pmb_nr = 0;
+			block_length = 0;
 			continue;
 		}
 
 		l->flags |= DIFF_SYMBOL_MOVED_LINE;
+		block_length++;
 
 		if (o->color_moved == COLOR_MOVED_PLAIN)
 			continue;
diff --git a/diff.h b/diff.h
index 9298d211d7..cc1224a93b 100644
--- a/diff.h
+++ b/diff.h
@@ -195,6 +195,7 @@ struct diff_options {
 		COLOR_MOVED_DEFAULT = 2,
 		COLOR_MOVED_ZEBRA_DIM = 3,
 	} color_moved;
+	#define COLOR_MOVED_MIN_BLOCK_LENGTH 3
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
-- 
2.13.0.31.g9b732c453e

