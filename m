Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA00C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 04:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiJYEGH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 25 Oct 2022 00:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiJYEGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 00:06:02 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB37DFF7
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 21:05:58 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id 7so3297471ilg.11
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 21:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kK/LjLOp38Fsam+QKr2bNhm8OzqCEqKndM5MJb7goMo=;
        b=KL6YE5rtIyECYwmIiidmYQ+Y2p9AjexxUvLA1mnjbg/86Cz3bA1eSg0r4I309sgfsZ
         +OXVZ60t1tkIN1DbYmFPJH5FI8U/6W9O6vG2b9vUWK8xnsqOUwP9EJLjJXwfonca0sNx
         7bGYLZDtInyBIf0N5Bpcrfd2+gJEPxQ8b9LTlaq3gchKXEqLhBMZOuE8T3rvH7NnXdhY
         go9R+F0pjOsiA95mpQiIT1uWod7JQ1RmNvuKkT+clqzyPOkeI35mRMcVoPcQIh4HnPx2
         vhFNdDcM8yhItjU3S+EgcTpsN89iF5pF4mlW0jG4bxShL9yxl9JVD4/+TXwxtUX1qZl2
         Qmvw==
X-Gm-Message-State: ACrzQf0u0NcEHhH1fXcPOUsFCIHCqs+tZ52OSIOQHpE8MSkaCvb6Ip8I
        3sNPLD+74SUgqGIvmBxXE2JasycZK1RW8ENASLA=
X-Google-Smtp-Source: AMsMyM5y2qlIRaW3hJqgiiXEI4gO6CBpaSrjSnAI0GonrPabtI6nW7DmBNaZzNfaqwMPFW2H9KMB6Gg5w9k9Qj5Mdng=
X-Received: by 2002:a05:6e02:b2f:b0:2fa:1c95:5c98 with SMTP id
 e15-20020a056e020b2f00b002fa1c955c98mr23884507ilu.249.1666670757344; Mon, 24
 Oct 2022 21:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com> <221024.865yg9ecsx.gmgdl@evledraar.gmail.com>
In-Reply-To: <221024.865yg9ecsx.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Oct 2022 00:05:46 -0400
Message-ID: <CAPig+cT=cWYT6kicNWT+6RxfiKKMyVz72H3_9kwkF-f4Vuoe1w@mail.gmail.com>
Subject: Re: chainlint.pl's new "deparse" output (was: [PATCH v2] [...])
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2022 at 6:28 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Sep 13 2022, Eric Sunshine via GitGitGadget wrote:
> > When `chainlint.pl` detects problems in a test definition, it emits the
> > test definition with "?!FOO?!" annotations highlighting the problems it
> > discovered. For instance, given this problematic test:
> >
> >     test_expect_success 'discombobulate frobnitz' '
> >         (echo balderdash; echo gnabgib) >expect &&
> >     '
> >
> > chainlint.pl will output:
> >
> >     # chainlint: t1234-confusing.sh
> >     # chainlint: discombobulate frobnitz
> >     (echo balderdash ; ?!AMP?! echo gnabgib) >expect &&
>
> I've noticed that chainlint.pl is better in some ways, but that the
> "deparse" output tends to be quite jarring. but I can't find version of
> it that emitted this "will output" here.

There is no such version.

> Before this patch, or fb41727b7ed (t: retire unused chainlint.sed,
> 2022-09-01) we'd emit this instead:
>
>         ( echo balderdash ; ?!AMP?! echo gnabgib ) > expect &&
>
> The difference is in whitespace, e.g. "( ", not "(", "> " not ">".  This
> is just because it's emitting "raw" tokenizer tokens.
>
> Was there maybe some local version where the whitespace munging you're
> doing against $checked was different & this commit message was left
> over?

