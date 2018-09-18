Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281241F404
	for <e@80x24.org>; Tue, 18 Sep 2018 00:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeIRGEK (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 02:04:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40446 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbeIRGEK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 02:04:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id c126-v6so98725qkd.7
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 17:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIVw3JA3TAc33Q9LfFX5nKO5fDfYIvX4aHIFxTqChUE=;
        b=VX7HuBsgeRsscK8a+aBZgLI9LlcTu69JZr7jNj80J22t99uXLgethp1hDpe5J4fn+A
         9A4kU6FKDFg6w6GydW7LccELyy5ltm5GY76DNq/v1E3KH3x0TzYcN+EjeoV9KXEHqGkL
         7P9pV6Ez/+LkAdIEXevUouWcWReaFhiV28r4oKBVite/QmnZDsZhQVsFFScpfE44Csy4
         4s9nPZTvEDVmtr9A4e7UG4c8fmhjWI+0M1bZUf62Jpj0bhTi0Reu0SsRTXcg8Z1hXwqv
         75WnFgHzKkj1gjl4kmVVzdaMEPU7ZWzJzekeDbPbrphELQOSsV+HmSZ2QTNIlHt7z6q8
         MCuA==
X-Gm-Message-State: APzg51APLqUmcgBkLfV/kwq9a8i5FGwdPVXr0ustDAAiLqG2YM9lVl8E
        TGl8sH0fOCbOch2WvQMAoFisJ1cflkcou6MwA1I=
X-Google-Smtp-Source: ANB0VdZ7tGlBsexd5JUKocoO8u6lpF152dQSa20IyE+Lf2ZKrDea2V84dVA+kJEVaw0MrpxmXX1PS48WNbESWxU1fjI=
X-Received: by 2002:a37:48e:: with SMTP id 136-v6mr19135466qke.26.1537230858684;
 Mon, 17 Sep 2018 17:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537222670.git.matvore@google.com>
 <44ee2bd27b510d4216525e24aa1734a1f5edbd95.1537222670.git.matvore@google.com>
In-Reply-To: <44ee2bd27b510d4216525e24aa1734a1f5edbd95.1537222670.git.matvore@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 17 Sep 2018 20:34:07 -0400
Message-ID: <CAPig+cTO=BJ+-6+73fDmdWX7axCZvsyKMxE0E1bhGX-YUFrR-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] tests: Add linter check for pipe placement style
To:     matvore@google.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 6:25 PM Matthew DeVore <matvore@google.com> wrote:
> tests: Add linter check for pipe placement style

Until now, the various "lint" checks have been for genuine portability
problems (except perhaps 'test-lint-duplicates'). This new lint check
makes style violations worthy of failing "make test". Is the indeed
the direction we want to go? (Genuine question. I can formulate
arguments for either side.)

> ---
> diff --git a/t/Makefile b/t/Makefile
> @@ -101,6 +101,16 @@ test-lint-filenames:
> +test-lint-pipes:
> +       @# Do not use \ to join lines when the next line starts with a
> +       @# pipe. Instead, end the prior line with the pipe, and allow that to
> +       @# join the lines implicitly.
> +       @bad="$$(${PERL_PATH} -n0e 'm/(\n[^\n|]+\\\n[\t ]+\|[^\n]*)/ and \
> +             print qq{$$ARGV:$$1\n\n}' $(T))"; \
> +               test -z "$$bad" || { \
> +               printf >&2 "pipe at start of line in file(s):\n%s\n" "$$bad"; \
> +               exit 1; }

If we're going in the direction of linting style violations, then
maybe generalize this by calling it "test-lint-style" rather than
"test-lint-pipes", and perhaps move the body of the test to a new
script check-shell-style.pl (or something), much as portability
violations are housed in check-non-portable-shell.pl.
