Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E013C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 02:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C422070B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 02:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgG2CY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:24:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46554 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbgG2CYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 22:24:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id r12so20039494wrj.13
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 19:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTMz0nG/9tEuIkeUm2+PEIYRERjyWf4W71h1yjeeKYw=;
        b=n6DyVLgJd29+Le2UyRuQsXMYVzFV/khM3cACdUqVvu0n5OH7xMe+mJr5VD9ncieegk
         n5q+K/4ER7aGpKWCrj3TTB685FAMZGEV3BQ5PcBxxRAEdcEpAoYavOEFPfYof5ZlUzIK
         deSFaUbGuMSe2qD9AUskU+Z04Ro4f9zAOdWDcOHqbiPWwuHEvYPde16aLYhXHusD8Xnm
         7wux/mBkAP7souDV/IRw12gqQ2drMqu9RImvN96a+PRZ/uP5lto91ypdvDYwdJGcqdvM
         Z5hd0BuPpmcQJ1dTePwbEJ+M7L6Vonu2VLDFfxIIQbLNYGsxNl34Q/zxthjbspc8ov//
         PaYQ==
X-Gm-Message-State: AOAM530Eck4fpzRyLaqSfKBxS1tUZyfHq6UgOua1gyhDSJT+ABhtVpw5
        0rgfo7oY1r7Kn7pYLLnle+mU3Dmv3CGWnQzBpBK/thJh848=
X-Google-Smtp-Source: ABdhPJzKkCw8k6yn1iiH1QpmnlAp3A3poORI5lWltzTmqzkXODOjLk7bu+7dI4pixdmOETZnitv7JnF7Bc9PSrWGu58=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr19134515wrv.120.1595989493510;
 Tue, 28 Jul 2020 19:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net> <20200728233446.3066485-19-sandals@crustytoothpaste.net>
In-Reply-To: <20200728233446.3066485-19-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Jul 2020 22:24:42 -0400
Message-ID: <CAPig+cTw0XXNcKp5vVLhPtV5jH9d9gwfuYGuLqpSXsGmpn_fqw@mail.gmail.com>
Subject: Re: [PATCH v5 18/39] t8002: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 7:35 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Compute the length of an object ID instead of hard-coding 40-based
> values.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> @@ -6,6 +6,10 @@ test_description='git blame'
> +test_expect_success 'setup' '
> +       hexsz=$(test_oid hexsz)
> +'

In the previous version of this series, the "setup" test  invoked
test_oid_init() as its very first step. This version doesn't. As a
reviewer, I was caught off-guard by this unexpected and unexplained
difference between versions. The script works fine without
test_oid_init() anyhow since test-lib.sh invokes test_oid_init(), so
the test_oid_init() call introduced here by the previous version was
redundant.

Some of the patches in this series add test_oid_init() calls to their
"setup" tests, while others don't, which makes for a somewhat
confusing impression as one reads the series. In general, it would be
nice for the patches to paint a consistent picture (i.e either
uniformly employ test_oid_init() or don't), however, I would not want
to see a re-roll just for that. Also, since the final patch of the
series ends up removing all those test_oid_init() calls anyhow, it's
all straightened out in the end.
