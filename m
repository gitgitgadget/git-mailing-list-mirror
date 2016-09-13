Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D465207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbcIMEqv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:51 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34053 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbcIMEqo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:44 -0400
Received: by mail-pa0-f52.google.com with SMTP id wk8so3854691pab.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hiTKoExo1HJ4kqVw3CVKIIa7fTvJ9+cq0gAqwByrZ+4=;
        b=i3o8Z6owlQcJRx+Whg5ZQi/zoq5UCmIHVf2LBvKCcswArZMTDjFD/bU2sXCTn06dlZ
         iBDQ8Q2Xq/8UKeYCNjWUCuak0XKSytEzLPBc8RRMzuoJtypw/qxoYrjaqd1HTh+8h2y2
         W6nYJsV6uCAtCDD69v7pgEWEVP132TeGPe2yEJQTZK6tWPerZtIQ/8Chmbg4Wyc0Kn7s
         jD3cCPhETQiDwjUIRKnIMHz0SUg0ErGhXLNtadCboTDLn3pI2hgMEyuKGHRlNELsNt0O
         5gko1rGXyhxs3cwQH+OxMmN6SvkXSsPM1ephP7QOQixK/eYtEI/NGfl7r6uyzVJoAH+K
         jEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hiTKoExo1HJ4kqVw3CVKIIa7fTvJ9+cq0gAqwByrZ+4=;
        b=fDhKyBxu8kU6CeqX0AbIUxJ9Azk+EqFqF7TwpKhl/yN3EV04+CEm2aJOErAGGlt8h4
         LpvZEY2uYRFrqfIY+2h+h3iQ+cGmcc3OFJCHzm1cS6s0bzu4d8K+b926IGVWBgyt23nu
         GQyWgvLOxT5jdTr2EUjw/8pW+6fPH71eNYVixZ/DKU4iG1BWxDzvtQ4BIP4ScTaQvUy2
         ivBojsrpYDpx3raUYvZYpXyM6AXma0s5S8riMH9O5npLLJmsZEa0o+H9HyYKuaqaWPok
         XIrKv/9KigqZUXnzR2FZavX4CilVrAJEy0jIMwZN6iESzEuiIH4YQM8A1ydbYOFR0lDp
         TCkw==
X-Gm-Message-State: AE9vXwPUV+l1en5Wj0dSuUttpHjUAhKk306Pk2QUFbubfNNtFBMxMYGRJxMAIjwQyTS/iToR
X-Received: by 10.66.5.5 with SMTP id o5mr40084513pao.38.1473742002889;
        Mon, 12 Sep 2016 21:46:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id f23sm13949176pfj.72.2016.09.12.21.46.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 14/17] diff.c: convert diff_flush to use emit_line_*
Date:   Mon, 12 Sep 2016 21:46:10 -0700
Message-Id: <20160913044613.1037-15-sbeller@google.com>
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

This covers diff_flush.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 3940f79..2b1ebcc 100644
--- a/diff.c
+++ b/diff.c
@@ -4737,12 +4737,13 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			fprintf(options->file, "%s%c",
-				diff_line_prefix(options),
-				options->line_termination);
+			emit_line_0(options, NULL, NULL,
+				    options->line_termination, "", 0);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
-				fputs(options->stat_sep, options->file);
+				emit_line_0(options, NULL, NULL, 0,
+					    options->stat_sep,
+					    strlen(options->stat_sep));
 			}
 		}
 
-- 
2.10.0.21.g1da280f.dirty

