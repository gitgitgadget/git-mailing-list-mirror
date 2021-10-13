Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59BFC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 02:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB38760F23
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 02:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbhJMCrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 22:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhJMCrp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 22:47:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75393C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 19:45:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so3337110pjw.0
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 19:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbAKrsPUBByX+UJ4NfHjvw6K5kNumYgjXO4i4KSV8ts=;
        b=agx+ZqBUBm6lZVZI/MNrvLLgWjcjguKenCkAQExiAH40Bl/uYUKGwsmgnarDtDrlGe
         s1u3dS6RUKDSMtaVsejCucr37M9LiZWDW3zGMdSJqf773I+Ej9eQXb+Nr522AaCXqCQM
         LVeFYe5yqRSi1dDkA0DFStRL1nE/LsdpiIQSJfdLFoUQMTzkV/Ozah50SGtw0JqgUotV
         HMWtCCLB7RHTQm75GMN3KUrSyaIVVjB3HR7dC1P+MNapoossd0fmMaNvfTJayzo22cfv
         +/ShSwD6mWeNL+HokKWqjO0vV7jnH9vCei8Z02oEJoIFSOErnq7W1L9SZC27yhDnwHOo
         MpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbAKrsPUBByX+UJ4NfHjvw6K5kNumYgjXO4i4KSV8ts=;
        b=nqmBZazDJDZTwpXM3EOiTExaOXKY4ZoexEAeA+t4qk9IUVY+9oBKouLJqRJEnZ13Cl
         BWjkq/u+VMmhOB3c0eXhMl5OjOQYrVfDUVLGiKLaN7D4FSSrWSHvKwWY3azLBy9xznL8
         XJyvvPevMuBSuEQhnIAnOo6Q4MXd+LtjgTeQkrmspl4jqOaxhUNtekFTYvAX72JwVlik
         24cyHkh+FqaqQrppZ7d5MiGofTMjv/GwW3FF8cx1WEFqgehorqvnKcxcF9khXx3YWy+k
         UhvtDryRb8dhj0gJvddn4f2WXX44I7yXHH/3Tj9I7nHTOZi1b6PHqsaqM30oZV/f0yRK
         FOMg==
X-Gm-Message-State: AOAM530q9ds53ug/C4WVDqn1wPNS1x5pAYrFHgAYQx8wtoPpA+Owicc8
        a+ffW30rrrBZU/bxV7AwGJxzouSQd7w=
X-Google-Smtp-Source: ABdhPJwrmVzXK2AaFO8eFESghzMCv9CSNagUZvvtTPspYeOHy3CnWGxktITVoCGjY8WRjURMCzwpfA==
X-Received: by 2002:a17:90a:b105:: with SMTP id z5mr10080211pjq.64.1634093142660;
        Tue, 12 Oct 2021 19:45:42 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id t8sm10181839pgk.66.2021.10.12.19.45.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 19:45:42 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mergetools/xxdiff: prevent segfaults from stopping difftool
Date:   Tue, 12 Oct 2021 19:45:39 -0700
Message-Id: <20211013024539.49612-1-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.1144.g9656da23d7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users often use "git difftool HEAD^" to review their work, and have
"mergetool.prompt" set to false so that difftool does not prompt them
before diffing each file.

This is very convenient because users can see all their diffs by
reviewing the xxdiff windows one at a time.

A problem occurs when xxdiff encounters some binary files.
It can segfault and return exit code 128, which is special-cased
by git-difftool-helper as being an extraordinary situation that
aborts the process.

Suppress the exit code from xxdiff in its diff_cmd() implementation
when we see exit code 128 so that the GIT_EXTERNAL_DIFF loop continues
on uninterrupted to the next file rather than aborting when it
encounters the first binary file.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 mergetools/xxdiff | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mergetools/xxdiff b/mergetools/xxdiff
index ce5b8e9f29..d5ce467995 100644
--- a/mergetools/xxdiff
+++ b/mergetools/xxdiff
@@ -3,6 +3,13 @@ diff_cmd () {
 		-R 'Accel.Search: "Ctrl+F"' \
 		-R 'Accel.SearchForward: "Ctrl+G"' \
 		"$LOCAL" "$REMOTE"
+
+	# xxdiff can segfault on binary files which are often uninteresting.
+	# Do not allow segfaults to stop us from continuing on to the next file.
+	if test $? = 128
+	then
+		return 1
+	fi
 }
 
 merge_cmd () {
-- 
2.33.0.1144.g9656da23d7

