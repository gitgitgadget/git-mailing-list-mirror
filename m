Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96DD20248
	for <e@80x24.org>; Sun, 10 Mar 2019 10:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfCJKNb (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 06:13:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34372 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfCJKNb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 06:13:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id f14so1909131wrg.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 03:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3oM2ptzsDQWVHgTREvAEvfw0eZx0D3IUcJigUskCX8=;
        b=B25tAYOza+ErOViEmdGIV/qQVYRx4kWlMhoyuYwoJWIcqwivCVLr+Nsx3maIXeagiC
         UQ0GGIW6zK/6p9kphCBGMEo2M043lxF6B//xjXPWv+a2D65CDhGpWFRoLkhYDmLNjh3L
         /u71Ws118ACzL1lI4+wXBGT8ow6bho8LQiquu8z4t7EyHYz/G/k3CR0INjcM+UZvFvbP
         HfJPsiXH2J36mVt4suwh5dAK99qqVRFxLJUKkeZLEm1PdhwNXyc8axaKcg4tJZRV4p8J
         nEErhd2y1XZsif2uC3AOL8IS08dIbeA+wNyihDe2NTYyRHgSUYrL9K7APVwKJh8HMojx
         gyhQ==
X-Gm-Message-State: APjAAAWF7NFGihCjHjcU5xzIlFZ4upRpUqWUDs5+yKCUHUxBF4LpRVnf
        23sMqrGEumfr/VLTeg7wbiGFP3M2IcVjPYE993o=
X-Google-Smtp-Source: APXvYqzEhzZlUgH3k4gPwhwsp3UngW5O/VX0vstSNw7G5JUsbX18eaLzVPSqXElyqys/4vuALdi2av1cTehnq5a/arE=
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr16457239wrg.217.1552212809888;
 Sun, 10 Mar 2019 03:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190310080841.64082-1-ttjtftx@gmail.com> <20190310080931.64134-1-ttjtftx@gmail.com>
In-Reply-To: <20190310080931.64134-1-ttjtftx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Mar 2019 06:13:19 -0400
Message-ID: <CAPig+cQP74MC6fJC4fNCz9Rz3tDux1K4TGB7N+cOC8zScxOoAA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 3/5] t0003-attributes: avoid using pipes
To:     Jonathan Chang <ttjtftx@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 4:09 AM Jonathan Chang <ttjtftx@gmail.com> wrote:
> The exit code of the upstream in a pipe is ignored thus we should avoid
> using it. By writing out the output of the git command to a file, we can
> test the exit codes of both the commands.
>
> Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
>
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> @@ -203,15 +203,18 @@ test_expect_success 'attribute test: read paths from stdin' '
>  test_expect_success 'attribute test: --all option' '
>         grep -v unspecified <expect-all | sort >specified-all &&
>         sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
> -       git check-attr --stdin --all <stdin-all | sort >actual &&
> +       git check-attr --stdin --all <stdin-all >actual &&
> +       sort -o actual actual &&
>         test_cmp specified-all actual
>  '

There is no existing use of "sort -o" anywhere in the Git test suite
(or, for that matter, anywhere else in Git), which should give one
pause before using it here. Although -o is allowed by POSIX, and POSIX
even says it's safe for the output file to have the same name as one
of the input files, there is no guarantee that "sort -o" will be
supported on all platforms, or that all platforms promise that the
output filename can match an input filename (in fact, neither the
MacOS nor FreeBSD man pages for 'sort' make this promise).
Consequently, it would be better to err on the side of safety and
avoid "sort -o", which is easily enough done by using another
temporary file:

    git check-attr --stdin --all <stdin-all >output &&
    sort output >actual &&

The same comment applies to the remaining changes.
