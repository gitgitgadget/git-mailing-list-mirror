Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E131F453
	for <e@80x24.org>; Tue, 16 Oct 2018 07:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeJPP2v (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 11:28:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39330 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPP2u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 11:28:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id d15-v6so20304523edq.6
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pndbho1JTYlAgSTBbPgtKLpVz2ohrCt15jtlqQq/yaQ=;
        b=KVTdRQuzB7bd7lSHJv5RXZVNyY16cbIHI0BzKMLylTU8bTM9UvUatS0JNbkts8OlhH
         gjocQBTywrkNxbAOsVmCMpcK5/nG+MY/QEk8Da5Y7n9OwDO8udgYufdXVsybuCujjulM
         jaiDK/i9XwL6XZc1Egqv88Z5FDz1AgD3mWcqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pndbho1JTYlAgSTBbPgtKLpVz2ohrCt15jtlqQq/yaQ=;
        b=hnFWQMYlkb5KVsTIDGTrdZ3nK7mY/YEGpByQ6MIqEZkRVWWMtabfyo9h6+D8uIyRs6
         3nbouiaKIm+uSU8oJOsgyB9MyMnwTokAfbh2ETmHlbtDMQDXnHcn6VeybHZfIX74Eq42
         lkw/7W4pjIwLRx4MO2jke5Mfa1SVquINBvGyZ0Lr/iX+TbhoDewaHA0+sKCj4jNZTgOb
         xsi/EBfFwNtxADQGCHAriZpvZF+E12HwRFYQ7YDWogjfWYJeG3+GjARd6APx+3fmkKEW
         AhisXss1sLwoegHePIDK0hs/g4fYG8XcGhfrQEl6aHXfd2O1o+3OOv11lkwm4QMDs9oT
         3Eog==
X-Gm-Message-State: ABuFfoiWMRR4bZTB59vCW/cBqZ+5m4aldddaZJN4hr5dHo4LvOp3YnDl
        BzJNIE4sGLDBuf8RPXL3hc/y7Ynthk0=
X-Google-Smtp-Source: ACcGV62bGqsodn8ASXI06PN97dCrCkGVU64XcVpPwuK/npYKorY47yP4qDClOSb8XHEItYApl5KGjg==
X-Received: by 2002:a17:906:755d:: with SMTP id a29-v6mr21904595ejn.84.1539675581476;
        Tue, 16 Oct 2018 00:39:41 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id q18-v6sm2774661ejr.8.2018.10.16.00.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 00:39:40 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 2/3] send-email: only consider lines containing @ or <> for automatic Cc'ing
Date:   Tue, 16 Oct 2018 09:39:22 +0200
Message-Id: <20181016073923.28134-3-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181016073923.28134-1-rv@rasmusvillemoes.dk>
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
 <20181016073923.28134-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the address sanitizations routines do accept local addresses, that
is almost never what is meant in a Cc or Signed-off-by trailer.

Looking through all the signed-off-by lines in the linux kernel tree
without a @, there are mostly two patterns: Either just a full name, or
a full name followed by <user at domain.com> (i.e., with the word at
instead of a @), and minor variations. For cc lines, the same patterns
appear, along with lots of "cc stable" variations that do not actually
name stable@vger.kernel.org

  Cc: stable # introduced pre-git times
  cc: stable.kernel.org

In the <user at domain.com> cases, one gets a chance to interactively
fix it. But when there is no <> pair, it seems we end up just using the
first word as a (local) address.

As the number of cases where a local address really was meant is
likely (and anecdotally) quite small compared to the number of cases
where we end up cc'ing a garbage address, insist on at least a @ or a <>
pair being present.

This is also preparation for the next patch, where we are likely to
encounter even more non-addresses in -by lines, such as

  Reported-by: Coverity
  Patch-generated-by: Coccinelle

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 git-send-email.perl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2be5dac337..1916159d2a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1694,6 +1694,11 @@ sub process_file {
 				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
 			}
+			if ($c !~ /.+@.+|<.+>/) {
+				printf("(body) Ignoring %s from line '%s'\n",
+					$what, $_) unless $quiet;
+				next;
+			}
 			push @cc, $c;
 			printf(__("(body) Adding cc: %s from line '%s'\n"),
 				$c, $_) unless $quiet;
-- 
2.19.1.6.gbde171bbf5

