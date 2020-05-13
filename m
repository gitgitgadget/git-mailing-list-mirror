Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E27C433E1
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A64320659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEMUkW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 13 May 2020 16:40:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36258 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgEMUkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 16:40:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so1162219wrs.3
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B9tVpeCMZuQ3iEl1CN4fNwQRPov9hEI6F/Xj69MUXWg=;
        b=OEnAT73bPeDzigYTagZTdftKgenQsLcmqfs2p3+NS6Rd+d8CVg0n9wplT3BdW0dssN
         WefBZ1v2eGRkvvk8RS4pUCB6JhJof9PFi5kiQ3GsYBr7nRjUeb23S0/922bExwERB21O
         CIyy6aUcv6p7aEiPnLpe5h++J9i921weXrMZWqUCoSgEC6vy+60h/YU5DqxGxFVVnOF0
         bTCg23HOsQoUlj/edVuVZm0GaC0X9c/VOmcSl2BO6ptkMjqrgfeFkDe1AX/G3plwQXrD
         4ynREDqdOEGvG8Pi0lxySup6+52jn1WMYql278j4N9/m7se2yavA7JSIv7lKxqBolFdn
         kPZQ==
X-Gm-Message-State: AOAM531Mq+REtTd42+EPVO2bbsJbH5QQYeTmr8UqNcwLvF9DgVYp/HxO
        /i4McvRrcuYv1Vd68ILGJgZX0paG82XIGeWZ3bMWBA==
X-Google-Smtp-Source: ABdhPJwZcjWEuz61aNx6pF8wFelEUBrj7u+xpkFkRVZ4kC1kAuPq1OxHylzhNKZ5wREg5mkAu/imbcXbXCW9WWRsC3I=
X-Received: by 2002:adf:f651:: with SMTP id x17mr1296546wrp.277.1589402420119;
 Wed, 13 May 2020 13:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200513111636.30818-1-carenas@gmail.com> <20200513180213.45866-1-carenas@gmail.com>
In-Reply-To: <20200513180213.45866-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 May 2020 16:40:08 -0400
Message-ID: <CAPig+cTeUh6MP4LLvgx1BEr7csWG_o+1H_RZS=Curx4pGLSAcA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] t4210: detect REG_ILLSEQ dynamically
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Ed Maste <emaste@freebsd.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 2:02 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> [...]
> The description of the first test which wasn't accurate has been corrected,
> and unlike the original fix from 7187c7bbb8, all added entries to test-lib
> are no longer needed and only the 2 affected engines will have their tests
> suppressed.

I see this paragraph was updated in response to my question about why
those additional test-lib.sh variable assignments were being dropped
by the patch. However, this explanation gives no actual detail about
why those assignments are unneeded, thus their removal is just as much
of a head-scratcher as was v1 in which the commit message did not talk
about them at all.

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> @@ -41,16 +41,21 @@ int cmd__regex(int argc, const char **argv)
> +       ret = regcomp(&r, pat, flags);
> +       if (ret) {
> +               if (!silent) {
> +                       regerror(ret, &r, errbuf, sizeof(errbuf));
> +                       die("failed regcomp() for pattern '%s' (%s)",
> +                               pat, errbuf);
> +               } else
> +                       return 1;
> +       }

This is pure nit, and I wouldn't necessarily want to see a re-roll
just for this, but you could lose an indentation level and make the
code a bit easier to grok by structuring it like this:

    if (ret) {
        if (silent)
            return 1;
        regerror(...);
        die(...);
    }
