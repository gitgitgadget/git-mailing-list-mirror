Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B010D1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 01:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934297AbeFVB5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 21:57:49 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:44805 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934246AbeFVB5p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 21:57:45 -0400
Received: by mail-qt0-f202.google.com with SMTP id n10-v6so4004139qtp.11
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 18:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=7CK3VbBDzfIKywIru29u3Tinjt8xGZ82ADPCmR9KSDI=;
        b=V/ZNhlVy2TqlKt5srPlvGO5Bfs1cxI4B1QnbRbUvlC3quelP8Vy9Vo2bcHW8oml6r9
         3R4MlgIBYnj/EITNFrrvNDro/RtiK0hwG9aT1U6v+SRL+8OkmGDaGaAJsBldOlMU1GrR
         urmsiUx7qt3zUKF65RMILPqBLvueGpOQSZEOV4QkxLCZfn/QJduy/oIFIdkH8hGWTlWb
         WO0K4K3taDWB+AsQt7AKWCIHwHyFpxRFdGU01HDeRIg8/ob7E8ohKXUiwbAyX+4gH5+h
         szxk1kdUe+s9xn+vsKPqbyxXh07kOqmT3he77f7qkeY/JJUn/AaGntTmxuy4WgwTFlgz
         kV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=7CK3VbBDzfIKywIru29u3Tinjt8xGZ82ADPCmR9KSDI=;
        b=S57RjH5GkgTywdBjhLuXgYuaa1IcDmxEnrRybSqawENfCAEM5oTqiEnuVXoBtD08kD
         bALj0L9MIXbxKSYNWqEu1Ee7rPDymfpE6UrNP1FGOjhWszTR4+GtistId+81hdpmoN3G
         cxRlpHpUfXEqq98B3CeKEJURFCFzFzTBg/T3fjclQm+WVA8+ulDsZ9/snn58eh1Avwog
         Pl+2rtlpr7w5DnfJ2nXYmr+q39twdS24bEa19D61pfpdJuDLoouo2OYonC0f0lKTVGhF
         G8QcnqIFzWudgIaUU1JJKHYtaPGYZMf6f0JLQYouet3EdKkHv7dzY4KbN0bL0HP6Lmfe
         bJlw==
X-Gm-Message-State: APt69E1x6LJ57g9a/yY54ahPxQlD0rs+97fxfmlod6NOzphO27hImdpY
        xTyQBrra9C5vEv4HmQOf7FvkDLGfIIwp
X-Google-Smtp-Source: ADUXVKLCgqEc1D2pqv9+aZMGevD66zronw/cDI9xq+xFajn4VNrkytVU9scY9eVHd+rwz9eCHFf8DM6CZNCC
MIME-Version: 1.0
X-Received: by 2002:a0c:c310:: with SMTP id f16-v6mr15209224qvi.50.1529632664754;
 Thu, 21 Jun 2018 18:57:44 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:57:20 -0700
In-Reply-To: <20180622015725.219575-1-sbeller@google.com>
Message-Id: <20180622015725.219575-4-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v3 3/8] diff.c: do not pass diff options as keydata to hashmap
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we initialize the hashmap, we give it a pointer to the
diff_options, which it then passes along to each call of the
hashmap_cmp_fn function. There's no need to pass it a second time as
the "keydata" parameter, and our comparison functions never look at
keydata.

This was a mistake left over from an earlier round of 2e2d5ac184
(diff.c: color moved lines differently, 2017-06-30), before hashmap
learned to pass the data pointer for us.

Explanation-by: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 136d44b4556..112e6af2cc8 100644
--- a/diff.c
+++ b/diff.c
@@ -842,13 +842,13 @@ static void mark_color_as_moved(struct diff_options *o,
 		case DIFF_SYMBOL_PLUS:
 			hm = del_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, key, o);
+			match = hashmap_get(hm, key, NULL);
 			free(key);
 			break;
 		case DIFF_SYMBOL_MINUS:
 			hm = add_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, key, o);
+			match = hashmap_get(hm, key, NULL);
 			free(key);
 			break;
 		default:
-- 
2.18.0.rc2.346.g013aa6912e-goog

