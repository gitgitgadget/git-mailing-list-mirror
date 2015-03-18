From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 18 Mar 2015 15:26:42 -0400
Message-ID: <CAPig+cR-87-dWXUKoKvphrdb_Y=7268G5uerAiPYDsj-UQiuRw@mail.gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 20:26:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYJc8-0000XX-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 20:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216AbbCRT0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 15:26:44 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:36446 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbbCRT0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 15:26:43 -0400
Received: by yhjf44 with SMTP id f44so18518231yhj.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yOT59alWQYBk78zb28OXleEL+HtHTNM/8CJyM1ZLV9s=;
        b=BrKRnIpClmJtwA8UVY2I2sAWe052H3vgc1KlDUzjL4lIPxRDCVzFI8yP7ST2PWjdAA
         I1ywhRRExUc5jLuCys1GyacLIymkw17pzSLWfVYFhl3W/3D9Uu21xk+a/OlMd/oRRRW/
         uP2zkLXmF5yjL00VfjNqs5Hg7utSFViE8Ixcin4q8wIPZnZCMSHL5ruzvMjuty6zpyjp
         mKX5dw0smJo9LB8bI9Iry41vXFjpL17WRLrVEX+qXPJ2I9WhBEaMhXONp7l/YDvEA98E
         gyEELYAA11iPCj6RXiK/ZNCk8KwjQgYyDrIMzA9I0H7oWlF2TTCDGaaxeATY+QvW/7k4
         t0Xg==
X-Received: by 10.236.202.238 with SMTP id d74mr74232499yho.166.1426706802707;
 Wed, 18 Mar 2015 12:26:42 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Wed, 18 Mar 2015 12:26:42 -0700 (PDT)
In-Reply-To: <1426662276-8728-4-git-send-email-pyokagan@gmail.com>
X-Google-Sender-Auth: AgSGMYOtER-SSStl0KsI_T7xNHY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265751>

On Wed, Mar 18, 2015 at 3:04 AM, Paul Tan <pyokagan@gmail.com> wrote:
> t0302 now tests git-credential-store's support for the XDG user-specific
> configuration file $XDG_CONFIG_HOME/git/credentials. Specifically:
> ---
>
> The previous version can be found at [1].
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/265305/focus=265308
>
> * Merge related, but previously separate, tests together in order to
>   make the test suite easier to understand.
>
> * Instead of setting/unsetting XDG_CONFIG_HOME in separate tests, set
>   it, and unset it immediately before and after "helper_test store" is
>   called in order to make it localized to only the command that it
>   should affect.
>
> * Add test, previously missing, to check that only the home credentials
>   file is written to if both the xdg and home files exist.
>
> * Correct mislabelling of "home-user"/"home-pass" to the proper
>   "xdg-user"/"xdg-pass".
>
> * Use "rm -f" instead of "test_might_fail rm".

This round looks much better. Thanks.

Most of the comments below are just nit-picky, with one or two genuine
(minor) issues.

> Thanks Eric for the code review.
>
> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index f61b40c..5b0a666 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -6,4 +6,115 @@ test_description='credential-store tests'
>
>  helper_test store
>
> +test_expect_success 'when xdg credentials file does not exist, only write to ~/.git-credentials; do not create xdg file' '

These test descriptions are quite long, often mirroring in prose what
the test body already says more concisely. I generally try to keep
descriptions short while still being descriptive enough to give a
general idea about what is being tested. I've rewritten a few test
descriptions (below) to be very short, in fact probably too terse; but
perhaps better descriptions would lie somewhere between the two
extremes. First example, for this test:

    "!xdg: >.git-credentials !xdg"

Key: Space-separated items. Items before ":" are the pre-conditions,
and items after are the post-state. "!" file does not exist; ">"
output goes here.

> +       test -s "$HOME/.git-credentials" &&
> +       test_path_is_missing "$HOME/.config/git/credentials"
> +'
> +
> +test_expect_success 'create $XDG_CONFIG_HOME/git/credentials file' '

It's customary to call this "setup" rather than "create".

Terse version: "setup: -.git-redentials +xdg"

Key: "-" file removed; "+" file created.

> +       rm -f "$HOME/.git-credentials" &&
> +       mkdir -p "$HOME/.config/git" &&
> +       >"$HOME/.config/git/credentials"
> +'
> +
> +helper_test store
> +
> +test_expect_success 'when xdg credentials file exists, only write to xdg file; do not create ~/.git-credentials' '

Terse version: "!.git-credentials xdg: !.git-credentials >xdg"

