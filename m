Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881501F453
	for <e@80x24.org>; Sun, 10 Feb 2019 02:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBJCMc (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 21:12:32 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:46332 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfBJCMc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 21:12:32 -0500
Received: by mail-qk1-f179.google.com with SMTP id q1so4456637qkf.13
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 18:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwj0D0oUajvZljhALmdjME2WY9FxZiAg3CgOn3LKASo=;
        b=HJuHWJ1Lmout2LbjN0L16xMa5QKzKeZBMn914dwSxSYCcf5bStvSXhZD/Gw0+wS00A
         7vBHIo7Ae6Yn7JxgTum1eyBGI+99LmSVhZedFkxaziaDQip874dLx8MC7QhQyDanuAR3
         6nAKRagZdswZNhG0w0eqcmBgbh9S88VLmGinVT/W26fTjbKF1Uae8UUmPH2wlJIqgOG+
         v84hiGysz0yrR8Rnr3Q16WT5XDYLvS8Krbys6U56wroYAOYewatvC9hNfpXF9nFqo9jk
         oDCtOWTlY5vkscCu7PF05ulfuhJ6eWrXmllRclTv/JmbbuxslmdRnuP74b+vdP+JXuNg
         4d5A==
X-Gm-Message-State: AHQUAua2LdI54ROILyya8GyALdi+2U8JGhRclzA6qbND84P1vRcnNjJD
        7jFRCnniD7u12lwOoC00JQdlKcR2aiGbRNGy6ig=
X-Google-Smtp-Source: AHgI3IaiEeykdnlS9dcPY6Wr+bcFq29NJsAdcSdTuhE+MEL5hcJQTKfS2SFJEBXdAAlB81TK4tJ5I0JlTE7DghSj3eU=
X-Received: by 2002:a37:9584:: with SMTP id x126mr21354016qkd.36.1549764751170;
 Sat, 09 Feb 2019 18:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20190209185930.5256-1-randall.s.becker@rogers.com> <20190209185930.5256-4-randall.s.becker@rogers.com>
In-Reply-To: <20190209185930.5256-4-randall.s.becker@rogers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Feb 2019 21:12:21 -0500
Message-ID: <CAPig+cQY57w9rmGzVifKMTMVwt209b959iL9+K79AMfEgiVTfg@mail.gmail.com>
Subject: Re: [Patch v1 3/3] t5562: replace /dev/zero with a pipe from generate_zero_bytes
To:     randall.s.becker@rogers.com
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 9, 2019 at 1:59 PM <randall.s.becker@rogers.com> wrote:
> This change removes the dependency on /dev/zero with an equivalent  pipe of

Too many spaces between "equivalent" and "pipe".

> deliberately NUL bytes. This allows tests to proceed where /dev/zero
> does not exist.

It wouldn't hurt to cite "NonStop" as an example of a platform lacking
/dev/zero.

The first sentence is a bit off grammatically. Perhaps the entire
commit message can be collapsed simply to:

    Stop depending on /dev/zero which may not be available on all
    platforms (for instance, HP NonStop).

> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> @@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '
>  test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
>         NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
> -       env \
> +       generate_zero_bytes infinity  | env \
>                 CONTENT_TYPE=application/x-git-upload-pack-request \
>                 QUERY_STRING=/repo.git/git-upload-pack \
>                 PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
>                 GIT_HTTP_EXPORT_ALL=TRUE \
>                 REQUEST_METHOD=POST \
>                 CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
> -               git http-backend </dev/zero >/dev/null 2>err &&
> +               git http-backend >/dev/null 2>err &&
>         grep "fatal:.*CONTENT_LENGTH" err
>  '
