Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA45E1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfHRU1z (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:27:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40271 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRU1y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 16:27:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so1227324wmj.5
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 13:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJq1ioJO1jiq/iKbV8Q2hbxekZwz9djQYQYdWGoOXJc=;
        b=Hcys3lyGZb4gQK++hXwWbSNWslgH2hv8FE/w+h2tgWK4TU9uUlcV2ArM1TRaykt5cG
         1orK8mpg7dx+JWa99H6qa7+UQPSQErdTF+ob49DSFpR7xonO+FWQjmDx9mKauaVElSgY
         koObzFRJ1LkY/6DYr56+YsPwY9Xcjljn32qdaWZ/JlRLFN2qyjXUgK2sE4RRXvHvjiKs
         rvX27uC16qObh8VxhxiunNRFpXiotGzPijGGBy0KYfrC0BXN/uufLuO0rY1xEC4AM9t1
         16pDIbjkEIlMy3wSuAKct95AVmwfjSNKmsPerzCLiWNutQhGbqRaZYFbbfBkqJYld62n
         GvEw==
X-Gm-Message-State: APjAAAXsIj0XrkNa96hQUA7d/H3NdyMkz8sq0TElhxmR3+ts/J9CPxBr
        RzXXH2qg1B1f6oixIwM16VN3BlR8XUiJ/oUxvKs=
X-Google-Smtp-Source: APXvYqwKEgsLRmtQ+8uPl5YeEVAaHaNBkV9VV3cJxu4zpT0zvWKV9cGpye8WsNrSIisagDonYMYu7fB5tJPR0rRU+2A=
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr17289922wmc.95.1566160072716;
 Sun, 18 Aug 2019 13:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190818191646.868106-1-sandals@crustytoothpaste.net> <20190818191646.868106-12-sandals@crustytoothpaste.net>
In-Reply-To: <20190818191646.868106-12-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Aug 2019 16:27:41 -0400
Message-ID: <CAPig+cT6Depk8sJ48zOp6+AObVmy3_eXnXPEsZJYXY=daZqXXQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] t3903: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 18, 2019 at 3:21 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Abstract away the SHA-1-specific constants by sanitizing diff output to
> remove the index lines, since it's clear from the assertions in question
> that we are not interested in the specific object IDs.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> @@ -7,6 +7,18 @@ test_description='Test git stash'
> +diff_cmp () {
> +       for i in "$1" "$2"
> +       do
> +               sed -e 's/^index 0000000\.\.[0-9a-f]*/index 0000000..1234567/' \
> +               -e 's/^index [0-9a-f]*\.\.[0-9a-f]*/index 1234567..89abcde/' \
> +               -e 's/^index [0-9a-f]*,[0-9a-f]*\.\.[0-9a-f]*/index 1234567,7654321..89abcde/' \
> +               "$i" > "$i.compare"
> +       done &&
> +       test_cmp "$1.compare" "$2.compare" &&
> +       rm -f "$1.compare" "$2.compare"
> +}

For safety, it would probably be a good idea to check the exit status
of the 'sed' invocation in the for-loop:

    for i in "$1" "$2"
    do
        sed -e ... "$i" >"$i.compare" || return 1
    done &&
    ...

(Note, also, that I dropped the whitespace after the '>' operator.)
