From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] am: let command-line options override saved options
Date: Sat, 1 Aug 2015 08:59:22 +0800
Message-ID: <CACRoPnQHGtA3BQxLuY4douhBt3=_b5U2ny4uDGfmR=5+La68YQ@mail.gmail.com>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
	<20150724180921.GA17730@peff.net>
	<CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
	<xmqq8ua1k7fc.fsf@gitster.dls.corp.google.com>
	<20150728164311.GA1948@yoshi.chippynet.com>
	<xmqqegjsfbtk.fsf@gitster.dls.corp.google.com>
	<CACRoPnR1df+uEnpFArJtwEBCh+HiQYDYGOyZ7KQEGtrdiaX3GQ@mail.gmail.com>
	<xmqqvbd05n5z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 02:59:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLL9I-0002Dl-V4
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 02:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbbHAA7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 20:59:25 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34515 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbbHAA7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 20:59:24 -0400
Received: by lbqc9 with SMTP id c9so29564688lbq.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 17:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2ugOjh4Uc9pgy3by2zNvIVkWuvexegkHUCOjvh/TH6U=;
        b=EOfrWX5LHbb1V8aMd3LoSw4jr6FPyLeQc2ob5g7EZrrhrKlud/PRRytrEXPfw1NgbI
         c3t6h1jxmdwKnijUuiy2GEi9h9Q8BnnndfHkNhasjFSJQlPKjdcs5FW9Zhy5ENoIOTiY
         uZyJVM9RRXuQd1YBH9HaR9a5RJ9xnTYu78XLA1E16cFBCsTBPWaHt9oVQOYCpvCLlTZn
         cZ+kng49K3Y4zWQ0UMYg8pM20LOPBjgxzBh4vw2FSdXp6UFNU6XVjPnMsVpgqFqsR7SH
         3Xn3GDb+bW+mE4fw7RI7utvGXlg8IY8WlKDTP9S1gSFZDG576kkqeXUNA4h4JIrHjobF
         U2fw==
X-Received: by 10.152.4.163 with SMTP id l3mr6256644lal.35.1438390762376; Fri,
 31 Jul 2015 17:59:22 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Fri, 31 Jul 2015 17:59:22 -0700 (PDT)
In-Reply-To: <xmqqvbd05n5z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275101>

On Sat, Aug 1, 2015 at 12:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> I think I will introduce a format_patch() function that takes a single
>> commit-ish so that we can use tag names to name the patches:
>>
>> # Given a single commit $commit, formats the following patches with
>> # git-format-patch:
>> #
>> # 1. $commit.eml: an email patch with a Message-Id header.
>> # 2. $commit.scissors: like $commit.eml but contains a scissors line at the
>> #    start of the commit message body.
>> format_patch () {
>>     {
>>         echo "Message-Id: <$1@example.com>" &&
>>         git format-patch --stdout -1 "$1" | sed -e '1d'
>>     } >"$1".eml &&
>
> I only said I can "understand" what is going on, though.
>
> It feels a bit unnatural for a test to feed a message that lack the
> "From " header line.  Perhaps
>
>         git format-patch --add-header="Message-Id: ..." --stdout -1
>
> or something?

Ah, okay. I wasn't aware of the --add-header option, but this is
definitely better.

>> These functions are called before we attempt to apply the patch, so we
>> should probably call append_signoff before then. However, this still
>> means that --no-signoff will have no effect should the patch
>> application fail and we resume, as the signoff would still have
>> already been appended...
>
> Ah, I see.  Let's not worry about this; we cannot change the
> expectation existing hook scripts depends on.

Okay, although this means that with the below change, --[no-]signoff
will be the oddball option that does not work when resuming.

>> 2. Re-reading Peff's message, I see that he expects the command-line
>> options to affect just the current patch, which makes sense. This
>> patch would need to be extended to call am_load() after we finish
>> processing the current patch when resuming.
>
> Yeah, so the idea is:
>
>  - upon the very first invocation, we parse the command line options
>    and write the states out;
>
>  - subsequent invocation, we read from the states and then override
>    with the command line options, but we do not write the states out
>    to update, so that subsequent invocations will keep reading from
>    the very first one.

... and we also load back the saved options after processing the patch
that we resume from, so the command-line options only affect the
conflicting patch, which fits in with Peff's idea on "wiggling that
_one_ patch".

>>>> +test_expect_success '--3way, --no-3way' '
>>>> +     rm -fr .git/rebase-apply &&
>>>> +     git reset --hard &&
>>>> +     git checkout first &&
>>>> +     test_must_fail git am --3way side-first.patch side-second.patch &&
>>>> +     test -n "$(git ls-files -u)" &&
>>>> +     echo will-conflict >file &&
>>>> +     git add file &&
>>>> +     test_must_fail git am --no-3way --continue &&
>>>> +     test -z "$(git ls-files -u)"
>>>> +'
>>>> +
>>
>> ... Although if I implement the above change, I can't implement the
>> test for --3way, as I think the only way to check if --3way/--no-3way
>> successfully overrides the saved options for the current patch only is
>> to run "git am --3way", but that does not work in the test runner as
>> it expects stdin to be a TTY :-/ So I may have to remove this test.
>> This shouldn't be a problem though, as all the tests in this test
>> suite all test the same mechanism.
>
> Sorry, you lost me.  Where does the TTY come into the picture only
> for --3way (but not for other things like --quiet)?

Ah, sorry, I should have provided more context. This is due to the
following block of code:

        /*
         * Catch user error to feed us patches when there is a session
         * in progress:
         *
         * 1. mbox path(s) are provided on the command-line.
         * 2. stdin is not a tty: the user is trying to feed us a patch
         *    from standard input. This is somewhat unreliable -- stdin
         *    could be /dev/null for example and the caller did not
         *    intend to feed us a patch but wanted to continue
         *    unattended.
         */
        if (argc || (resume == RESUME_FALSE && !isatty(0)))
            die(_("previous rebase directory %s still exists but mbox given."),
                state.dir);

And it will activate when git-am is run without
--continue/--abort/--skip (e.g. "git am --3way") because the test
framework sets stdin to /dev/null.

Thanks,
Paul
