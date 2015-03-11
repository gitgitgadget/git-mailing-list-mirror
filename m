From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 11 Mar 2015 04:40:49 -0400
Message-ID: <CAPig+cSZpYX0BZFN3Yx=PTiE3VVVVPH9X3yTwKe7p5J=5Dsngg@mail.gmail.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
	<1426056553-9364-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 09:40:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVcCG-0007CH-Vw
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 09:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbbCKIkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 04:40:53 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:40766 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbCKIku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 04:40:50 -0400
Received: by yhot59 with SMTP id t59so3669660yho.7
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gJCzEVzrNAy9GVxCALaFe9lt5aj2WNQJA5TkDlAFGrY=;
        b=V2QGc4VF+q6WYGj7UNgSNo2SOGh/ju7x9Gs3DOl7qO7reqtBJUhzYQOllpGXK/kzrl
         vnANcyDU9F0Z/QwgvauIMdFMzBWlV15PYSHun0RhtNlQVxip7WCJryGridswSxZuB7eE
         pJiFE6yTDtcMruvuQoHNhwAECxfuCve5R1egAt0n3hiAu96Ga+E+Y4zgR0X3BridcjLi
         Lzc9Hx1YhguclmLif/cnKbf57ISvmg5yUnAgOwwRkR005D3kk9YeJYwpC0yFANHswg8M
         6rzws7rOYdXfr/vTYW/MJ4v860Rf+Yg80LS4QrgTMM5/QWm3dMkEgrZ5/1hKEfZTlRRj
         U+ig==
X-Received: by 10.236.45.106 with SMTP id o70mr36433543yhb.180.1426063250039;
 Wed, 11 Mar 2015 01:40:50 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Wed, 11 Mar 2015 01:40:49 -0700 (PDT)
In-Reply-To: <1426056553-9364-5-git-send-email-pyokagan@gmail.com>
X-Google-Sender-Auth: ecq4eHZsEecNjKfwrM8ijgr83T8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265318>

On Wed, Mar 11, 2015 at 2:49 AM, Paul Tan <pyokagan@gmail.com> wrote:
> t0302 now tests git-credential-store's support for the XDG user-specific
> configuration file $XDG_CONFIG_HOME/git/credentials. Specifically:
>
> * Ensure that the XDG file is strictly opt-in. It should not be created
>   by git at all times if it does not exist.
>
> * On the flip side, if the XDG file exists, ~/.git-credentials should
>   not be created at all times.
>
> * If both the XDG file and ~/.git-credentials exists, then both files
>   should be used for credential lookups. However, credentials should
>   only be written to ~/.git-credentials.

Regarding the final sentence: I don't see a test corresponding to the
restriction that only ~/.git-credentials will be modified if both
files exist. Am I missing something?

More below.

> * Credentials must be erased from both files.
>
> * $XDG_CONFIG_HOME can be a custom directory set by the user as per the
>   XDG base directory specification. Test that git-credential-store
>   respects that, but defaults to "~/.config/git/credentials" if it does
>   not exist or is empty.
>
> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index f61b40c..34752ea 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -6,4 +6,111 @@ test_description='credential-store tests'
>
>  helper_test store
>
> +test_expect_success '~/.git-credentials is written to when xdg credentials file does not exist' '
> +       test -s "$HOME/.git-credentials"
> +'
> +
> +test_expect_success 'xdg credentials file will not be created if it does not exist' '
> +       test_path_is_missing "$HOME/.config/git/credentials"

Since these two tests are complementary, each checking a facet of the
same behavioral rule, it seems like they ought to be combined. For
people reading the tests, having them separate implies incorrectly
that they are unrelated, making it difficult to understand the overall
picture of how the pieces relate to one another. In prose, you would
describe the behavior as:

    When XDG credentials does not exist, write only to
    ~/.git-credentials; do not create XDG credentials.

It's one thought; easy to read and understand. The test should reflect
the same intent:

    test_expect_success '...' '
        test -s "$HOME/.git-credentials" &&
        test_path_is_missing "$HOME/.config/git/credentials"
    '

The same observation applies to several other tests below.

> +'
> +
> +test_expect_success 'create $XDG_CONFIG_HOME/git/credentials file' '
> +       test_might_fail rm "$HOME/.git-credentials" &&

Can this just be "rm -f $HOME/.git-credentials &&" instead?

> +       mkdir -p "$HOME/.config/git" &&
> +       >"$HOME/.config/git/credentials"
> +'
> +
> +helper_test store
> +
> +test_expect_success 'xdg credentials file will be written to if it exists' '
> +       test -s "$HOME/.config/git/credentials"
> +'
> +
> +test_expect_success '~/.git-credentials will not be created if xdg credentials file exists' '
> +       test_path_is_missing "$HOME/.git-credentials"

Ditto: It seems like these two tests should be combined.

> +'
> +
> +test_expect_success 'set up custom XDG_CONFIG_HOME credential file' '
> +       XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME &&
> +       mkdir -p "$XDG_CONFIG_HOME/git" &&
> +       >"$XDG_CONFIG_HOME/git/credentials" &&
> +       >"$HOME/.config/git/credentials"
> +'
> +
> +helper_test store
> +
> +test_expect_success 'custom XDG_CONFIG_HOME credentials file will be written to if it exists' '
> +       test_when_finished "unset XDG_CONFIG_HOME" &&
> +       test -s "$XDG_CONFIG_HOME/git/credentials"
> +'

It feels wrong to set global state (XDG_CONFIG_HOME) in one test and
then clear it later in another test, and it's not obvious to the
casual reader that global state is being modified. An alternative
would be to set XDG_CONFIG_HOME outside of the first test to which it
applies, clear it after the final test. In reality, however, it only
needs to be defined for the "helper_test store" invocation, so it also
could be highly localized:

    XDG_CONFIG_HOME="$HOME/xdg"
    export XDG_CONFIG_HOME
    helper_test store
    unset XDG_CONFIG_HOME

A final alternative would be to wrap the block of tests needing
XDG_CONFIG_HOME within a subshell and set the variable only within the
subshell. Then, there's no need to unset it, and it's clear to the
reader that only the tests within the subshell are affected by it.

> +
> +test_expect_success '~/.config/git/credentials file will not be written to if a custom XDG_CONFIG_HOME is set' '
> +       test_must_be_empty "$HOME/.config/git/credentials"
> +'
> +
> +test_expect_success '~/.git-credentials will not be created if xdg credentials file exists' '
> +       test_path_is_missing "$HOME/.git-credentials"

For clarity, the three above tests probably ought to be combined.

> +'
> +
> +test_expect_success 'get: return credentials from home file if matches are found in both home and xdg files' '
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
> +       mkdir -p "$HOME/.config/git" &&
> +       >"$HOME/.git-credentials" &&
> +       echo "https://home-user:home-pass@example.com" >"$HOME/.config/git/credentials" &&

In the other tests, credentials in the XDG file are
"xdg-user:xdg-pass", and credentials in ~/.git-credentials are
"home-user:home-pass". It's not at all clear why, in this test, you
instead use "home-user:home-pass" for the XDG credentials. It seems
like an arbitrary and unnecessary change from the norm, and thus
confuses the reader.

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
> +test_expect_success 'get: return credentials from home file if xdg files are unreadable' '
> +       mkdir -p "$HOME/.config/git" &&
> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
> +       chmod -r "$HOME/.config/git/credentials" &&
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
> +test_expect_success 'erase: erase matching credentials from both xdg and home files' '
> +       mkdir -p "$HOME/.config/git" &&
> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
> +       check reject store <<-\EOF
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
