Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0583FC74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 03:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjC2DNb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 28 Mar 2023 23:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjC2DNY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 23:13:24 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5826A5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 20:13:20 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id l14so9356875pfc.11
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 20:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680059600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I53jDXLYnsFbIjfZBQbPxXBpdih0oo0ggbxPTaoWO4o=;
        b=X2H5qHKN02UA4hnyCm/ehasBlRP6Jg3V9YHNQkZ0kQY6GWPJpMp9iX4mExkmWByocA
         kD3etPp8siC41oydS2vVPBjHh3Ytg7xqUO7LX/VQxoR4nRaXj1X/ORnI0qkqPvZZ5xf+
         yXTkWHDp2+nEPti+n775ssk7IlEBqLMIIO7z3nKtxVlWNDJg7665N+h6cppYUzXK/Q+A
         k2nvY4ucJX7vEalJ+2/FQB6MAoUG2damYAQqluhakFQG9MJJet3nd21XBLfVM0+D/vXZ
         iwoNhUUEdOF1e7ohYPVZW6u1WE3OwmFu+DQy3OClUhMHrRxBWNVXnd84xOwegBpUaCYD
         gSog==
X-Gm-Message-State: AAQBX9cw7E8lrDZ7TyF9c1HaBSXKzRwBFd/PH3JWf9t5hf8eiUIGq9SD
        QlADYgE43bXaO/8bY/KhEtHulBuVAjcl4LPprzU=
X-Google-Smtp-Source: AKy350ZgkJlUUTxHw/G1Kd0nh8yTRDoHPXVHXmO5WBBdW1yuHWcneFNwKjxvpDfjkjkGdFt7l6TG92YT6LVBPS7zif4=
X-Received: by 2002:a63:612:0:b0:503:2612:5554 with SMTP id
 18-20020a630612000000b0050326125554mr4770378pgg.10.1680059599874; Tue, 28 Mar
 2023 20:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202819.GC1241631@coredump.intra.peff.net> <xmqqzg7wczx7.fsf@gitster.g>
 <20230329023702.GA1793752@coredump.intra.peff.net> <20230329030432.GA1801645@coredump.intra.peff.net>
In-Reply-To: <20230329030432.GA1801645@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Mar 2023 23:13:08 -0400
Message-ID: <CAPig+cQexJ9s1f6tLLaq7baeVCKhazPBi_xQ6uybkQcJQ97geg@mail.gmail.com>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 11:04 PM Jeff King <peff@peff.net> wrote:
> On Tue, Mar 28, 2023 at 10:37:02PM -0400, Jeff King wrote:
> > I just think chainlint.pl is doing a good enough job of catching it that
> > we can rely on it. I'll be curious if Eric has input there on whether it
> > can do even better, which would remove all of the caveats from the
> > commit message.
>
> So I _think_ it's something like this:
>
> @@ -171,6 +171,9 @@ sub swallow_heredocs {
>                 my $start = pos($$b);
>                 my $indent = $tag =~ s/^\t// ? '\\s*' : '';
>                 $$b =~ /(?:\G|\n)$indent\Q$tag\E(?:\n|\z)/gc;
> +               if (pos($$b) == $start) {
> +                       die "oops, we did not find the end of the heredoc";
> +               }
>                 my $body = substr($$b, $start, pos($$b) - $start);
>                 $self->{lineno} += () = $body =~ /\n/sg;
>         }
>
> But I wasn't sure how to surface a clean error from here, since we're in
> the Lexer. Maybe we just accumulate a "problems" array here, and then
> roll those up via the TestParser? I'm not very familiar with the
> arrangement of that part of the script.

Yes, it would look something like that and you chose the correct spot
to detect the problem, but to get a "pretty" error message properly
positioned in the input, we need to capture the input stream position
of the here-doc tag itself in scan_heredoc_tag(). It doesn't look too
difficult, and I even started writing a bit of code to do it, but I'm
not sure how soon I can get around to finishing the implementation.

> And I say "think" because the thing I was worried about is that we'd do
> this lexing at too high a level, and accidentally walk past the end of
> the test. Which would mean getting fooled by;
>
>   test_expect_success 'this one is broken' '
>         cat >foo <<\EOF
>         oops, we are missing our here-doc end
>   '
>
>   test_expect_success 'this one is ok' '
>         cat >foo <<\EOF
>         this one is OK, but we would not want to confuse
>         its closing tag for the missing one
>         EOF
>   '
>
> But it looks like Lexer::swallow_heredocs gets to see the individual
> test snippets.

Correct. ScriptParser scans the input files for
test_expect_{success,failure} invocations in order to extract the
individual test snippets, which then get passed to TestParser for
semantic analysis.
