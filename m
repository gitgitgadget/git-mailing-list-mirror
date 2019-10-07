Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EEB11F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 21:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJGViw (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 17:38:52 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43738 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGViw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 17:38:52 -0400
Received: by mail-pf1-f201.google.com with SMTP id i187so12077822pfc.10
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QMKKVUv6k7UgFLjr7MGlKiH03rnI8U2e76vG8ArMtCI=;
        b=FwhfizxazIXXPYHg0gt5/XqRw75Q1Sl9oSm1CiKHqlPYHRgJWwE2NtzK7JkR90xraF
         UiTgHCGZD7zPbCFNLlp9kmh19JtRSxsCkV+g2OwMn+69Gf3umrS+Ovuupja9qYWNrJ8P
         nG7AfREGC/Cj6+BTcra5/St6VYcBIMlbbFF5Wn6kDNu1OgL8jkomxzBMZeNuuLmXs0DY
         fwudaONAuFXwDLtf6hO5/jn68eqN1GzDi21d6aWf72IKqpoj55kGJYOCFpUIEOCVhb5C
         hHrC9FQaaodTqFkSkXS6BdEmrPSqqFYsInKhlr34ZxTAVw41SL9f77qdQPDGt0kBM8Vx
         qxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QMKKVUv6k7UgFLjr7MGlKiH03rnI8U2e76vG8ArMtCI=;
        b=lA2WDL0pv4ZxiD6GBZfEd2NOLEszFOZUoUXB+owNk0Pw5scokU+1JJ01WxMayQMGJb
         q1HbqN0sEFJ/A8EDKipICZM9Zok2nZcw+ppKuQYRXqMbehDaR+vPCl9zK87PWCbEFuab
         afiMrAOTHHCzynNY2B2l28lCuNNHaRkl3EdOvYsKSsOlfTEV3gcGeJzQ+q5dAYpL03ov
         ssXiLGdDN0jlFQaLlxTJ5Q86OuSwiX6Bgi/xbTKQUJIT+f2izWKyzDQMyYZ6y0BVp2hr
         BQOCh+PyIEZlS/Hb1Jp8ou8fODqnciZww5ORXmjmPzDwTQD2nbiJWE3yFy8PIv3Ik62J
         jD2g==
X-Gm-Message-State: APjAAAW6t5U1Xoht9rJAjI8PfI9p7PdUJiPidOZ2qOddW1Gdc8qpH4Et
        uVNKUrn5Aq0wPQgmQCwT8aqAoGQwjWhaVNxDxNfWFLa36GeDGuwF8+GolNAKVNn0IIfv8BcAUb9
        IvxeJUr0rFAZtscuf7G+70YqTyMnixsNbyN72fbqTu6541LN3uaR7x9T3Cxj+1zM2xmbxOoWC/Z
        tM
X-Google-Smtp-Source: APXvYqxLhycsKPsGmKecCSjgz50K4Vn1HEotekLu8VIuz8cNrRzROMJ8v+rQX185s4UqCTUs2sonxTSryG9R7hxB87mY
X-Received: by 2002:a63:5c59:: with SMTP id n25mr32575955pgm.411.1570484329720;
 Mon, 07 Oct 2019 14:38:49 -0700 (PDT)
Date:   Mon,  7 Oct 2019 14:38:39 -0700
Message-Id: <20191007213839.233451-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] send-pack: never fetch when checking exclusions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When building the packfile to be sent, send_pack() is given a list of
remote refs to be used as exclusions. For each ref, it first checks if
the ref exists locally, and if it does, passes it with a "^" prefix to
pack-objects. However, in a partial clone, the check may trigger a lazy
fetch. Ensure that this lazy fetch does not occur.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 send-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index 6dc16c3211..34c77cbb1a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -40,7 +40,8 @@ int option_parse_push_signed(const struct option *opt,
 
 static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 {
-	if (negative && !has_object_file(oid))
+	if (negative &&
+	    !has_object_file_with_flags(oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 		return;
 
 	if (negative)
-- 
2.23.0.581.g78d2f28ef7-goog

