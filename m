Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2D420188
	for <e@80x24.org>; Sun, 14 May 2017 04:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbdENECJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:02:09 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34982 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbdENEBr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:47 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so42316133pfb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E2EsvBfi0/QQZoo98UesB37Z0CFEMCpLx2n+c0DHZac=;
        b=uKndoDUYQea1kOfxin//K38JxjZPiGvarSeH8rGXjvrr/0SHnlITMwZJVhPt5n0EZJ
         gx9rgTzv/G3FiEhA1g52iXnTtIkiP7Z5okhtghdKTAYApc+j+PdsoYZQB/PS2sUVxg1U
         3lLzOeeWl29lpb6+E0XKeD8hONOsad0xBrmVfhAYq3ZUQJYwylxMkKA5rdUYzoTCa6wk
         m/Fguxf4jOJnnxKKphv4zXg3Wo7eYLbVGxDK3QJDYJXdF3cTsxgjkIaLThIgcC3f/ZgK
         qsobmM//vrLtp1wV8Irjeb2ZAeaCGKov++VPP2YTE4Fvr9UYIduW77ndSvVYq8FUYv9E
         aBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E2EsvBfi0/QQZoo98UesB37Z0CFEMCpLx2n+c0DHZac=;
        b=qAlnAPAHk9P/dV+s/fSBEJnOy59BgxC30xfCKemOmjcsaMnf5jGf5lfUEsH7o1HoMv
         owTU51bRf3V15Tka6XLcnOYVmj1IySOv4ucj5p6tNh+vDl1k+InWjZiIJd8ySVqW5aVB
         vn3jt5/jtHgppt9Wimoy0VtPcy7cZkAdvLaMyDffVnTf0nB+MXTZ4b08LyXw7ZBPoPMf
         ul3vWLrSqQ2MIXXIv07//a/eyI+3hLGOSe6pMo6ZLdsGrfM+UfrPcom0FeW/YMUYga9j
         NN+btVjbx/Xm7diTPmaxyIbdExzgLkxYmxrwdY7CrF3k6mGRBK/iNGlAWcqIboT5i7l+
         8Hsg==
X-Gm-Message-State: AODbwcA6c/R8jz3NthtFFrWFiT9QrR38mE9ydX0CiHiGdlJkNUkEa1xf
        MDgLqjZtNMzcto+D
X-Received: by 10.99.185.91 with SMTP id v27mr12119956pgo.184.1494734506473;
        Sat, 13 May 2017 21:01:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id q4sm8649650pgf.9.2017.05.13.21.01.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/19] diff.c: convert diff_flush to use emit_line_*
Date:   Sat, 13 May 2017 21:01:13 -0700
Message-Id: <20170514040117.25865-16-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This covers diff_flush.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 07041a35ad..386b28cf47 100644
--- a/diff.c
+++ b/diff.c
@@ -4873,7 +4873,9 @@ void diff_flush(struct diff_options *options)
 				  term, 1);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
-				fputs(options->stat_sep, options->file);
+				emit_line(options, NULL, NULL,
+					  options->stat_sep,
+					  strlen(options->stat_sep));
 			}
 		}
 
-- 
2.13.0.18.g183880de0a

