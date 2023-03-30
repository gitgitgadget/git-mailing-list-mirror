Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8D2C761AF
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 21:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjC3V1I convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 30 Mar 2023 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC3V1H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 17:27:07 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097731A5
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 14:27:06 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id jl13so15111559qvb.10
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 14:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m8whdiYfFLpGy78XEVrvuRtGguttgL9KhUqWfAR5/0=;
        b=fU1UfbdSrzVRzatCJquWzzlaoGm27tRxn9hwlHPshwOyTmZR0RKiZcZc9D/QRaI64p
         x1dzHQNGftdhmCih5/TlVzGP9oH1dc1m6ZB6cmjEEXMXesl059DsS4u5+zjsFtdTwRg3
         /0LwkcP8NVu+hW4lAGFLcQqRUB9zPey9QylhPT6fmATAuC+WT6aoTW0P70m2HOGQw/tl
         yP0k0EEc0K7R+9l9CDWPU6u/7FO0lKx0Qc2voJOYJcVMH+sPvZ5P6xJL9Zfr1w2XJn3n
         ft6INVdzszsZ8+wh+wFg/XSe5Uy/0dEGUIoBuR9IGKG6bCEVBYyPxZZOeRQI8MiYlb0M
         Nk4w==
X-Gm-Message-State: AAQBX9eI3xoQXVaxkvXQwfsxL7g3HdBkQRbYJNJvQaaODU2NwlUGviPj
        tmmAghcXZomr8L8b8tncqUsj+Zx3jsVjm2gqRDY=
X-Google-Smtp-Source: AKy350ZY+GEBdqN+TZMs0Ukx7uKmvIllYGFNySwb8ThPFu+8FIdh2V3B1ShZW8GVoH73RQ1wwr1r4rITKGKiHeuMu/o=
X-Received: by 2002:a05:6214:192e:b0:56b:e002:75df with SMTP id
 es14-20020a056214192e00b0056be00275dfmr4280302qvb.5.1680211624851; Thu, 30
 Mar 2023 14:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230330192712.GA27719@coredump.intra.peff.net> <20230330193031.GC27989@coredump.intra.peff.net>
In-Reply-To: <20230330193031.GC27989@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Mar 2023 17:26:53 -0400
Message-ID: <CAPig+cRr=fvGKms5p3saWXm+38rBdn_jMK6p+mQCrS54krXagg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tests: diagnose unclosed here-doc in chainlint.pl
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 3:30 PM Jeff King <peff@peff.net> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> An unclosed here-doc in a test is a problem, because it silently gobbles
> up any remaining commands. Since 99a64e4b73c (tests: lint for run-away
> here-doc, 2017-03-22) we detect this by piggy-backing on the internal
> chainlint checker in test-lib.sh.
>
> However, it would be nice to detect it in chainlint.pl, for a few
> reasons:
>
>   - the output from chainlint.pl is much nicer; it can show the exact
>     spot of the error, rather than a vague "somewhere in this test you
>     broke the &&-chain or had a bad here-doc" message.
>
>   - the implementation in test-lib.sh runs for each test snippet. And
>     since it requires a subshell, the extra cost is small but not zero.
>     If chainlint.pl can reliably find the problem, we can optimize the
>     test-lib.sh code.
>
> The chainlint.pl code never intended to find here-doc problems. But
> since it has to parse them anyway (to avoid reporting problems inside
> here-docs), most of what we need is already there. We can detect the
> problem when we fail to find the missing end-tag in swallow_heredocs().
> The extra change in scan_heredoc_tag() stores the location of the start
> of the here-doc, which lets us mark it as the source of the error in the
> output (see the new tests for examples).
>
> [jk: added commit message and tests]

Thanks for packaging this up as a proper patch.

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> New in this iteration (thanks again, Eric!).
>
> I changed the error-tag from "HERE" to "UNCLOSED-HEREDOC". I don't think
> there any syntactic limitations to worry about (it's just shown to the
> user).

The error-tag is plucked by the script at a couple places using a
regex such as /\?![^?]+\?!/ which won't be tripped up by the longer
and hyphenated name, so no problem there.

> And it needs to be descriptive enough not to confuse users.
> "HERE" is especially bad because my brain interprets it as "HERE there
> is an error", which makes me say "Right. What error?".
>
> So "HEREDOC" would work, but there is no reason (aside from length) not
> to err on the side of being descriptive.

I had the same thought about HERE being potentially misleading, thus
wavered between HERE and HEREDOC, but ultimately chose the shorter for
length-similarity with the existing AMP and LOOP. That reminds me
that, for some time now, I've been thinking that t/README ought to
have a section explaining the meaning of AMP and LOOP (and HERE, if we
went with that) since newcomers may not intuitively understand what
such terse complaints mean.

> diff --git a/t/chainlint.pl b/t/chainlint.pl
> @@ -80,7 +80,8 @@ sub scan_heredoc_tag {
> -       push(@{$self->{heretags}}, $indented ? "\t$tag" : "$tag");
> +       $$token[0] = $indented ? "\t$tag" : "$tag";
> +       push(@{$self->{heretags}}, $token);
>         return "<<$indented$tag";
> @@ -169,10 +170,18 @@ sub swallow_heredocs {
> -               my $indent = $tag =~ s/^\t// ? '\\s*' : '';
> -               $$b =~ /(?:\G|\n)$indent\Q$tag\E(?:\n|\z)/gc;
> +               my $indent = $$tag[0] =~ s/^\t// ? '\\s*' : '';
> +               $$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
> +               if (pos($$b) > $start) {
> +                       my $body = substr($$b, $start, pos($$b) - $start);
> +                       $self->{lineno} += () = $body =~ /\n/sg;
> +                       next;
> +               }
> +               push(@{$self->{parser}->{problems}}, ['UNCLOSED-HEREDOC', $tag]);
> +               $$b =~ /(?:\G|\n).*\z/gc; # consume rest of input
>                 my $body = substr($$b, $start, pos($$b) - $start);
>                 $self->{lineno} += () = $body =~ /\n/sg;
> +               last;

Oddly enough, these changes look fine to me.