No, I botched the commit message. I typed the example test in by hand
and then, also by hand, typed in the example output, forgetting to
insert the spaces which you correctly noted are missing from the
example output. I should have run the example test through
chainlint.pl and copy/pasted its output into the commit message. (I
did, in fact, run the sample test through chanlint.pl _after_
hand-typing the example output, and compared them by eye but missed
most of the whitespace differences.)

> Anyway, that sort of an aside, but I did go hunting for the version with slightly better whitespace output.

Sorry, my fault for a faulty commit message.

> But to get to the actual point: I've found the new chainlint.pl output
> harder to read sometimes, because it goes through this parse & deparse
> state, so you're preserving "\n"''s.
>
> Whereas the old "sed" output also sucked because we couldn't note where
> the issue was, but we spewed out the test source verbatim.

Somewhat verbatim. chainlint.sed did swallow blank lines and comment
lines, and it folded multi-line strings into one-line strings.

> But it seem to me that we could get much better output if the
> ShellParser/Lexer etc. just kept enough state to emit "startcol",
> "endcol" and "linenum" along with every token, or something like that
> (you might want offsets from the beginning of the parsed source
> instead).
>
> Then when it has errors it could emit the actual source passed in, and
> even do gcc/clang-style underlining.
>
> I poked at getting that working for a few minutes, but quickly saw that
> someone more familiar with the code could do it much quicker, so
> consider the above a feature request :)

Yes, there should be better integration between the lexer and parser
for emitting errors. Unfortunately, it didn't occur to me during
implementation, and I only thought about it when Peff mentioned the
difficult-to-read output in a different part of this discussion.

An alternative, somewhat hacky approach, might be to simply retain
whitespace as tokens in the token stream. That would require less
retrofitting of the lexer, though perhaps more complexity/ugliness in
the parser. It wouldn't give you gcc/clang-level underlining, etc.,
but would more or less preserve whitespace in the test definition.
Definitely not a proper solution, but perhaps "good enough".

> Another thing: When a test *ends* in a "&&" (common when you copy/paste
> e.g. "test_cmp expect actual &&\n" from another test) it doesn't spot
> it, but instead we get all the way to the eval/117, i.e. "broken
> &&-chain or run-away HERE-DOC".

Yes, I recall considering that case and others, but decided that
that's probably outside the scope of the linter. In particular, a
trailing "&&" is a plain old syntax error, and the shell itself is
perfectly capable of diagnosing that problem along with all other
syntax errors, and you'll find out about syntax errors in your code
when the shell tries running it. The linter, on the other hand, is
meant to catch semantic problems (per the project's best-practices) in
what is assumed to be syntactically valid shell code. I suppose the
linter could be made to complain about this syntax error and others,
but it seems unnecessary to bloat it by duplicating behavior already
provided by the shell itself.

It is unfortunate, though, that the shell's "syntax error" output gets
swallowed by the eval/117 checker in test-lib.sh and turned into a
somewhat less useful message. I'm not quite sure how we can fix the
eval/117 checker to not swallow genuine syntax errors like that,
unless we perhaps specially recognize exit code 2 and, um, do
something...

> More feature requests (because for some reason you've got infinite time,
> but I don't :): This software is really close to being able to also
> change the tests on the fly. If you could define callbacks where you
> could change subsets of the parse stream, say a single command like:
>
>         grep some.*rx file
>
> So we could rewrite that into:
>
>         if ! grep some.*rx foo
>         then
>                 cat foo &&
>                 false
>         fi
>
> And other interesting auto-fixups and borderline coccinelle
> transformations, e.g. changing our various:
>
>         test "$(git ...) = "" &&
>
> Into:
>
>         git ... >out &&
>         test_must_be_empty out

The lexer/parser implemented for chainlint.pl might indeed be useful
for such transformations. I could imagine a tool which someone runs on
an old-style test script to help update it to modern conventions,
after which the person would, of course, carefully check all the
applied transformations. That's not something we'd necessarily want to
do project-wide, but might be handy when already working on a test
script for some other reason.
