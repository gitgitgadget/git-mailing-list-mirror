Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F0EB64DD
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFVVTJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Jun 2023 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjFVVTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:19:02 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A4213C
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:18:59 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-62ff3535bafso5902426d6.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687468738; x=1690060738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4wQRRs5C60pSBrtXSP1v7dAudkRs8flePThe9spuj4=;
        b=kwH0ks0f8yGIoNcd63x1aXz4P9+RIZXGrwLdlOwLUywNHYtVjmk1Sgt0Z9d2w4Xhck
         +NwDGvShipJu6TGHmx5WhIl1bJr4lPBU4b7iboRKROlfpx7F0hhATNLthXlq8ytpjX4N
         o7Hal2sNZ57xOlzzs2rCT4/Zry3Ji5hC1wYvAkvvBrjZxXXeLfaJVELajM8Y5PITC4+b
         S6gO3T/UhVr0QxC2VAmN7QRB6WEp+Iv6+09Wo7Fd14Wy3hSDDW4sqwTTBhSUc1UJWGNh
         ttVKckdKbCIByB8pYxaiCvz8L8BDQG58dEPLpO1q8lCq/vIu0MotjsZzr8KlBNJ+U7m0
         yLIw==
X-Gm-Message-State: AC+VfDwFEG1i5WjcvP2w1Eum2iSg66A7lyoTAzpmQ3hXA7IxMWwRz2JQ
        VL3lGatoosvh1tIt3i5yLMyQucKseYPBp/JjZcQ=
X-Google-Smtp-Source: ACHHUZ4VuQCybSiovV2bloLtOYUEbzDx8+Lzvq9ACuYRdKyAJFWf7Dt4v4kdQsEOXFxjDhP8vwWjl5Wqekkbfd4eIOA=
X-Received: by 2002:ad4:4ee8:0:b0:570:5389:2216 with SMTP id
 dv8-20020ad44ee8000000b0057053892216mr31084504qvb.22.1687468738265; Thu, 22
 Jun 2023 14:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230622195059.320593-1-sandals@crustytoothpaste.net> <20230622195059.320593-3-sandals@crustytoothpaste.net>
In-Reply-To: <20230622195059.320593-3-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Jun 2023 17:18:46 -0400
Message-ID: <CAPig+cQ=B7M6nPYx-+gqtsJeSuiqKeQhCfiWmyfjiGXsVnFbTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] var: add attributes files locations
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 4:06 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Currently, there are some programs which would like to read and parse
> the gitattributes files at the global or system levels.  However, it's
> not always obvious where these files live, especially for the system
> file, which may have been hard-coded at compile time or computed
> dynamically based on the runtime prefix.
>
> It's not reasonable to expect all callers of Git to intuitively know
> where the Git distributor or user has configured these locations to
> be, so add some entries to allow us to determine their location.  Honor
> the GIT_ATTR_NOSYSTEM environment variable if one is specified.  Expose
> the accessor functions in a way that we can reuse them from within the
> var code.
>
> In order to make our paths consistent on Windows and also use the same
> form as paths use in "git rev-parse", let's normalize the path before we
> return it.  This results in Windows-style paths that use slashes, which
> is convenient for making our tests function in a consistent way across
> platforms.  Note that this requires that some of our values be freed, so
> let's add a flag about whether the value needs to be freed and use it
> accordingly.
>
> Signed-off-by: brian m. carlson <bk2204@github.com>
> ---
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> @@ -159,6 +159,26 @@ test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
> +test_expect_success 'GIT_ATTR_SYSTEM points to the correct location' '
> +       test_must_fail env GIT_ATTR_NOSYSTEM=1 git var GIT_ATTR_SYSTEM &&
> +       (
> +               sane_unset GIT_ATTR_NOSYSTEM &&
> +               git var GIT_ATTR_SYSTEM >path &&
> +               test "$(cat path)" != ""
> +       )
> +'

Same observation as in patch [1/3]: no need for a temporary file:

    p=$(git var GIT_ATTR_SYSTEM) &&
    test -n "$p"

> +test_expect_success 'GIT_ATTR_GLOBAL points to the correct location' '
> +       TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&

The reference to $(pwd) is unnecessary, thus potentially confusing. Simpler:

    TRASHDIR="$(test-tool path-utils normalize_path_copy .)" &&

> +       XDG_CONFIG_HOME="$TRASHDIR/.config" git var GIT_ATTR_GLOBAL >path &&
> +       test "$(cat path)" = "$TRASHDIR/.config/git/attributes" &&

Same observation about unnecessary temporary file:

    p=$(XDG_CONFIG_HOME="$TRASHDIR/.config" git var GIT_ATTR_GLOBAL) &&
    test "$p" = "$TRASHDIR/.config/git/attributes" &&

> +       (
> +               sane_unset XDG_CONFIG_HOME &&
> +               HOME="$TRASHDIR" git var GIT_ATTR_GLOBAL >path &&
> +               test "$(cat path)" = "$TRASHDIR/.config/git/attributes"
> +       )

And here too.

> +'
