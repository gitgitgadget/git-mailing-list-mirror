Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FDCB207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbcIMEqj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:39 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34644 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbcIMEqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:34 -0400
Received: by mail-pf0-f177.google.com with SMTP id p64so59783775pfb.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9XBq8X44CUIVRpHG4989km7nj2URI/cllhh7GPSUkuA=;
        b=it4HJQ0YzG6CiqYeRvAw6zbiXNLu7fqn7uWxmm+Vzv+DG7wMTN4uWGkYNzXYSHSgRd
         wKjpbj2Wjc715TLuTflx5ZMTsEeujm+tFXoa0dOOhXXHJV/AhqvPdPDtAoEoZF19og8u
         TcvlLhgeqjXeU0eGejS2Frhw8680PZtujqNBMkDOvtyuE+xFXgtkt0VE260YMkTXTrOZ
         OxUJ1YBl3x5MQ0pRmPJdJebdF8YnLSyNbGaViGpZ2HD8r3O+0xS+x+K4W5ur+jeGaXqK
         k9Mdl/OXWJWAi4b8noPQRClFPCaDlDHxjTfIyzfsZkSGATmrA/pcpsHAGIBXwum20Zab
         PaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9XBq8X44CUIVRpHG4989km7nj2URI/cllhh7GPSUkuA=;
        b=c3TnHc7Iby3Gj3k0IJ933BZyVSDS8OmP0ho6RGkOs+J7G87W8vWc9tHtkKFZLc2Ikp
         41ItYG/URKiarHuOfJYYY84ie83EhetEb740RgfD5oSWe2dwu4MyjQcuyTASuiJZGcHC
         F84OdE+0IcRykCyU1h59d8K6J7h3tCr3cQOJXghE/U3z1Bzau4eujoJjDvTUV0c19+FL
         PzhVTXgHDtHh8GR90tiuMhrxv62BU9RO+5EEe389AMmH1It4pGFVD7BQY74thHdnqR/N
         TLNIwisB01cvO6vUuGhAT5zYCY7inRSZonWS5RdHluTn/BCDpweQScLMWfxAliFveZIi
         kMYA==
X-Gm-Message-State: AE9vXwMYtYylHi0dAknyiGYpRlgLDs7jRA5ahdbRv+vHz679WfLFxQA1R86cnQhkcRabv9wR
X-Received: by 10.98.75.4 with SMTP id y4mr792997pfa.25.1473741993291;
        Mon, 12 Sep 2016 21:46:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id 10sm26642641paq.20.2016.09.12.21.46.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 09/17] diff.c: convert emit_rewrite_lines to use emit_line_*
Date:   Mon, 12 Sep 2016 21:46:05 -0700
Message-Id: <20160913044613.1037-10-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
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

This covers emit_rewrite_lines.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ee4c9d4..3aa99d1 100644
--- a/diff.c
+++ b/diff.c
@@ -690,7 +690,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 	if (!endp) {
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
-		putc('\n', ecb->opt->file);
+		emit_line_0(ecb->opt, 0, 0, 0, "\n", 1);
 		emit_line_0(ecb->opt, context, reset, '\\',
 			    nneof, strlen(nneof));
 	}
-- 
2.10.0.21.g1da280f.dirty

