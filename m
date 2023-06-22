Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780DAEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 20:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjFVUmp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Jun 2023 16:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFVUmo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 16:42:44 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C961987
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 13:42:43 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7624679c9c4so544185885a.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 13:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687466562; x=1690058562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1olp7ES1IuH2tojHsLTM4Sm8Pl8F+tW5c42MEFfce6k=;
        b=SCNFh9CPmNb2o6rPU/IOqy4kydX3fPAfqJ8RX/LJWpvOzRSytv2UKNJuiwepOs2xlP
         qqz/a0bwKboRpGS/6fUC+wsQmFUyzOuCe6z+gMxvBWb2TMgynSGS0dl9EsNcX9a7VOkz
         jiLge2CgzW94/ZNGNKrLLdofye0SkJxh7lZ80RZxjlLJ/mrhgBpQLxyvPW4zDEVJoSFM
         rq4XcHmas07x09wzgVyNWqQ6Rp0FQd4gMC/8ZuKCTTTiUndQwmdpQRm87MI0l/9Q57eO
         sLF3hKW3gCid8TL+9J+VGDSFMyVP48Pw3kwlsKpLhT8K8wwRAQ3uA9vmM5tcPBKsu2JM
         4tPg==
X-Gm-Message-State: AC+VfDyU04EeWAqPLxhWCte7ecJ1VarKf/jQQb8hRudZayja3Khkmy/j
        MogfQ3Z/tgVdmrU+w7YEr2zdeAQkIpIHUjQRktk=
X-Google-Smtp-Source: ACHHUZ6rRNe3ZqXIgkIv3BsTFJKeejFU5SfKG20XxIf0TbsyYYvzBxEh8DZ/V8WtqQBx9mBDAFWxoHNwnkOJ1GPk/qk=
X-Received: by 2002:a05:6214:2346:b0:62f:f13e:bd73 with SMTP id
 hu6-20020a056214234600b0062ff13ebd73mr27021181qvb.20.1687466562457; Thu, 22
 Jun 2023 13:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230622195059.320593-1-sandals@crustytoothpaste.net> <20230622195059.320593-2-sandals@crustytoothpaste.net>
In-Reply-To: <20230622195059.320593-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Jun 2023 16:42:31 -0400
Message-ID: <CAPig+cSTR6oHeYjcHZ7m2CKYcFo2eistxz_X-7J2rhd7h+uf3g@mail.gmail.com>
Subject: Re: [PATCH 1/3] var: add support for listing the shell
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 4:03 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On most Unix systems, finding a suitable shell is easy: one simply uses
> "sh" with an appropriate PATH value.  However, in many Windows
> environments, the shell is shipped alongside Git, and it may or may not
> be in PATH, even if Git is.
>
> In such an environment, it can be very helpful to query Git for the
> shell it's using, since other tools may want to use the same shell as
> well.  To help them out, let's add a variable, GIT_SHELL_PATH, that
> points to the location of the shell.
>
> On Unix, we know our shell must be executable to be functional, so
> assume that the distributor has correctly configured their environment,
> and use that as a basic test.  On Git for Windows, we know that our
> shell will be one of a few fixed values, all of which end in "sh" (such
> as "bash").  This seems like it might be a nice test on Unix as well,
> since it is customary for all shells to end in "sh", but there probably
> exist such systems that don't have such a configuration, so be careful
> here not to break them.
>
> Signed-off-by: brian m. carlson <bk2204@github.com>
> ---
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> @@ -147,6 +147,18 @@ test_expect_success 'get GIT_SEQUENCE_EDITOR with configuration and environment
> +test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
> +       git var GIT_SHELL_PATH >shell &&
> +       test -x "$(cat shell)"
> +'

This can be implemented more simply without a temporary file:

    shpath=$(git var GIT_SHELL_PATH) &&
    test -x "$shpath"

This is safe since the exit code of the Git command is preserved
across the `shpath=...` assignment.

> +# We know in this environment that our shell will be one of a few fixed values
> +# that all end in "sh".
> +test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
> +       git var GIT_SHELL_PATH >shell &&
> +       grep "sh\$" shell
> +'

Similarly, there is no need for a temporary file or an extra process.
This can all be done entirely in the shell itself:

    shpath=$(git var GIT_SHELL_PATH) &&
    case "$shpath" in
    *sh) ;;
    *) return 1
    esac
