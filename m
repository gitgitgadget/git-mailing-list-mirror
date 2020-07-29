Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE7EC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 03:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574C1207E8
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 03:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgG2DBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:01:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38055 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2DBn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 23:01:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id f18so1448335wml.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 20:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ie2hvi8UOHongXgH4ifhs3lDUCPhHaptjF8QcqUf30=;
        b=sOq2p1YtMyDaVs/HGux5GuaoO7dHg2sZMOOumajiGcDMcAdRb64pOSYsQnolpwxs0L
         UaJkXjKng5QlnV1kJq+F3HyQwRaGvr/4gQPR3feF5gVLjpU3xfyHk+DaScWqu/4MzvTo
         eZRl+jO8zOaEaylge+Fmud75Sk41q/CX+F19YZLWEPJIspKX7tOuXw1GNjFgbLx2nlAO
         iVXiXRcqPP+J5MAC4lhTLZ1o3vY0tqPzP8Xj+igK1jwVq2CTkIX8BJSs4F+S3PVncpIW
         cCS8SA4kcQkKFFvm5Ha4yPQs8tNnrcA0oa15tTtTEGfz4YE0DLH9owfrwWooAeHxZYRw
         RXMA==
X-Gm-Message-State: AOAM5315Uk20RbtvNIMAcQJcIBAIvNIHRxAXkegHxEuPW2TlT+DBS6eZ
        BvmvEXf67J56ZgCUn3ymT6ET7r8aDCMHhkt/cz4=
X-Google-Smtp-Source: ABdhPJxPgJufwQd2qaqmfsGDGrTNwMT76mHH6z0Vfy/QQBLS4Be69KS6SQyBgEwvun8bZsK5S7oBOOJkxypFZ4PNT8k=
X-Received: by 2002:a1c:4e0d:: with SMTP id g13mr6494566wmh.177.1595991701337;
 Tue, 28 Jul 2020 20:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net> <20200728233446.3066485-37-sandals@crustytoothpaste.net>
In-Reply-To: <20200728233446.3066485-37-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Jul 2020 23:01:30 -0400
Message-ID: <CAPig+cSXmsUtFAgtM9+vXEcsk7USeNNK39RKQ5h_=y0fh+6Z9w@mail.gmail.com>
Subject: Re: [PATCH v5 36/39] t: make SHA1 prerequisite depend on default hash
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 7:36 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Currently, the SHA1 prerequisite depends on the output of git
> hash-object.  However, in order for that to produce sane behavior, we
> must be in a repository.  If we are not, the default will remain SHA-1,
> and we'll produce wrong results if we're using SHA-256 for the testsuite
> but the test assertion starts when we're not in a repository.
>
> Check the environment variable we use for this purpose, leaving it to
> default to SHA-1 if none is specified.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> @@ -1689,7 +1689,11 @@ test_lazy_prereq CURL '
>  test_lazy_prereq SHA1 '
> -       test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> +       case "$GIT_DEFAULT_HASH" in
> +       sha1) true ;;
> +       "") test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 ;;
> +       *) false ::
> +       esac
>  '

This deserves a s/::/;;/ in the final case arm. The "::" does work --
in a manner of speaking -- but only "by accident"; merely because it's
being interpreted as an argument to 'false' and it happens to be the
final case arm, but it still ought to be fixed.

(I'm pretty sure I typed ";;", not "::", when I gave this code as an
example in my previous review... {goes and checks...} indeed, I did
type ";;".)
