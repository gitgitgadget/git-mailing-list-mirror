Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025E4C433E9
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A89233F7
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbhATOIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbhATMqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 07:46:31 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4134C0613CF
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:45:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ox12so9033515ejb.2
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoTN67DqG/QMGgGeQZ6flR4NDUPX3zHu4H64mHUA4L0=;
        b=a7TxWXSu3ilZ3OdZQJrEGrfELKER7G89vg1BBu1n9FKsHH9uub+taQ9j4H1QbMav7Q
         jCEipWQGIZ9hehWpLZqhbXwsWpLT0RxcYKDiv29WNENwl/I8Y/0cUg5/Cvnv9z75JblO
         +i3XaI/FYtGjaSKMHXr+cZlOoSLYJUHIzyVSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoTN67DqG/QMGgGeQZ6flR4NDUPX3zHu4H64mHUA4L0=;
        b=itNIKgXH7b7YhK88Z8aAlUE86INfthM2oLQCwVC037LKL9RYkT75vIjjiS3phimEcj
         cBq1w+Mp41JI7qPnfEmwdzBlCZcxXKYg8cavSUEHF3Js84ivog/hHVKUlyQYgEzcjNED
         jFCgpkTOpJMjhz/pMNb2vdo1PZqle0cdNqkqfcMirzLd7nlD7mNu4nBMH8HmwjNoLoiG
         seQRs9MK4nZHjnLu1QCvxUo4B2GvM7N2ISG/VaxfIbTVxr076ZjTJC7+cBG1r7Zg6kqw
         tp1Q8ZjPy6LZ8oMjRYjiqJvu4pbm364l93phAlIk3sNqy7/Gdb18p280gWJLartPwUJF
         DJAQ==
X-Gm-Message-State: AOAM531QD1PeQjvh/sEW9BPKtXZW1oMmPEqRbPpbiSCslEHloMlm9SVp
        1PKbsLDt1liXqpsk5CKWamLrJf9zTyI92Qe/
X-Google-Smtp-Source: ABdhPJxJaO0HC2/gWdbJ59BPjf3HUyPN7YLtgxh8LW+h7KuZsU2DOBQ/c6oMtQ0rEddfabFxCHtGlg==
X-Received: by 2002:a17:906:14d5:: with SMTP id y21mr6142920ejc.410.1611146747372;
        Wed, 20 Jan 2021 04:45:47 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id dh14sm1033351edb.11.2021.01.20.04.45.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 04:45:46 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, me@ttaylorr.com,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v2 0/1] builtin/pack-objects.c: avoid iterating all refs
Date:   Wed, 20 Jan 2021 13:45:13 +0100
Message-Id: <20210120124514.49737-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have updated the patch with more background information in the
commit message, and I have cleaned up the add_ref_tag iterator
callback a bit. I also switched to for_each_tag_ref.

On the previous version of the patch there was some discussion about
whether we can use for_each_tag_ref in combination with peel_ref. It
turns out we can, and we were already doing it in the same file:
search for mark_tagged to see what I mean.

Jacob Vosmaer (1):
  builtin/pack-objects.c: avoid iterating all refs

 builtin/pack-objects.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.30.0

