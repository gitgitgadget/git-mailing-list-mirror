Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256D51F597
	for <e@80x24.org>; Mon, 30 Jul 2018 21:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeG3XPO (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 19:15:14 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37348 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeG3XPO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 19:15:14 -0400
Received: by mail-yw0-f195.google.com with SMTP id w76-v6so4964059ywg.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 14:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V12c4fBFj68Be1NPsuyhg4gEkqu7nToD3+qU5YXz57c=;
        b=fc1Hv5nr1m3kY042AL8BwW4cmfQYdz8bj43zXgICZaPyp1K9VOxIiwZhLXh7KbyGAX
         eiC3iQaK90F5L9vS76f3Drw7d9TFBKcaD04YU58f84uapURHF8fkCxoJ/MUySYFOM+/c
         R3nabBCthO9zD50Tq+hJdrEl/kbqE5xccmakOIW7oYs3nVlqOd5JDjRbKu9/omzZK2d4
         leQRPu+IjOpIaYq5xQtFgFCrZ60NLNqpRx4Hs38qbXguhx9VyIIDnaxwZWvfxQaaaQdA
         Jv/YtFGiQJtTpN/jK4c3TiUlEizyUXQ3lI4EM11ZaromVLHsiw49L7qLLfm/ot/Et/YY
         3qTg==
X-Gm-Message-State: AOUpUlGQ8nfg23xrkAMXTxM0QHliXb9K34fgRQGgufxUYwHlZf7xABx+
        kDuaaRlHtaS5SAYU0QMfW+C99EOHv4HI3kDGMmY=
X-Google-Smtp-Source: AAOMgpcOkdN+dvpApYidSKHvGoP/aAKfunREzn+8RiVPc5N8+Qc3F86oRsjxt9xifCB7Ak7yvg160IsY7wuVUj6aX34=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr9865894ywk.418.1532986698332;
 Mon, 30 Jul 2018 14:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com> <20180711064642.6933-2-sunshine@sunshineco.com>
 <20180730181356.GA156463@aiede.svl.corp.google.com> <CAPig+cRFMKBQVVYjhS6-Yyy-aQCYXGiqG6XoqucJoedCvAzheQ@mail.gmail.com>
 <20180730205914.GE156463@aiede.svl.corp.google.com>
In-Reply-To: <20180730205914.GE156463@aiede.svl.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Jul 2018 17:38:06 -0400
Message-ID: <CAPig+cRTgh6DStUdmXqvhbL_7sQY6wu21h27rjq_i=kZ_d+LAw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 4:59 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Sunshine wrote:
> > The subshell linter would normally fold out the here-doc content, but
> > 'sed' isn't a proper programming language, so the linter can't
> > recognize arbitrary here-doc tags. Instead it has hard-coded knowledge
> > of the tags commonly used in the Git tests, specifically EOF, EOT, and
> > INPUT_END.
>
> Oh, hmm.  I also see some others (outside subshells, though):
>
>         EXPECT_END
>         [...]

Correct. The linter does fold-out top-level EOF here-docs to hedge
against the body of a here-doc containing something that might look
like the start of a subshell (which would activate the more
strict/expensive &&-chain validation). It special-cases top-level EOF
because it's such a common tag name, thus an easy way to avoid
false-positives, in general. I didn't bother trying to recognize
_every_ possible tag since those other here-docs don't trigger any
problems. (It's heuristic-based, after all.)

> I wonder if it should look for something like [A-Z][A-Z_]* to catch
> all of these.

I considered that, but it doesn't handle nested here-docs, which we
actually have in the test suite. For instance, from t9300-fast-import:

    cat >input <<-INPUT_END &&
    mark :2
    data <<EOF
    $file2_data
    EOF
    ...
    INPUT_END

Nesting could be handled easily enough either by stashing away the
opening tag and matching against it later _or_ by doing recursive
here-doc folding, however, 'sed' isn't a proper programming language
and can't be coerced into doing either of those. (And, it was tricky
enough just getting it to handle the nested case with a limited set of
recognized tag names, without having to explicitly handle every
combination of those names nested inside one another.)

> > The linter also deals with multi-line $(...) expressions, however, it
> > currently only recognizes them when the $( is on its own line.
>
> That's reasonable, especially if "on its own line" means "at end of
> line".

It does; sorry for not being clear.

> What would help most is if the error message could explain what is
> going on, but I understand that that can be hard to do in a sed
> script.

Right, unfortunately, it can't be too helpful, but, when fixing all
those broken chains, I did find it useful to dump the result after
'sed' processing in order to identify what it was actually complaining
about. I did so by changing the $1 in this line from test-lib.sh:

error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"

to print the 'sed' output instead. The linter prepends "??AMP??" and
"??SEMI??" to suspect lines. It also prepends lines with ">" to
indicate where it thinks a subshell ends. This information was quite
helpful when figuring out what was broken in the test (or, for false
positives, where a heuristic had gone wrong).

I considered enabling this output by default instead of $1 but decided
against it since it is only helpful for broken &&-chains in subshells,
thus doesn't aid in the more common case of top-level &&-breakage,
thus might be confusing.

> > I could try to update the linter to not trip over this sort of input,
> > however, this test code is indeed ugly and difficult to understand,
> > and your rewrite[1] of it makes it far easier to grok, so I'm not sure
> > the effort would be worthwhile. What do you think?
>
> I'd be happy to look over a change that handles more here-doc
> delimiters or produces a clearer message for tests in poor style, but
> I agree with you that it's not too important.

I am, for a couple reasons, somewhat hesitant to tweak the heuristic.

First, each tweak has the potential of causing more false-positives or
(perhaps worse) false-negatives. The linter's own test-suite is
supposed to protect against that, but test suite coverage is never
perfect.

Second, ideally, the linter should protect against new broken
&&-chains from entering the codebase, so poorly coded historic tests
such as these aren't necessarily good motivation for tweaking, _and_
it is (hopefully) unlikely that we would allow this sort of ugly shell
code to enter the codebase going forward. (The counterargument is that
this false-positive doesn't help someone coding up a new test who
hasn't yet submitted the patch to the mailing list where more seasoned
eyes would suggest better coding style.)
