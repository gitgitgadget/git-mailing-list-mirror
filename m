Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B6420229
	for <e@80x24.org>; Fri, 11 Nov 2016 00:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966070AbcKKANl (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 19:13:41 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35632 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934906AbcKKANk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 19:13:40 -0500
Received: by mail-pf0-f169.google.com with SMTP id i88so943989pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 16:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pt1mDbcvO7gojaDCuuPp1f3RN/+1CUA5WwS5xGYJ63U=;
        b=drP5YAXb1GgpLGF5nIPIgAaIR0slG7xi+OLhKpUgOmagPcoLPhya8waMS3Celuge13
         NYaVNGLCBRx/4KXtfaZ1qLwFEq9e411/zf8eKtB2yUunXnSBnAqELPZD0fFjiQi9kMwT
         vw1pp1a0gtMDN1WtbRt7jrP3+lOSlxbZpWzVnSll5H0VYETVsftZ93GHHjgmvoemEDhQ
         WnByE0KEoV8OqZbgnBE2n/aWESdIh9sli8boWXE1t2lodXjXTj4klcIv/dVbAv+JgxTR
         xZ8UKXlgZQao2slEGrRDNLl9Mljff/md7i+66b0RCMShzjg35pAxEVw8sALhrp+G0BqT
         LEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pt1mDbcvO7gojaDCuuPp1f3RN/+1CUA5WwS5xGYJ63U=;
        b=bV89RFB/pgZrzZiYpd2M7/8WCxEAwBeMpArkAP0yMdvUZwctaB+8KODVF35fSxPzx9
         c/SnCpX0R0ymg5BMKzwF1Tb9iorPKQ536AJt9b/s9T4FXJ44KYiOiIW1cObLzxHzTzl6
         Du71BBqsvOITW5sWgO5InRXCT06QcYOmUNzg8l/050t0NDv6ZaweOqnz7ezYN1TWHhxc
         U81EjYq27Om0+R2nayqen8MEtGwUAP5Mxbe71ie/iwUVrK+BMEoy1K5SnrOwMnXuXKLZ
         PeG2GEISjVdV0FjyREat8Oq+m0XNt4tXtOF7vVTmfeAWybKRI+qm+q/g5WmFAHpE4wO1
         zAjw==
X-Gm-Message-State: ABUngvcymf2QU6wNb4oo00kTW6ugcMWKoJywLumR9xdvd9oYrMVIk7rtipA/mR+6AVmqiur9
X-Received: by 10.99.169.25 with SMTP id u25mr27918097pge.6.1478823219339;
        Thu, 10 Nov 2016 16:13:39 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.12])
        by smtp.gmail.com with ESMTPSA id s2sm9896425pfi.10.2016.11.10.16.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 16:13:38 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fetch: do not redundantly calculate tag refmap
Date:   Thu, 10 Nov 2016 16:13:28 -0800
Message-Id: <1478823208-10647-1-git-send-email-jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/fetch.c redundantly calculates refmaps for tags twice. Remove
the first calculation.

This is only a code simplification and slight performance improvement -
the result is unchanged, as the redundant refmaps are subsequently
removed by the invocation to "ref_remove_duplicates" anyway.

This was introduced in commit c5a84e9 ("fetch --tags: fetch tags *in
addition to* other stuff", 2013-10-29) when modifying the effect of the
--tags parameter to "git fetch". The refmap-for-tag calculation was
copied instead of moved.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

(I noticed this when working on something in this file.)

 builtin/fetch.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b6a5597..1d77e58 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -359,9 +359,6 @@ static struct ref *get_ref_map(struct transport *transport,
 
 		for (i = 0; i < fetch_refspec_nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec[i], &oref_tail, 1);
-
-		if (tags == TAGS_SET)
-			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	} else if (refmap_array) {
 		die("--refmap option is only meaningful with command-line refspec(s).");
 	} else {
-- 
2.8.0.rc3.226.g39d4020

