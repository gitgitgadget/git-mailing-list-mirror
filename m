Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F3C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4AB65224
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCPGiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 02:38:01 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:45221 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhCPGha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 02:37:30 -0400
Received: by mail-ej1-f52.google.com with SMTP id mm21so70196635ejb.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 23:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBf+mhjJMcwlCTbXKZDfGmXBLA8H8VsrKUr7+TTbq1o=;
        b=NvCf1IpcTycxQbhIMsPai7Yjfg5X3bbkPYjJyxxRyCyM76LIKhKaSWyGwWRoSCtFKs
         YqOuNrCOk/mwcrfiLacCQDqh/Xn4ucDKqBkzJO1vQgmOeEUQYYIkJICRQt+2D/0Dzemb
         vdckhq02pLFBXJTkmECwKDhu3bN7OjSqTqPbVX40xnMBl+uZsqR4/wW236ykTXd/ce1w
         9ePl9X8ze9Vy3wLM+XSFryUMPuwNTODFbpiC7MAJM9TT13k+VAGO3bd9stSV+bhS/lsq
         HDYQHPlEx3zjX6ltWeetKsT+6dquPx+oGTl/POSEv9wH1bxnz9OUy+X3WPDP+baWJ7gc
         tImA==
X-Gm-Message-State: AOAM532jnbjm0k5ubKPQJclxvbf4/PWbYx2JFQM2I1LnoYGii15bOBEJ
        kbFKyO5xXDyEHOJRC6HUJiMuYHqBOB9iUJUeQZfA6UD/Cfk=
X-Google-Smtp-Source: ABdhPJwDN8KKG+ny3duovhP+InPwImGAABeI+7aIMU2IX8pSzB7A4piEnDaQJwkSh14R9f00GFEc9gGv+Rwt5a2Zir0=
X-Received: by 2002:a17:906:d8c6:: with SMTP id re6mr26993331ejb.311.1615876646761;
 Mon, 15 Mar 2021 23:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615856156.git.liu.denton@gmail.com> <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
In-Reply-To: <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 16 Mar 2021 02:37:16 -0400
Message-ID: <CAPig+cRM2y15cH5gLvmn5dDa=rafBL53GPua8rmjsTsmkQAkPA@mail.gmail.com>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 8:57 PM Denton Liu <liu.denton@gmail.com> wrote:
> In the previous few commits, we sorted many lists into ASCII-order. In
> order to ensure that they remain that way, add the 'check-sort' target.
> [...]
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> +my @regexes = map { qr/^$_/ } @ARGV;
> +my $last_regex = 0;
> +my $last_line = '';
> +while (<STDIN>) {
> +       my $matched = 0;
> +       chomp;
> +       for my $regex (@regexes) {
> +               next unless $_ =~ $regex;
> +               if ($last_regex == $regex) {
> +                       die "duplicate lines: '$_'\n" unless $last_line ne $_;
> +                       die "unsorted lines: '$last_line' before '$_'\n" unless $last_line lt $_;
> +               }
> +               $matched = 1;
> +               $last_regex = $regex;
> +               $last_line = $_;
> +       }
> +       unless ($matched) {
> +               $last_regex = 0;
> +               $last_line = '';
> +       }
> +}

This is, of course, endlessly bikesheddable. Here is a shorter -- and,
at least for me, easier to understand -- way to do it:

    my $rc = 0;
    chomp(my @all = <STDIN>);
    foreach my $needle (@ARGV) {
        my @lines = grep(/^$needle/, @all);
        if (join("\n", @lines) ne join("\n", sort @lines)) {
            print "'$needle' lines not sorted\n";
            $rc = 1;
        }
    }
    exit $rc;

By the way, it might be a good idea to also print the filename in
which the problem occurred. Such context can be important for the
person trying to track down the complaint. To do so, you'd probably
want to pass the filename as an argument, and open and read the file
rather than sending it only as standard-input.
