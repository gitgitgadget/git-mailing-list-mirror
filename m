Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F2C38145
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 06:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiICGA0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 3 Sep 2022 02:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiICGAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 02:00:25 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0C5EDF4
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 23:00:23 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-344f8f691e2so20528017b3.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 23:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OO7kAM3hribtJYkplOP+GZ5KHlD3G6rbfIHon/6c2G8=;
        b=YuA5fjHMbZyCOAKegicQQTvisllpGmdNctriWPTcxuqi7Q9PK4buyMghSupPa6sBNm
         O8S6E6BzrpT1EilAGtgO9wVjGdAC8GgfqEpTKIKrvdWW7WAxDVDjyUvAYwCctSYZ+bm1
         +lfilMavpO3W774xk/M2oLgonchhasv5oWHPNNA2L15SB3NTYNNS0WZppGmbq42zizjs
         f+4/u+2IaLkhdbCngjv5rr+llB0j2wwwgVjdLhoZoUaOyfqHbMaQxfQT0qYlJh/lQKXT
         ZEVWTafH8thPCIFBS0AmjTN7mJLbAzKh0dzaZ7ROKjnSDVFo+HRgFXGpvW1kHmDeM/Ze
         uYkQ==
X-Gm-Message-State: ACgBeo1pThI+AAUZL776qLRpIvsCVg119Dnx70F9v5hmXRDycPxpgYIX
        ug1RuMScT22WRRxkQfIyjfhiFPuj3z9G1MpjV64=
X-Google-Smtp-Source: AA6agR7Xv7mXcfTQdH7uq9Kk5OrdGqvtvB6rd1WKs9Iah+pcnv6vlRIMDhL4HqHwMFOCYQSmEJjDL1+eiAFzvQPizLA=
X-Received: by 2002:a81:6c02:0:b0:340:b4ae:5aa7 with SMTP id
 h2-20020a816c02000000b00340b4ae5aa7mr27438393ywc.13.1662184822593; Fri, 02
 Sep 2022 23:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <c1042b9bcd94b9ecb0bf73dfbd4334b9f30ba99a.1661992197.git.gitgitgadget@gmail.com>
 <220901.86fshbjmqj.gmgdl@evledraar.gmail.com>
In-Reply-To: <220901.86fshbjmqj.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Sep 2022 02:00:11 -0400
Message-ID: <CAPig+cTfcz3cJ3-ESW-yUNa7QC0HbjZ_giDQA72gBWp5T4Zb6w@mail.gmail.com>
Subject: Re: [PATCH 02/18] chainlint.pl: add POSIX shell lexical analyzer
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2022 at 8:35 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Sep 01 2022, Eric Sunshine via GitGitGadget wrote:
> Just generally on this series:
>
> > +     $tag =~ s/['"\\]//g;
>
> I think this would be a *lot* easier to read if all of these little
> regex decls could be split out into some "grammar" class, or other
> helper module/namespace. So e.g.:
>
>         my $SCRIPT_QUOTE_RX = qr/['"\\]/;

Taken out of context (as in the quoted snippet), it may indeed be
difficult to understand what that line is doing, however in context
with a meaningful function name:

    sub scan_heredoc_tag {
        ...
        my $tag = $self->scan_token();
        $tag =~ s/['"\\]//g;
        push(@{$self->{heretags}}, $indented ? "\t$tag" : "$tag");
        ...
    }

for someone who is familiar with common heredoc tag quoting/escaping
(i.e. <<'EOF', <<"EOF", <<\EOF), I find the inline character class
`['"\\]` much easier to understand than some opaque name such as
$SCRIPT_QUOTE_RX, doubly so because the definition of the named regex
might be far removed from the actual code which uses it, which would
require going and studying that definition before being able to
understand what this code is doing.

I grasp you made that name up on-the-fly as an example, but that does
highlight another reason why I'd be hesitant to try to pluck out and
name these regexes. Specifically, naming is hard and I don't trust
that I could come up with succinct meaningful names which would convey
what a regex does as well as the actual regex itself conveys what it
does. In context within the well-named function, `s/['"\\]//g` is
obviously stripping quoting/escaping from the tag name; trying to come
up with a succinct yet accurate name to convey that intention is
difficult. And this is just one example. The script is littered with
little regexes like this, and they are almost all unique, thus making
the task of inventing succinct meaningful names extra difficult. And,
as noted above, I'm not at all convinced that plucking the regex out
of its natural context -- thus making the reader go elsewhere to find
the definition of the regex -- would help improve comprehension.

> Then:
>
> > +     return $cc if $cc =~ /^(?:&&|\|\||>>|;;|<&|>&|<>|>\|)$/;
>
>         my $SCRIPT_WHATEVER_RX = qr/
>                 ^(?:
>                 &&
>                 |
>                 \|\|
>                 [...]
>         /x;
>
> etc., i.e. we could then make use of /x to add inline comments to these.

`/x` does make this slightly easier to grok, and this is a an example
of a regex which might be easy to name (i.e. $TWO_CHAR_OPERATOR), but
-- extra mandatory escaping aside -- it's not hard to understand this
one as-is; it's pretty obvious that it's looking for operators `&&`,
`||`, `>>`, `;;`, `<&`, `>&`, `<>`, and `>|`.
