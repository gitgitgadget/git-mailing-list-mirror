Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D517CDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 17:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379618AbjJLRta convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 12 Oct 2023 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379549AbjJLRt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 13:49:29 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE881B8
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:49:27 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d9a5adc8cefso1402060276.0
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697132967; x=1697737767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoOAcvg9GKD7xHHgtLpjGuiibdySPR6IAdbFxRwZmnU=;
        b=XJwnBLs8kcpfs/BCNBuKdyz+/iVLVSKLvUNedgbtT+yBwomRKhdStvxJ3x1LzdGTUh
         6WoqN5czGcfhgEB5i7lEq+XXgM51HAmTO6+YCLiiDA6dbkYKhWEjnUFkXDEt/nQCt8Uz
         dVuiE8j/CE/Zg1Gd2qhQCbtNjne1UL1B0b9r7Eg/gaPeoraGgY+KgWwgFbrKrjoCKgqF
         0H4UtPi9MVn9va8ZvGLnpVbTcRB9vE703/EJpnzRGlJEEZfJC2CuqFIMlGo+7y7C0uLZ
         XBM1p097LCZm0CT0h7Sfk6cfjhnMLFw20yQcfU2zPw/ucP2bJoxAbJUd4wQS4sNef9Ew
         EoNg==
X-Gm-Message-State: AOJu0YzjCwX75k+xVEAocvfuPy1HXpJdjkb+3beFVGUaAU3tOohqiNEu
        +Pl2pCXCb2+ZTVYvz0T9DDV2wQvuKYx+v7qYbD8=
X-Google-Smtp-Source: AGHT+IGMVf/uznFMTfAEuLqiHh5b7FCqDNFcISqLunOnjnR21aGRNE16DlVtRKmgYPy7JWR8/bo5M4G1hAWFC8JskUc=
X-Received: by 2002:a25:2d20:0:b0:d9a:6259:5461 with SMTP id
 t32-20020a252d20000000b00d9a62595461mr7536356ybt.38.1697132964840; Thu, 12
 Oct 2023 10:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231012160930.330618-1-sandals@crustytoothpaste.net> <20231012160930.330618-2-sandals@crustytoothpaste.net>
In-Reply-To: <20231012160930.330618-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Oct 2023 13:49:13 -0400
Message-ID: <CAPig+cSUvyCS-NOYOoJAmg7LGyU5Dqky5HyS-QTNW1QoHj-0bA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t: add a test helper to truncate files
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jason Hatton <jhatton@globalfinishing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2023 at 12:10 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In a future commit, we're going to work with some large files which will
> be at least 4 GiB in size.  To take advantage of the sparseness
> functionality on most Unix systems and avoid running the system out of
> disk, it would be convenient to use truncate(2) to simply create a
> sparse file of sufficient size.
>
> However, the GNU truncate(1) utility isn't portable, so let's write a
> tiny test helper that does the work for us.
>
> Signed-off-by: brian m. carlson <bk2204@github.com>
> ---
> diff --git a/t/helper/test-truncate.c b/t/helper/test-truncate.c
> @@ -0,0 +1,27 @@
> +int cmd__truncate(int argc, const char **argv)
> +{
> +       char *p = NULL;
> +       uintmax_t sz = 0;
> +       int fd = -1;
> +
> +       if (argc != 3)
> +               die("expected filename and size");
> +
> +       sz = strtoumax(argv[2], &p, 0);
> +       if (*p)
> +               die("invalid size");

Do you want to check 'errno' here, as well (probably before the '*p' check)?

Or is that being too defensive for a 'test-tool' command?

> +       fd = open(argv[1], O_WRONLY | O_CREAT, 0600);
> +       if (fd < 0)
> +               die_errno("failed to open file %s", argv[1]);
> +
> +       if (ftruncate(fd, (off_t) sz) < 0)
> +               die_errno("failed to truncate file");
> +       return 0;
> +}
