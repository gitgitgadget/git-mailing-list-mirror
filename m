Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526D5C2D0E5
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF342073E
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgCZP0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:26:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgCZP0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 11:26:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id j17so8243224wru.13
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 08:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXWiI6dse/XqYrcy5e1qd7ZFWM+ZcCGIvX8T3IfEenU=;
        b=TNQJmfaWRQcmqS8cSUhgAsWg01wpEPGm5Wm7bQy6Tc12uE0qeBpZmre2yemmv6QnM3
         L5fcMQ9xT7zGEDnHzEE4Dum+cM1wJZ+UN8+GrqXi0KrYF6VfxhBG49ha+hnbnqh2h0cm
         /adjXdQWg/WMv3oonh83QZaXcSg/ELTnfbvdvOb99aCijcf0abKCc/IvTxpNSTNoBGPC
         LZqUUjYwrAOKWXW+VPjwA45mS2pe64LhY8z23zp22EE/GYw/O7xT3LdotTXt3lGQ726J
         1i5DzEJD/eiFMB9YJsK2EQBw5AtnyJvwBSTRNacooXZVgPHf9QY4349hVioGtr153T+a
         RkzA==
X-Gm-Message-State: ANhLgQ3W1GM7VkTMG3bPVlI6+NWT6UWBuDAwlye+K0Ouq7PT30vW5kEk
        saBoZrfKK05VnmguBGiIcPsSRKGVSZZ627kSE0Y=
X-Google-Smtp-Source: ADFU+vuQvm7xBSKYxheEauOgAR9sAI78VJJpKKArKE3UY5LezFigGM15ikfpFrmZ5WBAU+6hyaNpn/ob56JV5/BSY1U=
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr10580360wrx.226.1585236410577;
 Thu, 26 Mar 2020 08:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
 <53e64e7077063a177cfafd97aa01340ee5b4cf1f.1585209554.git.liu.denton@gmail.com>
In-Reply-To: <53e64e7077063a177cfafd97aa01340ee5b4cf1f.1585209554.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Mar 2020 11:26:39 -0400
Message-ID: <CAPig+cREV63OmEkrqQ_ou=HDHnJZXLcd8j34hqBibiKe6uUnhQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] t5550: simplify no matching line check
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 4:28 AM Denton Liu <liu.denton@gmail.com> wrote:
> In the 'did not use upload-pack service' test, we have a complicated
> song-and-dance to ensure that there are no "/git-upload-pack" lines in
> "$HTTPD_ROOT_PATH/access.log". Simplify this by just checking that grep
> returns a non-zero exit code.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> @@ -248,9 +248,7 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
>  test_expect_success 'did not use upload-pack service' '
> -       test_might_fail grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act &&
> -       : >exp &&
> -       test_cmp exp act
> +       ! grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
>  '

It would have been nice for the commit message to have mentioned that
the change is also eliminating an incorrect application of
test_might_fail(), but it's probably not worth a re-roll.