> +       test -s "$HOME/.config/git/credentials" &&
> +       test_path_is_missing "$HOME/.git-credentials"
> +'
> +
> +test_expect_success 'set up custom XDG_CONFIG_HOME credential file at ~/xdg/git/credentials' '

s/set up/setup/

Terse: "setup custom-xdg"

> +       mkdir -p "$HOME/xdg/git" &&
> +       rm -f "$HOME/.config/git/credentials" &&
> +       >"$HOME/xdg/git/credentials"

It would be easier to read this if you placed the two lines together
which refer to the custom xdg file. Also, for completeness and to be
self-contained, don't you want to remove ~/.git-credentials?

    rm -f "$HOME/.git-credentials" &&
    rm -f "$HOME/.config/git/credentials" &&
    mkdir -p "$HOME/xdg/git" &&
    >"$HOME/xdg/git/credentials"

> +'
> +
> +XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME && helper_test store
> +unset XDG_CONFIG_HOME

It's hard to spot the "helper_test store" at the end of line. I'd
place it on a line by itself so that it is easy to see that it is
wrapped by the setting and unsetting of the environment variable.

> +test_expect_success 'if custom XDG_CONFIG_HOME credentials file ~/xdg/git/credentials exists, it will only be written to; ~/.config/git/credentials and ~/.git-credentials will not be created' '

Terse: "!.git-credentials !xdg custom-xdg: !.git-credentials !xdg >custom-xdg"

> +       test_when_finished "rm -f $HOME/xdg/git/credentials" &&
> +       test -s "$HOME/xdg/git/credentials" &&
> +       test_path_is_missing "$HOME/.config/git/credentials"

Matthieu already pointed out the broken &&-chain.

> +       test_path_is_missing "$HOME/.git-credentials"
> +'
> +
> +test_expect_success 'get: return credentials from home file if matches are found in both home and xdg files' '

Terse: ".git-credentials xdg: <.git-credentials"

Key: "<" taken from here.

> +       mkdir -p "$HOME/.config/git" &&
> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
> +       check fill store <<-\EOF
> +       protocol=https
> +       host=example.com
> +       --
> +       protocol=https
> +       host=example.com
> +       username=home-user
> +       password=home-pass
> +       --
> +       EOF
> +'
> +
> +test_expect_success 'get: return credentials from xdg file if the home files do not have them' '

Terse: "!.git-credentials xdg: <xdg"

> +       mkdir -p "$HOME/.config/git" &&
> +       >"$HOME/.git-credentials" &&
> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
> +       check fill store <<-\EOF
> +       protocol=https
> +       host=example.com
> +       --
> +       protocol=https
> +       host=example.com
> +       username=xdg-user
> +       password=xdg-pass
> +       --
> +       EOF
> +'
> +
> +test_expect_success 'get: return credentials from home file if xdg files are unreadable' '

An earlier test showed that the home file is preferred if both it and
the xdg file exist, so is this test actually telling us anything new?
Did you mean instead to reverse the case and make the home file
unreadable?

> +       mkdir -p "$HOME/.config/git" &&
> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
> +       chmod -r "$HOME/.config/git/credentials" &&

It would be a bit easier to see that the 'chmod' applies to the xdg
file if it directly followed creation of the xdg file.

> +       check fill store <<-\EOF
> +       protocol=https
> +       host=example.com
> +       --
> +       protocol=https
> +       host=example.com
> +       username=home-user
> +       password=home-pass
> +       --
> +       EOF
> +'
> +
> +test_expect_success 'store: If both xdg and home files exist, only store in home file' '

Inconsistent capitalization: s/If/if/

> +       mkdir -p "$HOME/.config/git" &&
> +       >"$HOME/.config/git/credentials" &&
> +       >"$HOME/.git-credentials" &&
> +       check approve store <<-\EOF &&
> +       protocol=https
> +       host=example.com
> +       username=store-user
> +       password=store-pass
> +       EOF
> +       echo "https://store-user:store-pass@example.com" >expected &&
> +       test_cmp expected "$HOME/.git-credentials" &&
> +       test_must_be_empty "$HOME/.config/git/credentials"
> +'
> +
> +
> +test_expect_success 'erase: erase matching credentials from both xdg and home files' '
> +       mkdir -p "$HOME/.config/git" &&
> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
> +       check reject store <<-\EOF &&
> +       protocol=https
> +       host=example.com
> +       EOF
> +       test_must_be_empty "$HOME/.config/git/credentials" &&
> +       test_must_be_empty "$HOME/.git-credentials"
> +'
> +
>  test_done
> --
> 2.1.4
