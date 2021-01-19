Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D1BC10DC2
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580942253A
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405095AbhASOwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404713AbhASOnu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 09:43:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C131FC061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:43:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b2so21797332edm.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZRlK4p76Kz3qGj2t7SiYRgQjFfRGrV+3qfqBMa+DLWk=;
        b=KduwVY7JMnFQ/pCbO/J9UOTD4+AZ4LSxsNEJq8bC6X3t23S0BcdBU+oODtHxPy4J1v
         OA6N6v+XW64CPZ8L85QbC6961ziyy1mJtBgrapGSUdHTx/QagDQc4pCwSeCMuKxba1sR
         6RzG9IydrzuBDUqSZqg1DxBLB1ILYW2DLvnFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZRlK4p76Kz3qGj2t7SiYRgQjFfRGrV+3qfqBMa+DLWk=;
        b=hEUI5F/2KZQjdVGVlKRzmjymok8Ix3pSNw5yQYwA5kIk+ZGSSf2Uv0HLBzLTtzLjPR
         WcreUVdILcPCM4idmi7wUA+Nfru26lb6ZbggJhHXucPPrbCGziGBqhw1q5U6NEgwlxJw
         8xZIlL8mq/W4Kym8YbplRDL/3l3WnQugSnozvyN/ylDvZx2OrcJ3WVXOWq77BBGn6ekN
         oVIeoxDBu/oXhoLlKx3EqhyMUEZHGUKwh8f7AEdtHv5dl2QlF/eWau6J2mjmIJD6jSnA
         ZOmUuevjVBxtgHRDj06UHSUWnAI78VYqxLlPi66cNpyL1Cu5CaNVs9nw4lMeO2zmBGUv
         yhBg==
X-Gm-Message-State: AOAM5324ki4a+sGm8ld50LZQDLNWF3KDcQaq4KZidEXn5LNB8MP9tUsX
        VXEa/8zx99JKePRbQXVHElkUXICxh9ntsWTE
X-Google-Smtp-Source: ABdhPJznMBxsn7ZuOi6CdvdO6gKEyExqf6FQsNk5UOI7Ber3rhH3fNXByyENzdeUUDoxaGYkUnwu1Q==
X-Received: by 2002:aa7:c7d8:: with SMTP id o24mr3785044eds.328.1611067388237;
        Tue, 19 Jan 2021 06:43:08 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id j25sm12037652edy.13.2021.01.19.06.43.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 06:43:07 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 0/1] ls-refs.c: minimize number of refs visited
Date:   Tue, 19 Jan 2021 15:42:50 +0100
Message-Id: <20210119144251.27924-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The back story of this patch is in
https://gitlab.com/gitlab-com/gl-infra/scalability/-/issues/746; it
comes down to: we have a repo with 500,000 refs of which only 50,000
are visible. Having ls-refs iterate through all the refs adds
considerable overhead.

This patch reduces the number of refs visited by replacing one ref
walk over refs/ with multiple ref walks over the prefixes the user
requested via ref-prefix. In the case the user did not use ref-prefix
we fall back to the walk over all of refs/.

Jacob Vosmaer (1):
  ls-refs.c: minimize number of refs visited

 ls-refs.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

-- 
2.30.0

