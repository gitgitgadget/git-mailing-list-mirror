Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5572C4332F
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 17:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbhLHRGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:06:01 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56318 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237475AbhLHRF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 12:05:59 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D745E1F953;
        Wed,  8 Dec 2021 17:02:26 +0000 (UTC)
Date:   Wed, 8 Dec 2021 17:02:26 +0000
From:   Eric Wong <e@80x24.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Junio C Hamano <gitster@pobox.com>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
Message-ID: <20211208170226.GA12748@dcvr>
References: <20211123185237.M476855@dcvr>
 <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
 <20211126171141.GA21826@dcvr>
 <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
 <20211127195231.GA4636@dcvr>
 <xmqqtufx5p19.fsf@gitster.g>
 <87mtlnjhj6.fsf@intel.com>
 <20211129172618.GA26651@dcvr>
 <CAMuHMdWygx9kTemsrZdru-ieYyJXm=8276Q_ZSxZGkqsu5OWVg@mail.gmail.com>
 <af5ee2e8-cd59-fc9a-35fa-6fec1fc9aa33@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af5ee2e8-cd59-fc9a-35fa-6fec1fc9aa33@leemhuis.info>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> wrote:
> On 30.11.21 09:24, Geert Uytterhoeven wrote:
> > On Mon, Nov 29, 2021 at 11:29 PM Eric Wong <e@80x24.org> wrote:
> >> It's a bit much for common cases with git-send-email and
> >> reasonable MUAs, I think.  I don't know if formail is commonly
> >> installed, nowadays...
> 
> Well, after your earlier suggestion I considered to go with this:
> 
> -	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link:
> https://lore.kernel.org/r/$1|g;' "$1"
> +	perl -pi -e 's|^Message-ID:\s*<?([^>]+)>?$|Link:
> https://lore.kernel.org/r/$1|i;' "$1"
> 
> But...
> 
> > Of course ;-) You need it to run checkpatch on patch series obtained
> > through "b4 am", before you apply them to your tree:
> > 
> > $ cat *mbx | formail -s scripts/checkpatch.pl
> 
> ...this made me wonder if formail would be the better solution. I came
> up with this:
> 
> formail -A "Link: https://lore.kernel.org/r/`formail -c -x Message-ID <
> "${1}" | sed 's!.*<\(.*\)>!\1!'`" < "${1}" | sponge "${1}"
> 
> Downsides: instead of perl it requires sed and sponge (part of
> moreutils, which I guess not everyone has installed; but I tried to
> avoid a big here document or moving files around).

As Geert noted, formail is probably reasonable, but I certainly
don't have moreutils across all the systems I'm using right now.

> Is that worth it? Or is there a way to realize this in a more elegant
> fashion with tools everyone has installed?

*shrug*  Since newlines after ':' are a concern and it's (probably :P)
safe to slurp entire contents of emails into memory nowadays;
some minor tweaks to the original perl invocation should work:

* use `$/ = undef' to force Perl to operate on the entire input at once
* use `m' RE modifier to ensure `^' and `$' still match SOL/EOL
  ($/ is only the input record separator, it doesn't change
   Perl's definition of "lines" for `^' and `$')

perl -i -p -e 'BEGIN{$/=undef};s|^Message-ID:\s*<?([^>]+)>?$|Link:
 https://lore.kernel.org/r/$1|im;'
