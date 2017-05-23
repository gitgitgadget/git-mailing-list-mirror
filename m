Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E67C2023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965592AbdEWClu (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:50 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36180 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965586AbdEWClS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:18 -0400
Received: by mail-pf0-f174.google.com with SMTP id m17so99604028pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ojHg7GpKiHrWwSPsBjqao/bKSnSzitciM1YWPr+aYac=;
        b=SD2HlZi+LK4GMi1LDLDpJzLZNlZKEoYmHOUMZw4gi18Sv8LJDVpCwiHbYacpzCVMYJ
         QjBTFgNR3+E7ZGNo+EGR4ROggw0FMCpv4EFFloEgkfFvp/iy8+EIljHjpPUSEhKxZ4Fg
         KZd6eyMKD5onyYtL9oT76xEJVTkTQregAZRCnil7ONbq0ms2AF9Z+g3adUNkYmZDp8t9
         aRTPbd95ZOXUcMEqjh3R3eOQGu+Wqts/MbsDi3MwW/dmcNThWW18BgINO539SabEKr+R
         njSp2SBuBGHlRTJB8xPC4f2u48jrGIK8NKShApQFS3OPMI4I+BwmvUG3zJ7fXafEHOS+
         CnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ojHg7GpKiHrWwSPsBjqao/bKSnSzitciM1YWPr+aYac=;
        b=WCRbW/XzzSETEpQeWPPSi0GlRU7ELWKMpHwIkz86xgCWF8hNoNjodzCgBffwKrDlLx
         FUYuChQhAgs1iBWVyFa66PZvSooWM85RBtO7N7QRCR/LvK4Y+b9scPJleKEuaq5MojkC
         tYqfwwFOEC0eFhCgQS2iztmCqNXo+ebWbNjJmHSQpQgwoUq2wM7rbmOjKK+YZOi401Sn
         znOnTcfuaSk5ZtdfWGYX1BzfhWV8hCG3BpHdBuNJ8ljTxcWs1RmwxLCcvuPZS9Unbh06
         8/AT3am8VRDfhJ+eyLMt8xPvKsHOiSkhyiX13VASpGAnMKvsltGz88gTVtnVQE0c3rJ4
         AuuA==
X-Gm-Message-State: AODbwcApbQG6yB5QfB0Us7kOTFbocHfzbdNblfu3yIlhsI4B7sPpRmTq
        Y84wcTh5AprkFGRM
X-Received: by 10.98.86.74 with SMTP id k71mr28861963pfb.13.1495507277233;
        Mon, 22 May 2017 19:41:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id t5sm29768012pgt.19.2017.05.22.19.41.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 13/17] diff.c: convert diff_flush to use emit_line_*
Date:   Mon, 22 May 2017 19:40:44 -0700
Message-Id: <20170523024048.16879-14-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 8317824963..8ebe673331 100644
--- a/diff.c
+++ b/diff.c
@@ -4872,7 +4872,9 @@ void diff_flush(struct diff_options *options)
 			emit_line(options, NULL, NULL, 1, 0, term, !!term[0]);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
-				fputs(options->stat_sep, options->file);
+				emit_line(options, NULL, NULL, 0, 0,
+					  options->stat_sep,
+					  strlen(options->stat_sep));
 			}
 		}
 
-- 
2.13.0.18.g7d86cc8ba0

