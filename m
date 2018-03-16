Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C951F404
	for <e@80x24.org>; Fri, 16 Mar 2018 22:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeCPWhX (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 18:37:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38958 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPWhU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 18:37:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id u10so5706650wmu.4
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 15:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YkkN8IFFl3XsyAwliICZOMprR1+mw8J8GTUVAyIxHCU=;
        b=fgPoooijgwUEO4sXp3zuNHCsV0vN52XQiFxUMGAzdpHuUSkHxqk4ca0QNGOV1jMuPe
         0GGE6zeM4Nqi3blCTUMBXeORlZLhFcbp6QeCazxONJaYfDg+5r0fOdof3i4qcgz+DDfC
         N4kC4x9ykS89LnSYy+z1ssBeopeX37uD5at9OQax0YZUQgNESlpcwSLi5W/mf5DOC+E+
         Ki6NqPODYaLco8cBHr9n/bsCLGSa2LSDFUlduhE+fHwgaCLu+424I4mAlP2bV0NfGMO8
         PmjKJuqqgPUjCi7xQQUw3WOF+i+vUOTRhzQLpSbXp2Q8wvEvS5BnkuDMIaQzuttoi4Rz
         WYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=YkkN8IFFl3XsyAwliICZOMprR1+mw8J8GTUVAyIxHCU=;
        b=jc7fsoumrfKjBFLagLLS2kyrCd4fvSyHWSi0KZHXw/rDlmvYF8qVUFKQS2dld+AsAN
         urYtr8dwbzBOdfuH4vq8QbZcbYVHKuwNZF6uKTLEQO0bknQgg0otbuRFYnbpgJUTgQ3Z
         UEYtdQIBuop73mls8NF58Sphe9jTh+lh/7a0jMe7Z2ktQGW8qmfVEdptlJCQSAGostvQ
         Z0yrtaoGf9GT6OiS0zwCN4yvH8Vk8XmnnP034ejQTH3tZQieJxvMAi5F5kSFV6NZEeWf
         NO26N1qiSEJtwfvKU/jhvZvTV/Y7492NHt8bLyt946CKFIAFNiWu8vkX+r2wFagASLcG
         FF8A==
X-Gm-Message-State: AElRT7F6ykRb37Bo4DXyq3R5gHJtuRvXtNHy86Ht2VkGx4J0YOmyoG9V
        3rpN3DUnFe/unbKGjprDBBI0bRP8
X-Google-Smtp-Source: AG47ELtmtaTCjjoYlbzsd98rHkzfB/zkJhlapkZex/k6AP39WAOQrRDMV9WWBqQVduM/k+EeaIrc3g==
X-Received: by 10.28.48.85 with SMTP id w82mr2906403wmw.95.1521239838799;
        Fri, 16 Mar 2018 15:37:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o24sm9473086wmi.29.2018.03.16.15.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 15:37:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 1/3] stash: fix nonsense pipeline
Date:   Fri, 16 Mar 2018 15:37:13 -0700
Message-Id: <20180316223715.108044-2-gitster@pobox.com>
X-Mailer: git-send-email 2.17.0-rc0
In-Reply-To: <20180316223715.108044-1-gitster@pobox.com>
References: <20180316204306.862-1-t.gummerer@gmail.com>
 <20180316223715.108044-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An earlier change bba067d2 ("stash: don't delete untracked files
that match pathspec", 2018-01-06) was made by taking a suggestion in
a list discussion [1] but did not copy the suggested snippet
correctly.  And the bug was unnoticed during the review and slipped
through.

This fixes it.

[1] https://public-inbox.org/git/xmqqpo7byjwb.fsf@gitster.mtv.corp.google.com/

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index b48b164748..4c92ec931f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -315,9 +315,9 @@ push_stash () {
 
 		if test $# != 0
 		then
-			git add -u -- "$@" |
-			git checkout-index -z --force --stdin
-			git diff-index -p --cached --binary HEAD -- "$@" | git apply --index -R
+			git add -u -- "$@"
+			git diff-index -p --cached --binary HEAD -- "$@" |
+			git apply --index -R
 		else
 			git reset --hard -q
 		fi
-- 
2.17.0-rc0

