Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461AA20188
	for <e@80x24.org>; Sun, 14 May 2017 04:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbdENEBf (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:35 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35949 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdENEBd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:33 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so47211151pfg.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8xqL/iCSTs2OT/Wv8L/JiYkaieK84G3QIpPQ/l0Atg=;
        b=RzeGc1AioTfLbc9uShBhAqWKVQO3uKvvLaMtV2wiW6ffvaedAkOlOxPNAmNKZn3zce
         Xmnbzy+ZIfBcgZc0FxCP79AiehzHIEyuzr1V9dWxa3aRwEtDktD3h2+MeyN4OOesyWZS
         3GeD9lV3F7LqxoWFwLtB+Hv/0DgawVoKk38fjh4lJVHb5z8tvlX+3o/odCA7U5qzt7J7
         RB7PR3MKwzIRdYpXXuLDgxmzluwh26vyNGsScmeiStcAsq/ZjL6SevJQ8KoxX09c3wFa
         pAdqR3R7AqC6qH6/0pQ1lCFcTNDgSxwnznXoW7Sqv1Q0ixJizWONtHGyTUETOgWyomtv
         WVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i8xqL/iCSTs2OT/Wv8L/JiYkaieK84G3QIpPQ/l0Atg=;
        b=p40nxIMFgAUOkyIgNGyEuUKwD1KGJpAcL9zjP6dN5XRdjEbA89vR3u9ND7pZZu2WkQ
         LtB+dnd3fQfc9xodi1khdKxkQOYv+V/cNDntcP2XvZSiNlDRVfI7IRrkxLlnECAUNv1u
         gHf1rSiRkklfZrvs0v7c/p8MqySEJhVzjceIQZh1ADsRy8pCbYNdXSovqZs+Gwnt78fn
         lWtNDSc29qQnJryUgzXH+QqdD1eatR3rG6vnKwqzBg6wj0+3ce6ZDA6ECTZicDjkbMYa
         S7We4ziiIEQnYjQEt8UetifffP7AiqDapsYqziQRiWHpjuu+7uayK1O+rEZ56ndbkvGU
         D9Yg==
X-Gm-Message-State: AODbwcBgHbNNp73cXNBVLWm6MKowH2P+0h6PoQTDsnoktF+WlhIrNeeL
        CXpBFJRv5k8tZ8M+
X-Received: by 10.99.152.67 with SMTP id l3mr12127584pgo.97.1494734492932;
        Sat, 13 May 2017 21:01:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id t17sm13075842pfj.61.2017.05.13.21.01.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/19] diff.c: emit_line_0 can handle no color setting
Date:   Sat, 13 May 2017 21:01:03 -0700
Message-Id: <20170514040117.25865-6-sbeller@google.com>
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

In later patches we may pass lines that are not colored to
the central function emit_line_0, so we
need to emit the color only when it is non-NULL.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 381b572d76..48f0fb98dc 100644
--- a/diff.c
+++ b/diff.c
@@ -532,11 +532,13 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		len--;
 
 	if (len || sign) {
-		fputs(set, file);
+		if (set)
+			fputs(set, file);
 		if (sign)
 			fputc(sign, file);
 		fwrite(line, len, 1, file);
-		fputs(reset, file);
+		if (reset)
+			fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
-- 
2.13.0.18.g183880de0a

