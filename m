From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Thu, 12 Mar 2015 17:32:22 +0800
Message-ID: <CACRoPnTcrAW7BBdAM_C8mtm+bG5AKM5028L+wHCesjQ16fvHTQ@mail.gmail.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
	<1426056553-9364-5-git-send-email-pyokagan@gmail.com>
	<CAPig+cSZpYX0BZFN3Yx=PTiE3VVVVPH9X3yTwKe7p5J=5Dsngg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:32:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVzTy-0003Xf-01
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 10:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbbCLJc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 05:32:29 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:37716 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbbCLJcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 05:32:24 -0400
Received: by labgq15 with SMTP id gq15so14489681lab.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uofxV79uNEJJruSelv8fZKUuA9Q99/ZWYX6F+p9pNPI=;
        b=DIT+JmjtvP/JVDGRlx/45gh5yAllP5CpisOaAjPLGUntR5EMfj41ai6c0BJd/Y2uDU
         7PkK8uddYMtj8B3wRuUtWx/menX0Zi3CCq36pcso4G3lDksxUOHQDScQX5YiGXj9Dem6
         6JFPedYF7LAnlCZMSotjGaBnfrtfcEZmrufPxRzl+q2mAWuoHkKYPNf2lEAonttQTZwM
         T4+jYyAyapU8JBMoSntWQMMAO7JCuM8Nc55bzkGxlRwzIiblolXiLJ0Xsh3Z7SNElMzN
         hmI95Rn+tbgK53DPBmuvDGNpZ1kNF4HbYwgoG2OHS3fhnmwu/3loOw4e6PL8cdhCjL/j
         G74g==
X-Received: by 10.152.116.65 with SMTP id ju1mr18067636lab.32.1426152742524;
 Thu, 12 Mar 2015 02:32:22 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Thu, 12 Mar 2015 02:32:22 -0700 (PDT)
In-Reply-To: <CAPig+cSZpYX0BZFN3Yx=PTiE3VVVVPH9X3yTwKe7p5J=5Dsngg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265355>

Hi,

Thanks for taking the time to write such a detailed review and
catching all of my careless mistakes.

On Wed, Mar 11, 2015 at 4:40 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Mar 11, 2015 at 2:49 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> t0302 now tests git-credential-store's support for the XDG user-specific
>> configuration file $XDG_CONFIG_HOME/git/credentials. Specifically:
>>
>> * Ensure that the XDG file is strictly opt-in. It should not be created
>>   by git at all times if it does not exist.
>>
>> * On the flip side, if the XDG file exists, ~/.git-credentials should
>>   not be created at all times.
>>
>> * If both the XDG file and ~/.git-credentials exists, then both files
>>   should be used for credential lookups. However, credentials should
>>   only be written to ~/.git-credentials.
>
> Regarding the final sentence: I don't see a test corresponding to the
> restriction that only ~/.git-credentials will be modified if both
> files exist. Am I missing something?

Whoops, the test is indeed missing.

>> +test_expect_success '~/.git-credentials is written to when xdg credentials file does not exist' '
>> +       test -s "$HOME/.git-credentials"
>> +'
>> +
>> +test_expect_success 'xdg credentials file will not be created if it does not exist' '
>> +       test_path_is_missing "$HOME/.config/git/credentials"
>
> Since these two tests are complementary, each checking a facet of the
> same behavioral rule, it seems like they ought to be combined. For
> people reading the tests, having them separate implies incorrectly
> that they are unrelated, making it difficult to understand the overall
> picture of how the pieces relate to one another. In prose, you would
> describe the behavior as:
>
>     When XDG credentials does not exist, write only to
>     ~/.git-credentials; do not create XDG credentials.
>
> It's one thought; easy to read and understand. The test should reflect
> the same intent:
>
>     test_expect_success '...' '
>         test -s "$HOME/.git-credentials" &&
>         test_path_is_missing "$HOME/.config/git/credentials"
>     '
>
> The same observation applies to several other tests below.

Indeed, it looks much cleaner. Thanks for the suggestion.

>> +'
>> +
>> +test_expect_success 'create $XDG_CONFIG_HOME/git/credentials file' '
>> +       test_might_fail rm "$HOME/.git-credentials" &&
>
> Can this just be "rm -f $HOME/.git-credentials &&" instead?

I picked this pattern up in t1306-xdg-files.sh so I thought it is the
norm, but turns out it's not. I think I can see the rationale though.
At this point in the tests the file ~/.git-credentials is expected to
exist, so if it does not exist a diagnostic message should be printed
to stderr (which -f will not do). Whether this actually helps is
purely theoretical though, so I will change it to "rm -f" on the next
iteration.

>> +'
>> +
>> +test_expect_success 'set up custom XDG_CONFIG_HOME credential file' '
>> +       XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME &&
>> +       mkdir -p "$XDG_CONFIG_HOME/git" &&
>> +       >"$XDG_CONFIG_HOME/git/credentials" &&
>> +       >"$HOME/.config/git/credentials"
>> +'
>> +
>> +helper_test store
>> +
>> +test_expect_success 'custom XDG_CONFIG_HOME credentials file will be written to if it exists' '
>> +       test_when_finished "unset XDG_CONFIG_HOME" &&
>> +       test -s "$XDG_CONFIG_HOME/git/credentials"
>> +'
>
> It feels wrong to set global state (XDG_CONFIG_HOME) in one test and
> then clear it later in another test, and it's not obvious to the
> casual reader that global state is being modified. An alternative
> would be to set XDG_CONFIG_HOME outside of the first test to which it
> applies, clear it after the final test. In reality, however, it only
> needs to be defined for the "helper_test store" invocation, so it also
> could be highly localized:
>
>     XDG_CONFIG_HOME="$HOME/xdg"
>     export XDG_CONFIG_HOME
>     helper_test store
>     unset XDG_CONFIG_HOME
>
> A final alternative would be to wrap the block of tests needing
> XDG_CONFIG_HOME within a subshell and set the variable only within the
> subshell. Then, there's no need to unset it, and it's clear to the
> reader that only the tests within the subshell are affected by it.

I agree that the setting of XDG_CONFIG_HOME needs to be more
localized. This is a by-product of me following the "no code outside
tests" rule too strictly. A quick grep for "export" in the tests show
that quite a lot of tests do use export outside of test scripts,
though, so I guess I will change this to export XDG_CONFIG_HOME just
before running "helper_test store". Thanks for the suggestion.

>> +test_expect_success 'get: return credentials from xdg file if the home files do not have them' '
>> +       mkdir -p "$HOME/.config/git" &&
>> +       >"$HOME/.git-credentials" &&
>> +       echo "https://home-user:home-pass@example.com" >"$HOME/.config/git/credentials" &&
>
> In the other tests, credentials in the XDG file are
> "xdg-user:xdg-pass", and credentials in ~/.git-credentials are
> "home-user:home-pass". It's not at all clear why, in this test, you
> instead use "home-user:home-pass" for the XDG credentials. It seems
> like an arbitrary and unnecessary change from the norm, and thus
> confuses the reader.

This is a careless mistake on my part when I was renaming all the
usernames and passwords to the current form. Thanks for catching it.

Regards,
Paul
