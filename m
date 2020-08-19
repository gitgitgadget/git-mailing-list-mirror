Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE85C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA23207BB
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHSTjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:39:21 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:41997 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSTjV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 15:39:21 -0400
Received: by mail-ej1-f67.google.com with SMTP id g19so27662635ejc.9
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 12:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IfgI87ZJ4hjktmBvnpNsAf4YCftcoL6+QHhT/pJQlo=;
        b=th7LRYKNzPLvqdqrMczAdMX8Kby1aJYvranDLC+KEOETj8wQgg8/+ZHCJZu6Z2tmb1
         jmGo2OklSY5gLV0w8jmrqF1ZE5mWjdOCb7V3sr5JUpwQNzbjLWbN5wvZt1nDecyHIqtt
         oQjq5lugJDzwPywK/rr7MXBbyPmh37XSywhDyWfidMc9DKWmEJmNR9pqIVBqnPESemUF
         6JpIjhm2706vClKhT8LOypIa6raTO2abQU95I2v9i1UQJ3nh1AN6XIYWO98OVt51FV4I
         Fe26T6THNPolPk9QR5YDjawW2TlrCKCmrnjZcGLrY9qVknclR7gHBED8a7W/m8A3YeOC
         E0IA==
X-Gm-Message-State: AOAM533nTkmEUGUwr7+WTgxuANgidzMRn1DMEWdgqQwqV1SYL7NOq6RU
        kP0wJqU7an/Rb4OlASh4R8G9cyJmGkVBrzN0KOE=
X-Google-Smtp-Source: ABdhPJxL7sT5gy+x/3JzG+2ryLB+SfZMMETbFhc8GrLaa3676ZxfK0O2VGiUw/rb3OppADqwvDKnQkwSTeZcOHQv4To=
X-Received: by 2002:a17:906:a1cf:: with SMTP id bx15mr401067ejb.231.1597865959099;
 Wed, 19 Aug 2020 12:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <7daf9335a501b99c29e299f72823fcb7e549e748.1597841551.git.gitgitgadget@gmail.com>
 <xmqqv9hettag.fsf@gitster.c.googlers.com> <xmqqmu2qtpxp.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu2qtpxp.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Aug 2020 15:39:07 -0400
Message-ID: <CAPig+cS398dm4W5Q2DnK+bGvw0mOG3916dHPbZ=y1JNrqz1G-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: 'contents:trailers' show error if `:` is missing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 19, 2020 at 3:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >> +static int check_format_field(const char *arg, const char *field, const char **option)
> >> +{
> >> +            else if (*opt == ':') {
> >> +                    *option = ++opt;
> >> +                    return 1;
> >> +            }
>
> And the helper does not have such a breakage.  It looks good.

One minor comment (not worth a re-roll): I personally found:

    *option = ++opt;

more confusing than:

    *option = opt + 1;

The `++opt` places a higher cognitive load on the reader. As a
reviewer, I had to go back and carefully reread the function to see if
the side-effect of `++opt` had some impact which I didn't notice on
the first readthrough. The simpler `opt + 1` does not have a
side-effect, thus is easier to reason about (and doesn't require me to
re-study the function when I encounter it).
