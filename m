Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598ECC54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 00:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3474C206DD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 00:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgD0ATu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 26 Apr 2020 20:19:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35097 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgD0ATu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 20:19:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id r26so18498616wmh.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 17:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lTHsrkqtJICiyMFMQ8+NH2xZ/KGRT+f0yiglmmlSi68=;
        b=rAeD9gs3OvO7KndfhZcNyPoL2xFhM/J510ZrHsj/K4JNDPx23v41kHQdbu1R8lqF1u
         ZhIm/QGvVJa5LrmApx5jlS0cRCRlH34WC6bboXUDUGVZXoHLarHJEAdHV3b65h3kQrNm
         E3fVtDIV+lNW0Gdh+J7/sYT0KN3sMWTMx5Wl5fmNEWbuyZQbeR1VPFczzSHlM9sOQ8po
         N3ye7xJQJXO0K/O+iqVRZsNw4+5kySn7cLJrjxRimiJ80On01uloV94pMGqGZ/VCc4dm
         xEVj7d71l5N8ZyiJWiVA0C+Cbw/oBTcovRRmW4CSoNjtf4xhrUlTGGhIw8IUWuNWObTr
         lBgg==
X-Gm-Message-State: AGi0PuafUf+FaJw8ZyTMXX3CS7mi6BPpWCMm7rBIhb0SzC6T3dOwHCsJ
        8ko1MUWoQZPcoYtUTwCB3OkhLe38b2jkAmTc/Ydt9WXI
X-Google-Smtp-Source: APiQypLZ/Qq+UAWNhVW+6DYuoSYL0WDh6mg44su8eDHvsqm3l1ytyXzknF2VCGigkpJIOrWeTgjO461P7pfx9J9+V3A=
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr23319420wmg.177.1587946786578;
 Sun, 26 Apr 2020 17:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200426234750.40418-1-carenas@gmail.com>
In-Reply-To: <20200426234750.40418-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Apr 2020 20:19:35 -0400
Message-ID: <CAPig+cR8HKcbNxxw65ERz0iHvnO5aC6RXvF9NjvFTySXpcHCSQ@mail.gmail.com>
Subject: Re: [PATCH] git-credential-store: skip empty lines and comments from store
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, Dirk <dirk@ed4u.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Cc:+Dirk -- so he knows his bug report[1] wasn't ignored]

On Sun, Apr 26, 2020 at 7:48 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> with the added checks for invalid URLs in credentials, any locally
> modified store files which might have empty lines or even comments
> were reported as failing[1] to parse as valid credentials.
>
> instead of passing every line to the matcher as read, trim them
> from spaces and skip the ones that will be otherwise empty or
> start with "#" (assumed to be comments)
>
> Reported-by: Dirk <dirk@ed4u.de>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> @@ -120,4 +120,21 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
> +test_expect_success 'get: allow for empty lines or comments in store file' '
> +       echo "#this is a comment" >"$HOME/.git-credentials" &&
> +       echo "" >>"$HOME/.git-credentials" &&
> +       echo "https://user:pass@example.com" >>"$HOME/.git-credentials" &&
> +       echo "    " >>"$HOME/.git-credentials" &&

Is there a reason you don't use a here-doc for the above (which would
be less noisy)? For instance:

    q_to_tab >"$HOME/.git-credentials" <<-\EOF &&
    #this is a comment

    https://user:pass@example.com
    Q
    EOF

[1]: https://lore.kernel.org/git/ad80aa0d-3a35-6d7e-7958-b3520e16c855@ed4u.de/
